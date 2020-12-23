Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34FF92E1C63
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 13:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbgLWMwM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 23 Dec 2020 07:52:12 -0500
Received: from aposti.net ([89.234.176.197]:54176 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727047AbgLWMwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 07:52:12 -0500
Date:   Wed, 23 Dec 2020 12:51:17 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 1/2] mmc: jz4740: remove unused struct component
 card_detect_irq
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Tony Lindgren <tony@atomide.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
Message-Id: <HDMSLQ.E58BFK9OOELD3@crapouillou.net>
In-Reply-To: <415ea1cb85eedc12f0c2f70da9a1ae3885bdd091.1608714110.git.hns@goldelico.com>
References: <cover.1608714110.git.hns@goldelico.com>
        <415ea1cb85eedc12f0c2f70da9a1ae3885bdd091.1608714110.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le mer. 23 déc. 2020 à 10:01, H. Nikolaus Schaller 
<hns@goldelico.com> a écrit :
> I have not found any user for this struct component.
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
>  drivers/mmc/host/jz4740_mmc.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/jz4740_mmc.c 
> b/drivers/mmc/host/jz4740_mmc.c
> index a1f92fed2a55b7..b3c636edbb4610 100644
> --- a/drivers/mmc/host/jz4740_mmc.c
> +++ b/drivers/mmc/host/jz4740_mmc.c
> @@ -152,7 +152,6 @@ struct jz4740_mmc_host {
>  	enum jz4740_mmc_version version;
> 
>  	int irq;
> -	int card_detect_irq;
> 
>  	void __iomem *base;
>  	struct resource *mem_res;
> --
> 2.26.2
> 


