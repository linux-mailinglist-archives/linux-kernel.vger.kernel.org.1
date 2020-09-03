Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6AA25BEDD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Sep 2020 12:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbgICKKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Sep 2020 06:10:35 -0400
Received: from regular1.263xmail.com ([211.150.70.202]:51722 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgICKKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 06:10:03 -0400
X-Greylist: delayed 460 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Sep 2020 06:10:02 EDT
Received: from localhost (unknown [192.168.167.16])
        by regular1.263xmail.com (Postfix) with ESMTP id D451046E;
        Thu,  3 Sep 2020 18:02:37 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.120] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P23637T140495628007168S1599127357353308_;
        Thu, 03 Sep 2020 18:02:38 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <9d5d9546b9483c57ae5a220dcf1449de>
X-RL-SENDER: kever.yang@rock-chips.com
X-SENDER: yk@rock-chips.com
X-LOGIN-NAME: kever.yang@rock-chips.com
X-FST-TO: huangtao@rock-chips.com
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
Subject: Re: [PATCH v2 3/6] clk: rockchip: Export rockchip_register_softrst()
To:     Elaine Zhang <zhangqing@rock-chips.com>, heiko@sntech.de
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, xxx@rock-chips.com,
        xf@rock-chips.com, huangtao@rock-chips.com
References: <20200903063147.10237-1-zhangqing@rock-chips.com>
 <20200903063147.10237-4-zhangqing@rock-chips.com>
From:   Kever Yang <kever.yang@rock-chips.com>
Message-ID: <44699e71-1b08-919f-ddf3-187aee67b8a0@rock-chips.com>
Date:   Thu, 3 Sep 2020 18:02:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200903063147.10237-4-zhangqing@rock-chips.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/9/3 下午2:31, Elaine Zhang wrote:
> This is used by the Rockchip clk driver, export it to allow that
> driver to be compiled as a module..
>
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>   drivers/clk/rockchip/softrst.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/clk/rockchip/softrst.c b/drivers/clk/rockchip/softrst.c
> index 5f1ff5e47c4f..caba9055090b 100644
> --- a/drivers/clk/rockchip/softrst.c
> +++ b/drivers/clk/rockchip/softrst.c
> @@ -77,9 +77,9 @@ static const struct reset_control_ops rockchip_softrst_ops = {
>   	.deassert	= rockchip_softrst_deassert,
>   };
>   
> -void __init rockchip_register_softrst(struct device_node *np,
> -				      unsigned int num_regs,
> -				      void __iomem *base, u8 flags)
> +void rockchip_register_softrst(struct device_node *np,
> +			       unsigned int num_regs,
> +			       void __iomem *base, u8 flags)
>   {
>   	struct rockchip_softrst *softrst;
>   	int ret;
> @@ -107,3 +107,4 @@ void __init rockchip_register_softrst(struct device_node *np,
>   		kfree(softrst);
>   	}
>   };
> +EXPORT_SYMBOL(rockchip_register_softrst);

This looks good to me, so

Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,

- Kever



