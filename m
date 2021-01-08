Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAF52EF135
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 12:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbhAHL0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 06:26:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:42130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725817AbhAHL0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 06:26:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 98295235FC;
        Fri,  8 Jan 2021 11:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610105135;
        bh=QK8LVwXhJfa7Df8wuspRLx2EF41Pctw2jKJcl4LN3lk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qkJOcNYMh6LLm7n9wjP/4eygHxRLY0GsVzKfP1T7r7qe3YQP7yTfsFaydziHjOGRs
         1pzmCWKphVTARJkVEtPrx1ESNB9VG6wqdXeWj3Ex0f6vI5rMvG7oXGIdsrhvnqsEFX
         250VBDe+P2Xv7C2Sv3SkLQKeUpOtzIzAYnUJjU8A=
Date:   Fri, 8 Jan 2021 12:26:52 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     zhenwei pi <pizhenwei@bytedance.com>
Cc:     arnd@arndb.de, pbonzini@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] misc: pvpanic: introduce device capability
Message-ID: <X/hBfFrxJZvL4XDw@kroah.com>
References: <20210108111710.2665279-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210108111710.2665279-1-pizhenwei@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 07:17:10PM +0800, zhenwei pi wrote:
> According to pvpanic spec:
> https://git.qemu.org/?p=qemu.git;a=blob_plain;f=docs/specs/pvpanic.txt
> 
> The guest should determine pvpanic capability by RDPT, so initialize
> capability during device probing. There is no need to register panic
> notifier callback function if no events supported.
> 
> Before sending event to host side, check capability firstly.
> Suggested by Paolo, export capability of pvpanic device by read-only
> module parameter.
> 
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  drivers/misc/pvpanic.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/misc/pvpanic.c b/drivers/misc/pvpanic.c
> index 951b37da5e3c..c55a9d2fd001 100644
> --- a/drivers/misc/pvpanic.c
> +++ b/drivers/misc/pvpanic.c
> @@ -19,6 +19,9 @@
>  #include <uapi/misc/pvpanic.h>
>  
>  static void __iomem *base;
> +static unsigned int capability = PVPANIC_PANICKED | PVPANIC_CRASH_LOADED;
> +module_param(capability, uint, 0444);
> +MODULE_PARM_DESC(capability, "capability of pvpanic device");
>  
>  MODULE_AUTHOR("Hu Tao <hutao@cn.fujitsu.com>");
>  MODULE_DESCRIPTION("pvpanic device driver");
> @@ -27,7 +30,8 @@ MODULE_LICENSE("GPL");
>  static void
>  pvpanic_send_event(unsigned int event)
>  {
> -	iowrite8(event, base);
> +	if (event & capability)
> +		iowrite8(event, base);
>  }
>  
>  static int
> @@ -62,8 +66,12 @@ static int pvpanic_mmio_probe(struct platform_device *pdev)
>  	if (IS_ERR(base))
>  		return PTR_ERR(base);
>  
> -	atomic_notifier_chain_register(&panic_notifier_list,
> -				       &pvpanic_panic_nb);
> +	/* initlize capability by RDPT */
> +	capability &= ioread8(base);
> +
> +	if (capability)
> +		atomic_notifier_chain_register(&panic_notifier_list,
> +					       &pvpanic_panic_nb);
>  
>  	return 0;
>  }
> @@ -71,8 +79,9 @@ static int pvpanic_mmio_probe(struct platform_device *pdev)
>  static int pvpanic_mmio_remove(struct platform_device *pdev)
>  {
>  
> -	atomic_notifier_chain_unregister(&panic_notifier_list,
> -					 &pvpanic_panic_nb);
> +	if (capability)
> +		atomic_notifier_chain_unregister(&panic_notifier_list,
> +						 &pvpanic_panic_nb);
>  
>  	return 0;
>  }
> -- 
> 2.25.1
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
