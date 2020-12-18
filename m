Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E062DE215
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 12:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgLRLju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 06:39:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32011 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726267AbgLRLjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 06:39:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608291502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pyrPuPaxt/+ULQwnKy518EjPiNWx6UpiJp5ti3eLczU=;
        b=Li6Qo4Z25vkPtEiqVG3zCpCZc1LAeNNSWCRJsRSgKb08tYTAcTsY8bUFrgDLol7vDClvXM
        SfeuxiYg29VRth+H2ac0yxYhV/5HcjWU38eHGvL9wbGXiIvrFTjuhrC1z/o5G5QTcWlXvX
        p6YIJY24b0uIBNdADR12kwNuVIRanbQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-KkEj5TtGOSitdbNIuiHskQ-1; Fri, 18 Dec 2020 06:38:20 -0500
X-MC-Unique: KkEj5TtGOSitdbNIuiHskQ-1
Received: by mail-wr1-f70.google.com with SMTP id v1so1046723wri.16
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 03:38:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pyrPuPaxt/+ULQwnKy518EjPiNWx6UpiJp5ti3eLczU=;
        b=CJ1umOfoKsxthuXJEO0LLfa5ypBe1K7SFu5GF3AQDQkKT0J6WfnKbpHdFlamdfwdJe
         z1R3xgvHK1jCU+19UHrblTyICU1CJnuHhsa2b8aLZRcdQX7SG2w4VEeKKBgp2/FwSgXi
         56T81hlbewqYcQ0KDLwJopv/cVgVsc+IxRJJV3r0NzPel2EaDaaoANS8Vg+/C4lxaHRd
         DKO8I3+2Sdh76MBdKoJ7s9mAW40xpjo6LRqQmN2Sr5O77mSnhml6G6dfp8/JTM9FOpbH
         OvRp6P7EHso0VLmj119OzyQ/GBRPBzde1mhPnf3qu+KAqfGaGzcq+LjO0GgN6jDLwueK
         9zuw==
X-Gm-Message-State: AOAM532gR4hfxWw+uYGZIFVczf7Uny9dTonnrijWNOxNBbsM5l+6nacz
        5BIC2iY47qOU+Z8iUC8PsHNvlcrkDdGTgjXLRPZakMsV6Yf6eKd9Saz954YSXyrI5MygWRu1ybN
        WaFV5G1be3sDh5pHeojvHiSmx
X-Received: by 2002:a1c:9c52:: with SMTP id f79mr3844501wme.3.1608291499367;
        Fri, 18 Dec 2020 03:38:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzukL6Prl59FigQna6+aohMdU4wEFXfPaVe/UPsJdUR7FnJxLK1fC8EtDnc3DzTPCIG/QswiQ==
X-Received: by 2002:a1c:9c52:: with SMTP id f79mr3844480wme.3.1608291499121;
        Fri, 18 Dec 2020 03:38:19 -0800 (PST)
Received: from steredhat (host-79-13-204-15.retail.telecomitalia.it. [79.13.204.15])
        by smtp.gmail.com with ESMTPSA id c4sm12126404wmf.19.2020.12.18.03.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 03:38:18 -0800 (PST)
Date:   Fri, 18 Dec 2020 12:38:16 +0100
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
Message-ID: <20201218113816.zcyeyqipux4ao4cp@steredhat>
References: <20201113134712.69744-1-sgarzare@redhat.com>
 <93f207c0-61e6-3696-f218-e7d7ea9a7c93@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <93f207c0-61e6-3696-f218-e7d7ea9a7c93@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 11:37:48AM +0800, Jason Wang wrote:
>
>On 2020/11/13 下午9:47, Stefano Garzarella wrote:
>>Thanks to Max that started this work!
>>I took his patches, and extended the block simulator a bit.
>>
>>This series moves the network device simulator in a new module
>>(vdpa_sim_net) and leaves the generic functions in the vdpa_sim core
>>module, allowing the possibility to add new vDPA device simulators.
>>Then we added a new vdpa_sim_blk module to simulate a block device.
>>
>>I'm not sure about patch 11 ("vringh: allow vringh_iov_xfer() to skip
>>bytes when ptr is NULL"), maybe we can add a new functions instead of
>>modify vringh_iov_xfer().
>>
>>As Max reported, I'm also seeing errors with vdpa_sim_blk related to
>>iotlb and vringh when there is high load, these are some of the error
>>messages I can see randomly:
>>
>>   vringh: Failed to access avail idx at 00000000e8deb2cc
>>   vringh: Failed to read head: idx 6289 address 00000000e1ad1d50
>>   vringh: Failed to get flags at 000000006635d7a3
>>
>>   virtio_vdpa vdpa0: vringh_iov_push_iotlb() error: -14 offset: 
>>   0x2840000 len: 0x20000
>>   virtio_vdpa vdpa0: vringh_iov_pull_iotlb() error: -14 offset: 
>>   0x58ee000 len: 0x3000
>>
>>These errors should all be related to the fact that iotlb_translate()
>>fails with -EINVAL, so it seems that we miss some mapping.
>
>
>Is this only reproducible when there's multiple co-current accessing 
>of IOTLB? If yes, it's probably a hint that some kind of 
>synchronization is still missed somewhere.
>
>It might be useful to log the dma_map/unmp in both virtio_ring and 
>vringh to see who is missing the map.
>

Just an update about these issues with vdpa-sim-blk.
I've been focusing a little bit on these failures over the last few days 
and have found two issues related to the IOTLB/IOMMU:

1. Some requests coming from the block layer fills the SG list with 
multiple buffers that had the same physical address. This happens for 
example while using 'mkfs', at some points multiple sectors are zeroed 
so multiple SG elements point to the same physical page that is zeroed.
Since we are using vhost_iotlb_del_range() in the vdpasim_unmap_page(), 
this removes all the overlapped ranges. I fixed removing a single map in 
vdpasim_unmap_page(), but has an alternative we can implement some kind 
of reference counts.

2. There was a race between dma_map/unmap and the worker thread, since 
both are accessing the IOMMU. Taking the iommu_lock while using 
vhost_iotlb_* API in the worker thread fixes the "vringh: Failed to *" 
issues.

Whit these issues fixed the vdpa-blk simulator seems to work well.
I'll send the patches next week or after the break.

Thanks,
Stefano

