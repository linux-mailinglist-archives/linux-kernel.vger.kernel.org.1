Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A184300239
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 12:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbhAVL6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 06:58:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727748AbhAVK5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 05:57:04 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C63C061797
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 02:54:47 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id 186so2737151vsz.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 02:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zpsYHAdwN5j3WacuQ0BWujY+3R9jFAKUS6OekuCJX4Y=;
        b=bbpIfQMF/99HAQ+oXqoJwjlIxn2tGpU5i9hsS6DpESl9Ej/V84ojv/WsJxTEx0Kix+
         IcYSVVKZpFTMakz13XT2dDuqUuDUzeWjMBntRRW8ohc7r0S+fZIGJBK6BQGoNpvcIObh
         XwolAolG+dKYvsoPsYx+K4+pfJb2qWgiRTbPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zpsYHAdwN5j3WacuQ0BWujY+3R9jFAKUS6OekuCJX4Y=;
        b=BMPVEVgfEmLEyktfJ/ITWHScs9EFVCd4binhKj889lXZ3x+Fa/xdWmBOvkcDIpiT3W
         xmxBxvgKxLh7rXhg9ppl5oGGdBygUlx1KkKCIN5dA1V2KquG4jYAZitOPfN7oNzpwZnA
         B2khUSVILobrhbzPzoSAciZg21goF9KXcQPjr9ivC22TfAOy2EYb5uS58czIDzoc1IgV
         x0pPxDopHjdzNAIfeKurdZaOGoyoGLOsy229oYM5ak7afSW+X7hx2sR2oThyZ6ky8+MY
         3H5lGBOTuJjoNop42iwuNKWQsDskO5cXxQZtCuJmsPLqRgmm1kv9ATGIcVFeYF2AO87j
         gl9A==
X-Gm-Message-State: AOAM532CAk//MuJmHFqwp7X7toYOq3lNT/ahTti05iCqufmIpr+ILRUG
        fXDocLPCdxmarf/yx2eU3rEG+U23aUSi6ViQA0A6ng==
X-Google-Smtp-Source: ABdhPJxzxop195QKfUnrwXsxhnkgdkUVQCNadMDQOXSkAk02i/gmTtKh3+KUKkTdhYo+UZeN0AZp0UXR3ZEP4/awvLA=
X-Received: by 2002:a67:73c2:: with SMTP id o185mr376539vsc.16.1611312886546;
 Fri, 22 Jan 2021 02:54:46 -0800 (PST)
MIME-Version: 1.0
References: <20210121075149.1310-1-hailong.fan@mediatek.com>
 <CANMq1KBqKUofLaM+OEaTq6PSeYomNSLvn65c+Wyi1cKsLDNboQ@mail.gmail.com>
 <1611230975.2493.17.camel@mhfsdcap03> <CANMq1KCXrEGrNrOwivrchXyawzKySVzQoxA1goYC-eh-auNFCA@mail.gmail.com>
 <1611283438.2493.23.camel@mhfsdcap03>
In-Reply-To: <1611283438.2493.23.camel@mhfsdcap03>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Fri, 22 Jan 2021 18:54:35 +0800
Message-ID: <CANMq1KDa_aO_wtQAZofruN7r7BuvRTNGKkmfgTf2oM7ab9425g@mail.gmail.com>
Subject: Re: [PATCH RESEND] pinctrl: mediatek: Fix trigger type setting follow
 for unexpected interrupt
To:     mtk15103 <hailong.fan@mediatek.com>
Cc:     Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>, youlin.pei@mediatek.com,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Chen-Tsung Hsieh <chentsung@chromium.org>,
        gtk_pangao@mediatek.com, Hanks Chen <hanks.chen@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>, zhengnan.chen@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 10:44 AM mtk15103 <hailong.fan@mediatek.com> wrote:
