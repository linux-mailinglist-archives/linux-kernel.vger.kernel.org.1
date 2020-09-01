Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7B082587DC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 08:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbgIAGKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 02:10:53 -0400
Received: from mga09.intel.com ([134.134.136.24]:13570 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbgIAGKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 02:10:52 -0400
IronPort-SDR: L3/9t1zFNr4oUDsNKq5z/47fZG/iwBC6GOO8g4hqmROmo0iM50XbExFP09DvhQ/dM6AObleb3H
 FSbQVejcLBrw==
X-IronPort-AV: E=McAfee;i="6000,8403,9730"; a="158116489"
X-IronPort-AV: E=Sophos;i="5.76,378,1592895600"; 
   d="scan'208";a="158116489"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2020 23:10:50 -0700
IronPort-SDR: FmcIXz8KDqJa+lRqZeMn+zJ4VBOfgY2gS9DC5i5ZFAmAxolZDDOYIA4j2letRcia0tulrbzp2i
 QM0dKg78dxag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,378,1592895600"; 
   d="scan'208";a="325217549"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139]) ([10.239.159.139])
  by fmsmga004.fm.intel.com with ESMTP; 31 Aug 2020 23:10:47 -0700
Cc:     baolu.lu@linux.intel.com, CobeChen-oc@zhaoxin.com,
        RaymondPang-oc@zhaoxin.com, TonyWWang-oc@zhaoxin.com
Subject: Re: [PATCH v3 1/2] iommu/vt-d:Add support for detecting ACPI device
 in RMRR
To:     FelixCuioc <FelixCui-oc@zhaoxin.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Dan Carpenter <dan.carpenter@oracle.com>, kbuild@lists.01.org
References: <20200827100217.21324-1-FelixCui-oc@zhaoxin.com>
 <20200827100217.21324-2-FelixCui-oc@zhaoxin.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <a7492142-2fbf-781c-8ec7-e85d5ce3f1d5@linux.intel.com>
Date:   Tue, 1 Sep 2020 14:05:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200827100217.21324-2-FelixCui-oc@zhaoxin.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felix,

