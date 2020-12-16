Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A09242DBDF9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 10:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgLPJtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 04:49:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56791 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726243AbgLPJtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 04:49:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608112072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OnpaGqF6fBlhxGH2HmymIgB4u9qh1ujRtHG8EyWDWNA=;
        b=S37JJaeN+tRTM5rwkgZRcuMNgV1z6SAGGXudiIYKPkJxOhu/nSVVNc3ErBSTi5BKH8ZMxI
        9WRjqDx+QsZy42oWKrlbj56e9k6Aun3Jc0TcA/TgNcnhPK62BHJGgbxAj1eezFwaVkWs/7
        sLi/+SrwMhx8z5IgX2VMXetBSwzgG/Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-lZy3PngKPFe3I7duVb69EQ-1; Wed, 16 Dec 2020 04:47:50 -0500
X-MC-Unique: lZy3PngKPFe3I7duVb69EQ-1
Received: by mail-wm1-f70.google.com with SMTP id b194so560260wmd.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 01:47:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OnpaGqF6fBlhxGH2HmymIgB4u9qh1ujRtHG8EyWDWNA=;
        b=B8qY9YPZovisdEy/fmaB65CLD5yIH9ArUVNpOpB7yTwrN1cXzw/QWUNFMkISA2UUsQ
         MQqYRReuv2ci/7FWO+95y2rkYUA4oyTOY+//s4efJ3xnEsdnuUFLIDIVIrzPLr/S1Xoz
         sT/PRZEejilWdTD0N33d0Pc7Yo3A4mgKr2pAYpZQDR/nCNQI2EAH+crMS4tw+PjuscTo
         gzaaIp8gzGL/tnIXSgoJjPXHRppgyOJx8phdK/2vMNE0zDE/hLjmQS+9QPY3BQ0HdEXC
         uyttZfeJQ1jxmjNxP6n6qHm4WFrDP0iqJWvnwiJGWsHGp0R9gqBo+4gO0Bibp7GSWCvX
         zmbw==
X-Gm-Message-State: AOAM533cFZLMeow8STtmPXGp/RhXzAWiQkbWaW7UE58617szZWfRimq1
        shETpSkvoQ/XwoAgALsWgjri0jZUWPHOombHNB5MmqVgCoemASjKltqjpcD144Vo0dROUUh+/DI
        W8FkltUihjU1N/3VJtL+z56mD
X-Received: by 2002:adf:dc08:: with SMTP id t8mr37436431wri.195.1608112069510;
        Wed, 16 Dec 2020 01:47:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzfV1vXW29xJdPdujDOdRLOpVukt+skk2qfzG8oqvVv1VkOHFftPxLfa9EpZYgdf+afl0EleA==
X-Received: by 2002:adf:dc08:: with SMTP id t8mr37436406wri.195.1608112069274;
        Wed, 16 Dec 2020 01:47:49 -0800 (PST)
Received: from redhat.com (bzq-109-67-15-113.red.bezeqint.net. [109.67.15.113])
        by smtp.gmail.com with ESMTPSA id l5sm2422805wrv.44.2020.12.16.01.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 01:47:48 -0800 (PST)
Date:   Wed, 16 Dec 2020 04:47:45 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     eperezma@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, lulu@redhat.com, eli@mellanox.com,
        lingshan.zhu@intel.com, rob.miller@broadcom.com,
        stefanha@redhat.com, sgarzare@redhat.com
Subject: Re: [PATCH 00/21] Control VQ support in vDPA
Message-ID: <20201216044051-mutt-send-email-mst@kernel.org>
References: <20201216064818.48239-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201216064818.48239-1-jasowang@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 16, 2020 at 02:47:57PM +0800, Jason Wang wrote:
> Hi All:
> 
> This series tries to add the support for control virtqueue in vDPA.
> 
> Control virtqueue is used by networking device for accepting various
> commands from the driver. It's a must to support multiqueue and other
> configurations.
> 
> When used by vhost-vDPA bus driver for VM, the control virtqueue
> should be shadowed via userspace VMM (Qemu) instead of being assigned
> directly to Guest. This is because Qemu needs to know the device state
> in order to start and stop device correctly (e.g for Live Migration).
> 
> This requies to isolate the memory mapping for control virtqueue
> presented by vhost-vDPA to prevent guest from accesing it directly.
> To achieve this, vDPA introduce two new abstractions:
> 
> - address space: identified through address space id (ASID) and a set
>                  of memory mapping in maintained
> - virtqueue group: the minimal set of virtqueues that must share an
>                  address space

How will this support the pretty common case where control vq
is programmed by the kernel through the PF, and others by the VFs?