>
> On Thu, 2021-01-21 at 20:13 +0800, Nicolas Boichat wrote:
> > On Thu, Jan 21, 2021 at 8:09 PM mtk15103 <hailong.fan@mediatek.com> wrote:
> > >
> > > On Thu, 2021-01-21 at 16:55 +0800, Nicolas Boichat wrote:
> > > > On Thu, Jan 21, 2021 at 3:52 PM Hailong Fan <hailong.fan@mediatek.com> wrote:
> > > > >
> > > > > When flipping the polarity will be generated interrupt under certain
> > > > > circumstances, but GPIO external signal has not changed.
> > > > > Then, mask the interrupt before polarity setting, and clear the
> > > > > unexpected interrupt after trigger type setting completed.
> > > > >
> > > > > Signed-off-by: Hailong Fan <hailong.fan@mediatek.com>
> > > > > ---
> > > > > Resend since some server reject.
> > > > > ---
> > > > >  drivers/pinctrl/mediatek/mtk-eint.c | 13 +++++++++++--
> > > > >  1 file changed, 11 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/pinctrl/mediatek/mtk-eint.c b/drivers/pinctrl/mediatek/mtk-eint.c
> > > > > index 22736f60c16c..3acda6bb401e 100644
> > > > > --- a/drivers/pinctrl/mediatek/mtk-eint.c
> > > > > +++ b/drivers/pinctrl/mediatek/mtk-eint.c
> > > > > @@ -157,6 +157,7 @@ static void mtk_eint_ack(struct irq_data *d)
> > > > >  static int mtk_eint_set_type(struct irq_data *d, unsigned int type)
> > > > >  {
> > > > >         struct mtk_eint *eint = irq_data_get_irq_chip_data(d);
> > > > > +       unsigned int unmask;
> > > >
> > > > bool?
> > > Yes,thanks.
> > > >
> > > > >         u32 mask = BIT(d->hwirq & 0x1f);
> > > > >         void __iomem *reg;
> > > > >
> > > > > @@ -173,6 +174,13 @@ static int mtk_eint_set_type(struct irq_data *d, unsigned int type)
> > > > >         else
> > > > >                 eint->dual_edge[d->hwirq] = 0;
> > > > >
> > > > > +       if (!mtk_eint_get_mask(eint, d->hwirq)) {
> > > > > +               mtk_eint_mask(d);
> > > > > +               unmask = 1;
> > > > > +       } else {
> > > > > +               unmask = 0;
> > > > > +       }
> > > > > +
> > > > >         if (type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_EDGE_FALLING)) {
> > > > >                 reg = mtk_eint_get_offset(eint, d->hwirq, eint->regs->pol_clr);
> > > > >                 writel(mask, reg);
> > > > > @@ -189,8 +197,9 @@ static int mtk_eint_set_type(struct irq_data *d, unsigned int type)
> > > > >                 writel(mask, reg);
> > > > >         }
> > > > >
> > > > > -       if (eint->dual_edge[d->hwirq])
> > > > > -               mtk_eint_flip_edge(eint, d->hwirq);
> > > >
> > > > Why are you dropping this? Aren't we at risk to miss the first edge
> > > > after mtk_eint_set_type is called?
> > > mtk_eint_unmask() will do it.
> > > If unmask != 1, user need to call mtk_eint_unmask() to enable the
> > > interrupt before use it, thanks.
> >
> > Makes sense, I just have one more worry:
> > https://elixir.bootlin.com/linux/latest/source/drivers/pinctrl/mediatek/mtk-eint.c#L122
> >
> > mtk_eint_unmask unmasks the interrupt _before_ the edge is flipped,
> > could this cause a spurious interrupt? On any unmask operation -- not
> > just on mtk_eint_set_type (so this is technically another problem,
> > that should be fixed as a separate patch)
>
> This situation will not happen.
>
> Spurious interrupt occur condition: edge irq polarity value is same with
> input signal.
> e.g.
> Default value: GPIO input is high, trigger type is falling_edge.
> User want modify trigger type is rising_edge under some certain
> circumstances, it will generate spurious interrupt but external signal
> maintain high.
> So we need ack interrupt after trigger_type setting is completed.
>
> mtk_eint_flip_edge is for dual_edge, the polarity setting based on
> current gpio input signal:
> if (input == high)
>         polarity = low; /* falling_edge */
> else
>         polarity = high; /* rising_edge */
> Then it's not cause a spurious interrupt.

Okay let me try to make sure I follow:

- Say interrupt is currently IRQ_TYPE_EDGE_FALLING (and GPIO is high and stable)
- mtk_eint_set_type(d, IRQ_TYPE_EDGE_BOTH)
- mtk_eint_mask(d)
- (no mask changed, just eint->dual_edge)
- mtk_eint_ack(d) (not actually needed in this example)
- mtk_eint_unmask(d)
  - HW reg unmask (can't generate an interrupt as anything that would
have happened is acked already -- even with different previous/new
types than my example)
  - flip_edge (will swap polarity as needed but can't generate
interrupt as it won't set the polarity to be the same as the current
GPIO state)

Okay, I think I'm convinced.

Please fix the nits and then you can add

Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>

> > > > > +       mtk_eint_ack(d);
> > > > > +       if (unmask == 1)
> > > >
> > > > Just `if (unmask)`
> > > Yes,thanks.
> > > > > +               mtk_eint_unmask(d);
> > > > >
> > > > >         return 0;
> > > > >  }
> > > > > --
> > > > > 2.18.0
> > >
>
