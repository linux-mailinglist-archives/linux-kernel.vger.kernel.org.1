Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF8282A8D27
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 03:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgKFCvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 21:51:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgKFCvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 21:51:15 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85321C0613CF;
        Thu,  5 Nov 2020 18:51:15 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id i7so2730965qti.6;
        Thu, 05 Nov 2020 18:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WTOpuxQqUTD7Fs5ED8d6WE6HwICjQ/RXvxFgPZw8ydY=;
        b=p/JG8EDrUjsel8y++UnIKylNNB7pdtkG84acG4fowir5XwgMGq/dJP/aJWrh0XctbL
         ad+bYvmnzOOpMPsliLfFb9w0yxcfyKBiZd9sJOrOuniq56S3j5a3y5sYVEnZ5FO7/Q36
         omn87/g+QkVSEEycolY5jlF6rcNa9thuBFYqBKPPlFXQ/E8nDDqgvvRU97nxZ+1guG7p
         9OetQ7bZNAYVtwv9mHGIHzurr02g9ja+Hw36FbwjvLxyTERVcFRIsiw0a6ueba3flpt8
         nAy9mWVR0o7N/d2XsbQVm9ncI/AmWajjppaC7uve7TaNqJSCsYc2VTGEyLRrTKSjACH9
         z0Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WTOpuxQqUTD7Fs5ED8d6WE6HwICjQ/RXvxFgPZw8ydY=;
        b=UPHtsBv9Iv9ZQw6uvQ9KVtKyftLfWNc7QXUgpStfcWDFxU9O1ZvCq/FtNjnEQRw+Er
         JGR0oWJRNZypuXFh0E5octqFSWUMtT6eyiX4TD+ytmlJJ0+gCRpZzftg80x46LV/9J5u
         Mf7lMkILZPOY1zJ+8Xxrj329dLeEEiyMZmWjZ+s1KZgnaLela13UMr8OG4mcDFEZCs4s
         KP2F2utQwAr759qhtT5EeXqtUuPBpeBntK8ffCcrREIvMt4RPwgQYaxSie99VZXB+ych
         YngzgTgDi63cgAIJN8HxGTfbdhWhRIUAxQ4VT1VWrSMUR0x08iJMwgHk7/JcLW5j79eL
         ubkA==
X-Gm-Message-State: AOAM533xeGYPRYK4dqILY0+YPY621R0m2c/XsxgrUkc7og1CWAQ4ZD34
        ej0KHbkLX+vXYRZ5eMpbFr3N7JVHaz6dlwiazvo=
X-Google-Smtp-Source: ABdhPJzmaVLfpBM4DF4coroQarUHDYYbWmF3o5VQGr7jzQ39SDG3tzILiBVeORimIM8T60VCYrXH/xjW6RHzzC5xsMs=
X-Received: by 2002:ac8:71c3:: with SMTP id i3mr340558qtp.204.1604631074809;
 Thu, 05 Nov 2020 18:51:14 -0800 (PST)
MIME-Version: 1.0
References: <1604281947-26874-1-git-send-email-shengjiu.wang@nxp.com>
 <1604281947-26874-2-git-send-email-shengjiu.wang@nxp.com> <20201105013539.GA16459@Asurada-Nvidia>