I actually thought the way to support it is by exposing
something like an "inject buffers" API which sends data to a given VQ.
Maybe an ioctl, and maybe down the road uio ring can support batching
these ....


> 
> Device needs to advertise the following attributes to vDPA:
> 
> - the number of address spaces supported in the device
> - the number of virtqueue groups supported in the device
> - the mappings from a specific virtqueue to its virtqueue groups
> 
> The mappings from virtqueue to virtqueue groups is fixed and defined
> by vDPA device driver. E.g:
> 
> - For the device that has hardware ASID support, it can simply
>   advertise a per virtqueue virtqueue group.
> - For the device that does not have hardware ASID support, it can
>   simply advertise a single virtqueue group that contains all
>   virtqueues. Or if it wants a software emulated control virtqueue, it
>   can advertise two virtqueue groups, one is for cvq, another is for
>   the rest virtqueues.
> 
> vDPA also allow to change the association between virtqueue group and
> address space. So in the case of control virtqueue, userspace
> VMM(Qemu) may use a dedicated address space for the control virtqueue
> group to isolate the memory mapping.
> 
> The vhost/vhost-vDPA is also extend for the userspace to:
> 
> - query the number of virtqueue groups and address spaces supported by
>   the device
> - query the virtqueue group for a specific virtqueue
> - assocaite a virtqueue group with an address space
> - send ASID based IOTLB commands
> 
> This will help userspace VMM(Qemu) to detect whether the control vq
> could be supported and isolate memory mappings of control virtqueue
> from the others.
> 
> To demonstrate the usage, vDPA simulator is extended to support
> setting MAC address via a emulated control virtqueue.
> 
> Please review.
> 
> Changes since RFC:
> 
> - tweak vhost uAPI documentation
> - switch to use device specific IOTLB really in patch 4
> - tweak the commit log
> - fix that ASID in vhost is claimed to be 32 actually but 16bit
>   actually
> - fix use after free when using ASID with IOTLB batching requests
> - switch to use Stefano's patch for having separated iov
> - remove unused "used_as" variable
> - fix the iotlb/asid checking in vhost_vdpa_unmap()
> 
> Thanks
> 
> Jason Wang (20):
>   vhost: move the backend feature bits to vhost_types.h
>   virtio-vdpa: don't set callback if virtio doesn't need it
>   vhost-vdpa: passing iotlb to IOMMU mapping helpers
>   vhost-vdpa: switch to use vhost-vdpa specific IOTLB
>   vdpa: add the missing comment for nvqs in struct vdpa_device
>   vdpa: introduce virtqueue groups
>   vdpa: multiple address spaces support
>   vdpa: introduce config operations for associating ASID to a virtqueue
>     group
>   vhost_iotlb: split out IOTLB initialization
>   vhost: support ASID in IOTLB API
>   vhost-vdpa: introduce asid based IOTLB
>   vhost-vdpa: introduce uAPI to get the number of virtqueue groups
>   vhost-vdpa: introduce uAPI to get the number of address spaces
>   vhost-vdpa: uAPI to get virtqueue group id
>   vhost-vdpa: introduce uAPI to set group ASID
>   vhost-vdpa: support ASID based IOTLB API
>   vdpa_sim: advertise VIRTIO_NET_F_MTU
>   vdpa_sim: factor out buffer completion logic
>   vdpa_sim: filter destination mac address
>   vdpasim: control virtqueue support
> 
> Stefano Garzarella (1):
>   vdpa_sim: split vdpasim_virtqueue's iov field in out_iov and in_iov
> 
>  drivers/vdpa/ifcvf/ifcvf_main.c   |   9 +-
>  drivers/vdpa/mlx5/net/mlx5_vnet.c |  11 +-
>  drivers/vdpa/vdpa.c               |   8 +-
>  drivers/vdpa/vdpa_sim/vdpa_sim.c  | 292 ++++++++++++++++++++++++------
>  drivers/vhost/iotlb.c             |  23 ++-
>  drivers/vhost/vdpa.c              | 246 ++++++++++++++++++++-----
>  drivers/vhost/vhost.c             |  23 ++-
>  drivers/vhost/vhost.h             |   4 +-
>  drivers/virtio/virtio_vdpa.c      |   2 +-
>  include/linux/vdpa.h              |  42 ++++-
>  include/linux/vhost_iotlb.h       |   2 +
>  include/uapi/linux/vhost.h        |  25 ++-
>  include/uapi/linux/vhost_types.h  |  10 +-
>  13 files changed, 561 insertions(+), 136 deletions(-)
> 
> -- 
> 2.25.1

