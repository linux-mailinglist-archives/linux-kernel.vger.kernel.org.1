Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 738D31D7BF2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 16:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbgERO4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 10:56:51 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44307 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbgERO4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 10:56:50 -0400
Received: by mail-lf1-f66.google.com with SMTP id w15so973623lfe.11;
        Mon, 18 May 2020 07:56:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=py+NSpkp68bZvDketQ0LHFlU7cQ4OapcQ54P+6JzKs4=;
        b=Jt1EFdy4FDlHZ+kJFSldLagl2lBzcbmqj7BEY6t+SPL4XaTDZPnCqGtkoPO1129skF
         ZS1ZiHlZFzMv9JWCpSd1xQZJe1//CyAEB53R4r6pxT1Tu9dyoOeKf7cafzFPGYXtiu7s
         wIIcRMX0Ltcw6GICg9yJ/QK0wh4TLSBLHev8YMdELpm4bNvt+PTIfCExy6ByIid6wFUZ
         uViv+Xu/qBJadYtHoBIRLJoRJVdejQElNiW0Jnrmh4JHiCSGnF5Bq82cXaCIqbEvEyU+
         Jss1ds7w5u1n7fJrNxughKYR3xerfJDwVbZNd8/sVYFpGDcna1eU1zv1wwqUzd6t9tgH
         /MUA==
X-Gm-Message-State: AOAM531jymc7lqdsnNMMHS8YlqNHvk+I4UhM0rv6wZAHqYnQQtzllovj
        qj5T7d/uWfk7YbuJuq9jXqo=
X-Google-Smtp-Source: ABdhPJx+XZWZVGWM9nNpq7eb8MJwagwl3MdlS+Oya7jXIfgJ6ix2JYoNLOYvub/lc0afK3SzKDkuUg==
X-Received: by 2002:ac2:4105:: with SMTP id b5mr12178529lfi.94.1589813807316;
        Mon, 18 May 2020 07:56:47 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id x10sm3000527ljd.25.2020.05.18.07.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 07:56:46 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1jahCF-0004MN-Vd; Mon, 18 May 2020 16:56:52 +0200
Date:   Mon, 18 May 2020 16:56:51 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Claire Chang <tientzu@chromium.org>
Cc:     robh@kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com,
        long.cheng@mediatek.com, changqi.hu@mediatek.com,
        linux-serial@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] serdev: ttyport: add devt for tty port
Message-ID: <20200518145651.GL25962@localhost>
References: <20200506072314.112409-1-tientzu@chromium.org>
 <20200506072314.112409-2-tientzu@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506072314.112409-2-tientzu@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 03:23:12PM +0800, Claire Chang wrote:
> serial_match_port() uses devt to match devices. However, when serdev
> registers a tty port, devt has never been set. This makes
> device_find_child() always return NULL.
> 
> Assign devt in serdev_tty_port_register() to fix this.
> 
> Signed-off-by: Claire Chang <tientzu@chromium.org>
> ---
>  drivers/tty/serdev/serdev-ttyport.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/serdev-ttyport.c
> index d367803e2044f..9238119173a47 100644
> --- a/drivers/tty/serdev/serdev-ttyport.c
> +++ b/drivers/tty/serdev/serdev-ttyport.c
> @@ -267,6 +267,7 @@ struct device *serdev_tty_port_register(struct tty_port *port,
>  {
>  	struct serdev_controller *ctrl;
>  	struct serport *serport;
> +	dev_t devt = MKDEV(drv->major, drv->minor_start) + idx;
>  	int ret;
>  
>  	if (!port || !drv || !parent)
> @@ -282,6 +283,7 @@ struct device *serdev_tty_port_register(struct tty_port *port,
>  	serport->tty_drv = drv;
>  
>  	ctrl->ops = &ctrl_ops;
> +	ctrl->dev.devt = devt;

This is conceptually wrong. A serdev controller is not a tty class
device with a corresponding character device.

It seems you need to rethink how serial core should handle the wakeup
flags with respect to serdev.

>  
>  	port->client_ops = &client_ops;
>  	port->client_data = ctrl;

Johan
