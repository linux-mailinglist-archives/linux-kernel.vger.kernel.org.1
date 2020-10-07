Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEE52285920
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 09:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgJGHNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 03:13:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24233 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726041AbgJGHNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 03:13:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602054803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mXDY+qs2o62bP8I5M3LGBqeIqTHLq7IvmqKRxurTHeU=;
        b=T/vpMR1kkwZj7R4X9JUL5Pbsd1M7326dcJsUtHZp9k0cjWL17gGZ8a9ABwbQ1cu5HHmFj6
        p4uMQn0e0Xdur0nNXOSk5r9cgQhx5hojJ8dkRAgWMuAyIzLqPLypRt0QONVH7IWvzZ6xpi
        64LZdvLL7CHCOip8CtNsCELwONlt5UM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-Pv_Ypn6VOQy0Lvz4awtXXA-1; Wed, 07 Oct 2020 03:13:22 -0400
X-MC-Unique: Pv_Ypn6VOQy0Lvz4awtXXA-1
Received: by mail-wm1-f72.google.com with SMTP id v14so193548wmj.6
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 00:13:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mXDY+qs2o62bP8I5M3LGBqeIqTHLq7IvmqKRxurTHeU=;
        b=r8K+qVyagZwh0v2QCwiMgJZoJfzK4MZ7jM93bD/WVQtli7ibpvfO6uDYC7UcbpnCtS
         D+Euh34X8n+mD02abk072W8dBQ5629YkgVPumhfl4vXNg1zuJ4tU8FlzFgL8LOPl12Uk
         BKSxc0HOUE3Bhm3pAEJp6LYpgT6yJAkji8L9hEyEfIWnnjbO9XaeJwHIBMj2eh0mjNut
         AqgnVooZ4Bg6JpGZ9qERkfc70cEQtIS4apjgiaZPHuzyEVsspSNoUQM0rJuH9Wkdlf33
         i4zbPCcLgZ+5pkh08QKFuL5pPYFKcM8vJLJ1GwX0ilRjalbn8dNIHlSJhz88dj3J/Du/
         MAAw==
X-Gm-Message-State: AOAM533TLL/U+WmKk/PoIhEHwkDp/SOrV6ZVp/tZbU2b/judyA6gK9w6
        l9Y5XcFeoj9KAnkHxGaydJXBG1EO98x4CCxfmTDuVU2x3eP5eEkRvCTN3D4BIfq+b7Nz+3cBahw
        p85nU/lr9fsKzKIAr53UjDZX1
X-Received: by 2002:adf:9043:: with SMTP id h61mr1890310wrh.237.1602054800823;
        Wed, 07 Oct 2020 00:13:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyOmzwyGXD1+i6qJ8RNZ1W8nCOaadruhiprYWXENjEzNDSQwRU62/WOV2VQALuGsqYrv7ZZ5A==
X-Received: by 2002:adf:9043:: with SMTP id h61mr1890276wrh.237.1602054800545;
        Wed, 07 Oct 2020 00:13:20 -0700 (PDT)
Received: from steredhat (host-79-27-201-176.retail.telecomitalia.it. [79.27.201.176])
        by smtp.gmail.com with ESMTPSA id l11sm1589187wrt.54.2020.10.07.00.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 00:13:19 -0700 (PDT)
Date:   Wed, 7 Oct 2020 09:13:17 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Pavel Machek <pavel@denx.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 07/38] vsock/virtio: stop workers during the
 .remove()
Message-ID: <20201007071317.cf7wpip3yxicv362@steredhat>
References: <20201005142108.650363140@linuxfoundation.org>
 <20201005142109.015282314@linuxfoundation.org>
 <20201006193432.GA8771@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006193432.GA8771@duo.ucw.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 06, 2020 at 09:34:32PM +0200, Pavel Machek wrote:
> Hi!
> 
> > [ Upstream commit 17dd1367389cfe7f150790c83247b68e0c19d106 ]
> > 
> > Before to call vdev->config->reset(vdev) we need to be sure that
> > no one is accessing the device, for this reason, we add new variables
> > in the struct virtio_vsock to stop the workers during the .remove().
> > 
> > This patch also add few comments before vdev->config->reset(vdev)
> > and vdev->config->del_vqs(vdev).
> 
> 
> > @@ -621,12 +645,18 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
> >  	INIT_WORK(&vsock->send_pkt_work, virtio_transport_send_pkt_work);
> >  	INIT_WORK(&vsock->loopback_work, virtio_transport_loopback_work);
> >  
> > +	mutex_lock(&vsock->tx_lock);
> > +	vsock->tx_run = true;
> > +	mutex_unlock(&vsock->tx_lock);
> > +
> >  	mutex_lock(&vsock->rx_lock);
> >  	virtio_vsock_rx_fill(vsock);
> > +	vsock->rx_run = true;
> >  	mutex_unlock(&vsock->rx_lock);
> >  
> >  	mutex_lock(&vsock->event_lock);
> >  	virtio_vsock_event_fill(vsock);
> > +	vsock->event_run = true;
> >  	mutex_unlock(&vsock->event_lock);
> >
> 
> This looks like some kind of voodoo code. Locks are just being
> allocated few lines above, so there are no other threads accessing
> *vsock. That means we don't need to take the locks... right?
> 
> At least taking the tx_lock is unneccessary, but probably the others,
> too...

Before commit 0deab087b16a ("vsock/virtio: use RCU to avoid use-after-free
on the_virtio_vsock") we assigned 'the_virtio_vsock pointer' before this
section, so this should be the reason of these locks.

Now that we moved the assignment at the end of the probe(), we can clean
a bit, especially the tx_lock.

I'll take a look.

Thanks,
Stefano

