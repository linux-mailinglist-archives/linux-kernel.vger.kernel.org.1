Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A649D2FB82E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392265AbhASMD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 07:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391344AbhASLty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 06:49:54 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E68C061574;
        Tue, 19 Jan 2021 03:49:12 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id 22so21479673qkf.9;
        Tue, 19 Jan 2021 03:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4LpuhTvBYJesYPrAPbATGqGL/XPg46mfGcaf26GnNbY=;
        b=cbwTc7FbYEelW71VdHEUe0164C0+XdTfe2t9TOOeEykD7cN/M0la6TlB/Ar0t1Sha4
         +hALqcVW9lRMeMHw5zYMOjm71jQfhtc/n509YYNKIfkoKJNYsRD4Wl84umeLMNdmqifU
         KInmG++n4zMnxFCzVQre55X8A2Q/RAl/t8KfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4LpuhTvBYJesYPrAPbATGqGL/XPg46mfGcaf26GnNbY=;
        b=G4cunBvOELeqpRQWpQB3LZ6phw64Yardq+enJXuhQIjwlPNCzSM+7xHc3f76szCYXM
         QyEndQW/WuDfc0j5ydlXA2UVKfKvCndjM1xASiPt1nYltQhxqfsmrUP7wLGwhuwYnlG0
         AR94PbPXKs/N0sO9KiF4YVo5+LK/NkXXxhGQuxIsqjNjmJ6cYgVrc4Fkfu9IlEkjFiIC
         YNbQLd6iaxBCUVRDyIJ2pYpKifs/pH7H/exzMBHb5IEyLm4Tdiyg48nvUbzK2+WUbx8q
         F6VYXlI28bGuBSA2rCeruHAaN3ODz8/zL6npXoPU/9xE/zklKLXshzjIGrCTy78rSQVj
         i98w==
X-Gm-Message-State: AOAM532px1BGVnwnjO/UB+w+7dQ6yfyW3KsqDBq5EEoiyc1tGAuBPwnv
        hpNNvHx+wLEbvbt91S9Mie1eSanbGs3kEg966ok=
X-Google-Smtp-Source: ABdhPJw64YKoavEiyF5WN22uIQzwfrs9VY2nkSCmL1q08Te3IraYLriBAULVhEXmLYMv3Hbr+J1+tA88JG7/2DnWrxo=
X-Received: by 2002:a37:a085:: with SMTP id j127mr3767413qke.273.1611056951752;
 Tue, 19 Jan 2021 03:49:11 -0800 (PST)
MIME-Version: 1.0
References: <20210118100813.30821-2-ryan_chen@aspeedtech.com> <20210119061715.6043-1-ryan_chen@aspeedtech.com>
In-Reply-To: <20210119061715.6043-1-ryan_chen@aspeedtech.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 19 Jan 2021 11:48:59 +0000
Message-ID: <CACPK8XcUTE7HFRkB=kK2qEWAz1eS6dRnM4LWyTaQzFNd76GG+Q@mail.gmail.com>
Subject: Re: [PATCH v2] clk: aspeed: Fix APLL calculate formula from ast2600-A2
To:     Ryan Chen <ryan_chen@aspeedtech.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        andrewrj@aj.id.au, joel@linux.ibm.com,
        BMC-SW <BMC-SW@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jan 2021 at 06:31, Ryan Chen <ryan_chen@aspeedtech.com> wrote:
>
> Starting from A2, the A-PLL calculation has changed. Use the
> existing formula for A0/A1 and the new formula for A2 onwards.
>
> Fixes: d3d04f6c330a ("clk: Add support for AST2600 SoC")
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  drivers/clk/clk-ast2600.c | 37 +++++++++++++++++++++++++++----------
>  1 file changed, 27 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/clk/clk-ast2600.c b/drivers/clk/clk-ast2600.c
> index bbacaccad554..8933bd1506b3 100644
> --- a/drivers/clk/clk-ast2600.c
> +++ b/drivers/clk/clk-ast2600.c
> @@ -17,7 +17,8 @@
>
>  #define ASPEED_G6_NUM_CLKS             71
>
> -#define ASPEED_G6_SILICON_REV          0x004
> +#define ASPEED_G6_SILICON_REV          0x014
> +#define CHIP_REVISION_ID                       GENMASK(23, 16)
>
>  #define ASPEED_G6_RESET_CTRL           0x040
>  #define ASPEED_G6_RESET_CTRL2          0x050
> @@ -190,18 +191,34 @@ static struct clk_hw *ast2600_calc_pll(const char *name, u32 val)
>  static struct clk_hw *ast2600_calc_apll(const char *name, u32 val)
>  {
>         unsigned int mult, div;
> +       u32 chip_id = readl(scu_g6_base + ASPEED_G6_SILICON_REV);
>
> -       if (val & BIT(20)) {
> -               /* Pass through mode */
> -               mult = div = 1;
> +       if (((chip_id & CHIP_REVISION_ID) >> 16) >= 2) {
> +               if (val & BIT(24)) {
> +                       /* Pass through mode */
> +                       mult = div = 1;
> +               } else {
> +                       /* F = 25Mhz * [(m + 1) / (n + 1)] / (p + 1) */
> +                       u32 m = val & 0x1fff;
> +                       u32 n = (val >> 13) & 0x3f;
> +                       u32 p = (val >> 19) & 0xf;
> +
> +                       mult = (m + 1);
> +                       div = (n + 1) * (p + 1);
> +               }
>         } else {
> -               /* F = 25Mhz * (2-od) * [(m + 2) / (n + 1)] */
> -               u32 m = (val >> 5) & 0x3f;
> -               u32 od = (val >> 4) & 0x1;
> -               u32 n = val & 0xf;
> +               if (val & BIT(20)) {
> +                       /* Pass through mode */
> +                       mult = div = 1;
> +               } else {
> +                       /* F = 25Mhz * (2-od) * [(m + 2) / (n + 1)] */
> +                       u32 m = (val >> 5) & 0x3f;
> +                       u32 od = (val >> 4) & 0x1;
> +                       u32 n = val & 0xf;
>
> -               mult = (2 - od) * (m + 2);
> -               div = n + 1;
> +                       mult = (2 - od) * (m + 2);
> +                       div = n + 1;
> +               }
>         }
>         return clk_hw_register_fixed_factor(NULL, name, "clkin", 0,
>                         mult, div);
> --
> 2.17.1
>
