Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 276642C46E6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 18:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732859AbgKYRhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 12:37:07 -0500
Received: from out28-75.mail.aliyun.com ([115.124.28.75]:56091 "EHLO
        out28-75.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730419AbgKYRhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 12:37:07 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1272624|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.000914905-6.43672e-05-0.999021;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047188;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.J.Bnm3T_1606325822;
Received: from 192.168.11.205(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.J.Bnm3T_1606325822)
          by smtp.aliyun-inc.com(10.147.44.145);
          Thu, 26 Nov 2020 01:37:03 +0800
Subject: Re: [PATCH] clocksource/drivers/ingenic: Fix section mismatch
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, paul@crapouillou.net,
        paul@boddie.org.uk, hns@goldelico.com,
        kernel test robot <lkp@intel.com>
References: <202011251435.7F0RQBXw-lkp@intel.com>
 <20201125102346.1816310-1-daniel.lezcano@linaro.org>
From:   Zhou Yanjie <zhouyanjie@wanyeetech.com>
Message-ID: <61742e23-5b09-5c6c-fdaf-1500f089987e@wanyeetech.com>
Date:   Thu, 26 Nov 2020 01:34:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20201125102346.1816310-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

在 2020/11/25 下午6:23, Daniel Lezcano 写道:
> The function ingenic_tcu_get_clock() is annotated for the __init
> section but it is actually called from the online cpu callback.
>
> That will lead to a crash if a CPU is hotplugged after boot time.
>
> Remove the __init annotatation for the ingenic_tcu_get_clock()
> function.
>
> Fixes: f19d838d08fc (clocksource/drivers/ingenic: Add high resolution timer support for SMP/SMT)
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   drivers/clocksource/ingenic-timer.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)


Works fine on JZ4780, X1000, and X1830.

Tested-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>


Thanks and best regards!


> diff --git a/drivers/clocksource/ingenic-timer.c b/drivers/clocksource/ingenic-timer.c
> index 58fd9189fab7..905fd6b163a8 100644
> --- a/drivers/clocksource/ingenic-timer.c
> +++ b/drivers/clocksource/ingenic-timer.c
> @@ -127,7 +127,7 @@ static irqreturn_t ingenic_tcu_cevt_cb(int irq, void *dev_id)
>   	return IRQ_HANDLED;
>   }
>   
> -static struct clk * __init ingenic_tcu_get_clock(struct device_node *np, int id)
> +static struct clk *ingenic_tcu_get_clock(struct device_node *np, int id)
>   {
>   	struct of_phandle_args args;
>   
