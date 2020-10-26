Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29D802994D8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 19:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1789207AbgJZSIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 14:08:32 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:34722 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1783374AbgJZSIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 14:08:32 -0400
Received: by mail-il1-f195.google.com with SMTP id v18so3829895ilg.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 11:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FHudRtp7yzYdmsxvUUGKxH7K88Fn6l9DBuMQ5iU2qAI=;
        b=EgVUQ50Kuv45cI5ojv4WXe4qC3H1y/RPR4naCQph6DTzVdU4YcS6zm1VL0nyTRaKSz
         7Xa4pbYYWS5GJ5MRiqBFginYq2aewpye2Sj6DcyQ/5XmHeefO1RRueF0X71qlv8LY8pL
         y6/n5OYAur+1WCRQF1PU3ncXDYj+5m6P6AZsIbb7iF7Xg+v3A+nP8+H6N3ItNqIoFTCr
         fFcM/KVRTY0oYIWL2G0qc9bRNDdFVYwGbBVQva0vconViKNWw2N4dJkRgzXlAHNWy7M5
         Hfaaag7nn9dW9hgSSGR3OMQQMzyLY4D+/mQ6ke8F53hYZUoQ4JdkqX8iImaHPe760Mrh
         saJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FHudRtp7yzYdmsxvUUGKxH7K88Fn6l9DBuMQ5iU2qAI=;
        b=pmQVEkJYJS58cn2JAKyZQmmQzZjRKKyvp0jjuLYAXdVN++q2RgENi3QB29Zrdxg5Yj
         IQB1ZB3ZXTnzh+gbokV4jPKSNSG08BkeIxp7R2VIqQBlNyd5bWdiMMvc2QdSyJ8mseVM
         E0PovlyrtZYocNmu0DmAGh+l0AHt5aH5ssMEoWyhvrnkn5HuAW1HDwm9DeH8J67k2prc
         OeLgdU3WKsHDSiruDjeCJae6aPCFXboXalRr6S+ukORbmxEGdS6AHvzJAWMLi/1YOK9Q
         mgZxJYn0sVk3rK44HsfkIycw0M5nYmD6GsIv0+LhIaWKZx3z9Ov+0x2Whj0c1bpNzN5b
         4+7A==
X-Gm-Message-State: AOAM533BRxycDbskrz4AcqUTOEjNE86VKZVJXLW4USjm6iT9ot1NyH+O
        xZaQV6dpPqsyiwrmDWEzLlWgVT0O6kwUEDYJGGn9Hg==
X-Google-Smtp-Source: ABdhPJyAnrUXnX8HS6B0CYvBbgrW7BhkwL2lF6G9o1ylXON0aM6cIo/qvmxrBM044uvfh8/xKjMwDMo7m8/xFU1nr98=
X-Received: by 2002:a92:7f10:: with SMTP id a16mr12479315ild.134.1603735710869;
 Mon, 26 Oct 2020 11:08:30 -0700 (PDT)
MIME-Version: 1.0
References: <20201017153857.2494845-1-fparent@baylibre.com>
 <20201017153857.2494845-2-fparent@baylibre.com> <20201026133006.GA29275@bogus>
In-Reply-To: <20201026133006.GA29275@bogus>
From:   Fabien Parent <fparent@baylibre.com>
Date:   Mon, 26 Oct 2020 19:08:20 +0100
Message-ID: <CAOwMV_z9QzAOO09ZUVyn61Fv4+pRUNA0H22tnP-PrXUOLRjXeg@mail.gmail.com>
Subject: Re: [PATCH 2/2] clocksource: mediatek: add clk13m and bus clock support
To:     Rob Herring <robh@kernel.org>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>, tglx@linutronix.de,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Mon, Oct 26, 2020 at 2:30 PM Rob Herring <robh@kernel.org> wrote:
>
> On Sat, Oct 17, 2020 at 05:38:57PM +0200, Fabien Parent wrote:
> > Some MediaTek SoC like MT8516 need to enable additional clocks
> > for the GPT timer. Enable them if present.
> >
> > Signed-off-by: Fabien Parent <fparent@baylibre.com>
> > ---
> >  drivers/clocksource/timer-mediatek.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/drivers/clocksource/timer-mediatek.c b/drivers/clocksource/timer-mediatek.c
> > index 9318edcd8963..42e2d2090484 100644
> > --- a/drivers/clocksource/timer-mediatek.c
> > +++ b/drivers/clocksource/timer-mediatek.c
> > @@ -9,6 +9,7 @@
> >
> >  #define pr_fmt(fmt)  KBUILD_MODNAME ": " fmt
> >
> > +#include <linux/clk.h>
> >  #include <linux/clockchips.h>
> >  #include <linux/clocksource.h>
> >  #include <linux/interrupt.h>
> > @@ -278,8 +279,19 @@ static int __init mtk_syst_init(struct device_node *node)
> >
> >  static int __init mtk_gpt_init(struct device_node *node)
> >  {
> > +     struct clk *clk_13m, *clk_bus;
> >       int ret;
> >
> > +     /* Optional clock*/
>
> Then use the optional api variant.

I looked for optional API variant but could only find these:
* struct clk *devm_clk_get_optional(struct device *dev, const char *id);
* struct clk *devm_clk_get_optional(struct device *dev, const char *id);

These two require a "struct device" parameter but in the function
mtk_gpt_init, we only have a "struct device_node" I didn't see any way
to get a "struct device" from a "struct device_node".

>
> > +     clk_13m = of_clk_get_by_name(node, "clk13m");
> > +     if (!IS_ERR(clk_13m))
>
> And then you can drop this check (or handle it for any error other than
> clock is not present).
>
> > +             clk_prepare_enable(clk_13m);
> > +
> > +     /* Optional clock*/
> > +     clk_bus = of_clk_get_by_name(node, "bus");
> > +     if (!IS_ERR(clk_bus))
> > +             clk_prepare_enable(clk_bus);
> > +
> >       to.clkevt.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
> >       to.clkevt.set_state_shutdown = mtk_gpt_clkevt_shutdown;
> >       to.clkevt.set_state_periodic = mtk_gpt_clkevt_set_periodic;
> > --
> > 2.28.0
> >
