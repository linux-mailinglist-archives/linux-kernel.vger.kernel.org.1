Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2432786D0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 14:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbgIYMQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 08:16:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:35652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728336AbgIYMQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 08:16:27 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B250422B2D;
        Fri, 25 Sep 2020 12:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601036187;
        bh=7+BsSmZJ1hOqFBKjy5Lwvr6BbeMcTQUirgr8OyJLBy0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QBML2NUrdUZOadvfEAwBUG6ycUUy03+IFhNrjJOp8Ig8fdrFmlBCk6nOeRZyhUoj7
         NiEP8J3ZayeCPuzlw3wvUtTq+9hdBR/kQHkUtPX2gPoUDj5TYWT4iWvlryLDRWB/Iv
         WMgPuV15YHiSEv4kiDBWM34Q3hd/FXzL1sLD4So8=
Date:   Fri, 25 Sep 2020 14:16:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     sudeep.dutt@intel.com, ashutosh.dixit@intel.com, arnd@arndb.de,
        wang.yi59@zte.com.cn, huang.zijiang@zte.com.cn,
        rikard.falkeborn@gmail.com, lee.jones@linaro.org, mst@redhat.com,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH 4/5] misc: vop: set VIRTIO_F_ACCESS_PLATFORM for
 nocoherent platform
Message-ID: <20200925121641.GB2680110@kroah.com>
References: <20200925072630.8157-1-sherry.sun@nxp.com>
 <20200925072630.8157-5-sherry.sun@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925072630.8157-5-sherry.sun@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 03:26:29PM +0800, Sherry Sun wrote:
> Set VIRTIO_F_ACCESS_PLATFORM feature for nocoherent platform, since
> it needs the DMA API for virtio.
> 
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> ---
>  drivers/misc/mic/vop/vop_main.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/misc/mic/vop/vop_main.c b/drivers/misc/mic/vop/vop_main.c
> index d3645122c983..d609f0dc6124 100644
> --- a/drivers/misc/mic/vop/vop_main.c
> +++ b/drivers/misc/mic/vop/vop_main.c
> @@ -125,6 +125,9 @@ static void vop_transport_features(struct virtio_device *vdev)
>  	 * creates virtio rings on preallocated memory.
>  	 */
>  	__virtio_clear_bit(vdev, VIRTIO_F_RING_PACKED);
> +
> +	if (!dev_is_dma_coherent(vdev->dev.parent))
> +		__virtio_set_bit(vdev, VIRTIO_F_ACCESS_PLATFORM);

Why look at the parent and not the device itself?

