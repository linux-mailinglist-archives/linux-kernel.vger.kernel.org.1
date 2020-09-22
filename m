Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97E672738F4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 04:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729352AbgIVCzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 22:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728925AbgIVCzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 22:55:23 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A677C061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 19:55:23 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id j12so5017895ual.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 19:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ru94yawi1J4H6mzGaA+bu3tz0jur5splNtJNFK2pEjw=;
        b=P1DRcYb/nUX2CdcgXprpBI9tvTvLET6HBPS6TSWEM8LPAWKOXRSbp3g8NfjjWEPrg2
         z5OY/gpUVCFFh7gg8fztZ3165X3/9SLbiq2vlES4FPHsU/276ohv2drtY9Fg47FRIM9r
         k049Oz7Qt1TFWAkDt6LUx2VPTcBBs/0Z0aPRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ru94yawi1J4H6mzGaA+bu3tz0jur5splNtJNFK2pEjw=;
        b=UD3rmOhCPqKnkbTZIoZ/h3qUzpuBjCFTXhtq6zA/4wV1O6pWCnKclveCoNzZE4Ojnp
         HdgM0BYLRMqOCe77+WZo+oK/usIniYIex20d+VtxGsXUP4K2eU6UlSipQgz7p/G691C0
         b8bOxEFfmPtHVBkFPH80ji3ecAcDETSJG5ABIho7W9y0QyEz8M0aHm78/GLF1+cfY1MF
         OI/wBsBvMsVLosP46Yat8tb/B/woKpxOsL0wCQllvoDk/J+gT58FgZ201MQPKDhMT0ep
         /lssAFVWPSpRuaCgiomQ7tSEq9GTOftqOiysFJhbNlvqgNX4aNivEX/RIDmHafWaoY/D
         H7sQ==
X-Gm-Message-State: AOAM532dLjxAqBPOxth2UEDCDXiegNuCwAMYGv8Ykh112HPJDSn0PLjB
        3THquIvGdS6D4Rrd6HYqHufv3b6yZBuye0ZMAfWB5Q==
X-Google-Smtp-Source: ABdhPJzXVsQocQsixjn2gyYjkmtSokc8QsHvNccpRbxRW75Lla1V27EuRsAXbx5XGoSul1cExZQl1l+CB2eUrRu9cls=
X-Received: by 2002:ab0:6d8d:: with SMTP id m13mr1970572uah.82.1600743322399;
 Mon, 21 Sep 2020 19:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200730120054.1.I5e6f8c262031d0451fe7241b744f4f3111c1ce71@changeid>
 <6549429e-bd3c-5249-2fbd-cd1c45b5b2c1@gmail.com>
In-Reply-To: <6549429e-bd3c-5249-2fbd-cd1c45b5b2c1@gmail.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Tue, 22 Sep 2020 10:55:11 +0800
Message-ID: <CANMq1KANt+3=qJ56QR_A2jnujohvPqJxTR=xkAwYzX_gxQ7L+g@mail.gmail.com>
Subject: Re: [PATCH] soc: mediatek: Check if power domains can be powered on
 at boot time
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Daniel Kurtz <djkurtz@chromium.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 22, 2020 at 1:07 AM Matthias Brugger <matthias.bgg@gmail.com> wrote:
>
> Hi Nicolas,
>
> Thanks for the patch.
>
> On 30/07/2020 06:01, Nicolas Boichat wrote:
> > In the error case, where a power domain cannot be powered on
> > successfully at boot time (in mtk_register_power_domains),
> > pm_genpd_init would still be called with is_off=false, and the
> > system would later try to disable the power domain again, triggering
> > warnings as disabled clocks are disabled again (and other potential
> > issues).
> >
> > Fixes: c84e358718a66f7 ("soc: Mediatek: Add SCPSYS power domain driver")
> > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> >
> > ---
> >
> >   drivers/soc/mediatek/mtk-scpsys.c | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> > index f669d3754627dad..0055a52a49733d5 100644
> > --- a/drivers/soc/mediatek/mtk-scpsys.c
> > +++ b/drivers/soc/mediatek/mtk-scpsys.c
> > @@ -524,6 +524,7 @@ static void mtk_register_power_domains(struct platform_device *pdev,
> >       for (i = 0; i < num; i++) {
> >               struct scp_domain *scpd = &scp->domains[i];
> >               struct generic_pm_domain *genpd = &scpd->genpd;
> > +             bool on;
> >
> >               /*
> >                * Initially turn on all domains to make the domains usable
> > @@ -531,9 +532,9 @@ static void mtk_register_power_domains(struct platform_device *pdev,
> >                * software.  The unused domains will be switched off during
> >                * late_init time.
> >                */
> > -             genpd->power_on(genpd);
> > +             on = genpd->power_on(genpd) >= 0;
>
> Is this something we expect? On probing we realize that some domains can't be
> turned on?
>
> I understand that this would be a bug in the driver. Therefore we should at most
> provide a warning instead of working around the bug, hiding it. Or do I got this
> wrong?

No, you get this right. That's a bug (we see this on unreleased HW),
and we will fix it.

Now, we already get this (somewhat subtle) error message on boot:
mtk-scpsys 10006000.power-controller: Failed to power on domain adsp

But without this patch, there is an unbalance later on (that is
possibly a bit confusing):
[    6.510811] ------------[ cut here ]------------
[    6.515417] adsp_sel already disabled
[    6.519089] WARNING: CPU: 5 PID: 180 at drivers/clk/clk.c:958
clk_core_disable+0x1ec/0x22c
...
[    6.658393]  clk_core_disable+0x1ec/0x22c
[    6.662395]  clk_disable+0x34/0x48
[    6.665791]  scpsys_clk_disable+0x34/0x58
[    6.669791]  scpsys_power_off+0x374/0x3ec
[    6.673790]  _genpd_power_off+0x40/0x98
[    6.677616]  genpd_power_off+0x168/0x208
[    6.681530]  genpd_power_off_work_fn+0x38/0x54
[    6.685964]  process_one_work+0x208/0x3c8
[    6.689964]  worker_thread+0x23c/0x3e8
[    6.693703]  kthread+0x11c/0x12c
[    6.696923]  ret_from_fork+0x10/0x18
[    6.700487] ---[ end trace 91ddada49c4d717c ]---

But I get your point, we should probably add something like
WARN_ON(!on) to make it clearer, at the time when the issue occurs,
that something is not right...

Thanks,

> Regards,
> Matthias
>
> >
> > -             pm_genpd_init(genpd, NULL, false);
> > +             pm_genpd_init(genpd, NULL, !on);
> >       }
> >
> >       /*
> >
