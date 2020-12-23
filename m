Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 702152E1193
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 03:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgLWCNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 21:13:48 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:9910 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgLWCNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 21:13:48 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4D0xYL2T42z6vD5;
        Wed, 23 Dec 2020 10:12:22 +0800 (CST)
Received: from [10.174.178.154] (10.174.178.154) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.498.0; Wed, 23 Dec
 2020 10:13:04 +0800
Subject: Re: [RESEND] usb: dwc3: meson-g12a: disable clk on error handling
 path in probe
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <khilman@baylibre.com>, <narmstrong@baylibre.com>,
        <jbrunet@baylibre.com>, <martin.blumenstingl@googlemail.com>
CC:     <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20201215025459.91794-1-zhengzengkai@huawei.com>
From:   Zheng Zengkai <zhengzengkai@huawei.com>
Message-ID: <c069b566-224d-f938-089c-6a69d1ec9d55@huawei.com>
Date:   Wed, 23 Dec 2020 10:13:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20201215025459.91794-1-zhengzengkai@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

Friendly ping:

Just want to know why this patch was ignored,

Am I missing something?

Merry Christmas and Happy New Year!

> dwc3_meson_g12a_probe() does not invoke clk_bulk_disable_unprepare()
> on one error handling path. This patch fixes that.
>
> Fixes: 347052e3bf1b ("usb: dwc3: meson-g12a: fix USB2 PHY initialization on G12A and A1 SoCs")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zheng Zengkai <zhengzengkai@huawei.com>
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>   drivers/usb/dwc3/dwc3-meson-g12a.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
> index 417e05381b5d..bdf1f98dfad8 100644
> --- a/drivers/usb/dwc3/dwc3-meson-g12a.c
> +++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
> @@ -754,7 +754,7 @@ static int dwc3_meson_g12a_probe(struct platform_device *pdev)
>   
>   	ret = priv->drvdata->setup_regmaps(priv, base);
>   	if (ret)
> -		return ret;
> +		goto err_disable_clks;
>   
>   	if (priv->vbus) {
>   		ret = regulator_enable(priv->vbus);
