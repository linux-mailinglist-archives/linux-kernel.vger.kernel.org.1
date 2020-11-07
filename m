Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E64DD2AA472
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 11:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbgKGKmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 05:42:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:51522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbgKGKmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 05:42:08 -0500
Received: from kernel.org (unknown [77.125.7.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91A1920704;
        Sat,  7 Nov 2020 10:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604745728;
        bh=0Y0gNCEZ8YBIwsICc3k1ML2seEYgzXgY+mU0jFyfQ7M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rkym1LrxNYqaNJRDu0jVnGulZbvj/14eJN8VxwT3T8WU+X/MYWTVkviTLsBlTh7yH
         k7nTT7XLqAT77DWbXUjXnLVWjQd+VSZla75A6dxSmXBxZrxEbes2tGnqJuOZD3FW8D
         k9Q2LaLeAlhiuE7QIRoE1+5VxrS/96OG07kyHAR0=
Date:   Sat, 7 Nov 2020 12:42:03 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Wang Qing <wangqing@vivo.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm: mach-sa1100: remove duplicate include
Message-ID: <20201107104203.GC301837@kernel.org>
References: <1604740947-28241-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604740947-28241-1-git-send-email-wangqing@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 07, 2020 at 05:22:26PM +0800, Wang Qing wrote:
> Remove duplicate header which is included twice.
> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  arch/arm/mach-sa1100/hackkit.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/mach-sa1100/hackkit.c b/arch/arm/mach-sa1100/hackkit.c
> index 3085f1c..3fe34ee
> --- a/arch/arm/mach-sa1100/hackkit.c
> +++ b/arch/arm/mach-sa1100/hackkit.c
> @@ -18,7 +18,6 @@
>  #include <linux/serial_core.h>
>  #include <linux/mtd/mtd.h>
>  #include <linux/mtd/partitions.h>
> -#include <linux/tty.h>
>  #include <linux/gpio.h>
>  #include <linux/leds.h>
>  #include <linux/platform_device.h>
> -- 
> 2.7.4
> 

-- 
Sincerely yours,
Mike.
