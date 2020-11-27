Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7212C6692
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 14:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730328AbgK0NSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 08:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730033AbgK0NSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 08:18:40 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9502C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 05:18:39 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id u12so5578218wrt.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 05:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ME0d1krnpfBPa1ZQBMZAFrZpY9utmeWEixoYm4tf5bY=;
        b=dRuq4iN5UDLxbDjrPpQEopkC9Qnw24+ZFgBiWozs07pHyTKANR6skeZ61I3Xhkkf34
         Udgm3GaePWWmQZGZCP82fkqtaQakndiFz9Iy69nZLhdaK4PjZWsNicvHnxnDlOgnLjku
         UbjGAIAoY4OQigTZbue0Nzt1aS4lb/I4KtsD0hTDQqMAedQcULmh0O07aRTg8l2CJ/Ir
         WdbAQ1HrRUbh29obHv5tG//UxgqZVogw6xgiKEuPdMMKqlKPRJnLVfp6VXTiGFhGRxUR
         QUT81H99SwkxyZ/45P9U/fznRJbQSp/rIjuJgplBKAT+EAEybBOAy1ux+oyfp8h80k0N
         ZLvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ME0d1krnpfBPa1ZQBMZAFrZpY9utmeWEixoYm4tf5bY=;
        b=mggIxW1h4nxyjHkw8k9qDONk5aQKhLe93XZYRJrXiKaXr+oURopkwatQ7Y1Kam4dMe
         r+s00W6pwpg2O+6xFEoG76cQ9WUbPwl8fvGC6o1uv7518IvLpZvKRaWEoZgRPBreVJy4
         D8NMGuvAEd41XYuMyt7fN5J1WoAi0X5zTuAMjwuugsPNVjUbvsrobQ3ToU8P8GPWSpEP
         1Y09FH8dsBAiYAB8qROkoYIvyQDv4cNu55cBBtWlTUlEzaLxllTUwIExYK4KfefVDM8G
         j0SaCY4GWD39HqIWwlrB2t03BxyN5ZOMZuY/5Mzg1KpzsYfTwzUTF67X03pFJEPGcSJu
         734Q==
X-Gm-Message-State: AOAM531JVts9W7cu4xJUTG2XkByZSvOj33VQlk33PoRpjcRXBHU+lsn0
        +it9iSQhR9FxKgHa4Mdsfwio3w==
X-Google-Smtp-Source: ABdhPJw4U2eyaATAcQ+k5RfJrLNVchpXgT2k/i/RmKEJSDe+Q+igGbMtLm1Mea8GM0jAbTHbvk0yYg==
X-Received: by 2002:adf:a198:: with SMTP id u24mr10477010wru.219.1606483118494;
        Fri, 27 Nov 2020 05:18:38 -0800 (PST)
Received: from dell ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id 2sm17405240wrq.87.2020.11.27.05.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 05:18:37 -0800 (PST)
Date:   Fri, 27 Nov 2020 13:18:35 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Michael Klein <michael@fossekall.de>
Cc:     Andrei Stefanescu <andrei.stefanescu@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH v2 3/3] mfd: da9055: fix "REGULATOR" spelling in register
 content macro
Message-ID: <20201127131835.GS2455276@dell>
References: <20201127093142.GP2455276@dell>
 <20201127125202.23917-1-michael@fossekall.de>
 <20201127125202.23917-3-michael@fossekall.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201127125202.23917-3-michael@fossekall.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Nov 2020, Michael Klein wrote:

> "REGUALTOR" -> "REGULATOR"
> 
> Signed-off-by: Michael Klein <michael@fossekall.de>
> ---
> Changes in v2:
>   - split patch
>   - make subject line more forthcoming
> 
>  drivers/regulator/da9055-regulator.c | 4 ++--
>  include/linux/mfd/da9055/reg.h       | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
