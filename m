Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1393B2A2EB0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 16:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgKBPyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 10:54:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbgKBPyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 10:54:13 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2499C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 07:54:13 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id g12so11127603pgm.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 07:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1vrzECiaWBeiBq9l7kPvoWRn3e/pBcE0avlni3wG6D0=;
        b=wXlymlStqCInllzkbQGt+QGzgVJNNnFu9FyHhNSouRC0vvk8k21EPC3zMIzpjxKmVH
         ZmYe258u7ytwCpOwXe/O4fJBDnm0QCwiR37uDix+FDAbDMoSBD5ZpiPw5V9Io0PD8riD
         KVYO1JGSrJPdP2uHt03gAkCO/PK0pEDwdZ+nMRZainwMiJeUnom4HgWH6ALl5n50l34T
         OBAY1VNZKoHbYtXwk/kUz7aR1JhucVNJ+I2HP+iIPZzocvlAYfmpfr4IiAnjJyNSLz1h
         3Fr3WDSDpPmlVSUcmDoPJLFDzWih2XnI6XyWmxxDdlH0PEMgBrfWsIs7uJmYQhYkGXKV
         i4Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1vrzECiaWBeiBq9l7kPvoWRn3e/pBcE0avlni3wG6D0=;
        b=I4ygHRXKHC3nvmCTyPQRjUmzv/Qt5mSfJ6wz1El0KPNpoGNRuy9pUaMOH5vRtL/0fF
         +WbWMw1zU99tdxRs99pmYa+Yi29CKImEU3wGiQsx+ih73NBeLqax6R25/w7WYG2f+0Kt
         Lr7ZiduR0PhUsyfdm+DOPcvf2UABcieFxCmuSCSs4rZ75WT5CP9XOGs48OKfuSK61lro
         8D2TMdIsOoOT1t2KiCZ8Y1OqHnIyvX4FDFrssGAjRZbIplI9oC7DeMeBTi29IdYxOuZa
         RPb5na9NqWWW0z/m3egoplq/J9/nD5913WMlLvkcYS7Ul2vFCuC6/7uEUWSA346YW0BM
         7u8g==
X-Gm-Message-State: AOAM531Jh8QE3BwoCaAX+Xusapigy6f38RKXXO4P2CpOOhltw9oVBS/q
        gRAfD55YkCJYsUBtcWBSFUW1
X-Google-Smtp-Source: ABdhPJz1NniixdppysYFa0woWutPPGbzr5naR4tv7+GicWc3IN7HyHQCL307+sfnTYuFMeeCpGSc6Q==
X-Received: by 2002:a63:1d15:: with SMTP id d21mr13875401pgd.433.1604332453083;
        Mon, 02 Nov 2020 07:54:13 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:88d:1669:71a1:e02e:eb52:9e34])
        by smtp.gmail.com with ESMTPSA id j11sm13828752pfc.64.2020.11.02.07.54.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Nov 2020 07:54:12 -0800 (PST)
Date:   Mon, 2 Nov 2020 21:24:03 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     ulf.hansson@linaro.org, afaerber@suse.de, p.zabel@pengutronix.de,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: owl-mmc: replace spin_lock_irqsave by spin_lock in
 hard IRQ
Message-ID: <20201102155403.GB4009@Mani-XPS-13-9360>
References: <1604278337-55624-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604278337-55624-1-git-send-email-tiantao6@hisilicon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 08:52:17AM +0800, Tian Tao wrote:
> The code has been in a irq-disabled context since it is hard IRQ. There
> is no necessity to do it again.
> 

Ah, yes. This should save few cycles!

> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/mmc/host/owl-mmc.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/owl-mmc.c b/drivers/mmc/host/owl-mmc.c
> index ccf214a..82d2bad 100644
> --- a/drivers/mmc/host/owl-mmc.c
> +++ b/drivers/mmc/host/owl-mmc.c
> @@ -134,10 +134,9 @@ static void owl_mmc_update_reg(void __iomem *reg, unsigned int val, bool state)
>  static irqreturn_t owl_irq_handler(int irq, void *devid)
>  {
>  	struct owl_mmc_host *owl_host = devid;
> -	unsigned long flags;
>  	u32 state;
>  
> -	spin_lock_irqsave(&owl_host->lock, flags);
> +	spin_lock(&owl_host->lock);
>  
>  	state = readl(owl_host->base + OWL_REG_SD_STATE);
>  	if (state & OWL_SD_STATE_TEI) {
> @@ -147,7 +146,7 @@ static irqreturn_t owl_irq_handler(int irq, void *devid)
>  		complete(&owl_host->sdc_complete);
>  	}
>  
> -	spin_unlock_irqrestore(&owl_host->lock, flags);
> +	spin_unlock(&owl_host->lock);
>  
>  	return IRQ_HANDLED;
>  }
> -- 
> 2.7.4
> 
