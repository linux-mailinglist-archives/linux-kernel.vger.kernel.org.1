Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 350572AC8EA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 23:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730528AbgKIW4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 17:56:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:33752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729247AbgKIW4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 17:56:05 -0500
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB196206CB;
        Mon,  9 Nov 2020 22:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604962564;
        bh=NsZcofEyIKb2X8Wlt/4XFtO3Nm/unnGQ3KF7Jjksszw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cDCeQxbqjfFkAGqw/f5Nud3y8GsIe63Ekh/bRzArzTorzPDlL3PEaKCOK5qqUxbge
         7S3MlpFqNqS52ji5A+4vJP7296N8ZjgFnxR4MAgcdceBAcjy/bh9XLlE0eVoVxe+f9
         ojf0Zz9et6kE1WRk8AEt7MDzypyaC7TS/P2+gejM=
Received: by mail-oi1-f182.google.com with SMTP id w188so6547775oib.1;
        Mon, 09 Nov 2020 14:56:03 -0800 (PST)
X-Gm-Message-State: AOAM530ZW+tJSP6TsgLsOxNQNtCe6Aleud1RKuEtKR1GqXn8F9F3tYsk
        bNj8K+9rPXxjmZCNO2YUq+mC3l9q1kUne4ymOw==
X-Google-Smtp-Source: ABdhPJwybqjTGBz+FjUfHDk4KxlRIocGcbu+GBXlye/2MonQkkOgu9HS12MHFfXa1YfyQdWekO+6Bphop1H+9jfG8So=
X-Received: by 2002:aca:5dc2:: with SMTP id r185mr1012366oib.106.1604962563242;
 Mon, 09 Nov 2020 14:56:03 -0800 (PST)
MIME-Version: 1.0
References: <20201108185113.31377-1-michael@walle.cc> <20201108185113.31377-4-michael@walle.cc>
 <20201109220543.GA1835644@bogus> <78aa06920a318cfb68e962afe13e8432@walle.cc>
In-Reply-To: <78aa06920a318cfb68e962afe13e8432@walle.cc>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 9 Nov 2020 16:55:51 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+8KSGL1963Zk1-z6-=u-wPOBO52cZg29Y3fUjop09fhg@mail.gmail.com>
Message-ID: <CAL_Jsq+8KSGL1963Zk1-z6-=u-wPOBO52cZg29Y3fUjop09fhg@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] clk: qoriq: provide constants for the type
To:     Michael Walle <michael@walle.cc>
Cc:     linux-clk <linux-clk@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        "Y . b . Lu" <yangbo.lu@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        Ashish Kumar <Ashish.Kumar@nxp.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 9, 2020 at 4:39 PM Michael Walle <michael@walle.cc> wrote:
>
> Am 2020-11-09 23:05, schrieb Rob Herring:
> > On Sun, Nov 08, 2020 at 07:51:07PM +0100, Michael Walle wrote:
> >> To avoid future mistakes in the device tree for the clockgen module,
> >> add
> >> constants for the clockgen subtype as well as a macro for the PLL
> >> divider.
> >>
> >> Signed-off-by: Michael Walle <michael@walle.cc>
> >> ---
> >> Changes since v2:
> >>  - new patch
> >>
> >>  drivers/clk/clk-qoriq.c                        | 13 +++++++------
> >>  include/dt-bindings/clock/fsl,qoriq-clockgen.h | 15 +++++++++++++++
> >>  2 files changed, 22 insertions(+), 6 deletions(-)
> >>  create mode 100644 include/dt-bindings/clock/fsl,qoriq-clockgen.h
> >>
> >> diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
> >> index 46101c6a20f2..70aa521e7e7f 100644
> >> --- a/drivers/clk/clk-qoriq.c
> >> +++ b/drivers/clk/clk-qoriq.c
> >> @@ -7,6 +7,7 @@
> >>
> >>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> >>
> >> +#include <dt-bindings/clock/fsl,qoriq-clockgen.h>
> >>  #include <linux/clk.h>
> >>  #include <linux/clk-provider.h>
> >>  #include <linux/clkdev.h>
> >> @@ -1368,33 +1369,33 @@ static struct clk *clockgen_clk_get(struct
> >> of_phandle_args *clkspec, void *data)
> >>      idx = clkspec->args[1];
> >>
> >>      switch (type) {
> >> -    case 0:
> >> +    case QORIQ_CLK_SYSCLK:
> >>              if (idx != 0)
> >>                      goto bad_args;
> >>              clk = cg->sysclk;
> >>              break;
> >> -    case 1:
> >> +    case QORIQ_CLK_CMUX:
> >>              if (idx >= ARRAY_SIZE(cg->cmux))
> >>                      goto bad_args;
> >>              clk = cg->cmux[idx];
> >>              break;
> >> -    case 2:
> >> +    case QORIQ_CLK_HWACCEL:
> >>              if (idx >= ARRAY_SIZE(cg->hwaccel))
> >>                      goto bad_args;
> >>              clk = cg->hwaccel[idx];
> >>              break;
> >> -    case 3:
> >> +    case QORIQ_CLK_FMAN:
> >>              if (idx >= ARRAY_SIZE(cg->fman))
> >>                      goto bad_args;
> >>              clk = cg->fman[idx];
> >>              break;
> >> -    case 4:
> >> +    case QORIQ_CLK_PLATFORM_PLL:
> >>              pll = &cg->pll[PLATFORM_PLL];
> >>              if (idx >= ARRAY_SIZE(pll->div))
> >>                      goto bad_args;
> >>              clk = pll->div[idx].clk;
> >>              break;
> >> -    case 5:
> >> +    case QORIQ_CLK_CORECLK:
> >>              if (idx != 0)
> >>                      goto bad_args;
> >>              clk = cg->coreclk;
> >> diff --git a/include/dt-bindings/clock/fsl,qoriq-clockgen.h
> >> b/include/dt-bindings/clock/fsl,qoriq-clockgen.h
> >> new file mode 100644
> >> index 000000000000..ddec7d0bdc7f
> >> --- /dev/null
> >> +++ b/include/dt-bindings/clock/fsl,qoriq-clockgen.h
> >> @@ -0,0 +1,15 @@
> >> +/* SPDX-License-Identifier: GPL-2.0-only */
> >> +
> >> +#ifndef DT_CLOCK_FSL_QORIQ_CLOCKGEN_H
> >> +#define DT_CLOCK_FSL_QORIQ_CLOCKGEN_H
> >> +
> >> +#define QORIQ_CLK_SYSCLK    0
> >> +#define QORIQ_CLK_CMUX              1
> >> +#define QORIQ_CLK_HWACCEL   2
> >> +#define QORIQ_CLK_FMAN              3
> >> +#define QORIQ_CLK_PLATFORM_PLL      4
> >> +#define QORIQ_CLK_CORECLK   5
> >> +
> >> +#define QORIQ_CLK_PLL_DIV(x)        ((x) - 1)
> >
> > This is not used and doesn't seem like part of the ABI (shared with dts
> > files).
>
> TBH I haven't found a nice way to integrate this macro into the clock
> driver. It is used in the device tree for the type PLATFORM_PLL.
> Previously, you had "<&clockgen 4 1>", where 4 is the PLATFORM_PLL and 1
> is actually "div-by-2". Thus I replaced it by <&clockgen
> QORIQ_CLK_PLATFORM_PLL QORIQ_CLK_PLL_DIV(2)>. (I just realized that
> QORIQ_CLK_PLL_DIV_BY(2) might be a better name.)

Ah okay. I guess this is fine.

Acked-by: Rob Herring <robh@kernel.org>

Rob
