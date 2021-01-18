Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB802FA529
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 16:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405950AbhARPvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 10:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406014AbhARPvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 10:51:10 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF26C061575
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 07:50:30 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id o10so142622wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 07:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=hnlP4TCuuuU1Boi/hLdzhd2/6iQdts7ZHhXzPyMgjoQ=;
        b=C5aYq8K6u9jjD9Bxrht4BtypiJqRgY4dAlrtbgaYqLKiGopcD3CZOqogeLuBQshiC/
         rLAS9F/uord1WqD0EZA4j9vpmHY6rxDIiSOeN80PtzTh8ARftMzeDqbc78uo4fxmhH3J
         W8BtWFO05uzZsIDEUzKTpHVpsTqoN8rTqx6AlbDD7W2ngK66pKXgcB/nLEbfFpyH9F7L
         nAwKM4QM/IdBwnPo4LUsDt2Q3PBg3E1yL5dAFy/JhUVMDJ7nZ7B4Gfl0WYtsD61uPuAx
         QxIIDD6739wfYHmcmVuZJM6p55gXqigdlDAlJEhGaA8bIWjtLnqzZU3858Zfa+hDNi1x
         tuYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hnlP4TCuuuU1Boi/hLdzhd2/6iQdts7ZHhXzPyMgjoQ=;
        b=cPlx9+GHVIgkpYFhYbby9R3CQa1t8Isyyprg5Bc32WDzVaWoTEIHYy4c2yaSNzU9to
         yIIuLszuZ5FXMTjgtEMRHUthrEogdAbDXpMNwsom5UO2yw4l8mkc3S0lUZM/lLX8Zldx
         hkKz03M906/RV9dSPA+W+skzKYNE1vwezStbWe3ZTAql4w4ywUfBM4uVCt3qjuT4U23a
         FZTk+VPxq5YEEvpjtsTvbMZayAFbgzgEyjUSTrerpau1I/50w60xJINl5QtlRQPZLqD7
         QbTFK1FGIFsUw4om4frteK745Get+wnaAp0/sRCb0YO8lt+VkwX3ZQx3zEOGTzmMEKiV
         4qDQ==
X-Gm-Message-State: AOAM530WpgaqiknfHfJzO/pfk0j0IK2GnpGLpUMv0edZiOK53EE9RUKF
        ZXbdT63Pzko65Xb8eKT/xOS1yA==
X-Google-Smtp-Source: ABdhPJyGQlmjNpAe5FPf9+L9SpVO6HOy+hRWw/s3IfHIcDSQDh6vMYL2r/2lCncdI6UxCHS92rQYVA==
X-Received: by 2002:a1c:6383:: with SMTP id x125mr37380wmb.46.1610985028772;
        Mon, 18 Jan 2021 07:50:28 -0800 (PST)
Received: from dell ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id m14sm30211665wrh.94.2021.01.18.07.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 07:50:28 -0800 (PST)
Date:   Mon, 18 Jan 2021 15:50:26 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mayulong <mayulong1@huawei.com>,
        Rob Herring <robh+dt@kernel.org>, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/13] mfd: hi6421-spmi-pmic: move driver from staging
Message-ID: <20210118155026.GH4903@dell>
References: <cover.1610975633.git.mchehab+huawei@kernel.org>
 <8a152819ef89c73dd6afb5c2deb5441402fcd2fa.1610975633.git.mchehab+huawei@kernel.org>
 <20210118151227.GF4903@dell>
 <20210118163222.6161f9a2@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210118163222.6161f9a2@coco.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jan 2021, Mauro Carvalho Chehab wrote:

> Em Mon, 18 Jan 2021 15:12:27 +0000
> Lee Jones <lee.jones@linaro.org> escreveu:
> 
> > On Mon, 18 Jan 2021, Mauro Carvalho Chehab wrote:
> > 
> > > This driver is ready for mainstream. So, move it out of staging.
> > > 
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > ---
> > >  .../mfd/hisilicon,hi6421-spmi-pmic.yaml       | 133 +++++++
> > >  MAINTAINERS                                   |   7 +
> > >  drivers/mfd/Kconfig                           |  15 +
> > >  drivers/mfd/Makefile                          |   1 +
> > >  drivers/mfd/hi6421-spmi-pmic.c                | 342 ++++++++++++++++++
> > >  drivers/staging/hikey9xx/Kconfig              |  16 -
> > >  drivers/staging/hikey9xx/Makefile             |   1 -
> > >  drivers/staging/hikey9xx/hi6421-spmi-pmic.c   | 342 ------------------
> > >  .../hikey9xx/hisilicon,hi6421-spmi-pmic.yaml  | 133 -------
> > >  9 files changed, 498 insertions(+), 492 deletions(-)  
> > 
> > Could you please resubmit this will the correct flags.
> > 
> > I believe it's the `git format-patch` -M flag that you want.
> 
> As explained at patch 00/13, this was intentionally generated with
> --no-merges, in order to allow reviewers to view the entire source
> code at the patch. 

That's a fair point.  Please leave it as it is for now then.

I'll get around to the review soon I hope.

> Anyway, I'll re-send the series with -M, as it makes easier to merge,
> if everything is ok.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
