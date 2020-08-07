Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36D7923E891
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Aug 2020 10:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgHGIIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Aug 2020 04:08:13 -0400
Received: from mga17.intel.com ([192.55.52.151]:55670 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgHGIIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 04:08:12 -0400
IronPort-SDR: svkrNjzQAbM3R0BG2RqaAz87Y03s/ixqrD7uMm2HomZrikTlZb/rV/SkZ4Y2LKj2jybOLBpFiP
 iOufjcVVn4yw==
X-IronPort-AV: E=McAfee;i="6000,8403,9705"; a="133100308"
X-IronPort-AV: E=Sophos;i="5.75,444,1589266800"; 
   d="scan'208";a="133100308"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2020 01:08:11 -0700
IronPort-SDR: HiBVHTwOuprK8YUFYEIJwiOo+j3AjWdofl0qJszoPpjrDpBUG+0xXwQ+QznsQ/v1BfC2JwUt5j
 DFv6qtJqxCbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,444,1589266800"; 
   d="scan'208";a="293593780"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.215.69]) ([10.254.215.69])
  by orsmga006.jf.intel.com with ESMTP; 07 Aug 2020 01:08:09 -0700
Cc:     baolu.lu@linux.intel.com,
        RaymondPang-oc <RaymondPang-oc@zhaoxin.com>,
        CobeChen-oc <CobeChen-oc@zhaoxin.com>
Subject: =?UTF-8?B?UmU6IOetlOWkjTog562U5aSNOiDnrZTlpI06IOetlOWkjTog562U5aSN?=
 =?UTF-8?B?OiDnrZTlpI06IOetlOWkjTogW1BBVENIXSBpb21tdS92dC1kOkFkZCBzdXBwb3J0?=
 =?UTF-8?Q?_for_ACPI_device_in_RMRR?=
To:     FelixCui-oc <FelixCui-oc@zhaoxin.com>,
        Joerg Roedel <joro@8bytes.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>
References: <20200802100735.2722-1-FelixCui-oc@zhaoxin.com>
 <73d4a1e4-f6b7-efb0-e225-2e462c838657@linux.intel.com>
 <f6759b9bb2594026b58f9a89e3ce9dc6@zhaoxin.com>
 <9f64d9b6-16e8-73ce-2186-9d8ba49c39f4@linux.intel.com>
 <44ff8f73fa1f49a183a1d8d6d9c2213c@zhaoxin.com>
 <314679b4-7653-041b-9310-73baf8117766@linux.intel.com>
 <1aea042a1b524ef88e491ca2a6d95fb7@zhaoxin.com>
 <36da53a6-00e2-1be1-91b5-d90906a6199f@linux.intel.com>
 <a5fda3f364da4e739736e7d7bc618972@zhaoxin.com>
 <a2658f9c-23fa-bb72-edba-ad61e52085cd@linux.intel.com>
 <9ba29114fcad43d58159fcc7a4d89501@zhaoxin.com>
 <1477b1dd-ac48-b49d-77f9-107bb4555b91@linux.intel.com>
 <06a05e49a2564909a2049eb8be401670@zhaoxin.com>
 <30ef5891-1368-d580-564a-1c21d90f47cd@linux.intel.com>
 <f25e4fdf592a455594d0e88fced8fb62@zhaoxin.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <f631a3b2-5bd4-f48a-5ec5-0fc6118e1c95@linux.intel.com>
Date:   Fri, 7 Aug 2020 16:08:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <f25e4fdf592a455594d0e88fced8fb62@zhaoxin.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2020/8/7 11:29, FelixCui-oc wrote:
> Hi baolu,
> 		I understand what you mean is that you want to put the following processing code in the acpi_device_create_direct_mappings() into the probe_acpi_namespace_devices() ,right?
> 		If you mean it , I think it's OK.

Yes. If the acpi device has companion physical devices, then probe the
companion devices; otherwise, probe the acpi device instead. Also, let's
put detecting and probing acpi devices in different patches so that they
could be easier for reviewing.

Best regards,
baolu

