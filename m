Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 679DE2EF13C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 12:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbhAHL2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 06:28:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:42330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbhAHL2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 06:28:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 76CDD235FC;
        Fri,  8 Jan 2021 11:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610105248;
        bh=TMM+WaSJeVbADwJnLj/8YSm130HSmfiTNDKKYyriEsA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zMmld/DoFvLAxP1UAjQkpWsdaz++N0iYlfwzN/m6Nf0SZNyP4h0pNzFUPlS+Szooy
         NkpDQ9aX7gf1Vx4CqomcBRW2Hs1ZQd8UVxV4+XEOWQ6WfNMQILjZhYz1hE8gNmMp5S
         miAGL/zoZsS8e63jD7ZYMTsnb26UK7CSLF3GZqZ4=
Date:   Fri, 8 Jan 2021 12:28:45 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     zhenwei pi <pizhenwei@bytedance.com>
Cc:     arnd@arndb.de, pbonzini@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] misc: pvpanic: introduce device capability
Message-ID: <X/hB7ejy7XtjNO68@kroah.com>
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

This is not the 1990's, please do not add new module parameters :(

Use sysfs, and properly document the file in Documentation/ABI/

thanks,

greg k-h

