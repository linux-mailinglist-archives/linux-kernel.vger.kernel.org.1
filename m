Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DADB2CD629
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 13:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730480AbgLCMzL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 3 Dec 2020 07:55:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbgLCMzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 07:55:11 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19F8C061A4F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 04:54:30 -0800 (PST)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kko7m-0006rU-LQ; Thu, 03 Dec 2020 13:54:18 +0100
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kko7j-0006Zq-BC; Thu, 03 Dec 2020 13:54:15 +0100
Message-ID: <9277bc82766d26d840dbd0a7b4041cd267862a39.camel@pengutronix.de>
Subject: Re: [PATCH 1/4] reset: hisilicon: correct vendor prefix
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Wei Xu <xuwei5@hisilicon.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Zhangfei Gao <zhangfei.gao@linaro.org>,
        Chen Feng <puck.chen@hisilicon.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date:   Thu, 03 Dec 2020 13:54:15 +0100
In-Reply-To: <20201203120212.1105-2-thunder.leizhen@huawei.com>
References: <20201203120212.1105-1-thunder.leizhen@huawei.com>
         <20201203120212.1105-2-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-12-03 at 20:02 +0800, Zhen Lei wrote:
> The vendor prefix of "Hisilicon Limited" is "hisilicon", it is clearly
> stated in "vendor-prefixes.yaml".
> 
> Fixes: 1527058736fa ("reset: hisilicon: add reset-hi3660")
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> Cc: Zhangfei Gao <zhangfei.gao@linaro.org>
> ---
>  drivers/reset/hisilicon/reset-hi3660.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/reset/hisilicon/reset-hi3660.c b/drivers/reset/hisilicon/reset-hi3660.c
> index a7d4445924e558c..8f1953159a65b31 100644
> --- a/drivers/reset/hisilicon/reset-hi3660.c
> +++ b/drivers/reset/hisilicon/reset-hi3660.c
> @@ -83,7 +83,7 @@ static int hi3660_reset_probe(struct platform_device *pdev)
>  	if (!rc)
>  		return -ENOMEM;
>  
> -	rc->map = syscon_regmap_lookup_by_phandle(np, "hisi,rst-syscon");
> +	rc->map = syscon_regmap_lookup_by_phandle(np, "hisilicon,rst-syscon");

What about those that don't upgrade kernel and DT in lock-step?
It would be easy to fall back to the old compatible if the new one
fails.

regards
Philipp
