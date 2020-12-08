Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37B3D2D2C61
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 14:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbgLHN4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 08:56:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43810 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729600AbgLHN4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 08:56:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607435712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XdwZVmp6074Z98H6zQEtlKhAw+DWLjOXe9vwluABFMA=;
        b=dXXwsTO00hrRO4/xBxQ4Th82LRkgDH6pd2VqlWQjyzdptHyt3Rno9HIJp1/TSmcJRm6sAm
        qljg/c/XBBNjQJ6ZuZAcAzcNAH1WKNLP5X14oy4inbHssFhQTu+m7VyiZwact89gEErxJO
        Zu+WasfWaf6xOCAfPUpIKpiOo4yXPWo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-UTOz2rUhMYCD05NwDfnp0A-1; Tue, 08 Dec 2020 08:55:11 -0500
X-MC-Unique: UTOz2rUhMYCD05NwDfnp0A-1
Received: by mail-wr1-f72.google.com with SMTP id m2so6223623wro.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 05:55:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XdwZVmp6074Z98H6zQEtlKhAw+DWLjOXe9vwluABFMA=;
        b=b601vaccOjJ0CwbkiAy6L82ekHmlKJe+ow6hPvWdwpZduo6OkWwtVrdkNZnVCw2Aj2
         jbhRjRGCDl2iQbIlSPF+4rMlppw9FpNUluBSjC8f9IyqRkBYyvHuGu3Hr90N8W6XSDtX
         IHjh0qWLes/R+k0qdxSstijbtwgH502o7F9JLCa0M8VHrvKFCiE/RoEkutlDi/9QpqfB
         FAoAPNHuRG/97Y7sSB08dW4z3qjJMeTIXPDHRUwTmjDIz8959SmsVlI3+ZQbqt13xlq3
         F8sXMYPwh0sLy9A5JTZsBNZ/BHYzSBFGMvdpYqvBogwRaV3jcpdFEaH9X7jAJGOGsSl6
         fyrQ==
X-Gm-Message-State: AOAM532s92crAjIbB9WCMN9ORZNrTkzjpazx/BVqSbXufJ5rYkdta0x/
        mYVq96lcOPzeAGMe5l2YnmN0SOATVVOE3lfLGsXGCnqcrNjPwsvXC9icJUg++C5llMb6DcGMpI3
        +Eb/5IKjwNYs7eVfRiSLVaztW
X-Received: by 2002:a05:600c:211:: with SMTP id 17mr3995061wmi.84.1607435709589;
        Tue, 08 Dec 2020 05:55:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzA6N3s86U/JDjUOs8NZEIzyA44f8DIyvIaz2dcybq7vg+qYLltQnCtH2dJeOyEBFEGBHspdw==
X-Received: by 2002:a05:600c:211:: with SMTP id 17mr3995051wmi.84.1607435709452;
        Tue, 08 Dec 2020 05:55:09 -0800 (PST)
Received: from redhat.com (bzq-79-176-44-197.red.bezeqint.net. [79.176.44.197])
        by smtp.gmail.com with ESMTPSA id v189sm3702487wmg.14.2020.12.08.05.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 05:55:08 -0800 (PST)
Date:   Tue, 8 Dec 2020 08:55:06 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     liush <liush@allwinnertech.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio: replace constant parameter '1' with num
Message-ID: <20201208085423-mutt-send-email-mst@kernel.org>
References: <1607428671-4802-1-git-send-email-liush@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607428671-4802-1-git-send-email-liush@allwinnertech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 08, 2020 at 07:57:51PM +0800, liush wrote:
> 'num' can represent the value of out_sgs(in_sags), no need to pass 
> in constant parameters in 'virtqueue_add'.
> 
> Signed-off-by: liush <liush@allwinnertech.com>

Point being?
A constant is likely easier for the compiler to optimize ...

> ---
>  drivers/virtio/virtio_ring.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index becc776..7583f8b 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1760,7 +1760,7 @@ int virtqueue_add_outbuf(struct virtqueue *vq,
>  			 void *data,
>  			 gfp_t gfp)
>  {
> -	return virtqueue_add(vq, &sg, num, 1, 0, data, NULL, gfp);
> +	return virtqueue_add(vq, &sg, num, num, 0, data, NULL, gfp);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_add_outbuf);
>  
> @@ -1782,7 +1782,7 @@ int virtqueue_add_inbuf(struct virtqueue *vq,
>  			void *data,
>  			gfp_t gfp)
>  {
> -	return virtqueue_add(vq, &sg, num, 0, 1, data, NULL, gfp);
> +	return virtqueue_add(vq, &sg, num, 0, num, data, NULL, gfp);
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_add_inbuf);
>  
> -- 
> 2.7.4

