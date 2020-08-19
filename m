Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFB5249491
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 07:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgHSFpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 01:45:55 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:36334 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbgHSFpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 01:45:54 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id B2B3C803202D;
        Wed, 19 Aug 2020 05:45:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rm8l1j1x8qWq; Wed, 19 Aug 2020 08:45:45 +0300 (MSK)
Date:   Wed, 19 Aug 2020 08:45:45 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Wang Hai <wanghai38@huawei.com>
CC:     <arnd@arndb.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] bus: bt1-apb: remove duplicate include
Message-ID: <20200819054545.grzebs7fkwtrglah@mobilestation>
References: <20200819024351.37982-1-wanghai38@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200819024351.37982-1-wanghai38@huawei.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 10:43:51AM +0800, Wang Hai wrote:
> Remove linux/clk.h which is included more than once
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Hai <wanghai38@huawei.com>

Thanks!

Acked-by: Serge Semin <fancer.lancer@gmail.com>

> ---
>  drivers/bus/bt1-apb.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/bus/bt1-apb.c b/drivers/bus/bt1-apb.c
> index b25ff941e7c7..74b1b712ef3a 100644
> --- a/drivers/bus/bt1-apb.c
> +++ b/drivers/bus/bt1-apb.c
> @@ -22,7 +22,6 @@
>  #include <linux/clk.h>
>  #include <linux/reset.h>
>  #include <linux/time64.h>
> -#include <linux/clk.h>
>  #include <linux/sysfs.h>
>  
>  #define APB_EHB_ISR			0x00
> -- 
> 2.17.1
> 
