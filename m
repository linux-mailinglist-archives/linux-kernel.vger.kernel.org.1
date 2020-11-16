Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 939402B4487
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 14:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbgKPNMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 08:12:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45884 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728017AbgKPNMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 08:12:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605532363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1MsyfwNa8Jx32AXWJVdoiRXVhLmfFI1tNXSgaZ45fq4=;
        b=FS2B2tSPC2hTRK/gO5gjkOp9ujZUzL9/ZfaqzkrnCn26eBjRtahhdzfFewgcFBLjoYZt8W
        CuHp97zP/31WI3xo0pdUpVwRB4b4/vU8G2G3ST9avt0TDqmeyNy/04zT3VBO9Hw/awa/Ae
        scYKdBzFYLw8vKjLELp2cWFCL1l75dI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-eaIXAlqdM_2NAUb2qEu6vA-1; Mon, 16 Nov 2020 08:12:42 -0500
X-MC-Unique: eaIXAlqdM_2NAUb2qEu6vA-1
Received: by mail-wr1-f71.google.com with SMTP id p16so11150626wrx.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 05:12:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1MsyfwNa8Jx32AXWJVdoiRXVhLmfFI1tNXSgaZ45fq4=;
        b=lrqgbO+6PWvoKcmGanXrNMNvTRy3bKmTGz3TKuRSq5nmsb7AXcvqWugMAErV1RYlAN
         OTmrIHG5gjCr+Fdqh9GJdMeY2AELfszLNPILDTi362gcKO/LCwKYp/fM1A5MXlKDeFap
         ohChB3b4sU7ycIDJ9+4isKiU3dajnU9jq3qjkk8l5AUFEKx8anWwnBnHDxgkv/Abc8h5
         EwBeI+vq4rRW3SgCInX1AbYYyZyLDM6PGfncBBtI3HFrePMk6pVzVoWQT//pPkxz4aZN
         ycmBTjx+08Mc1SetYy6l05xVdbUuueK4rscXhltp11FmnOmcmcdVQlDAXg9IIc3zzM3Q
         maHg==
X-Gm-Message-State: AOAM531z643UJHD8p1OVIf3q7+icAY53YF3G7MqgKyOK7TlPWojiDgbN
        YpEuswY9EzHDx5wfIRKDUGiVBdp/GyTptuQ8IlQCA/SZvO/WRuDJubyujKJk5SnQpk4LxTr/fwW
        XcU8MptLg6GVd1D7HG4/UAtK8
X-Received: by 2002:a1c:3d54:: with SMTP id k81mr16012160wma.144.1605532360899;
        Mon, 16 Nov 2020 05:12:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxWEajR0OWDyqeKkIjBoeFIm1XjBpo/ZNOIzpQvPnoEBfltGFQv72xS2lc0N8QZKFC3zlWOfQ==
X-Received: by 2002:a1c:3d54:: with SMTP id k81mr16012142wma.144.1605532360706;
        Mon, 16 Nov 2020 05:12:40 -0800 (PST)
Received: from redhat.com ([147.161.8.56])
        by smtp.gmail.com with ESMTPSA id f19sm19145825wml.21.2020.11.16.05.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 05:12:39 -0800 (PST)
Date:   Mon, 16 Nov 2020 08:12:31 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alexander Lobakin <alobakin@pm.me>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Amit Shah <amit@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org, Suman Anna <s-anna@ti.com>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH virtio] virtio: virtio_console: fix DMA memory allocation
 for rproc serial
Message-ID: <20201116080943-mutt-send-email-mst@kernel.org>
References: <AOKowLclCbOCKxyiJ71WeNyuAAj2q8EUtxrXbyky5E@cp7-web-042.plabs.ch>
 <20201116091950.GA30524@infradead.org>
 <20201116071910-mutt-send-email-mst@kernel.org>
 <u9RJBckNwnezQttAPrOyEqDYKu0rnhedUZYGpaS83qg@cp3-web-024.plabs.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <u9RJBckNwnezQttAPrOyEqDYKu0rnhedUZYGpaS83qg@cp3-web-024.plabs.ch>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 01:07:28PM +0000, Alexander Lobakin wrote:
> From: "Michael S. Tsirkin" <mst@redhat.com>
> Date: Mon, 16 Nov 2020 07:25:31 -0500
> 
> > On Mon, Nov 16, 2020 at 09:19:50AM +0000, Christoph Hellwig wrote:
> >> I just noticed this showing up in Linus' tree and I'm not happy.
> >
> > Are you sure? I think it's in next.
> 
> Nope, it goes to fixes since it just fixes the regression introduced
> in 5.7.

Oh you are right, Greg merged it and I didn't notice because I didn't
rebase my tree.