In-Reply-To: <20201105013539.GA16459@Asurada-Nvidia>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Fri, 6 Nov 2020 10:51:03 +0800
Message-ID: <CAA+D8ANrkgXR+8JGp4fPLvkKJ05EqQyShWTO+xWpPOycPT9Tyw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] ASoC: fsl_aud2htx: Add aud2htx module driver
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, alsa-devel@alsa-project.org,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 5, 2020 at 9:48 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Mon, Nov 02, 2020 at 09:52:27AM +0800, Shengjiu Wang wrote:
> > The AUD2HTX is a digital module that provides a bridge between
> > the Audio Subsystem and the HDMI RTX Subsystem. This module
> > includes intermediate storage to queue SDMA transactions prior
> > to being synchronized and passed to the HDMI RTX Subsystem over
> > the Audio Link.
> >
> > The AUD2HTX contains a DMA request routed to the SDMA module.
> > This DMA request is controlled based on the watermark level in
> > the 32-entry sample buffer.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
>
> Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
>
> Despite some small comments inline.
>
> > +static int fsl_aud2htx_dai_probe(struct snd_soc_dai *cpu_dai)
> > +{
> > +     struct fsl_aud2htx *aud2htx = dev_get_drvdata(cpu_dai->dev);
> > +
> > +     /* DMA request when number of entries < WTMK_LOW */
> > +     regmap_update_bits(aud2htx->regmap, AUD2HTX_CTRL_EXT,
> > +                        AUD2HTX_CTRE_DT_MASK, 0);
> > +
> > +     /* Disable interrupts*/
> > +     regmap_update_bits(aud2htx->regmap, AUD2HTX_IRQ_MASK,
> > +                        AUD2HTX_WM_HIGH_IRQ_MASK |
> > +                        AUD2HTX_WM_LOW_IRQ_MASK |
> > +                        AUD2HTX_OVF_MASK,
> > +                        AUD2HTX_WM_HIGH_IRQ_MASK |
> > +                        AUD2HTX_WM_LOW_IRQ_MASK |
> > +                        AUD2HTX_OVF_MASK);
> > +
> > +     /* Configure watermark */
> > +     regmap_update_bits(aud2htx->regmap, AUD2HTX_CTRL_EXT,
> > +                        AUD2HTX_CTRE_WL_MASK,
> > +                        AUD2HTX_WTMK_LOW << AUD2HTX_CTRE_WL_SHIFT);
> > +     regmap_update_bits(aud2htx->regmap, AUD2HTX_CTRL_EXT,
> > +                        AUD2HTX_CTRE_WH_MASK,
> > +                        AUD2HTX_WTMK_HIGH << AUD2HTX_CTRE_WH_SHIFT);
>
> If there isn't a hard requirement from hardware, feels better to
> combine all the writes to AUD2HTX_CTRL_EXT into one single MMIO.

ok, will update it.

>
> > +static irqreturn_t fsl_aud2htx_isr(int irq, void *dev_id)
> > +{
> > +     return IRQ_HANDLED;
>
> Empty isr? Perhaps can drop the request_irq() at all?

I'd like to keep this for future enhancement, what do you think?

>
> > +static int fsl_aud2htx_probe(struct platform_device *pdev)
> > +{
> > +     struct fsl_aud2htx *aud2htx;
> > +     struct resource *res;
> > +     void __iomem *regs;
> > +     int ret, irq;
> > +
> > +     aud2htx = devm_kzalloc(&pdev->dev, sizeof(*aud2htx), GFP_KERNEL);
> > +     if (!aud2htx)
> > +             return -ENOMEM;
> > +
> > +     aud2htx->pdev = pdev;
> > +
> > +     res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +     regs = devm_ioremap_resource(&pdev->dev, res);
> > +     if (IS_ERR(regs)) {
> > +             dev_err(&pdev->dev, "failed ioremap\n");
> > +             return PTR_ERR(regs);
> > +     }
> > +
> > +     aud2htx->regmap = devm_regmap_init_mmio(&pdev->dev, regs,
> > +                                             &fsl_aud2htx_regmap_config);
> > +     if (IS_ERR(aud2htx->regmap)) {
> > +             dev_err(&pdev->dev, "failed to init regmap");
> > +             return PTR_ERR(aud2htx->regmap);
> > +     }
> > +
> > +     irq = platform_get_irq(pdev, 0);
> > +     if (irq < 0) {
> > +             dev_err(&pdev->dev, "no irq for node %s\n",
> > +                     dev_name(&pdev->dev));
>
> dev_err() already prints dev_name, so not necessary to print again.

ok, will update it

best regards
wang shengjiu
