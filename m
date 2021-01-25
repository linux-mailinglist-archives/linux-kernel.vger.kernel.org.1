Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1747B302332
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 10:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbhAYJUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 04:20:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbhAYJPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 04:15:23 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8B4C06121E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 00:47:42 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id c12so11351985wrc.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 00:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=L7zRLOa9/A/iQHZsxRUBd/9JtCVTjujkb4lDAg3Vr/k=;
        b=j8lsVt/e7FhY4i8Y9QQP5WgESMMeZIAWgIRZOLbW5E07ES6H7jUpfiUfE7QeFdOHa0
         ItxEt6o9YKKMy3BhwIB0kW5uFBrz/fttbgTjb5/bYkaxbsKPoXZYv85PowEdLtmYOJXO
         i/PT6SeXKYMF+Xf1vaPSeJvXcG1SyerAO2+sjQwoqfcw+B57A9ZPTvFxr+yfdII4Q3JH
         LPvpoiB8VArMarTPiLhj5CQ52Af3IVk9MO8X3HRDqdYdCu/sKjayNFtGTFQ5szcsHlk9
         UTauyFktDFvfyhx70AZGyAt8Je7Pu3nB5ZjYaZz4WomeXp7iBUH3uUNY3A/ZYZAC1n1O
         TQiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=L7zRLOa9/A/iQHZsxRUBd/9JtCVTjujkb4lDAg3Vr/k=;
        b=caB5Pa+GQk10d3w//VAi+JEzOonD5bM9NpcuB2Fp4WqeQ3JClv2YG4G/QaHkcECwsE
         EF03fa9cz4J7I5sdX7yIPmsNoOA2dsNccZB1Jk5vS7iDu67KiPGnndp3+Bjl5cHXP8Fy
         BF3S82ufVsOVC4H19aQoym+FIrxh6ga+QGMaPMHTGT6uxMh2KCIuYcHg6PrZYOo8vUEn
         uN6D8Mf1LX8AP5PXaO9bbB1PIrGB6WfoirupfOTe3JWbqiMGH3MXPAbllRDYUxzf943A
         BRSyFSW0yxfZHc9gvdDdeZJsS8zSKD7rLsH66AGXyTDkbhhKYNoPdG5tuM64SRai8EYT
         O2IQ==
X-Gm-Message-State: AOAM5301qaz2jr2ll/GENJhpOnEOtt4rpgKhIE9dsfGOcgd4qmhiNXtD
        xLkLkBCMjOT01vdMmmJBoSlt0A==
X-Google-Smtp-Source: ABdhPJwvAT5QrVlgVRVXIetqyDdGS4/PFt4ktrvS4hgcS34u7NUByd/Pzsn94Nh20vlcxbXW4hhjMA==
X-Received: by 2002:adf:f009:: with SMTP id j9mr1074570wro.35.1611564461410;
        Mon, 25 Jan 2021 00:47:41 -0800 (PST)
Received: from dell ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id i6sm13827473wrs.71.2021.01.25.00.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 00:47:40 -0800 (PST)
Date:   Mon, 25 Jan 2021 08:47:39 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        Pragnesh.patel@sifive.com, zong.li@sifive.com,
        linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 06/20] clk: sifive: fu540-prci: Declare static const
 variable 'prci_clk_fu540' where it's used
Message-ID: <20210125084739.GW4903@dell>
References: <20210120093040.1719407-7-lee.jones@linaro.org>
 <mhng-d13d3ca6-2ec1-4c56-a4a8-56faafe5569c@palmerdabbelt-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <mhng-d13d3ca6-2ec1-4c56-a4a8-56faafe5569c@palmerdabbelt-glaptop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jan 2021, Palmer Dabbelt wrote:

> On Wed, 20 Jan 2021 01:30:26 PST (-0800), lee.jones@linaro.org wrote:
> > Fixes the following W=1 kernel build warning(s):
> > 
> >  drivers/clk/sifive/fu540-prci.h:16:35: warning: ‘prci_clk_fu540’ defined but not used [-Wunused-const-variable=]
> >  drivers/clk/sifive/fu540-prci.h:16:35: warning: ‘prci_clk_fu540’ defined but not used [-Wunused-const-variable=]
> > 
> > Cc: Michael Turquette <mturquette@baylibre.com>
> > Cc: Stephen Boyd <sboyd@kernel.org>
> > Cc: Paul Walmsley <paul.walmsley@sifive.com>
> > Cc: Palmer Dabbelt <palmer@dabbelt.com>
> > Cc: Pragnesh Patel <Pragnesh.patel@sifive.com>
> > Cc: Zong Li <zong.li@sifive.com>
> > Cc: linux-clk@vger.kernel.org
> > Cc: linux-riscv@lists.infradead.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/clk/sifive/fu540-prci.h  | 5 -----
> >  drivers/clk/sifive/sifive-prci.c | 5 +++++
> >  2 files changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/clk/sifive/fu540-prci.h b/drivers/clk/sifive/fu540-prci.h
> > index c8271efa7bdc7..c220677dc0108 100644
> > --- a/drivers/clk/sifive/fu540-prci.h
> > +++ b/drivers/clk/sifive/fu540-prci.h
> > @@ -13,9 +13,4 @@
> > 
> >  extern struct __prci_clock __prci_init_clocks_fu540[NUM_CLOCK_FU540];
> > 
> > -static const struct prci_clk_desc prci_clk_fu540 = {
> > -	.clks = __prci_init_clocks_fu540,
> > -	.num_clks = ARRAY_SIZE(__prci_init_clocks_fu540),
> > -};
> > -
> >  #endif /* __SIFIVE_CLK_FU540_PRCI_H */
> > diff --git a/drivers/clk/sifive/sifive-prci.c b/drivers/clk/sifive/sifive-prci.c
> > index c78b042750e21..1490b01ce6290 100644
> > --- a/drivers/clk/sifive/sifive-prci.c
> > +++ b/drivers/clk/sifive/sifive-prci.c
> > @@ -12,6 +12,11 @@
> >  #include "fu540-prci.h"
> >  #include "fu740-prci.h"
> > 
> > +static const struct prci_clk_desc prci_clk_fu540 = {
> > +	.clks = __prci_init_clocks_fu540,
> > +	.num_clks = ARRAY_SIZE(__prci_init_clocks_fu540),
> > +};
> > +
> >  /*
> >   * Private functions
> >   */
> 
> This doesn't look like my sifive-prci.c, so I'm assuming it's against one of
> the clock trees and therefor should go in over there.

This patch is applied against -next.

> Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>

Thanks Palmer.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
