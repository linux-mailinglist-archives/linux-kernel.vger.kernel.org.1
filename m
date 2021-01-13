Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C472F453E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 08:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbhAMHeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 02:34:05 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:60875 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725681AbhAMHeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 02:34:04 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0ULbG-a5_1610523195;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0ULbG-a5_1610523195)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 13 Jan 2021 15:33:16 +0800
Subject: Re: [PATCH for doc-next] doc/zh_CN: adjust table markup in
 mips/ingenic-tcu.rst
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Yanteng Si <siyanteng@loongson.cn>,
        Harry Wei <harryxiyou@gmail.com>, linux-doc@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210113070023.25064-1-lukas.bulwahn@gmail.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <6040230e-5710-6580-aeb3-70d3f1859197@linux.alibaba.com>
Date:   Wed, 13 Jan 2021 15:33:15 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.0; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20210113070023.25064-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Alex Shi <alex.shi@linux.alibaba.com>

在 2021/1/13 下午3:00, Lukas Bulwahn 写道:
> Commit 419b1d4ed1cb ("doc/zh_CN: add mips ingenic-tcu.rst translation")
> introduces a warning with make htmldocs:
> 
>   ./Documentation/translations/zh_CN/mips/ingenic-tcu.rst:
>     61: WARNING: Malformed table. Text in column margin in table line 6.
> 
> Adjust the table markup to address this warning.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> applies cleanly on next-20210113
> 
> Yanteng, please ack.
> 
> Jonathan, please pick this doc warning fixup on your -next tree. 
> 
>  Documentation/translations/zh_CN/mips/ingenic-tcu.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/translations/zh_CN/mips/ingenic-tcu.rst b/Documentation/translations/zh_CN/mips/ingenic-tcu.rst
> index 72b5d409ed89..9324a0a26430 100644
> --- a/Documentation/translations/zh_CN/mips/ingenic-tcu.rst
> +++ b/Documentation/translations/zh_CN/mips/ingenic-tcu.rst
> @@ -53,14 +53,14 @@
>  
>  TCU硬件的功能分布在多个驱动程序：
>  
> -===========         =====
> +==============      ===================================
>  时钟                drivers/clk/ingenic/tcu.c
>  中断                drivers/irqchip/irq-ingenic-tcu.c
>  定时器              drivers/clocksource/ingenic-timer.c
>  OST                 drivers/clocksource/ingenic-ost.c
>  脉冲宽度调制器      drivers/pwm/pwm-jz4740.c
>  看门狗              drivers/watchdog/jz4740_wdt.c
> -===========         =====
> +==============      ===================================
>  
>  因为可以从相同的寄存器控制属于不同驱动程序和框架的TCU的各种功能，所以
>  所有这些驱动程序都通过相同的控制总线通用接口访问它们的寄存器。
> 
