Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD7642EC87B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 04:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbhAGDBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 22:01:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbhAGDBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 22:01:24 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21B5C0612F0
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 19:00:44 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id i7so3818365pgc.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 19:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BRLNPuGfj3ivO2euUNkJ0P2eXIJZBKP4UpcEqnbsjb0=;
        b=nsQXvntr/Be1QwCn3rjuU1BaOepIKvGnGbEQIh9SeSgggzyGKOrNfuMv2lXfCE9Sfj
         1vBUuJFoYVD47AMsJHSjCt12FkTfEe+yVcYtY9rBnAb214XfC5F/SP9XOGhRQu3fZCph
         rQzBcKwgGFfsGTT3Cdl2x+49ENuaAVb4cs3NQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BRLNPuGfj3ivO2euUNkJ0P2eXIJZBKP4UpcEqnbsjb0=;
        b=NLGxqs0+6Fs4Z5ZEFivP47/OsbWIA2ntvUxuFmDMvW9nE9shpKsRr04Cq8bFuJRGeN
         4Xsl+Xa//rxkrJuAEigEmhyJ/3qBKO1cRez9rGnc8agoyyGc44ZtUMxKbD/Dx7NQrfdl
         d0zVfKJM+kdEtBQXtroaDr6R+wsfkbz+m1SgAEo9DlcB5fKGczTG+Z6nqwPe3l+tjhdK
         lOMZQMDC6J6tAZilWzmRVQya7aC/FJlRxOWBocYoxFUV/OtGSVQVfx4jycxd2EXqhnzS
         ibDANh5zecs3DGoBJvRUABN1NCdLLwVzzYTuPLeOiTl/QeL0kF3hnReC7r/T7H7UFbzV
         OGOw==
X-Gm-Message-State: AOAM532so/dbc6gN32mwa4FlK2+w0z5tpo5Tx8CfMR0BHiIqECFnucbz
        GCS48XFOlR7pW1dj/AahBjTKnGfH4Vydqsov3Ai1og==
X-Google-Smtp-Source: ABdhPJygrAgFZ2XgLIlhW5wQPGzTk6X7MBKbFeUG69GLIJhGNsa0p96qlju/S7+tGj+7yG58V+PkWBmJ9aWjsw6VpC8=
X-Received: by 2002:a63:5f93:: with SMTP id t141mr7558126pgb.299.1609988444001;
 Wed, 06 Jan 2021 19:00:44 -0800 (PST)
MIME-Version: 1.0
References: <1608642587-15634-1-git-send-email-weiyi.lu@mediatek.com>
 <1608642587-15634-11-git-send-email-weiyi.lu@mediatek.com>
 <CAATdQgC_BnZywDxaZgmF72VRoAZ-1vFGrPD9GL4uEBhsKQTxnQ@mail.gmail.com>
 <1609929721.7491.3.camel@mtksdaap41> <CAATdQgBJ7EVRJW7iJG63yW89fh5skpe9-UCd4pdZystV_JrvCg@mail.gmail.com>
 <1609931196.30620.3.camel@mtksdaap41>
