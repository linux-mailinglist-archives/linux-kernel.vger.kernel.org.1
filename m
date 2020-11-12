Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 020402B0AEA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 18:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgKLRE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 12:04:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:44456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgKLRE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 12:04:56 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C58621D7F;
        Thu, 12 Nov 2020 17:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605200696;
        bh=qEGu5uST4byz8XuJRMjnqZZkRabdlL6gGWmFkpschCo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BHYu2GVHYY7GTOmz8a4uXpdurzwymiO5oR5TaJepK0yXP8/vAgy/bZnVJSJMKOndk
         rjlSioJxLgU6QdTh9CkDQqtecBYOJRLhVdj2NXpDoA33ovt17OdZeF9+SJXWOj7mX9
         07jQPCTDECz06JDYesZpuDDdi/vLAakx5/Mbbpxo=
Date:   Thu, 12 Nov 2020 18:05:53 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     John Boero <boeroboy@gmail.com>
Cc:     Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: core: Null deref in kernel with USB webcams.
Message-ID: <X61rce8GANHW1ysh@kroah.com>
References: <CAO5W59jOWuRKizngF8vv9jb-zr_HnLC2eNxKqi3AYwg8KLwKoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO5W59jOWuRKizngF8vv9jb-zr_HnLC2eNxKqi3AYwg8KLwKoA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 03:52:02PM +0000, John Boero wrote:
> >From 54f9886454e9a28e8d943c1cef15df9c11555df7 Mon Sep 17 00:00:00 2001
> From: JohnnyB <jboero@users.noreply.github.com>

Why all this header here?

And the from: line doesn't match your Signed-off-by: line :(

> Date: Thu, 12 Nov 2020 15:28:29 +0000
> Subject: [PATCH] usb: core: Null deref in kernel with USB webcams.
> 
> Fixes: Ubuntu Launchpad bug 1827452
> 
> This is my first attempt at a kernel contribution so sorry if sloppy.

No need to put this in the changelog text and have it be in the kernel
for foever :)

> 
> There is some kind of race condition affecting Logitech
> webcams that crash USB with a null dereference.
> Affects raspberry pi devices as well as x86.
> No check on dev before dereference.
> Simple fix for issue experienced for months in
> both x86 and arm/rpi environments.
> 
> Signed-off-by: John Boero <boeroboy@gmail.com>
> 
> ---
> drivers/usb/core/usb.c | 6 +-----
> 1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
> index d8756ffe513a..9b4ac4415f1a 100644
> --- a/drivers/usb/core/usb.c
> +++ b/drivers/usb/core/usb.c
> @@ -272,13 +272,9 @@ EXPORT_SYMBOL_GPL(usb_find_alt_setting);
> struct usb_interface *usb_ifnum_to_if(const struct usb_device *dev,
>                                      unsigned ifnum)
> {
> -       struct usb_host_config *config = NULL;
> +       struct usb_host_config *config = dev->actconfig;
>        int i;
> 
> -       if (!dev)
> -               return NULL;
> -
> -       config = dev->actconfig;
>        if (!config)
>                return NULL;
>        for (i = 0; i < config->desc.bNumInterfaces; i++)

This patch is corrupted and can not be applied, but also, it looks
backwards, right?

And how about we find the race condition and fix that instead of trying
to paper over it here?

thanks,

greg k-h
