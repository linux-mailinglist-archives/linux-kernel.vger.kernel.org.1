Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55736217CF9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 04:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbgGHCRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 22:17:35 -0400
Received: from mga05.intel.com ([192.55.52.43]:63062 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728479AbgGHCRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 22:17:34 -0400
IronPort-SDR: 2u3KdpWlYtGwmeq5e9lODcvZ8rIikqBqXogmhUMSefsXOldRLFgXhnmVmvAkCzv+ngmmAOG1oJ
 nUpn6ali0mWA==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="232587574"
X-IronPort-AV: E=Sophos;i="5.75,326,1589266800"; 
   d="scan'208";a="232587574"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2020 19:17:34 -0700
IronPort-SDR: TUGrLOQs9vhlflb9p3/9zdjZy2bptRKESKoPv85baFE2PqNBXRXxQxjxVVzJzlHDoBYkF6Le4k
 hGFimBrBbZ5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,326,1589266800"; 
   d="scan'208";a="457323827"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139]) ([10.239.159.139])
  by orsmga005.jf.intel.com with ESMTP; 07 Jul 2020 19:17:32 -0700
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] iommu/vt-d: Report page request faults for guest
 SVA
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20200706002535.9381-1-baolu.lu@linux.intel.com>
 <20200706002535.9381-4-baolu.lu@linux.intel.com>
 <20200707112344.GB159413@myrica>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <3d0680fc-afba-e642-f88f-aac4e276c5a5@linux.intel.com>
Date:   Wed, 8 Jul 2020 10:13:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200707112344.GB159413@myrica>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,

On 7/7/20 7:23 PM, Jean-Philippe Brucker wrote:
> On Mon, Jul 06, 2020 at 08:25:34AM +0800, Lu Baolu wrote:
>> A pasid might be bound to a page table from a VM guest via the iommu
>> ops.sva_bind_gpasid. In this case, when a DMA page fault is detected
>> on the physical IOMMU, we need to inject the page fault request into
>> the guest. After the guest completes handling the page fault, a page
>> response need to be sent back via the iommu ops.page_response().
>>
>> This adds support to report a page request fault. Any external module
>> which is interested in handling this fault should regiester a notifier
>> callback.
>>
>> Co-developed-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Co-developed-by: Liu Yi L <yi.l.liu@intel.com>
>> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
> [...]
>> +static int
>> +intel_svm_prq_report(struct device *dev, struct page_req_dsc *desc)
>> +{
>> +	struct iommu_fault_event event;
>> +	u8 bus, devfn;
>> +
>> +	memset(&event, 0, sizeof(struct iommu_fault_event));
>> +	bus = PCI_BUS_NUM(desc->rid);
>> +	devfn = desc->rid & 0xff;
>> +
>> +	/* Fill in event data for device specific processing */
>> +	event.fault.type = IOMMU_FAULT_PAGE_REQ;
>> +	event.fault.prm.addr = desc->addr;
>> +	event.fault.prm.pasid = desc->pasid;
>> +	event.fault.prm.grpid = desc->prg_index;
>> +	event.fault.prm.perm = prq_to_iommu_prot(desc);
>> +
>> +	/*
>> +	 * Set last page in group bit if private data is present,
>> +	 * page response is required as it does for LPIG.
>> +	 */
>> +	if (desc->lpig)
>> +		event.fault.prm.flags |= IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE;
>> +	if (desc->pasid_present)
>> +		event.fault.prm.flags |= IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
> 
> Do you also need to set IOMMU_FAULT_PAGE_RESPONSE_NEEDS_PASID?  I added
> the flag to deal with devices that do not want a PASID value in their PRI
> response (bit 15 in the PCIe Page Request Status Register):
> https://lore.kernel.org/linux-iommu/20200616144712.748818-1-jean-philippe@linaro.org/
> (applied by Joerg for v5.9)
> 
> Grepping for pci_prg_resp_pasid_required() in intel/iommu.c it seems to
> currently reject devices that do not want a PASID in a PRI response, so I
> think you can set this flag unconditionally for now.

Yes. You are right. I will set this flag in the next version.

Best regards,
baolu

> 
> Thanks,
> Jean
> 
>> +	if (desc->priv_data_present) {
>> +		event.fault.prm.flags |= IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE;
>> +		event.fault.prm.flags |= IOMMU_FAULT_PAGE_REQUEST_PRIV_DATA;
>> +		memcpy(event.fault.prm.private_data, desc->priv_data,
>> +		       sizeof(desc->priv_data));
>> +	}
>> +
>> +	return iommu_report_device_fault(dev, &event);
>> +}
