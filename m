Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCA9D2B3BE2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 04:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbgKPDiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 22:38:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31292 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726203AbgKPDiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 22:38:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605497885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sJuVxD8MKBr57zv/aexgnLowqoN1xbyWUa+Emh3GwGE=;
        b=EwdKSOYVVF287ZQXZ8Lkw4/oHYGW/IA2+ewQPdqOo5XHEqrsG3tZnOWD0OZAjuqyaUw4FU
        KLRzsAGE5Od6RdDpY34iXcaMMOJIlEzj6RIh0IHq4SUq6voBZci9yDgzWVy9+7NDyLSv95
        gE5VIjmXIu2cnknwFYMkz8vtki7OlVo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-xKPNSRrfMP-foyIS6wm_3Q-1; Sun, 15 Nov 2020 22:38:03 -0500
X-MC-Unique: xKPNSRrfMP-foyIS6wm_3Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 52A458049D6;
        Mon, 16 Nov 2020 03:38:02 +0000 (UTC)
Received: from [10.72.13.126] (ovpn-13-126.pek2.redhat.com [10.72.13.126])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 502A227CC5;
        Mon, 16 Nov 2020 03:37:50 +0000 (UTC)
Subject: Re: [PATCH RFC 00/12] vdpa: generalize vdpa simulator and add block
 device
To:     Stefano Garzarella <sgarzare@redhat.com>,
        virtualization@lists.linux-foundation.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>,
        linux-kernel@vger.kernel.org, Eli Cohen <elic@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
References: <20201113134712.69744-1-sgarzare@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <93f207c0-61e6-3696-f218-e7d7ea9a7c93@redhat.com>
Date:   Mon, 16 Nov 2020 11:37:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201113134712.69744-1-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/11/13 下午9:47, Stefano Garzarella wrote:
> Thanks to Max that started this work!
> I took his patches, and extended the block simulator a bit.
>
> This series moves the network device simulator in a new module
> (vdpa_sim_net) and leaves the generic functions in the vdpa_sim core
> module, allowing the possibility to add new vDPA device simulators.
> Then we added a new vdpa_sim_blk module to simulate a block device.
>
> I'm not sure about patch 11 ("vringh: allow vringh_iov_xfer() to skip
> bytes when ptr is NULL"), maybe we can add a new functions instead of
> modify vringh_iov_xfer().
>
> As Max reported, I'm also seeing errors with vdpa_sim_blk related to
> iotlb and vringh when there is high load, these are some of the error
> messages I can see randomly:
>
>    vringh: Failed to access avail idx at 00000000e8deb2cc
>    vringh: Failed to read head: idx 6289 address 00000000e1ad1d50
>    vringh: Failed to get flags at 000000006635d7a3
>
>    virtio_vdpa vdpa0: vringh_iov_push_iotlb() error: -14 offset: 0x2840000 len: 0x20000
>    virtio_vdpa vdpa0: vringh_iov_pull_iotlb() error: -14 offset: 0x58ee000 len: 0x3000
>
> These errors should all be related to the fact that iotlb_translate()
> fails with -EINVAL, so it seems that we miss some mapping.


Is this only reproducible when there's multiple co-current accessing of 
IOTLB? If yes, it's probably a hint that some kind of synchronization is 
still missed somewhere.

It might be useful to log the dma_map/unmp in both virtio_ring and 
vringh to see who is missing the map.

Thanks


>
> I'll debug more carefully, in the meantime can you give a first review?
>
> Thanks,
> Stefano
>
> Max Gurtovoy (4):
>    vhost-vdpa: add support for vDPA blk devices
>    vdpa: split vdpasim to core and net modules
>    vdpa_sim: remove hard-coded virtq count
>    vdpa: add vdpa simulator for block device
>
> Stefano Garzarella (8):
>    vdpa_sim: remove the limit of IOTLB entries
>    vdpa_sim: add struct vdpasim_device to store device properties
>    vdpa_sim: move config management outside of the core
>    vdpa_sim: use kvmalloc to allocate vdpasim->buffer
>    vdpa_sim: make vdpasim->buffer size configurable
>    vdpa_sim: split vdpasim_virtqueue's iov field in riov and wiov
>    vringh: allow vringh_iov_xfer() to skip bytes when ptr is NULL
>    vdpa_sim_blk: implement ramdisk behaviour
>
>   drivers/vdpa/vdpa_sim/vdpa_sim.h     | 117 +++++++++++
>   drivers/vdpa/vdpa_sim/vdpa_sim.c     | 283 +++++----------------------
>   drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 251 ++++++++++++++++++++++++
>   drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 172 ++++++++++++++++
>   drivers/vhost/vdpa.c                 |  11 +-
>   drivers/vhost/vringh.c               |  16 +-
>   drivers/vdpa/Kconfig                 |  16 +-
>   drivers/vdpa/vdpa_sim/Makefile       |   2 +
>   8 files changed, 628 insertions(+), 240 deletions(-)
>   create mode 100644 drivers/vdpa/vdpa_sim/vdpa_sim.h
>   create mode 100644 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
>   create mode 100644 drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>

