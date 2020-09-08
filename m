Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 932A2261EBA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 21:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732460AbgIHTyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 15:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730616AbgIHPhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:37:36 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA52C0619E4
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 06:54:55 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id z9so17280337wmk.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 06:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=21ErxJddccU49ubJp25MBlzdQEC+AMusP2qDOYG8bQA=;
        b=KfWrdNq5b6Xs0qtZNuisCZjRDKHqR/D8hsPPwcZScyENV9E1QeXxz3IfqSPvkxEcrC
         J5vXWENb+6Vd3MxMp2OnuK9QmW7CLOMd8FFrM3/NXcX+Z2R86vjbFNqFJtj7/14igA4l
         Id9tsHlpHOWMNL1SAq/LuSbz+O7laDtS4Reh/Qhb8x8iXTpnbx9x7jzj+8meVIgInH41
         qT19/Q2puqGNskc8XllHTseldPfG79DZWxDkIm2snuHA17/03ktRKKCUDXhT0q91vBBj
         laxaaQTjsxmTy5LcYzAPp+WVgiujgjtjgWx5AJYlw+TT4xPUCkJdMxamFEuDm/8wez3t
         DoEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=21ErxJddccU49ubJp25MBlzdQEC+AMusP2qDOYG8bQA=;
        b=DytManW3iK+8YSfTtfkrLX1YqfxOvzyg5L+Uklmi7T5WKy8WQL8tN7LXivXP0P65wp
         FJYzJiRE8Ga+eHMwtOyUNwXI8cuyfpB0aJhyCEs5PTbPh/VTemCkaVz9CfiZYzqAZKWB
         Y7jLTynQsCkt7LdGpvfOpM1FF3NWuCLJcY/dV4g6uzCnsBtxIbOsSpXZdiVCMFObcnZU
         3NNEu6YPDYMhqK87LXzyW/O3IhLm49t4zHpYoZuRExlLYo2pMUHAcPwmZxC94kB3UnoS
         prjBG9MLLbXJjOFpg0bSAOrbybN7ucxn7mbUy6qQaYOxBe+9H8y8RIG0CjyLCL/iUBVv
         TlQA==
X-Gm-Message-State: AOAM531zCNSi+af3BBOn3Ykj5QdG13tEX6le53MQ9i7vMIpcKKCP6SSX
        f8aHm0FcQvtg2KRTebT5+w7cMiNId9zjnQ==
X-Google-Smtp-Source: ABdhPJxs3Vbv0U9j5vtSqJvOYGxLy67/ixPr4yE71yizUUDaOf4qmB+brVJLpGhbDw7L8PyHirT6Bg==
X-Received: by 2002:a1c:7d55:: with SMTP id y82mr4602544wmc.100.1599573294696;
        Tue, 08 Sep 2020 06:54:54 -0700 (PDT)
Received: from dell ([91.110.221.179])
        by smtp.gmail.com with ESMTPSA id 92sm37125579wra.19.2020.09.08.06.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 06:54:54 -0700 (PDT)
Date:   Tue, 8 Sep 2020 14:54:52 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-doc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mfd: ab8500: Remove weird Unicode characters
Message-ID: <20200908135452.GV4400@dell>
References: <20200905185803.1293715-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200905185803.1293715-1-j.neuschaefer@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 05 Sep 2020, Jonathan Neuschäfer wrote:

> There are stray Unicode quotation marks (U+201C	DOUBLE TURNED COMMA
> QUOTATION MARK) in the file. Remove them, as they don't serve a purpose.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
>  Documentation/devicetree/bindings/mfd/ab8500.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
