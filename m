Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A28852E0941
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 12:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgLVK7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 05:59:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45186 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726719AbgLVK7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 05:59:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608634660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HUqZxqa8Hto+LIciCh/MDtUD1YZexx2bkHHuabHifwA=;
        b=NQEHb3yVvZjdZv2JWgnUWnHAGnZggSngM+BOaL5LKlLwPuvHjp7uwQ8o4/Jf/1YQQFryjE
        u59pvdd1nI/zeqsZv8lg6ViXVS6Dydgsf9zFwtFMZ21r5d8VWReJJ94tMH5/x0MicKIBjM
        S9MNmCAb8dZFtMYx/rqAn1AAcE4t41g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-xBrEE9qlO4mfjo23JrN9cA-1; Tue, 22 Dec 2020 05:57:39 -0500
X-MC-Unique: xBrEE9qlO4mfjo23JrN9cA-1
Received: by mail-wr1-f72.google.com with SMTP id y5so11026487wrs.15
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 02:57:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HUqZxqa8Hto+LIciCh/MDtUD1YZexx2bkHHuabHifwA=;
        b=O+gHXF8X7tnfuKhs9BGIAD++INIlZNFHrIrfU7sHzlimdE/fmZBxc2KJ/WknAhJ+2f
         FBTlxWOPnAV5YU55v/tPWiZ1dCtZ7d69BpXHnLYNS21IV6dFdCgM3dCX4P2o1yAFO8Cr
         CvW4tkLeOKPPwb1dhrF8XH2tCaGnc3ND5Tza8Ohtw0SDfWVUjEfKbW7H9t/aWuEviQ5X
         Ecdii3UKCEgjQWjEGfe8SwNZJOkXrfPBE48/qDPskmMbPzdROGEQYw/FWJjEwqvLr7bK
         Mz49YCrwZ3L3G6rM3l4WaP5kL8VrMCxQ/JgOpRmabfSRmrieVZgQ7gITSP7VPNpInvmk
         Teew==
X-Gm-Message-State: AOAM532ZmmAmr5yFaTIzT9x27Tj4Pog8qdKAmu7qjFuR8SEx20y3yJ5C
        +6Ms8LEdWAIMa5VFgjHfuMsBExJcLXMBsR6QzmzC5uW91YZH8HyleMX/huIk5fVb+Ly/BYhMgRi
        rdvwSzk33UUkEH6A4+xwQ5Jhs
X-Received: by 2002:a1c:4684:: with SMTP id t126mr21204126wma.165.1608634657599;
        Tue, 22 Dec 2020 02:57:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxnZK58B0WG9HQAYkhmv2Ni3xwkfZ+ilVxWV+8a3a96JzWjI13O3HYHbD/TbNH2vg1Rhw94SQ==
X-Received: by 2002:a1c:4684:: with SMTP id t126mr21204104wma.165.1608634657357;
        Tue, 22 Dec 2020 02:57:37 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it. [79.34.249.199])
        by smtp.gmail.com with ESMTPSA id z22sm25892487wml.1.2020.12.22.02.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 02:57:36 -0800 (PST)
Date:   Tue, 22 Dec 2020 11:57:33 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>,
        linux-kernel@vger.kernel.org, Eli Cohen <elic@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH RFC 00/12] vdpa: generalize vdpa simulator and add block
 device
Message-ID: <20201222105733.4f6oou7lshi35qvc@steredhat>
References: <20201113134712.69744-1-sgarzare@redhat.com>
 <93f207c0-61e6-3696-f218-e7d7ea9a7c93@redhat.com>
 <20201218113816.zcyeyqipux4ao4cp@steredhat>
 <7dd3ed02-36c3-fcfd-0a1d-9c31af6f473e@redhat.com>
 <20201221111423.sestfroiw2dgpluc@steredhat>
 <856d53c2-82e2-e408-76e6-24c92010f973@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <856d53c2-82e2-e408-76e6-24c92010f973@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 22, 2020 at 10:44:48AM +0800, Jason Wang wrote:
