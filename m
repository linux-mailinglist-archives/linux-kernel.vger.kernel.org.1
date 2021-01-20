Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E36F2FCCEF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 09:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731019AbhATIo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 03:44:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730951AbhATIoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 03:44:17 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C2CC061757
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 00:43:36 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id a9so18779728wrt.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 00:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=zZeqVFyGPCnVkhhZMkK/fwVjgN94Q3QJTGFXkTCP56M=;
        b=UPgCFMVw9ttZBzgi+Fx/uL8idzSWMrpskcJD9L+5I/YFutv8AuCexMiteQ5XKjb6Eo
         Akaib27hA/ftrxp6ucO3PgqygpbD1ftwf3bIsOU+GZSfUKGj3hDTdAc39HmQ8cDo/L2i
         ZYNvalFUELDeAeV8DpIDensNRgTM5NmHNOpxYRpACYXfbCAYTsoyBBcjkaDPR1ifXbyz
         u9VTL9AlEU9OJXvKCu89hK7EzRp4EvtdTMy6Y10f2amMPoy2fyyt0KpjHc+m/wvYeqZB
         D/ZcV4zP/0K1gX/KU1M9d2NIdPPSVWzAWrQl6Jk5BRPE7DlOrk8+yu0KCgEvkGiMVx3S
         sHtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zZeqVFyGPCnVkhhZMkK/fwVjgN94Q3QJTGFXkTCP56M=;
        b=PRdF1ma2pMDwPrpZz2n8IsX0sz6BRO6Cw0cVB4bQ7y8rdT33dHDNybCZzsJggtkZH5
         eyNiM/FAlxWlnV0KZwvwOWi9j8Khp9rTrPWxr+znh+J4TTzxWUEEr69HZMbClpVqQX2+
         4O4JRBvgXUP0XFuc6syraHJRlSUbGAJWccGqEEdEeTfxhRqOY5mYx1ZP5p8AnpYYZnYd
         zGrYz8rhZUSamaOT1CvCRWIbdYA0Oh4chMqwXo6LFARbeVlahhtNvynQnNHvAwZ3p7qW
         NAPJsDdRmnJzd4RHKx0sYSnNRIs4JhYqznXKesZFUP2Rmcatt6XcXs1dx3Nklab0glKx
         7xRQ==
X-Gm-Message-State: AOAM530SYr8P3vDvkvs9uX/J5+3s/GmNQSdC3f2JwbdTCTg2XY7rxYkh
        d0H76UjeJvOPwvItqAA5VnaX69aW4BsFqTIV
X-Google-Smtp-Source: ABdhPJyD24aygEwtGUIWVyoHTzbtcmsqJs9BB3zS3WHSpXSIlIYNMpLg7NGnce2odgTjYkSxHjntRw==
X-Received: by 2002:a05:6000:1043:: with SMTP id c3mr7313091wrx.140.1611132215560;
        Wed, 20 Jan 2021 00:43:35 -0800 (PST)
Received: from dell ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id u83sm2489930wmu.12.2021.01.20.00.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 00:43:34 -0800 (PST)
Date:   Wed, 20 Jan 2021 08:43:32 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] mfd: iqs62x: Increase interrupt handler return
 delay
Message-ID: <20210120084332.GQ4903@dell>
References: <1610942228-7275-1-git-send-email-jeff@labundy.com>
 <1610942228-7275-5-git-send-email-jeff@labundy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1610942228-7275-5-git-send-email-jeff@labundy.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Jan 2021, Jeff LaBundy wrote:

> The time the device takes to deassert its RDY output following an
> I2C stop condition scales with the core clock frequency.
> 
> To prevent level-triggered interrupts from being reasserted after
> the interrupt handler returns, increase the time before returning
> to account for the worst-case delay (~90 us) plus margin.
> 
> Signed-off-by: Jeff LaBundy <jeff@labundy.com>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> ---
> Changes in v2:
>   - Added Acked-for-MFD-by trailer
> 
>  drivers/mfd/iqs62x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
