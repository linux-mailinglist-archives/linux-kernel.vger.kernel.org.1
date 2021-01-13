Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5AE62F4F10
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 16:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbhAMPps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 10:45:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbhAMPpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 10:45:47 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8D4C061794
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 07:45:06 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id 91so2610046wrj.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 07:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=jilZrI+RmYVgG4Z+y9i7C0wTauSiN6ryBINcA136TDY=;
        b=pHbMHZsbRZqCJZNHIj5Q4eo3iNWwbm8uio2Df/L7M2KkVfbI9hxA0dQ7Wqj91kaUvj
         NGR65+VNC001MYb7eUoVV1U7w6/pIV1+DXzNE3aTqyjXYyDn+9roJ1sOtYWBQuXlbFZn
         6EGT9CT0+OnFPtxxTXTq7Dzu7ltn9FtRJOr0n2+CW7EkVB3fnFQBrCnxjvmF02MxXNXc
         qlb35Xo7TMuqFIR/kKgTON2Nmoiz4SJRVwDuVYy83YVASKZLeYAA3eUMp0fa6AObRRJW
         5HKgxBHw9tgv2Y33Bxcj5ernIaUEQahlymZ4m3AGRt0dRDf7855cNxMbDEK1vulxQb5s
         6Liw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=jilZrI+RmYVgG4Z+y9i7C0wTauSiN6ryBINcA136TDY=;
        b=ZGu3BD1jLe2MER3DweKNr+dfyGs0sjcVOxy9mADbsOIM2vukGA7tgXWiHicDulED03
         x22hZnCmSaVGwqloA9dRdKrlNFmiyirw/JETMj41z46s8ZayRVlaDNfxpPm3NrGKtpr1
         UckG6K3rd8502k8VRCfYuy8JruljZpkdDzxQV3l1IVP5GGynEh9L9ADapa8trYfhvrWh
         NSh6cxyZIpmOjX5tuZW75ro2hTGITwNtHLUPwkBAEHoY0O04HbCZTEPObo+vPj0ITFJr
         lcryiS36ZOxq+f1FJCwnyFh0lQzfScIGmzxk/Blt8SnaeP+CPuREQH+KwvtCJexNSOmX
         72IA==
X-Gm-Message-State: AOAM530hZ5PmvSl9DWv+nv3SgwzCUQFGbWsuv83/8NIxEFBQOHdGEcmQ
        vVqZaNIxg0LzmrRL3xsdcNVCWg==
X-Google-Smtp-Source: ABdhPJzqrERn/dDttB73B0YdhAneozcMUw1VFgp6txkY+IVWPvM27AcW7s9nl/hMjf+ddsQJc1qKww==
X-Received: by 2002:adf:ef01:: with SMTP id e1mr3227461wro.59.1610552705461;
        Wed, 13 Jan 2021 07:45:05 -0800 (PST)
Received: from dell ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id 14sm3397949wmk.37.2021.01.13.07.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 07:45:04 -0800 (PST)
Date:   Wed, 13 Jan 2021 15:45:03 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     =?iso-8859-1?Q?Dani=EBl?= Mantione 
        <daniel.mantione@freepascal.org>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 14/31] video: fbdev: aty: mach64_ct: Remove some set but
 unused variables
Message-ID: <20210113154503.GD3975472@dell>
References: <20210113145009.1272040-1-lee.jones@linaro.org>
 <20210113145009.1272040-15-lee.jones@linaro.org>
 <alpine.DEB.2.21.2101131618160.8079@idefix.freepascal.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.21.2101131618160.8079@idefix.freepascal.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jan 2021, Daniël Mantione wrote:

> Hi,
> 
> If I remember well, the removed lines have to do with the VGA/accelerator
> mode of the chip. The current driver always runs the chip in accelerator
> mode. Suppose you would want to support high resolution hardware text modes
> with the driver (fbdev bpp=0), then you would need to switch the chip into
> VGA mode mode and then the removed lines become relevant.
> 
> I did some experiments with this when I was working on the driver, but
> because the documentation was silent about the behaviour of extended CRTC
> registers in VGA mode, I failed to make hardware text modes to work
> properly.
> 
> The #if 0 was there so code was already there in case me or someone else
> would pick it up again.