>
>On 2020/12/21 下午7:14, Stefano Garzarella wrote:
>>On Mon, Dec 21, 2020 at 11:16:54AM +0800, Jason Wang wrote:
>>>
>>>On 2020/12/18 下午7:38, Stefano Garzarella wrote:
>>>>On Mon, Nov 16, 2020 at 11:37:48AM +0800, Jason Wang wrote:
>>>>>
>>>>>On 2020/11/13 下午9:47, Stefano Garzarella wrote:
>>>>>>Thanks to Max that started this work!
>>>>>>I took his patches, and extended the block simulator a bit.
>>>>>>
>>>>>>This series moves the network device simulator in a new module
>>>>>>(vdpa_sim_net) and leaves the generic functions in the vdpa_sim core
>>>>>>module, allowing the possibility to add new vDPA device simulators.
>>>>>>Then we added a new vdpa_sim_blk module to simulate a block device.
>>>>>>
>>>>>>I'm not sure about patch 11 ("vringh: allow vringh_iov_xfer() to skip
>>>>>>bytes when ptr is NULL"), maybe we can add a new functions instead of
>>>>>>modify vringh_iov_xfer().
>>>>>>
>>>>>>As Max reported, I'm also seeing errors with vdpa_sim_blk related to
>>>>>>iotlb and vringh when there is high load, these are some of the error
>>>>>>messages I can see randomly:
>>>>>>
>>>>>>  vringh: Failed to access avail idx at 00000000e8deb2cc
>>>>>>  vringh: Failed to read head: idx 6289 address 00000000e1ad1d50
>>>>>>  vringh: Failed to get flags at 000000006635d7a3
>>>>>>
>>>>>>  virtio_vdpa vdpa0: vringh_iov_push_iotlb() error: -14 
>>>>>>offset:   0x2840000 len: 0x20000
>>>>>>  virtio_vdpa vdpa0: vringh_iov_pull_iotlb() error: -14 
>>>>>>offset:   0x58ee000 len: 0x3000
>>>>>>
>>>>>>These errors should all be related to the fact that iotlb_translate()
>>>>>>fails with -EINVAL, so it seems that we miss some mapping.
>>>>>
>>>>>
>>>>>Is this only reproducible when there's multiple co-current 
>>>>>accessing of IOTLB? If yes, it's probably a hint that some 
>>>>>kind of synchronization is still missed somewhere.
>>>>>
>>>>>It might be useful to log the dma_map/unmp in both virtio_ring 
>>>>>and vringh to see who is missing the map.
>>>>>
>>>>
>>>>Just an update about these issues with vdpa-sim-blk.
>>>>I've been focusing a little bit on these failures over the last 
>>>>few days and have found two issues related to the IOTLB/IOMMU:
>>>>
>>>>1. Some requests coming from the block layer fills the SG list 
>>>>with multiple buffers that had the same physical address. This 
>>>>happens for example while using 'mkfs', at some points multiple 
>>>>sectors are zeroed so multiple SG elements point to the same 
>>>>physical page that is zeroed.
>>>>Since we are using vhost_iotlb_del_range() in the 
>>>>vdpasim_unmap_page(), this removes all the overlapped ranges. I 
>>>>fixed removing a single map in vdpasim_unmap_page(), but has an 
>>>>alternative we can implement some kind of reference counts.
>>>
>>>
>>>I think we need to do what hardware do. So using refcount is 
>>>probably not a good ida.
>>
>>Okay, so since we are using for simplicity an identical mapping, we 
>>are assigning the same dma_addr to multiple pages.
>
>
>I think I get you now. That's the root cause for the failure.

Yes, sorry, I didn't explain well previously.

>
>Then I think we need an simple iova allocator for vdpa simulator, and 
>it might be useful for VDUSE as well.

Okay, I'll work on it.
If you have an example to follow or some pointers, they are welcome :-)

Thanks,
Stefano

