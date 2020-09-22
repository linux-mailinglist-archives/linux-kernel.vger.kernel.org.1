Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD96273C96
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 09:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgIVHtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 03:49:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:49618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726766AbgIVHtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 03:49:16 -0400
Received: from coco.lan (ip5f5ad5bc.dynamic.kabel-deutschland.de [95.90.213.188])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CA0523A5F;
        Tue, 22 Sep 2020 07:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600760955;
        bh=0DzvC1tqpuuweLFZwjymVALFk6hcfat24pA61wff9hE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DIhtMyF1wPsYzJaiplUZkVnharswC/x8I5bMRm7hdpVNsevB5v/XgTIhFfYsaVGKx
         Q3JDam8caFWKOoMq4yqVc8nCLw+P2ato9J4Nf3eHAwXdXR0N7TO54f5UIm0a92V4M7
         1gCQVruP+ZcoEFODY2a6zKZ90f2OOHeKA6vHvfJg=
Date:   Tue, 22 Sep 2020 09:49:10 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Alex Dewar <alex.dewar90@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yu Chen <chenyu56@huawei.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: hikey9xx: Fix incorrect assignment
Message-ID: <20200922094910.36501e57@coco.lan>
In-Reply-To: <20200921212146.34662-1-alex.dewar90@gmail.com>
References: <20200921174113.19566-1-a.dewar@sussex.ac.uk>
        <20200921212146.34662-1-alex.dewar90@gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 21 Sep 2020 22:21:47 +0100
Alex Dewar <alex.dewar90@gmail.com> escreveu:

> In hi3670_phy_probe(), when reading property tx-vboost-lvl fails, its
> default value is assigned to priv->eye_diagram_param, rather than to
> priv->tx_vboost_lvl. Fix this.
> 
> Fixes: 8971a3b880b2 ("staging: hikey9xx: add USB physical layer for Kirin 3670")
> Addresses-Coverity: CID 1497107: Incorrect expression (COPY_PASTE_ERROR)
> Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>

Patch looks good to me. I also double-checked if everything
works ok after this fix - although it should, as the DT I'm using
has "hisilicon,tx-vboost-lvl" property defined. So:

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Tested-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>



> ---
> v2: Fix my email address and a typo in title
> 
>  drivers/staging/hikey9xx/phy-hi3670-usb3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/hikey9xx/phy-hi3670-usb3.c b/drivers/staging/hikey9xx/phy-hi3670-usb3.c
> index 42dbc20a0b9a..4fc013911a78 100644
> --- a/drivers/staging/hikey9xx/phy-hi3670-usb3.c
> +++ b/drivers/staging/hikey9xx/phy-hi3670-usb3.c
> @@ -640,7 +640,7 @@ static int hi3670_phy_probe(struct platform_device *pdev)
>  
>  	if (of_property_read_u32(dev->of_node, "hisilicon,tx-vboost-lvl",
>  				 &priv->tx_vboost_lvl))
> -		priv->eye_diagram_param = KIRIN970_USB_DEFAULT_PHY_VBOOST;
> +		priv->tx_vboost_lvl = KIRIN970_USB_DEFAULT_PHY_VBOOST;
>  
>  	phy = devm_phy_create(dev, NULL, &hi3670_phy_ops);
>  	if (IS_ERR(phy))



Thanks,
Mauro
