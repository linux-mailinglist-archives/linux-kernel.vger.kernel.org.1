Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBDC2C60E7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 09:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbgK0Ics (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 03:32:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgK0Icr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 03:32:47 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D1DC0617A7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 00:32:45 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id f190so2704913wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 00:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=eAdalm4QHc9hAmDG/xOUAcKIOz0SCKnJUjFdQgtGIsQ=;
        b=Wq0s8zBftW/RgJ+9EJq3lrsGXgIq0Ey5tY4hA3KR6BbQNTNKY93Acig8eR1C7dCkid
         iR8RULncWs2A0qGCnLxPiTWmRHBM5bDXNl6T1Syl3zVU2jYBOVWzW+ZKRck5I1tBRxWs
         Ghuht/XT+k+gHrg19fBtv+eyVYbKEfcZjIDif/l1HkPNoCCov5+DgJyeymtO9WGa75Gw
         6LGlzC2eaqN6qlJ/CsAdcWmssQdNB5Dsr8r0fswg6BUon6N2ZD0Ul315nrpzEYsu/f+V
         4wzZHWHtZceljWDkHmd9xMDMUy4hSum4Oa4GQ+vVmVFvJRm2IWpTWvZFKEIvZprzH+g4
         mn+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=eAdalm4QHc9hAmDG/xOUAcKIOz0SCKnJUjFdQgtGIsQ=;
        b=j6KqqBMFDfzvQol7mrUz99AQFNwCszYrav5umX7NMmBA3lZUlQi97zBf3ahFpKyYW+
         /ewrF2WU7m7Qe4F62KiXq63vODDiHDbIguq2OM8Z9wjUr/mFJte4BKq9YZislIhs0Cyw
         bcengf6r4GHJvIeUcOThI9AUFaVl8jgU4W40gO3He9+iimuHcYJ0Jburt5P7nCUWrxn0
         YWsQ3FoTFQqYVuGAJ2ajoCDR3qWSReDBTO2BetSXenZ58gTedPE98Uv12L/MUDA9uFxm
         xEpbD/j96nfiVQH7hl4IyAPfE1imkGAnRp5EEhADXBhk5Wigcrj81Gni4TQ/bT9XAVFF
         8emg==
X-Gm-Message-State: AOAM5314GWinvmsMLKkz/Uz6s7x4etk/IBIB0gCdBKFVPucK6pdt81Jf
        +gEw29i3zKYQy7C81C3a+DHNkw==
X-Google-Smtp-Source: ABdhPJwi040KwhQPzoYDENnmMcnuFP/231E5ZtxqzU/8uZay0K6yX1s6Z8Cs55dc2kCY2vohc8aRoQ==
X-Received: by 2002:a05:600c:2314:: with SMTP id 20mr3641698wmo.92.1606465964655;
        Fri, 27 Nov 2020 00:32:44 -0800 (PST)
Received: from dell ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id w15sm13402265wrp.52.2020.11.27.00.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 00:32:43 -0800 (PST)
Date:   Fri, 27 Nov 2020 08:32:42 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com, Rob Herring <robh+dt@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-power@fi.rohmeurope.com,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH RESEND v6 2/4] mfd: Support ROHM BD9576MUF and BD9573MUF
Message-ID: <20201127083242.GK2455276@dell>
References: <cover.1605882179.git.matti.vaittinen@fi.rohmeurope.com>
 <cc46e329efa30c66f000ab7c97f9bbf0bc31f0f7.1605882179.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cc46e329efa30c66f000ab7c97f9bbf0bc31f0f7.1605882179.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Nov 2020, Matti Vaittinen wrote:

> Add core support for ROHM BD9576MUF and BD9573MUF PMICs which are
> mainly used to power the R-Car series processors.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
>  drivers/mfd/Kconfig              |  11 ++++
>  drivers/mfd/Makefile             |   1 +
>  drivers/mfd/rohm-bd9576.c        | 108 +++++++++++++++++++++++++++++++
>  include/linux/mfd/rohm-bd957x.h  |  59 +++++++++++++++++
>  include/linux/mfd/rohm-generic.h |   2 +
>  5 files changed, 181 insertions(+)
>  create mode 100644 drivers/mfd/rohm-bd9576.c
>  create mode 100644 include/linux/mfd/rohm-bd957x.h

Looks like a possible candidate for "simple-mfd-i2c".

Could you look into that please?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