> 
> 	if (pn_dev == NULL) {
> 		acpi_device->bus->iommu_ops = &intel_iommu_ops;
> 		ret = iommu_probe_device(acpi_device);
> 		if (ret) {
> 			pr_err("acpi_device probe fail! ret:%d\n", ret);
> 			return ret;
> 		}
> 		return 0;
> 	}
> 
> Best regards
> Felix cui-oc
> 
> 
> 
> 	
> 
> -----邮件原件-----
> 发件人: Lu Baolu <baolu.lu@linux.intel.com>
> 发送时间: 2020年8月7日 9:08
> 收件人: FelixCui-oc <FelixCui-oc@zhaoxin.com>; Joerg Roedel <joro@8bytes.org>; iommu@lists.linux-foundation.org; linux-kernel@vger.kernel.org; David Woodhouse <dwmw2@infradead.org>
> 抄送: baolu.lu@linux.intel.com; RaymondPang-oc <RaymondPang-oc@zhaoxin.com>; CobeChen-oc <CobeChen-oc@zhaoxin.com>
> 主题: Re: 答复: 答复: 答复: 答复: 答复: 答复: [PATCH] iommu/vt-d:Add support for ACPI device in RMRR
> 
> Hi Felix,
> 
> On 2020/8/6 14:51, FelixCui-oc wrote:
>> Hi  baolu,
>> 		>Sure. Before that, let me sync my understanding with you. You have an acpi namespace device in ANDD table, it also shows up in the device scope of a RMRR.
>> 		>Current code doesn't enumerate that device for the RMRR, hence iommu_create_device_direct_mappings() doesn't work for this device.
>>
>> 		>At the same time, probe_acpi_namespace_devices() doesn't work for this device, hence you want to add a home-made
>> 		>acpi_device_create_direct_mappings() helper.
>>
>> 		Your understanding is right.
>> 		But there is a problem that even if the namespace device in rmrr is enumerated in the code, probe_acpi_namespace_devices() also doesn't work for this device.
>> 		This is because the dev parameter of the iommu_create_device_direct_mappings() is not the namespace device in RMRR.
>> 		The actual parameter passed in is the namespace device's physical node device.
>> 		In iommu_create_device_direct_mappings(), the physical node device passed in cannot match the namespace device in rmrr->device[],right?
>> 		We need acpi_device_create_direct_mappings() helper ?
>>
>> 		In addition, adev->physical_node_list is related to the __HID of namespace device reported by the bios.
>> 		For example, if the __HID reported by the bios belongs to acpi_pnp_device_ids[], adev->physical_node_list has no devices.
>> 		So in acpi_device_create_direct_mappings(), I added the case that adev->physical_node_list is empty.
> 
> Got you. Thanks!
> 
> Have you ever tried to have probe_acpi_namespace_devices() handle the case of empty adev->physical_node_list at the same time?
> 
> Best regards,
> baolu
> 
>>
>>
>> Best regards
>> Felix cui
>>
>>
>>    
>>
>> -----邮件原件-----
>> 发件人: Lu Baolu <baolu.lu@linux.intel.com>
>> 发送时间: 2020年8月6日 10:36
>> 收件人: FelixCui-oc <FelixCui-oc@zhaoxin.com>; Joerg Roedel
>> <joro@8bytes.org>; iommu@lists.linux-foundation.org;
>> linux-kernel@vger.kernel.org; David Woodhouse <dwmw2@infradead.org>
>> 抄送: baolu.lu@linux.intel.com; RaymondPang-oc
>> <RaymondPang-oc@zhaoxin.com>; CobeChen-oc <CobeChen-oc@zhaoxin.com>
>> 主题: Re: 答复: 答复: 答复: 答复: 答复: [PATCH] iommu/vt-d:Add support for ACPI
>> device in RMRR
>>
>> Hi Felix,
>>
>> On 8/5/20 3:37 PM, FelixCui-oc wrote:
>>> Hi baolu,
>>> 		Let me talk about why acpi_device_create_direct_mappings() is needed and please tell me if there is an error.
>>
>> Sure. Before that, let me sync my understanding with you. You have an acpi namespace device in ANDD table, it also shows up in the device scope of a RMRR. Current code doesn't enumerate that device for the RMRR, hence iommu_create_device_direct_mappings() doesn't work for this device.
>>
>> At the same time, probe_acpi_namespace_devices() doesn't work for this
>> device, hence you want to add a home-made
>> acpi_device_create_direct_mappings() helper.
>>
>> Did I get it right?
>>
>>> 		In the probe_acpi_namespace_devices() function, only the device in the addev->physical_node_list is probed,
>>> 		but we need to establish identity mapping for the namespace device in RMRR. These are two different devices.
>>
>> The namespace device has been probed and put in one drhd's device list.
>> Hence, it should be processed by probe_acpi_namespace_devices(). So the question is why there are no devices in addev->physical_node_list?
>>
>>> 		Therefore, the namespace device in RMRR is not mapped in probe_acpi_namespace_devices().
>>> 		acpi_device_create_direct_mappings() is to create direct mappings for namespace devices in RMRR.
>>
>> Best regards,
>> baolu
>>
