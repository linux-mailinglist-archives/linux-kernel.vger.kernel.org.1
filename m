Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0B426CADC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgIPUQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:16:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:44258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727172AbgIPRbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:31:03 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B72E222C8;
        Wed, 16 Sep 2020 17:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600277453;
        bh=Ms7SR3/sWRqfkOqtXGugqTmM9pwbi5WP66/p/LE+AuA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wrqUu1/5o7yonR3qmYpfQI5/pVWhdYchgJPDOvjqtQ8twknc2A/NQ0az26yssvhwe
         gbjt7r5X1hnQIBP5Zd6iU4d6BkaEyT0KP2UWX7UjIqyePGuHW6Qsgi3Y6xPUJfOm53
         j4sAfwQnV5ZlB1GS476nwkYCIsTxgm5RI0cHhLho=
Date:   Wed, 16 Sep 2020 19:31:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Quentin Perret <qperret@google.com>
Cc:     stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, gprocida@google.com,
        maennich@google.com, kernel-team@android.com
Subject: Re: [PATCH] ehci-hcd: Move include to keep CRC stable
Message-ID: <20200916173127.GB3068942@kroah.com>
References: <20200916171825.3228122-1-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916171825.3228122-1-qperret@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 06:18:25PM +0100, Quentin Perret wrote:
> The CRC calculation done by genksyms is triggered when the parser hits
> EXPORT_SYMBOL*() macros. At this point, genksyms recursively expands the
> types of the function parameters, and uses that as the input for the CRC
> calculation. In the case of forward-declared structs, the type expands
> to 'UNKNOWN'. Following this, it appears that the result of the
> expansion of each type is cached somewhere, and seems to be re-used
> when/if the same type is seen again for another exported symbol in the
> same C file.
> 
> Unfortunately, this can cause CRC 'stability' issues when a struct
> definition becomes visible in the middle of a C file. For example, let's
> assume code with the following pattern:
> 
>     struct foo;
> 
>     int bar(struct foo *arg)
>     {
> 	/* Do work ... */
>     }
>     EXPORT_SYMBOL_GPL(bar);
> 
>     /* This contains struct foo's definition */
>     #include "foo.h"
> 
>     int baz(struct foo *arg)
>     {
> 	/* Do more work ... */
>     }
>     EXPORT_SYMBOL_GPL(baz);
> 
> Here, baz's CRC will be computed using the expansion of struct foo that
> was cached after bar's CRC calculation ('UNKOWN' here). But if
> EXPORT_SYMBOL_GPL(bar) is removed from the file (because of e.g. symbol
> trimming using CONFIG_TRIM_UNUSED_KSYMS), struct foo will be expanded
> late, during baz's CRC calculation, which now has visibility over the
> full struct definition, hence resulting in a different CRC for baz.
> 
> The proper fix for this certainly is in genksyms, but that will take me
> some time to get right. In the meantime, we have seen one occurrence of
> this in the ehci-hcd code which hits this problem because of the way it
> includes C files halfway through the code together with an unlucky mix
> of symbol trimming.
> 
> In order to workaround this, move the include done in ehci-hub.c early
> in ehci-hcd.c, hence making sure the struct definitions are visible to
> the entire file. This improves CRC stability of the ehci-hcd exports
> even when symbol trimming is enabled.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  drivers/usb/host/ehci-hcd.c | 1 +
>  drivers/usb/host/ehci-hub.c | 1 -
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
> index 6257be4110ca..3575b7201881 100644
> --- a/drivers/usb/host/ehci-hcd.c
> +++ b/drivers/usb/host/ehci-hcd.c
> @@ -22,6 +22,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/usb.h>
>  #include <linux/usb/hcd.h>
> +#include <linux/usb/otg.h>
>  #include <linux/moduleparam.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/debugfs.h>
> diff --git a/drivers/usb/host/ehci-hub.c b/drivers/usb/host/ehci-hub.c
> index ce0eaf7d7c12..087402aec5cb 100644
> --- a/drivers/usb/host/ehci-hub.c
> +++ b/drivers/usb/host/ehci-hub.c
> @@ -14,7 +14,6 @@
>   */
>  
>  /*-------------------------------------------------------------------------*/
> -#include <linux/usb/otg.h>
>  
>  #define	PORT_WAKE_BITS	(PORT_WKOC_E|PORT_WKDISC_E|PORT_WKCONN_E)

Thanks for root-causing this issue.  genksyms is a fragile beast, good
luck trying to resolve that!

I'll go queue this up and mark it for stable kernels, thanks.

greg k-h
