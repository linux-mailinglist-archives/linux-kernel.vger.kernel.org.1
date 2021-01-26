Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0411304E84
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 02:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404542AbhA0Acr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 19:32:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:38804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392868AbhAZRkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 12:40:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 33994221FB;
        Tue, 26 Jan 2021 17:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611682768;
        bh=4I0wInzR+eOz/jyMqpCBctR9x3WhgHBS66ZyaFP8lZc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wWYiajXUHjDrN4BIxT072VjVgMORHk7wcbIj2uKO/hPZ920SMGPX8KT+7hjWTVr54
         FNGpdUqC4Ygwd6DgVuDQldmR6g7Uu/YveTMSWm0MGZRza0ig/tuhS09uqBaTUIqvRH
         +uBw0arnKXKpI1YT7qZofGxpR+idZ0Wdcbt2wYDE=
Date:   Tue, 26 Jan 2021 18:39:26 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zou Wei <zou_wei@huawei.com>
Cc:     andreyknvl@google.com, dvyukov@google.com, allen.lkml@gmail.com,
        stern@rowland.harvard.edu, sashal@kernel.org,
        gustavoars@kernel.org, a.darwish@linutronix.de,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] usb: core: Remove unused including
 <linux/version.h>
Message-ID: <YBBTzkPiyMZov9J0@kroah.com>
References: <1611578688-43256-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611578688-43256-1-git-send-email-zou_wei@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 08:44:48PM +0800, Zou Wei wrote:
> Fix the following versioncheck warning:
> 
> drivers/usb/core/hcd.c:14:1: unused including <linux/version.h>
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
>  drivers/usb/core/hcd.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> index 3f03813..53bc93d 100644
> --- a/drivers/usb/core/hcd.c
> +++ b/drivers/usb/core/hcd.c
> @@ -11,7 +11,6 @@
>  
>  #include <linux/bcd.h>
>  #include <linux/module.h>
> -#include <linux/version.h>
>  #include <linux/kernel.h>
>  #include <linux/sched/task_stack.h>
>  #include <linux/slab.h>

You didn't test this patch, why???

{sigh}

greg k-h
