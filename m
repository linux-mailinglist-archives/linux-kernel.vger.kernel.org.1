Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 237A92B3F29
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 09:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbgKPIxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 03:53:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22373 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726291AbgKPIxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 03:53:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605516798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=azmEdku+v957nDfLerEj6eIbgCibvT//LlaEDmIrd4c=;
        b=UFYTVEn5HL5fLA43ADRRwXo1Yz+ExKkApc0Lx1yW4VH7U17o4eSKRdlwcNcQVP7VcFONwS
        +JoJsrVp492uABFxulQXYQJ/y6VkGWXI3KVN51b0ZB2cmSBPK5rP2N74pWl9fUADHl+ok3
        eBhVWS/BDe3Jea79MUnydmXraZsMcMQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-_2aEDRkaNz-2OsuAmHRGvQ-1; Mon, 16 Nov 2020 03:53:16 -0500
X-MC-Unique: _2aEDRkaNz-2OsuAmHRGvQ-1
Received: by mail-wr1-f69.google.com with SMTP id p16so10847588wrx.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 00:53:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=azmEdku+v957nDfLerEj6eIbgCibvT//LlaEDmIrd4c=;
        b=nKMtK/Bj01K4vMgcW2H8IcBjoUEDGStwcJ07zNsfry+OBxqpom4XYdEPHbUWUzQtY4
         WvWSMtEhNfpVGMO4ZCrWuqt9pcjMv7eliIEb68wgejM33jpcCRZxJkzIcTatnUDgi1J7
         o+wVvc6FvULTuCC2q1yCm9x9kBbB0p/q7qv40CX+ssf+J7baraDfQzNdIg/P1MzoVzkV
         x6SXiG8Bp+P+sbptTpWBsvahOVwWZxAUo4B+u/uqvNFHDBXMPB2BOKUEGrxLYiJo7Kdo
         XhYzyL1sUncIhdAN2QfcfoP7yuB9cH1BXmGP30zaTA6ugLQ/wXOKWnQHAngI0O42B+wX
         T1Gg==
X-Gm-Message-State: AOAM532kcs57sSCzuKfp4+7BiPnOys85dj8t4F0iLC2VoN9uKYgA5Ozx
        iiljIC0sVg0rjvJWhDmg4oXpftYCuQcBk2eCssn6XcH/NsSABb0/WEfGVrlEIvmKEvRPFjujgz4
        dlUFjyE7/RQ8qHAwfMAB1r26T
X-Received: by 2002:adf:8030:: with SMTP id 45mr18011633wrk.407.1605516795092;
        Mon, 16 Nov 2020 00:53:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz5n/AE2nQyDKnmQoyCVlmIjPAbEsArXe/3Q5hcir6iosfRJevDexRLbmoqU1yU9ow+HAnSAQ==
X-Received: by 2002:adf:8030:: with SMTP id 45mr18011610wrk.407.1605516794887;
        Mon, 16 Nov 2020 00:53:14 -0800 (PST)
Received: from steredhat (host-79-17-248-175.retail.telecomitalia.it. [79.17.248.175])
        by smtp.gmail.com with ESMTPSA id u5sm17132310wro.56.2020.11.16.00.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 00:53:13 -0800 (PST)
Date:   Mon, 16 Nov 2020 09:53:11 +0100
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
Message-ID: <20201116085311.erzo2z322qesw5in@steredhat>
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
>>   virtio_vdpa vdpa0: vringh_iov_push_iotlb() error: -14 offset: 0x2840000 len: 0x20000
>>   virtio_vdpa vdpa0: vringh_iov_pull_iotlb() error: -14 offset: 0x58ee000 len: 0x3000
>>
>>These errors should all be related to the fact that iotlb_translate()
>>fails with -EINVAL, so it seems that we miss some mapping.
>
>
>Is this only reproducible when there's multiple co-current accessing 
>of IOTLB? If yes, it's probably a hint that some kind of 
>synchronization is still missed somewhere.

Yeah, maybe this is the case where virtio_ring and vringh use IOTLB 
concorrentetively.

>
>It might be useful to log the dma_map/unmp in both virtio_ring and 
>vringh to see who is missing the map.

I'll try.

Thanks for the hints,
Stefano