In-Reply-To: <1609931196.30620.3.camel@mtksdaap41>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Thu, 7 Jan 2021 11:00:32 +0800
Message-ID: <CAATdQgCNV5RCQGDLFamFHsuZddQakxSyjzsja=ypSV7OL531Aw@mail.gmail.com>
Subject: Re: [PATCH v6 10/22] clk: mediatek: Add MT8192 basic clocks support
To:     Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     Rob Herring <robh@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Stephen Boyd <sboyd@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 6, 2021 at 7:06 PM Weiyi Lu <weiyi.lu@mediatek.com> wrote:
>
> On Wed, 2021-01-06 at 18:52 +0800, Ikjoon Jang wrote:
> > On Wed, Jan 6, 2021 at 6:42 PM Weiyi Lu <weiyi.lu@mediatek.com> wrote:
> > >
> > > On Wed, 2021-01-06 at 18:25 +0800, Ikjoon Jang wrote:
> > > > On Tue, Dec 22, 2020 at 9:14 PM Weiyi Lu <weiyi.lu@mediatek.com> wrote:
> > > > >
> > > > > Add MT8192 basic clock providers, include topckgen, apmixedsys,
> > > > > infracfg and pericfg.
> > > > >
> > > > > Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> > > > > ---
> > > > >  drivers/clk/mediatek/Kconfig      |    8 +
> > > > >  drivers/clk/mediatek/Makefile     |    1 +
> > > > >  drivers/clk/mediatek/clk-mt8192.c | 1326 +++++++++++++++++++++++++++++++++++++
> > > > >  drivers/clk/mediatek/clk-mux.h    |   15 +
> > > > >  4 files changed, 1350 insertions(+)
> > > > >  create mode 100644 drivers/clk/mediatek/clk-mt8192.c
> > > > >
> > > >
> > > > <snip>
> > > >
> > > > > diff --git a/drivers/clk/mediatek/clk-mux.h b/drivers/clk/mediatek/clk-mux.h
> > > > > index f5625f4..afbc7df 100644
> > > > > --- a/drivers/clk/mediatek/clk-mux.h
> > > > > +++ b/drivers/clk/mediatek/clk-mux.h
> > > > > @@ -77,6 +77,21 @@ struct mtk_mux {
> > > > >                         _width, _gate, _upd_ofs, _upd,                  \
> > > > >                         CLK_SET_RATE_PARENT)
> > > > >
> > > > > +#define MUX_CLR_SET_UPD_FLAGS(_id, _name, _parents, _mux_ofs,          \
> > > > > +                       _mux_set_ofs, _mux_clr_ofs, _shift, _width,     \
> > > > > +                       _upd_ofs, _upd, _flags)                         \
> > > > > +               GATE_CLR_SET_UPD_FLAGS(_id, _name, _parents, _mux_ofs,  \
> > > > > +                       _mux_set_ofs, _mux_clr_ofs, _shift, _width,     \
> > > > > +                       0, _upd_ofs, _upd, _flags,                      \
> > > > > +                       mtk_mux_clr_set_upd_ops)
> > > > > +
> > > > > +#define MUX_CLR_SET_UPD(_id, _name, _parents, _mux_ofs,                        \
> > > > > +                       _mux_set_ofs, _mux_clr_ofs, _shift, _width,     \
> > > > > +                       _upd_ofs, _upd)                                 \
> > > > > +               MUX_CLR_SET_UPD_FLAGS(_id, _name, _parents,             \
> > > > > +                       _mux_ofs, _mux_set_ofs, _mux_clr_ofs, _shift,   \
> > > > > +                       _width, _upd_ofs, _upd, CLK_SET_RATE_PARENT)
> > > > > +
> > > >
> > > > conflicts, these macros are already existed in upstream.
> > >
> > > really? These two macros don't show up in 5.11-rc1 yet.
> >
> > yep, maybe this one: a3ae549917f1 "clk: mediatek: Add new clkmux register API"
> >
>
> The new macros in this patch are for the clock MUX without gate control.
> It's a little different from those mux macros with gate control in
> a3ae549917f1 "clk: mediatek: Add new clkmux register API"
>

sorry, my bad. it's just a simple context conflict from

> > >
> > > > >  struct clk *mtk_clk_register_mux(const struct mtk_mux *mux,
> > > > >                                  struct regmap *regmap,
> > > > >                                  spinlock_t *lock);
> > > > > --

your another patch,
2aeff9d8c8e "clk: mediatek: Make mtk_clk_register_mux() a static function"
was applied before this series.

> > > > > 1.8.1.1.dirty
> > > > > _______________________________________________
> > > > > Linux-mediatek mailing list
> > > > > Linux-mediatek@lists.infradead.org
> > > > > http://lists.infradead.org/mailman/listinfo/linux-mediatek
> > >
> > > _______________________________________________
> > > Linux-mediatek mailing list
> > > Linux-mediatek@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-mediatek
>