On 8/27/20 6:02 PM, FelixCuioc wrote:
> Some ACPI devices need to issue dma requests to access
> the reserved memory area.BIOS uses the device scope type
> ACPI_NAMESPACE_DEVICE in RMRR to report these ACPI devices.
> This patch add support for detecting ACPI devices in RMRR.
> 
> Signed-off-by: FelixCuioc <FelixCui-oc@zhaoxin.com>
> ---
>   drivers/iommu/intel/dmar.c  | 76 +++++++++++++++++++++----------------
>   drivers/iommu/intel/iommu.c | 23 ++++++++++-
>   include/linux/dmar.h        | 12 +++++-
>   3 files changed, 76 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index 93e6345f3414..f6691c36bd3f 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -215,7 +215,7 @@ static bool dmar_match_pci_path(struct dmar_pci_notify_info *info, int bus,
>   }
>   
>   /* Return: > 0 if match found, 0 if no match found, < 0 if error happens */
> -int dmar_insert_dev_scope(struct dmar_pci_notify_info *info,
> +int dmar_pci_insert_dev_scope(struct dmar_pci_notify_info *info,
>   			  void *start, void*end, u16 segment,
>   			  struct dmar_dev_scope *devices,
>   			  int devices_cnt)
> @@ -304,7 +304,7 @@ static int dmar_pci_bus_add_dev(struct dmar_pci_notify_info *info)
>   
>   		drhd = container_of(dmaru->hdr,
>   				    struct acpi_dmar_hardware_unit, header);
> -		ret = dmar_insert_dev_scope(info, (void *)(drhd + 1),
> +		ret = dmar_pci_insert_dev_scope(info, (void *)(drhd + 1),
>   				((void *)drhd) + drhd->header.length,
>   				dmaru->segment,
>   				dmaru->devices, dmaru->devices_cnt);
> @@ -697,47 +697,59 @@ dmar_find_matched_drhd_unit(struct pci_dev *dev)
>   	return dmaru;
>   }
>   
> -static void __init dmar_acpi_insert_dev_scope(u8 device_number,
> -					      struct acpi_device *adev)
> +/* Return: > 0 if match found, 0 if no match found */
> +bool dmar_acpi_insert_dev_scope(u8 device_number,
> +				struct acpi_device *adev,
> +				void *start, void *end,
> +				struct dmar_dev_scope *devices,
> +				int devices_cnt)
>   {
> -	struct dmar_drhd_unit *dmaru;
> -	struct acpi_dmar_hardware_unit *drhd;
>   	struct acpi_dmar_device_scope *scope;
>   	struct device *tmp;
>   	int i;
>   	struct acpi_dmar_pci_path *path;
>   
> +	for (; start < end; start += scope->length) {
> +		scope = start;
> +		if (scope->entry_type != ACPI_DMAR_SCOPE_TYPE_NAMESPACE)
> +			continue;
> +		if (scope->enumeration_id != device_number)
> +			continue;
> +		path = (void *)(scope + 1);
> +		for_each_dev_scope(devices, devices_cnt, i, tmp)
> +			if (tmp == NULL) {
> +				devices[i].bus = scope->bus;
> +				devices[i].devfn = PCI_DEVFN(path->device, path->function);
> +				rcu_assign_pointer(devices[i].dev,
> +						   get_device(&adev->dev));
> +				return true;
> +			}
> +		WARN_ON(i >= devices_cnt);
> +	}
> +	return false;
> +}
> +
> +static int dmar_acpi_bus_add_dev(u8 device_number, struct acpi_device *adev)
> +{
> +	struct dmar_drhd_unit *dmaru;
> +	struct acpi_dmar_hardware_unit *drhd;
> +	int ret;
> +
>   	for_each_drhd_unit(dmaru) {
>   		drhd = container_of(dmaru->hdr,
>   				    struct acpi_dmar_hardware_unit,
>   				    header);
> +		ret = dmar_acpi_insert_dev_scope(device_number, adev, (void *)(drhd+1),
> +						((void *)drhd)+drhd->header.length,
> +						dmaru->devices, dmaru->devices_cnt);
> +		if (ret)
> +			break;
> +	}
> +	if (ret > 0)
> +		ret = dmar_rmrr_add_acpi_dev(device_number, adev);
>   
> -		for (scope = (void *)(drhd + 1);
> -		     (unsigned long)scope < ((unsigned long)drhd) + drhd->header.length;
> -		     scope = ((void *)scope) + scope->length) {
> -			if (scope->entry_type != ACPI_DMAR_SCOPE_TYPE_NAMESPACE)
> -				continue;
> -			if (scope->enumeration_id != device_number)
> -				continue;
> +	return ret;
>   
> -			path = (void *)(scope + 1);
> -			pr_info("ACPI device \"%s\" under DMAR at %llx as %02x:%02x.%d\n",
> -				dev_name(&adev->dev), dmaru->reg_base_addr,
> -				scope->bus, path->device, path->function);

Please keep such information. People are used to use them as a method to
know the hardware configuration.

> -			for_each_dev_scope(dmaru->devices, dmaru->devices_cnt, i, tmp)
> -				if (tmp == NULL) {
> -					dmaru->devices[i].bus = scope->bus;
> -					dmaru->devices[i].devfn = PCI_DEVFN(path->device,
> -									    path->function);
> -					rcu_assign_pointer(dmaru->devices[i].dev,
> -							   get_device(&adev->dev));
> -					return;
> -				}
> -			BUG_ON(i >= dmaru->devices_cnt);
> -		}
> -	}
> -	pr_warn("No IOMMU scope found for ANDD enumeration ID %d (%s)\n",
> -		device_number, dev_name(&adev->dev));

Ditto.

>   }
>   
>   static int __init dmar_acpi_dev_scope_init(void)
> @@ -766,7 +778,7 @@ static int __init dmar_acpi_dev_scope_init(void)
>   				       andd->device_name);
>   				continue;
>   			}
> -			dmar_acpi_insert_dev_scope(andd->device_number, adev);
> +			dmar_acpi_bus_add_dev(andd->device_number, adev);
>   		}
>   	}
>   	return 0;
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index ca557d351518..208a91605288 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4508,6 +4508,25 @@ int dmar_find_matched_atsr_unit(struct pci_dev *dev)
>   	return ret;
>   }
>   
> +int dmar_rmrr_add_acpi_dev(u8 device_number, struct acpi_device *adev)
> +{
> +	int ret;
> +	struct dmar_rmrr_unit *rmrru;
> +	struct acpi_dmar_reserved_memory *rmrr;
> +
> +	list_for_each_entry(rmrru, &dmar_rmrr_units, list) {
> +		rmrr = container_of(rmrru->hdr,
> +				struct acpi_dmar_reserved_memory,
> +				header);
> +		ret = dmar_acpi_insert_dev_scope(device_number, adev, (void *)(rmrr + 1),
> +						((void *)rmrr) + rmrr->header.length,
> +						rmrru->devices, rmrru->devices_cnt);
> +		if (ret)
> +			break;
> +	}
> +	return 0;
> +}

