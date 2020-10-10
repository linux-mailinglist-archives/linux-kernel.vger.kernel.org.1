Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B77A289EC1
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Oct 2020 08:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbgJJG4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 02:56:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:47212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728109AbgJJGzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 02:55:31 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FA2A207CD;
        Sat, 10 Oct 2020 06:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602312930;
        bh=dUv7VgWxKZNcHWA7B66+/MTaE7fFnLkKpOgX0imlPKg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=duDr0cstUgfyaR2b7RPNciasrgIcyJbBrP+w/HC+tR9JMlajRVOxvnJysNERodBY+
         oSG4kx/XUcy6MHEqprMk2Bi3YtW31m1iGvWBBqmshPCWYaDwnhKkvZ/x+0aTECw0Ap
         5Pfuz8pVAXboQ3N6asm9ipJmVgmcl5opnHBoG9vU=
Date:   Sat, 10 Oct 2020 08:55:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     NazimeHandeHarputluogluhandeharput@gmail.com
Cc:     Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Hande Harputluoglu <handeharput@gmail.com>,
        Nazime Hande Harputluoglu <handeharputlu@google.com>
Subject: Re: [PATCH] usbip, kcov: collect coverage from usbip client
Message-ID: <20201010065527.GA130900@kroah.com>
References: <dfb5eee2b1bdff14508100ee7c427596de384cd3.1602237653.git.handeharputlu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfb5eee2b1bdff14508100ee7c427596de384cd3.1602237653.git.handeharputlu@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 09, 2020 at 03:22:55PM +0000, NazimeHandeHarputluogluhandeharput@gmail.com wrote:
> From: Nazime Hande Harputluoglu <handeharputlu@google.com>
> 
> Add kcov_remote_start()/kcov_remote_stop() annotations to the
> vhci_rx_loop() function, which is responsible for parsing USB/IP packets
> in USB/IP client.
> 
> Since vhci_rx_loop() threads are spawned per usbip device instance, the
> common kcov handle is used for kcov_remote_start()/stop() annotations
> (see Documentation/dev-tools/kcov.rst for details). As the result kcov
> can now be used to collect coverage from vhci_rx_loop() threads.
> 
> Signed-off-by: Nazime Hande Harputluoglu <handeharputlu@google.com>
> ---
>  drivers/usb/usbip/usbip_common.h | 2 ++
>  drivers/usb/usbip/vhci_rx.c      | 6 ++++--
>  drivers/usb/usbip/vhci_sysfs.c   | 2 ++
>  3 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/usbip/usbip_common.h b/drivers/usb/usbip/usbip_common.h
> index 8be857a4fa13..cbbf2aa8ac73 100644
> --- a/drivers/usb/usbip/usbip_common.h
> +++ b/drivers/usb/usbip/usbip_common.h
> @@ -277,6 +277,8 @@ struct usbip_device {
>  		void (*reset)(struct usbip_device *);
>  		void (*unusable)(struct usbip_device *);
>  	} eh_ops;
> +
> +        u64 kcov_handle;
>  };
>  
>  #define kthread_get_run(threadfn, data, namefmt, ...)			   \
> diff --git a/drivers/usb/usbip/vhci_rx.c b/drivers/usb/usbip/vhci_rx.c
> index 266024cbb64f..b2eb3e8c04b9 100644
> --- a/drivers/usb/usbip/vhci_rx.c
> +++ b/drivers/usb/usbip/vhci_rx.c
> @@ -260,8 +260,10 @@ int vhci_rx_loop(void *data)
>  	while (!kthread_should_stop()) {
>  		if (usbip_event_happened(ud))
>  			break;
> -
> -		vhci_rx_pdu(ud);
> +                
> +                kcov_remote_start_common(ud->kcov_handle);
> +                vhci_rx_pdu(ud);
> +                kcov_remote_stop();
>  	}
>  
>  	return 0;
> diff --git a/drivers/usb/usbip/vhci_sysfs.c b/drivers/usb/usbip/vhci_sysfs.c
> index be37aec250c2..4dfe3809ebbb 100644
> --- a/drivers/usb/usbip/vhci_sysfs.c
> +++ b/drivers/usb/usbip/vhci_sysfs.c
> @@ -9,6 +9,7 @@
>  #include <linux/net.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
> +#include <linux/kcov.h>
>  
>  /* Hardening for Spectre-v1 */
>  #include <linux/nospec.h>
> @@ -383,6 +384,7 @@ static ssize_t attach_store(struct device *dev, struct device_attribute *attr,
>  	vdev->ud.sockfd     = sockfd;
>  	vdev->ud.tcp_socket = socket;
>  	vdev->ud.status     = VDEV_ST_NOTASSIGNED;
> +        vdev->ud.kcov_handle = kcov_common_handle();
>  
>  	spin_unlock(&vdev->ud.lock);
>  	spin_unlock_irqrestore(&vhci->lock, flags);
> -- 
> 2.28.0.1011.ga647a8990f-goog
> 

Please run checkpatch.pl on your patches before sending them out, so you
don't get grumpy maintainers telling you to run checkpatch.pl on your
patch...

thanks,

greg k-h
