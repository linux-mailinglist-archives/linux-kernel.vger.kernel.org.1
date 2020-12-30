Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E266D2E7A81
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 16:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgL3Pl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 10:41:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:45108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbgL3Pl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 10:41:58 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DB622222A;
        Wed, 30 Dec 2020 15:41:11 +0000 (UTC)
Date:   Wed, 30 Dec 2020 15:41:07 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Xu Wang <vulab@iscas.ac.cn>
Cc:     lars@metafoo.de, pmeerw@pmeerw.net, mcoquelin.stm32@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: stm32-dfsdm: Remove redundant null check
 before clk_disable_unprepare
Message-ID: <20201230154107.4b301aed@archlinux>
In-Reply-To: <20201218094145.1123-1-vulab@iscas.ac.cn>
References: <20201218094145.1123-1-vulab@iscas.ac.cn>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Dec 2020 09:41:45 +0000
Xu Wang <vulab@iscas.ac.cn> wrote:

> ecause clk_disable_unprepare() already checked NULL clock parameter,
> so the additional check is unnecessary, just remove it.
Please resend, making sure to cc linux-iio@vger.kernel.org

Thanks,

Jonathan

> 
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
> ---
>  drivers/iio/adc/stm32-dfsdm-core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-dfsdm-core.c b/drivers/iio/adc/stm32-dfsdm-core.c
> index 42a7377704a4..bb925a11c8ae 100644
> --- a/drivers/iio/adc/stm32-dfsdm-core.c
> +++ b/drivers/iio/adc/stm32-dfsdm-core.c
> @@ -117,8 +117,7 @@ static void stm32_dfsdm_clk_disable_unprepare(struct stm32_dfsdm *dfsdm)
>  {
>  	struct dfsdm_priv *priv = to_stm32_dfsdm_priv(dfsdm);
>  
> -	if (priv->aclk)
> -		clk_disable_unprepare(priv->aclk);
> +	clk_disable_unprepare(priv->aclk);
>  	clk_disable_unprepare(priv->clk);
>  }
>  