This is only used in dmar.c. Why do you want to define it here and use
it in another file?

> +
>   int dmar_iommu_notify_scope_dev(struct dmar_pci_notify_info *info)
>   {
>   	int ret;
> @@ -4523,7 +4542,7 @@ int dmar_iommu_notify_scope_dev(struct dmar_pci_notify_info *info)
>   		rmrr = container_of(rmrru->hdr,
>   				    struct acpi_dmar_reserved_memory, header);
>   		if (info->event == BUS_NOTIFY_ADD_DEVICE) {
> -			ret = dmar_insert_dev_scope(info, (void *)(rmrr + 1),
> +			ret = dmar_pci_insert_dev_scope(info, (void *)(rmrr + 1),
>   				((void *)rmrr) + rmrr->header.length,
>   				rmrr->segment, rmrru->devices,
>   				rmrru->devices_cnt);
> @@ -4541,7 +4560,7 @@ int dmar_iommu_notify_scope_dev(struct dmar_pci_notify_info *info)
>   
>   		atsr = container_of(atsru->hdr, struct acpi_dmar_atsr, header);
>   		if (info->event == BUS_NOTIFY_ADD_DEVICE) {
> -			ret = dmar_insert_dev_scope(info, (void *)(atsr + 1),
> +			ret = dmar_pci_insert_dev_scope(info, (void *)(atsr + 1),
>   					(void *)atsr + atsr->header.length,
>   					atsr->segment, atsru->devices,
>   					atsru->devices_cnt);
> diff --git a/include/linux/dmar.h b/include/linux/dmar.h
> index 65565820328a..d0981d35d3c9 100644
> --- a/include/linux/dmar.h
> +++ b/include/linux/dmar.h
> @@ -113,10 +113,14 @@ extern int dmar_parse_dev_scope(void *start, void *end, int *cnt,
>   				struct dmar_dev_scope **devices, u16 segment);
>   extern void *dmar_alloc_dev_scope(void *start, void *end, int *cnt);
>   extern void dmar_free_dev_scope(struct dmar_dev_scope **devices, int *cnt);
> -extern int dmar_insert_dev_scope(struct dmar_pci_notify_info *info,
> +extern int dmar_pci_insert_dev_scope(struct dmar_pci_notify_info *info,
>   				 void *start, void*end, u16 segment,
>   				 struct dmar_dev_scope *devices,
>   				 int devices_cnt);
> +extern bool dmar_acpi_insert_dev_scope(u8 device_number,
> +				struct acpi_device *adev, void *start, void *end,
> +				struct dmar_dev_scope *devices, int devices_cnt);
> +
>   extern int dmar_remove_dev_scope(struct dmar_pci_notify_info *info,
>   				 u16 segment, struct dmar_dev_scope *devices,
>   				 int count);
> @@ -140,6 +144,7 @@ extern int dmar_parse_one_atsr(struct acpi_dmar_header *header, void *arg);
>   extern int dmar_check_one_atsr(struct acpi_dmar_header *hdr, void *arg);
>   extern int dmar_release_one_atsr(struct acpi_dmar_header *hdr, void *arg);
>   extern int dmar_iommu_hotplug(struct dmar_drhd_unit *dmaru, bool insert);
> +extern int dmar_rmrr_add_acpi_dev(u8 device_number, struct acpi_device *adev);
>   extern int dmar_iommu_notify_scope_dev(struct dmar_pci_notify_info *info);
>   #else /* !CONFIG_INTEL_IOMMU: */
>   static inline int intel_iommu_init(void) { return -ENODEV; }
> @@ -150,6 +155,11 @@ static inline void intel_iommu_shutdown(void) { }
>   #define	dmar_check_one_atsr		dmar_res_noop
>   #define	dmar_release_one_atsr		dmar_res_noop
>   
> +static inline int dmar_rmrr_add_acpi_dev(u8 device_number, struct acpi_device *adev)
> +{
> +	return 0;
> +}
> +
>   static inline int dmar_iommu_notify_scope_dev(struct dmar_pci_notify_info *info)
>   {
>   	return 0;
> 

Best regards,
baolu