This code has been commented out for *at least* 16 years.

Probably time to let it go. :)

> Best regards,
> 
> Daniël Mantione
> 
> Op Wed, 13 Jan 2021, schreef Lee Jones:
> 
> > Fixes the following W=1 kernel build warning(s):
> > 
> > drivers/video/fbdev/aty/mach64_ct.c: In function ‘aty_init_pll_ct’:
> > drivers/video/fbdev/aty/mach64_ct.c:405:46: warning: variable ‘vga_dsp_on_off’ set but not used [-Wunused-but-set-variable]
> > drivers/video/fbdev/aty/mach64_ct.c:405:30: warning: variable ‘vga_dsp_config’ set but not used [-Wunused-but-set-variable]
> > drivers/video/fbdev/aty/mach64_ct.c:405:18: warning: variable ‘dsp_on_off’ set but not used [-Wunused-but-set-variable]
> > 
> > Cc: daniel.mantione@freepascal.org
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-fbdev@vger.kernel.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> > drivers/video/fbdev/aty/mach64_ct.c | 19 ++-----------------
> > 1 file changed, 2 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/video/fbdev/aty/mach64_ct.c b/drivers/video/fbdev/aty/mach64_ct.c
> > index f87cc81f4fa2b..23eececa1e9d7 100644
> > --- a/drivers/video/fbdev/aty/mach64_ct.c
> > +++ b/drivers/video/fbdev/aty/mach64_ct.c
> > @@ -402,7 +402,7 @@ static int aty_init_pll_ct(const struct fb_info *info, union aty_pll *pll)
> > 	struct atyfb_par *par = (struct atyfb_par *) info->par;
> > 	u8 mpost_div, xpost_div, sclk_post_div_real;
> > 	u32 q, memcntl, trp;
> > -	u32 dsp_config, dsp_on_off, vga_dsp_config, vga_dsp_on_off;
> > +	u32 dsp_config;
> > #ifdef DEBUG
> > 	int pllmclk, pllsclk;
> > #endif
> > @@ -488,25 +488,10 @@ static int aty_init_pll_ct(const struct fb_info *info, union aty_pll *pll)
> > 
> > 	/* Allow BIOS to override */
> > 	dsp_config = aty_ld_le32(DSP_CONFIG, par);
> > -	dsp_on_off = aty_ld_le32(DSP_ON_OFF, par);
> > -	vga_dsp_config = aty_ld_le32(VGA_DSP_CONFIG, par);
> > -	vga_dsp_on_off = aty_ld_le32(VGA_DSP_ON_OFF, par);
> > 
> > 	if (dsp_config)
> > 		pll->ct.dsp_loop_latency = (dsp_config & DSP_LOOP_LATENCY) >> 16;
> > -#if 0
> > -	FIXME: is it relevant for us?
> > -	if ((!dsp_on_off && !M64_HAS(RESET_3D)) ||
> > -		((dsp_on_off == vga_dsp_on_off) &&
> > -		(!dsp_config || !((dsp_config ^ vga_dsp_config) & DSP_XCLKS_PER_QW)))) {
> > -		vga_dsp_on_off &= VGA_DSP_OFF;
> > -		vga_dsp_config &= VGA_DSP_XCLKS_PER_QW;
> > -		if (ATIDivide(vga_dsp_on_off, vga_dsp_config, 5, 1) > 24)
> > -			pll->ct.fifo_size = 32;
> > -		else
> > -			pll->ct.fifo_size = 24;
> > -	}
> > -#endif
> > +
> > 	/* Exit if the user does not want us to tamper with the clock
> > 	rates of her chip. */
> > 	if (par->mclk_per == 0) {


-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