> That's why it's not about any refactoring or rethinking the whole
> model.
> 
> >> This whole model of the DMA subdevices in remoteproc is simply broken.
> >>
> >> We really need to change the virtio code pass an expicit DMA device (
> >> similar to what e.g. the USB and RDMA code does), instead of faking up
> >> devices with broken adhoc inheritance of DMA properties and magic poking
> >> into device parent relationships.
> 
> But lots of subsystems like netdev for example uses dev->parent for
> DMA operations. I know that their pointers go directly to the
> platform/PCI/etc. device, but still.
> 
> The only reason behind "fake" DMA devices for rproc is to be able to
> reserve DMA memory through the Device Tree exclusively for only one
> virtio dev like virtio_console or virtio_rpmsg_bus. That's why
> they are present, are coercing DMA caps from physical dev
> representor, and why questinable dma_declare_coherent_memory()
> is still here and doesn't allow to build rproc core as a module.
> I agree that this is not the best model obviously, and we should take
> a look at it.
> 
> > OK but we do have a regression since 5.7 and this looks like
> > a fix appropriate for e.g. stable, right?
> >
> >> Bjorn, I thought you were going to look into this a while ago?
> >>
> >>
> >> On Wed, Nov 04, 2020 at 03:31:36PM +0000, Alexander Lobakin wrote:
> >>> Since commit 086d08725d34 ("remoteproc: create vdev subdevice with
> >>> specific dma memory pool"), every remoteproc has a DMA subdevice
> >>> ("remoteprocX#vdevYbuffer") for each virtio device, which inherits
> >>> DMA capabilities from the corresponding platform device. This allowed
> >>> to associate different DMA pools with each vdev, and required from
> >>> virtio drivers to perform DMA operations with the parent device
> >>> (vdev->dev.parent) instead of grandparent (vdev->dev.parent->parent).
> >>>
> >>> virtio_rpmsg_bus was already changed in the same merge cycle with
> >>> commit d999b622fcfb ("rpmsg: virtio: allocate buffer from parent"),
> >>> but virtio_console did not. In fact, operations using the grandparent
> >>> worked fine while the grandparent was the platform device, but since
> >>> commit c774ad010873 ("remoteproc: Fix and restore the parenting
> >>> hierarchy for vdev") this was changed, and now the grandparent device
> >>> is the remoteproc device without any DMA capabilities.
> >>> So, starting v5.8-rc1 the following warning is observed:
> >>>
> >>> [    2.483925] ------------[ cut here ]------------
> >>> [    2.489148] WARNING: CPU: 3 PID: 101 at kernel/dma/mapping.c:427 0x80e7eee8
> >>> [    2.489152] Modules linked in: virtio_console(+)
> >>> [    2.503737]  virtio_rpmsg_bus rpmsg_core
> >>> [    2.508903]
> >>> [    2.528898] <Other modules, stack and call trace here>
> >>> [    2.913043]
> >>> [    2.914907] ---[ end trace 93ac8746beab612c ]---
> >>> [    2.920102] virtio-ports vport1p0: Error allocating inbufs
> >>>
> >>> kernel/dma/mapping.c:427 is:
> >>>
> >>> WARN_ON_ONCE(!dev->coherent_dma_mask);
> >>>
> >>> obviously because the grandparent now is remoteproc dev without any
> >>> DMA caps:
> >>>
> >>> [    3.104943] Parent: remoteproc0#vdev1buffer, grandparent: remoteproc0
> >>>
> >>> Fix this the same way as it was for virtio_rpmsg_bus, using just the
> >>> parent device (vdev->dev.parent, "remoteprocX#vdevYbuffer") for DMA
> >>> operations.
> >>> This also allows now to reserve DMA pools/buffers for rproc serial
> >>> via Device Tree.
> >>>
> >>> Fixes: c774ad010873 ("remoteproc: Fix and restore the parenting hierarchy for vdev")
> >>> Cc: stable@vger.kernel.org # 5.1+
> >>> Signed-off-by: Alexander Lobakin <alobakin@pm.me>
> >>> ---
> >>>  drivers/char/virtio_console.c | 8 ++++----
> >>>  1 file changed, 4 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> >>> index a2da8f768b94..1836cc56e357 100644
> >>> --- a/drivers/char/virtio_console.c
> >>> +++ b/drivers/char/virtio_console.c
> >>> @@ -435,12 +435,12 @@ static struct port_buffer *alloc_buf(struct virtio_device *vdev, size_t buf_size
> >>>  		/*
> >>>  		 * Allocate DMA memory from ancestor. When a virtio
> >>>  		 * device is created by remoteproc, the DMA memory is
> >>> -		 * associated with the grandparent device:
> >>> -		 * vdev => rproc => platform-dev.
> >>> +		 * associated with the parent device:
> >>> +		 * virtioY => remoteprocX#vdevYbuffer.
> >>>  		 */
> >>> -		if (!vdev->dev.parent || !vdev->dev.parent->parent)
> >>> +		buf->dev = vdev->dev.parent;
> >>> +		if (!buf->dev)
> >>>  			goto free_buf;
> >>> -		buf->dev = vdev->dev.parent->parent;
> >>>
> >>>  		/* Increase device refcnt to avoid freeing it */
> >>>  		get_device(buf->dev);
> >>> --
> >>> 2.29.2
> >>>
> >>>
> >> ---end quoted text---
> 
> Thanks,
> Al

