Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3001324D118
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 11:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgHUJEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 05:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgHUJEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 05:04:31 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE7EC061385
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 02:04:30 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id q68so344653uaq.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 02:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2aqaXn/OLBCEnJD6W+rO7Mlnssb9JvC0HBRl/U0OUUg=;
        b=KXTqyq//OKA+RNGjE5YSIsFCI3e1XJ/Cbv7Kr7u8/PQc0Pne19cNWJTK3R16ixQbyV
         VAMcV7KnRMckctx7KTif5eeTKATrRY8cWdVqpChUFOqX8BNVrLmVflXeAb8fjaVMF1zW
         EKyw6ZB2LKGHT5NqprV9oUDt04K8Znv+gyIrF8yr/wGIDsrzsAKPaWox6IKO+hlYRpEk
         IIbtK7XXBHZeuftRPOHcNPWUf2PfQEdiVxPdJLLe+jnsvQEwzPRGX9Kitbuh1ehG2SUR
         BEEZz9VPJuWoBa+7bCQxdM6bIy7sWenPObAEnq9BK4FySXEghM3d93OZz1bTInRZPAnq
         tJgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2aqaXn/OLBCEnJD6W+rO7Mlnssb9JvC0HBRl/U0OUUg=;
        b=c8NMky4H3lcZpME0AVycdMp+j213OXlJobW4eIH/Iyyv2pV+R8LkspKJHFD7lpMe29
         SNiioX5ou9tYauMlHG2piKGx/38Yrjf+FLfkGKFGPJY7KHuhbelZ1HnHdHarlklKi3A+
         TUVmMTjaHQL38GX2mTzcwzb2fXcaDo3InFg5pWDiO2+BeSoQ4UYrttosI/7UKn8L2pPq
         G2+KxJo1nkWG8Di64BmkQyVFgGNSe+OiTAaWPd/764KpPm/p+Be966o9qg/PZi2IISoz
         5/jUExERKnSkKObEhVRzRxFgbjDo4m+gxFyK7S16UH/XEE2P3vDlibEbHyHdsLjKEsnw
         Dm+Q==
X-Gm-Message-State: AOAM53341Nt7q+wJdx0Cb6lHKvkQCfxkRgxaZRlBbwarzICpssZ6COlu
        0tn22nGw3vPQ2fJhcOWeplr0rimspR5PnDepUQIi1Q==
X-Google-Smtp-Source: ABdhPJydH0kCtnDYCtghoZB5iwFnEbCN/wAnXbObjFLDzaJ5v/m+pKf0/FjLejd2JiPmOueyYS7pzqgtZYcXvBCBayM=
X-Received: by 2002:ab0:2ea2:: with SMTP id y2mr820544uay.15.1598000669938;
 Fri, 21 Aug 2020 02:04:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200819125832.v2.1.Ie8f0689ec9f449203328b37409d1cf06b565f331@changeid>
 <CANMq1KC3BC4bbh9YF1r3nfOAJgQp4mVZJ11_77cwFJY9fGK-Dg@mail.gmail.com>
In-Reply-To: <CANMq1KC3BC4bbh9YF1r3nfOAJgQp4mVZJ11_77cwFJY9fGK-Dg@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 21 Aug 2020 11:03:52 +0200
Message-ID: <CAPDyKFoHW=taANc4UZU7spGghn8ASo+2VOiEVPNRh9URdeyQpA@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-acpi: Fix HS400 tuning for AMDI0040
To:     Raul E Rangel <rrangel@chromium.org>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Akshu Agrawal <Akshu.Agrawal@amd.com>, chris.wang@amd.com,
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Aug 2020 at 02:24, Nicolas Boichat <drinkcat@chromium.org> wrote:
>
> On Thu, Aug 20, 2020 at 3:00 AM Raul E Rangel <rrangel@chromium.org> wrote:
> >
> > The AMD eMMC Controller can only use the tuned clock while in HS200 and
> > HS400 mode. If we switch to a different mode, we need to disable the
> > tuned clock. If we have previously performed tuning and switch back to
> > HS200 or HS400, we can re-enable the tuned clock.
> >
> > Previously the tuned clock was not getting disabled when switching to
> > DDR52 which is part of the HS400 tuning sequence.
> >
> > Fixes: 34597a3f60b1 ("mmc: sdhci-acpi: Add support for ACPI HID of AMD Controller with HS400")
> > Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> > Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Applied for fixes, by dropping the trace_printk below, thanks!

Kind regards
Uffe


> > ---
> >
> > Changes in v2:
> > - Added static to amd_sdhci_execute_tuning
> >
> >  drivers/mmc/host/sdhci-acpi.c | 68 +++++++++++++++++++++++++++++------
> >  1 file changed, 58 insertions(+), 10 deletions(-)
> [snip]
> > +               /* DLL is only required for HS400 */
> > +               if (host->timing == MMC_TIMING_MMC_HS400 &&
> > +                   !amd_host->dll_enabled) {
> > +                       trace_printk("%s: Enabling DLL\n", __func__);
>
> Please do not use trace_printk in production code [1,2], it is only
> meant for debug use. Consider using dev_dbg.
>
> [1] https://elixir.bootlin.com/linux/v5.8/source/kernel/trace/trace.c#L3158
> [2] https://elixir.bootlin.com/linux/v5.8/source/include/linux/kernel.h#L766
>
> > +                       sdhci_acpi_amd_hs400_dll(host);
> > +                       amd_host->dll_enabled = true;
> > +               }
> >         }
