Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5C9F2B3DE2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 08:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbgKPHsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 02:48:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:47702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbgKPHsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 02:48:40 -0500
Received: from localhost (unknown [122.171.203.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC70A2225E;
        Mon, 16 Nov 2020 07:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605512919;
        bh=orvkKSLE3qDSBwWd3ifg4y+FDRcfc/HXOtvw1V1r1Sc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B8/I2oc8lNFmKnMaVvVDwVfMYGoiEFJX/5balP2X9PRKAhX7zRdHpylefGXIUs7gD
         8yjLvdPJgeV5e+TJWJnPdW37B7+usdWjPH73z4kopT5kgDFyrNYMYZZD1IsUsFRvQF
         2szwO46TSUfW6m8lm1MVKif7wkD+ld/zxx0BIJrY=
Date:   Mon, 16 Nov 2020 13:18:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     xiakaixu1987@gmail.com
Cc:     kishon@ti.com, linux-kernel@vger.kernel.org,
        Kaixu Xia <kaixuxia@tencent.com>
Subject: Re: [PATCH] phy: mapphone-mdm6600: remove the unused variable error
 value assignment
Message-ID: <20201116074835.GO7499@vkoul-mobl>
References: <1605256482-5101-1-git-send-email-kaixuxia@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605256482-5101-1-git-send-email-kaixuxia@tencent.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-11-20, 16:34, xiakaixu1987@gmail.com wrote:
> From: Kaixu Xia <kaixuxia@tencent.com>
> 
> The value of variable error is overwritten by the following call
> devm_request_threaded_irq() in phy_mdm6600_device_power_on(), so here the
> value assignment is useless. Remove it.
> 
> Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
> Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
> ---
>  drivers/phy/motorola/phy-mapphone-mdm6600.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/phy/motorola/phy-mapphone-mdm6600.c b/drivers/phy/motorola/phy-mapphone-mdm6600.c
> index 5172971..24ab848 100644
> --- a/drivers/phy/motorola/phy-mapphone-mdm6600.c
> +++ b/drivers/phy/motorola/phy-mapphone-mdm6600.c
> @@ -421,7 +421,6 @@ static int phy_mdm6600_device_power_on(struct phy_mdm6600 *ddata)
>  			dev_info(ddata->dev, "Powered up OK\n");
>  	} else {
>  		ddata->enabled = false;
> -		error = -ETIMEDOUT;
>  		dev_err(ddata->dev, "Timed out powering up\n");

Maybe the right fix is adding return error here..?

-- 
~Vinod
