Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA1652DFB70
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 12:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgLULP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 06:15:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33188 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726526AbgLULP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 06:15:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608549269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZDuzjQILtwz+gw9q0HmA3y9zkFhYkHaBbPqeWnl780o=;
        b=H3+QLBjB+lAZijdExmTGmDyu53bIJW2w1z3Dlb058IyN6bd2G5jVch3Ww4kIWpYqa2q9Rg
        /UXFHeYf2URSzgpkNUa57D7EUxN3aTpH8ix5o2K9FgfYckQ7Irjw9Lc48vntLRJ/kksUb1
        BfDnoMYAPxKufKHiWBOXy5GAvjIgud0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-547-Ubnj8GMhMX-4lyecaGWgAg-1; Mon, 21 Dec 2020 06:14:28 -0500
X-MC-Unique: Ubnj8GMhMX-4lyecaGWgAg-1
Received: by mail-wm1-f71.google.com with SMTP id s130so6679843wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 03:14:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZDuzjQILtwz+gw9q0HmA3y9zkFhYkHaBbPqeWnl780o=;
        b=pPOydtstQUfHCPyrcVgexA+C0sKiLhHZLUFSy139QGDDkLCl4tmkf3nTCxHatq6Bg3
         szPEySTkhQr7kv30d9fVTHjQZaLpNDSU3xcT4FfA7Es1s0kJ1GKTdcwUIpicGDYGsRil
         sOXtamTyMVMv21bSiaqZ1C8CfI0H2gtTspXyEGkiSLX7uuISonE6WHANNuA9ptuoy58d
         hzYLvPtwguccOIyqkZ3O7unAPRLY9MIRNTERMx5gAN3pAJw/DU/7KmC8schjy+n4luAg
         pF2GIRHfNt6FUFdrOJwYWuONRu9wC8Z3E9NvVQZ1YpEYA3TGbwzDWrInI2OqJiAqPpRj
         e9Fg==
X-Gm-Message-State: AOAM53283zqZ0VFvuQ/drew5RK5RX2yEu060yf4gm7go1QY8o1tuEyBl
        jLPiyWx/sG8IExvI7KMhPx8at+XzgmMXjl4hRXAWwoqSrvml31thfVUrsuK2PpE2N3lb9SXogsI
        xIgZorAkEAsEJfmxevz1390b3
X-Received: by 2002:adf:e710:: with SMTP id c16mr18449653wrm.295.1608549266981;
        Mon, 21 Dec 2020 03:14:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz3nV2W14x0SGDcjI6dNEEZouk16bJA3Gmr/23ZBhO5vNIp1gfRAr6YwQplvjk3uknYrvF/0w==
X-Received: by 2002:adf:e710:: with SMTP id c16mr18449635wrm.295.1608549266799;
        Mon, 21 Dec 2020 03:14:26 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it. [79.34.249.199])
        by smtp.gmail.com with ESMTPSA id c10sm27792009wrb.92.2020.12.21.03.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 03:14:25 -0800 (PST)
Date:   Mon, 21 Dec 2020 12:14:23 +0100
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
Message-ID: <20201221111423.sestfroiw2dgpluc@steredhat>
References: <20201113134712.69744-1-sgarzare@redhat.com>
 <93f207c0-61e6-3696-f218-e7d7ea9a7c93@redhat.com>
 <20201218113816.zcyeyqipux4ao4cp@steredhat>
 <7dd3ed02-36c3-fcfd-0a1d-9c31af6f473e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7dd3ed02-36c3-fcfd-0a1d-9c31af6f473e@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 11:16:54AM +0800, Jason Wang wrote:
>
>On 2020/12/18 下午7:38, Stefano Garzarella wrote:
>>On Mon, Nov 16, 2020 at 11:37:48AM +0800, Jason Wang wrote:
>>>
>>>On 2020/11/13 下午9:47, Stefano Garzarella wrote:
>>>>Thanks to Max that started this work!
>>>>I took his patches, and extended the block simulator a bit.
>>>>
>>>>This series moves the network device simulator in a new module
>>>>(vdpa_sim_net) and leaves the generic functions in the vdpa_sim core
>>>>module, allowing the possibility to add new vDPA device simulators.
>>>>Then we added a new vdpa_sim_blk module to simulate a block device.
>>>>
>>>>I'm not sure about patch 11 ("vringh: allow vringh_iov_xfer() to skip
>>>>bytes when ptr is NULL"), maybe we can add a new functions instead of
>>>>modify vringh_iov_xfer().
>>>>
>>>>As Max reported, I'm also seeing errors with vdpa_sim_blk related to
>>>>iotlb and vringh when there is high load, these are some of the error
>>>>messages I can see randomly:
>>>>
>>>>  vringh: Failed to access avail idx at 00000000e8deb2cc
>>>>  vringh: Failed to read head: idx 6289 address 00000000e1ad1d50
>>>>  vringh: Failed to get flags at 000000006635d7a3
>>>>
>>>>  virtio_vdpa vdpa0: vringh_iov_push_iotlb() error: -14 offset: 
>>>>  0x2840000 len: 0x20000
>>>>  virtio_vdpa vdpa0: vringh_iov_pull_iotlb() error: -14 offset: 
>>>>  0x58ee000 len: 0x3000
>>>>
>>>>These errors should all be related to the fact that iotlb_translate()
>>>>fails with -EINVAL, so it seems that we miss some mapping.
>>>
>>>
>>>Is this only reproducible when there's multiple co-current 
>>>accessing of IOTLB? If yes, it's probably a hint that some kind of 
>>>synchronization is still missed somewhere.
>>>
>>>It might be useful to log the dma_map/unmp in both virtio_ring and 
>>>vringh to see who is missing the map.
>>>
>>
>>Just an update about these issues with vdpa-sim-blk.
>>I've been focusing a little bit on these failures over the last few 
>>days and have found two issues related to the IOTLB/IOMMU:
>>
>>1. Some requests coming from the block layer fills the SG list with 
>>multiple buffers that had the same physical address. This happens 
>>for example while using 'mkfs', at some points multiple sectors are 
>>zeroed so multiple SG elements point to the same physical page that 
>>is zeroed.
>>Since we are using vhost_iotlb_del_range() in the 
>>vdpasim_unmap_page(), this removes all the overlapped ranges. I 
>>fixed removing a single map in vdpasim_unmap_page(), but has an 
>>alternative we can implement some kind of reference counts.
>
>
>I think we need to do what hardware do. So using refcount is probably 
>not a good ida.

Okay, so since we are using for simplicity an identical mapping, we are 
assigning the same dma_addr to multiple pages.

So, it should be okay to remove a single mapping checking the others 
parameters (i.e. dir, size).

I'll send a patch, so with the code it should be easier :-)

Thanks,
Stefano

>
>
>>
>>2. There was a race between dma_map/unmap and the worker thread, 
>>since both are accessing the IOMMU. Taking the iommu_lock while 
>>using vhost_iotlb_* API in the worker thread fixes the "vringh: 
>>Failed to *" issues.
>>
>>Whit these issues fixed the vdpa-blk simulator seems to work well.
>>I'll send the patches next week or after the break.
>
>
>Good to know this.
>
>Thanks
>
>
>>
>>Thanks,
>>Stefano
>>
>

