select * from NashVilleHousing;

------------------------------------------------------------------------------------------------------------------------------------------
--------Standlize Date Formatting

select SaleDate,CONVERT(Date, SaleDate)
from NashVilleHousing;

Update NashVilleHousing
set SaleDate = CONVERT(Date, SaleDate)

Alter table NashVilleHousing
Add SaleDateConverted Date;

Update NashVilleHousing
set SaleDateConverted = SaleDate;

select SaleDateConverted from NashVilleHousing;
-------------------------------------------------------------------------------------------------------------------------------------------

----Breaking out Adress into individual columns(Adress, city, State)

select 
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress )-1) as Address --PrpertySplitAdress
,SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress )+1, LEN(PropertyAddress)) as Address --PropertySplitCity
from NashVilleHousing 

Alter table NashVilleHousing
Add PropertySplitAddress Nvarchar(255);

Alter table NashvilleHousing
Add  PropertySplitCity Nvarchar(255);

Update NashVilleHousing
set PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress )-1) 


Update NashVilleHousing
set PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress )+1, LEN(PropertyAddress)) 

select * from NashVilleHousing

select
ParseName(Replace(OwnerAddress,',', '.'), 3),
ParseName(Replace(OwnerAddress,',', '.'), 2),
ParseName(Replace(OwnerAddress,',', '.'), 1)
from NashVilleHousing

Alter table NashVilleHousing
Add OwnerSplitAddress Nvarchar(255);

Alter table NashvilleHousing
Add  OwnerSplitCity Nvarchar(255);


Alter table NashvilleHousing
Add  OwnerSplitState Nvarchar(255);

Update NashVilleHousing
set OwnerSplitAddress = ParseName(Replace(OwnerAddress,',', '.'), 3) 


Update NashVilleHousing
set OwnerSplitCity = ParseName(Replace(OwnerAddress,',', '.'), 2) 

Update NashVilleHousing
set OwnerSplitState = ParseName(Replace(OwnerAddress,',', '.'), 1) 



-------------Populate Property Address-------------------------------------------------------------------------------

select a.ParcelID, b.ParcelID, a.PropertyAddress, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
from NashVilleHousing a
inner join NashVilleHousing b
on a.ParcelID = b.ParcelID
and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null

Update a
set PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
from NashVilleHousing a
inner join NashVilleHousing b
on a.ParcelID = b.ParcelID
and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null

---------------------------------------------------------------------------------------------------------------


----------Replace Y and N in "Sold as Vacant" with YES & NO-----------------------------------------------------------

select DISTINCT (SoldAsVacant), COUNT(SoldAsVacant) 
from NashVilleHousing
group by SoldAsVacant
order by 2

Select SoldAsVacant,
CASE When SoldAsVacant = 'Y' then 'YES'
     When SoldAsVacant = 'N' then 'NO'
	 else SoldAsVacant
	 END
from NashVilleHousing;

Update NashVilleHousing
set SoldAsVacant = CASE When SoldAsVacant = 'Y' then 'YES'
                        When SoldAsVacant = 'N' then 'NO'
	                    else SoldAsVacant
	                    END

------------------Remove duplicates----------------------------------------------------------------------------------
With RowNumbCTE AS (
select *,
ROW_NUMBER() Over(
                       Partition BY ParcelID,
			              PropertyAddress,
						  SalePrice,
						  SaleDate,
						  LegalReference
						  
						  order by UniqueID
				)row_num

from NashVilleHousing
)
Delete
from RowNumbCTE
Where row_num > 1

----------------------------------------------------------------------------------------------------------------
----------------------Delete unused Columns--------------------

select *
from NashVilleHousing

Alter table NashVilleHousing
Drop column PropertyAddress, OwnerAddress

Alter table NashVilleHousing
drop column TaxDistrict
