Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0D12A62CB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 11:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729665AbgKDK7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 05:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbgKDK7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 05:59:06 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186DFC0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 02:59:06 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id c17so2183964wrc.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 02:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7Xzh03thSu71cPFyVHXh51rZbQa5FJ10M7IZ8JTMsUw=;
        b=R/dyvIo44grXXEUtlCA7suDvXalQSfBaaoDuQ7akPe/9woqizk5nVvsySV4bAU5fZQ
         VFvX5VSq31Bw5PvBunLUDKCP9S9y02RoPPzgsZ88EnxmfjBdT6c+650tmFVD+dNhQYsF
         xqdM7M1jrM8u8mgyAnGJCmiKgM5WlyXREDfB90y5GpBrwi9l/iS5UmRWsCeVXoHCytY4
         LmpEasaHRim54tfFnfqGRQPfKf3h4puCqw5NNuKep3PrhtmKSd1CZ5YufAnhMAo8/8KR
         RVmF4NtS4BeF85CO2RUulJWU6NGSYErtHnu3jhfr3sHUu/V0yFTrgnoYBvIKcgcXVRd2
         j2ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7Xzh03thSu71cPFyVHXh51rZbQa5FJ10M7IZ8JTMsUw=;
        b=TpugzIl4SOtf3gS8Vw8wxJKK8AzWyjmLOri/pwYvWbSMjuq18j8WCmu6J55h6HBhaT
         OiNC6pj7Gi5KaYxsIPtsx71HfqyM7jF+mlWm+Qx6CE16lMlOQ3IxKSVLpKWXNlwVxgVv
         xL7gaLq2ni1Bp0BecpXOIjef0JUwkixDe+fxgM7EnscQXXgYKRhigCUpzCIB4ZW7MaGF
         mYa7U6j3xhKnel8tqgNupm4C2fJoA1SvP69AKzwJVBt6lL9RUiZQUtJoEr6Whra3PTXt
         m9boZ5pqqGp4QUwB80XXjZgd+CbOOIkTy1///cR8WGOiPguNAOlH99wXpK458dGyuk+7
         m/+A==
X-Gm-Message-State: AOAM530AXWACDIJvRIDrCweMGauuDEfyXETrvun+x7zZEyaY7X9ysK5/
        eisFtK+rvg+4n/iwRIUmQPmIZbLUl90mOH0A
X-Google-Smtp-Source: ABdhPJwnpq5eXB7UF1V5Q5/uAwHwz9fko7wyb6l2BSo4dI99oqnwm78XdGu0I1zanbB2bbmu5xFuog==
X-Received: by 2002:a05:6000:1084:: with SMTP id y4mr29929410wrw.138.1604487544891;
        Wed, 04 Nov 2020 02:59:04 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id u5sm1647438wml.13.2020.11.04.02.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 02:59:04 -0800 (PST)
Date:   Wed, 4 Nov 2020 10:59:02 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 7/8] mfd: sun4i-gpadc: Constify static struct resource
Message-ID: <20201104105902.GY4488@dell>
References: <20200922192659.14535-1-rikard.falkeborn@gmail.com>
 <20200922192659.14535-8-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200922192659.14535-8-rikard.falkeborn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Sep 2020, Rikard Falkeborn wrote:

> Constify adc_resources[]. The only usage is to assign its address to the
> resources field of the mfd_cell struct. This allows the compiler to put
> it in read-only memory. Done with the help of Coccinelle.
> 
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> ---
>  drivers/mfd/sun4i-gpadc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
