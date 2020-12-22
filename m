Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 698F82E0473
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 03:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725968AbgLVCqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 21:46:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35572 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725924AbgLVCqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 21:46:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608605103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mtrZTTJIr7oR1Tjy1htJ8dmZVuN7yGZCQoQCqS0N9aA=;
        b=IOWNDpbMOf4VXM2Z4ZfL3zwHipsPL2xunAy06hjGmv0LrWMO4NshiSqhyx7RbDscbr/9q/
        NBuXrlYf6PH+Gdf9udvY0ar68+Ar9xhkYCPh7MDumBR7KbwnlYfNdCz49ydJ+5V1HlQX+Q
        Sv/oEvJ5HcIynGMcD3OIchOx3CH8KIk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-SL4XcIw9NsKPmHr7FDGARw-1; Mon, 21 Dec 2020 21:45:00 -0500
X-MC-Unique: SL4XcIw9NsKPmHr7FDGARw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A3D26801817;
        Tue, 22 Dec 2020 02:44:59 +0000 (UTC)
Received: from [10.72.13.168] (ovpn-13-168.pek2.redhat.com [10.72.13.168])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3E66F5D6D1;
        Tue, 22 Dec 2020 02:44:49 +0000 (UTC)
Subject: Re: [PATCH RFC 00/12] vdpa: generalize vdpa simulator and add block
 device
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>,
        linux-kernel@vger.kernel.org, Eli Cohen <elic@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
References: <20201113134712.69744-1-sgarzare@redhat.com>
 <93f207c0-61e6-3696-f218-e7d7ea9a7c93@redhat.com>
 <20201218113816.zcyeyqipux4ao4cp@steredhat>
 <7dd3ed02-36c3-fcfd-0a1d-9c31af6f473e@redhat.com>
 <20201221111423.sestfroiw2dgpluc@steredhat>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <856d53c2-82e2-e408-76e6-24c92010f973@redhat.com>
Date:   Tue, 22 Dec 2020 10:44:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201221111423.sestfroiw2dgpluc@steredhat>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/12/21 下午7:14, Stefano Garzarella wrote:
> On Mon, Dec 21, 2020 at 11:16:54AM +0800, Jason Wang wrote:
>>
>> On 2020/12/18 下午7:38, Stefano Garzarella wrote:
>>> On Mon, Nov 16, 2020 at 11:37:48AM +0800, Jason Wang wrote:
>>>>
>>>> On 2020/11/13 下午9:47, Stefano Garzarella wrote:
>>>>> Thanks to Max that started this work!
>>>>> I took his patches, and extended the block simulator a bit.
>>>>>
>>>>> This series moves the network device simulator in a new module
>>>>> (vdpa_sim_net) and leaves the generic functions in the vdpa_sim core
>>>>> module, allowing the possibility to add new vDPA device simulators.
>>>>> Then we added a new vdpa_sim_blk module to simulate a block device.
>>>>>
>>>>> I'm not sure about patch 11 ("vringh: allow vringh_iov_xfer() to skip
>>>>> bytes when ptr is NULL"), maybe we can add a new functions instead of
>>>>> modify vringh_iov_xfer().
>>>>>
>>>>> As Max reported, I'm also seeing errors with vdpa_sim_blk related to
>>>>> iotlb and vringh when there is high load, these are some of the error
>>>>> messages I can see randomly:
>>>>>
>>>>>   vringh: Failed to access avail idx at 00000000e8deb2cc
>>>>>   vringh: Failed to read head: idx 6289 address 00000000e1ad1d50
>>>>>   vringh: Failed to get flags at 000000006635d7a3
>>>>>
>>>>>   virtio_vdpa vdpa0: vringh_iov_push_iotlb() error: -14 offset:   
>>>>> 0x2840000 len: 0x20000
>>>>>   virtio_vdpa vdpa0: vringh_iov_pull_iotlb() error: -14 offset:   
>>>>> 0x58ee000 len: 0x3000
>>>>>
>>>>> These errors should all be related to the fact that iotlb_translate()
>>>>> fails with -EINVAL, so it seems that we miss some mapping.
>>>>
>>>>
>>>> Is this only reproducible when there's multiple co-current 
>>>> accessing of IOTLB? If yes, it's probably a hint that some kind of 
>>>> synchronization is still missed somewhere.
>>>>
>>>> It might be useful to log the dma_map/unmp in both virtio_ring and 
>>>> vringh to see who is missing the map.
>>>>
>>>
>>> Just an update about these issues with vdpa-sim-blk.
>>> I've been focusing a little bit on these failures over the last few 
>>> days and have found two issues related to the IOTLB/IOMMU:
>>>
>>> 1. Some requests coming from the block layer fills the SG list with 
>>> multiple buffers that had the same physical address. This happens 
>>> for example while using 'mkfs', at some points multiple sectors are 
>>> zeroed so multiple SG elements point to the same physical page that 
>>> is zeroed.
>>> Since we are using vhost_iotlb_del_range() in the 
>>> vdpasim_unmap_page(), this removes all the overlapped ranges. I 
>>> fixed removing a single map in vdpasim_unmap_page(), but has an 
>>> alternative we can implement some kind of reference counts.
>>
>>
>> I think we need to do what hardware do. So using refcount is probably 
>> not a good ida.
>
> Okay, so since we are using for simplicity an identical mapping, we 
> are assigning the same dma_addr to multiple pages.


I think I get you now. That's the root cause for the failure.

Then I think we need an simple iova allocator for vdpa simulator, and it 
might be useful for VDUSE as well.

Thanks


>
> So, it should be okay to remove a single mapping checking the others 
> parameters (i.e. dir, size).
>
> I'll send a patch, so with the code it should be easier :-)
>
> Thanks,
> Stefano
>
>>
>>
>>>
>>> 2. There was a race between dma_map/unmap and the worker thread, 
>>> since both are accessing the IOMMU. Taking the iommu_lock while 
>>> using vhost_iotlb_* API in the worker thread fixes the "vringh: 
>>> Failed to *" issues.
>>>
>>> Whit these issues fixed the vdpa-blk simulator seems to work well.
>>> I'll send the patches next week or after the break.
>>
>>
>> Good to know this.
>>
>> Thanks
>>
>>
>>>
>>> Thanks,
>>> Stefano
>>>
>>
>

