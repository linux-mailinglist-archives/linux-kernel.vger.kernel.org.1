Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA3022AAA2F
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 10:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbgKHJLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 04:11:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:42138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbgKHJLk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 04:11:40 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 985A0206E3;
        Sun,  8 Nov 2020 09:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604826700;
        bh=nDNxAtrBPS2tDV2KcZN06hO/zTzru/CpsYng1FbwwRw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W1qbwCiwryQXHg0VNixMzP7l5h1ADzhIGn40eIMUumw3En1K8pt93yb3GQ87A5Swy
         27/2khEHlFy+RXWyMPxycBUr0GfK97xa5irjI1x3vAYOwJZHrlVLgzwVMfxZeIDwAq
         nJBBK5U6xJgzJ9XcVvwqeJ/SdUchnxitX/qz3+H0=
Date:   Sun, 8 Nov 2020 10:11:36 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Atul <leoatul12@gmail.com>
Cc:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: usb-audio: Fix coding style problems
Message-ID: <20201108091136.GA44749@kroah.com>
References: <20201108083515.5256-1-leoatul12@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201108083515.5256-1-leoatul12@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 08, 2020 at 02:05:16PM +0530, Atul wrote:
> From: Atul Gopinathan <leoatul12@gmail.com>
> 
> Hi,

No need for this to be in the changelog.

> 
> This patch fixes some coding style warnings and errors that were
> generated using scripts/checkpatch.pl.

You should be explicit about _what_ warnings and errors.  And probably
break them out into individual patches, one per warning/error type.

But more importantly, always run your patch through checkpatch.pl when
you are done, as you just _ADDED_ warnings to the kernel with this
change:

> @@ -895,9 +896,10 @@ static int snd_usb_nativeinstruments_boot_quirk(struct usb_device *dev)
>  	usb_reset_device(dev);
>  
>  	/* return -EAGAIN, so the creation of an audio interface for this
> -	 * temporary device is aborted. The device will reconnect with a
> -	 * new product ID */
> -	return -EAGAIN;
> +     * temporary device is aborted. The device will reconnect with a
> +     * new product ID
> +     */
> +    return -EAGAIN;
>  }
>  
>  static void mbox2_setup_48_24_magic(struct usb_device *dev)

You turned tabs into spaces, not allowed, sorry.

If you want to do basic checkpatch cleanups, try starting in the
drivers/staging/ area of the kernel, which is much more forgiving and
set up just for this type of thing, instead of trying to do this in the
"core" kernel portions, where you have to deal with other real code
changing happening at the same time.

good luck!

greg k-h
