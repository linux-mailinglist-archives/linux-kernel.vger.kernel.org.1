Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 272B329D5AC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730152AbgJ1WHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:07:43 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:41339 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730129AbgJ1WHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:07:39 -0400
Received: by mail-ej1-f68.google.com with SMTP id s15so1057498ejf.8;
        Wed, 28 Oct 2020 15:07:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bZlCZTDwAJNro79TS3InJDAfis8jNWbj3KB0SY/Cc4k=;
        b=cpb8k+jncLXekyiif8q3wVI91bcSdDNfjBbxQtBtIsJEyFimlF1mVlhiV1emxLSwdW
         emfwinnNJSA75gq92W4BxeqnhBLankw1r6T5t6rODpctsb8xU04Hl4MRc5WfbaTBP/t8
         PqxLZGeI62aB5PUIwgV/fIq2KJdT99IFnS9E4L6nIqL5BYlbf878AUFTqXXEeLpLt9/J
         f/NSSzha/fY60Bg7Tc/pnxyqlTTU+KhxbaWk+6HUCm3pKjAYIwJZktAIisE+gx3rGx6t
         JsOFTn99f18TKAQdyZ4yFiLhqTXlzsJi1GvtGNHan7qirzOWym8teA7JCdW97KaO9qSD
         0Uuw==
X-Gm-Message-State: AOAM531wym3N+w9rPF0H9cNQIP3VcQ+VCcX76Gnz6DEJjz+yi/y0S55J
        dtH5fPgrLSASfcifCP2Xx1w=
X-Google-Smtp-Source: ABdhPJyRmpfag6RIm2++FBM/0keuZbgnjwCIrwJuWHSQK3lNqf0rJbKI08iYVMOyjfncGqQDAZyWLA==
X-Received: by 2002:a17:906:bc91:: with SMTP id lv17mr1181717ejb.249.1603922856842;
        Wed, 28 Oct 2020 15:07:36 -0700 (PDT)
Received: from kozik-lap ([194.230.155.184])
        by smtp.googlemail.com with ESMTPSA id i14sm435620ejp.2.2020.10.28.15.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 15:07:35 -0700 (PDT)
Date:   Wed, 28 Oct 2020 23:07:33 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 2/2] clk: samsung: exynos-clkout: convert to module driver
Message-ID: <20201028220733.GB271157@kozik-lap>
References: <20201001165646.32279-1-krzk@kernel.org>
 <20201001165646.32279-3-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201001165646.32279-3-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 01, 2020 at 06:56:46PM +0200, Krzysztof Kozlowski wrote:
> The Exynos clkout driver depends on board input clock (typically XXTI or
> XUSBXTI), however on Exynos4 boards these clocks were modeled as part of
> SoC clocks (Exynos4 clocks driver).  Obviously this is not proper, but
> correcting it would break DT backward compatibility.
> 
> Both drivers - clkout and Exynos4 clocks - register the clock providers
> with CLK_OF_DECLARE/OF_DECLARE_1 so their order is fragile (in the
> Makefile clkout is behind Exynos4 clock).  It will work only if the
> Exynos4 clock driver comes up before clkout.
> 
> A change in DTS adding input clock reference to Exynos4 clocks input
> PLL, see reverted commit eaf2d2f6895d ("ARM: dts: exynos: add input
> clock to CMU in Exynos4412 Odroid"), caused probe reorder: the clkout
> appeared before Exynos4 clock provider.  Since clkout depends on Exynos4
> clocks and does not support deferred probe, this did not work and caused
> later failure of usb3503 USB hub probe which needs clkout:
> 
>     [    5.007442] usb3503 0-0008: unable to request refclk (-517)
> 
> The Exynos clkout driver is not a critical/core clock so there is
> actually no problem in instantiating it later, as a regular module.
> This removes specific probe ordering and adds support for probe
> deferral.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/clk/samsung/clk-exynos-clkout.c | 198 +++++++++++++++++-------
>  1 file changed, 141 insertions(+), 57 deletions(-)

Applied (with fixes pointed out by Sylwester).

Best regards,
Krzysztof

