Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73EC5297E99
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 23:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1763260AbgJXVDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 17:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762772AbgJXVDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 17:03:30 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD8CC0613CE;
        Sat, 24 Oct 2020 14:03:30 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id b15so6010452iod.13;
        Sat, 24 Oct 2020 14:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wyIkGJOqvy6PVAg1gwb0BH/LAgmxVz9OxPtjjrw/XtY=;
        b=jtH+p9X0+tbDCWuB2cr1qRJSALaDW3KwGqoQYwdVa+WDOzubYiIg1ywYvAxQakzIoJ
         Yj44qfzAVvl8FGTZxZp6xa7dfMe10vDot0ETjj5c9P9BHCSCTlrmhahbUdjlSwRYcYDU
         8cMoMPfE1jweKPsGZ/ZZPqgaM1VO5kTxK2xFF72BQT/yVGmNWSPNnQqsjWrroskQse+V
         VCmYvdl+v7kFJgYmCfd7T68ArGpSie099tL7YJ6m7+qIZNwjE5hecpX4BeqiLiJ+NNnt
         ZHXAgGjRm5bsHrCO5yyN2+TFAd+VBiADwnqlx5/fhfSBtBbLXRBL3z8NnsDHLsrS9eed
         PSMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wyIkGJOqvy6PVAg1gwb0BH/LAgmxVz9OxPtjjrw/XtY=;
        b=nmkOJP8Lbh7cvDVkXwZxIoyM25EB97u19zBwAZyYXLCzX27pZN81/5AZdUkMKDOyBs
         Zr2qgLyt94dRgrmbWSwTRjyGiQZt0EzonZcyfir5lDwjh+ktjKOPiwiLqhquFgfIxZbT
         e6xTVdD6o+UOX6nggO/DYOMrUHH7SggX8KWUMGXX5WvdKHcxQqLK7xvw9oRI8c5SmjNu
         3GHRLsskVA1fLk/nIh8os2Iz+7XF80txDN7KTeMsamGZ2Zgo8eFGjKLjvWYX6V3bEog8
         aU1KaDdJBCE5c6tmQHsJKtI1k6quKEZeTKwEt4Yy5L1A7jruqRw4zVVxN1TGUgAEL2Pu
         is1g==
X-Gm-Message-State: AOAM532FUBTp9mCVppOFC2whIjvVW4nqI6EDjwkuAcj78O+bbgeSh916
        Eb8oBdMm7aekFzC9ZsoG7g8wdos9C4XJUFk7Rbg=
X-Google-Smtp-Source: ABdhPJzV9s8rhB+z1rknF5fL0z57cSKllpGucQ6vfGRCF8Ze0dDfK9NduZaQ7K4zL9UBFsGqF4/w2earioOK1pzu5Fw=
X-Received: by 2002:a02:8562:: with SMTP id g89mr6402489jai.65.1603573408907;
 Sat, 24 Oct 2020 14:03:28 -0700 (PDT)
MIME-Version: 1.0
References: <20201024162016.1003041-1-aford173@gmail.com> <20201024202335.y3npwtgragpp5wcz@fsr-ub1664-175>
In-Reply-To: <20201024202335.y3npwtgragpp5wcz@fsr-ub1664-175>
From:   Adam Ford <aford173@gmail.com>
Date:   Sat, 24 Oct 2020 16:03:17 -0500
Message-ID: <CAHCN7xJiygvLStO56v4xSnOEqR_5fbYQHn5juA8YeDiWh2awbg@mail.gmail.com>
Subject: Re: [RFC 0/3] clk: imx: Implement blk-ctl driver for i.MX8MN
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     linux-clk <linux-clk@vger.kernel.org>, Marek Vasut <marex@denx.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 24, 2020 at 3:23 PM Abel Vesa <abel.vesa@nxp.com> wrote:
>
> On 20-10-24 11:20:12, Adam Ford wrote:
> > There are some less-documented registers which control clocks and
> > resets for the multimedia block which controls the LCDIF, ISI, MIPI
> > CSI, and MIPI DSI.
> >
> > The i.Mx8M Nano appears to have a subset of the i.MX8MP registers with
> > a couple shared registers with the i.MX8MM.  This series builds on the
> > series that have been submitted for both of those other two platforms.
> >
> > This is an RFC because when enabling the corresponding DTS node, the
> > system freezes on power on.  There are a couple of clocks that don't
> > correspond to either the imx8mp nor the imx8mm, so I might have something
> > wrong, and I was hoping for some constructive feedback in order to get
> > the imx8m Nano to a similar point of the Mini and Plus.
> >
>
> Thanks for the effort.

Sure thing!

>
> I'm assuming this relies on the following patchset, right ?
> https://lkml.org/lkml/2020/10/24/139
Abell,

Your link points right back to this e-mail.  ;-)

I based this work off:
https://www.spinics.net/lists/arm-kernel/msg843906.html  from Marek
which I beleive is based on
https://www.spinics.net/lists/arm-kernel/msg836165.html from you.

I also have a GPC patch series located:
https://www.spinics.net/lists/arm-kernel/msg847925.html

Together, both the GPC and the clk-blk driver should be able to pull
the multimedia block out of reset.  Currently, the GPC can handle the
USB OTG and the GPU, but the LCDIF and MIPI DSI appear to be gated by
the clock block

My original patch RFC didn't include the imx8mn node, because it
hangs, but the node I added looks like:

media_blk_ctl: clock-controller@32e28000 {
     compatible = "fsl,imx8mn-media-blk-ctl", "syscon";
     reg = <0x32e28000 0x1000>;
     #clock-cells = <1>;
     #reset-cells = <1>;
};

I was hoping you might have some feedback on the 8mn clk-blk driver
since you did the 8mp clk-blk drive and they appear to be very
similar.

adam


>
> > Adam Ford (3):
> >   dt-bindings: clock: imx8mn: Add media blk_ctl clock IDs
> >   dt-bindings: reset: imx8mn: Add media blk_ctl reset IDs
> >   clk: imx: Add blk-ctl driver for i.MX8MN
> >
> >  drivers/clk/imx/clk-blk-ctl-imx8mn.c     | 80 ++++++++++++++++++++++++
> >  include/dt-bindings/clock/imx8mn-clock.h | 11 ++++
> >  include/dt-bindings/reset/imx8mn-reset.h | 22 +++++++
> >  3 files changed, 113 insertions(+)
> >  create mode 100644 drivers/clk/imx/clk-blk-ctl-imx8mn.c
> >  create mode 100644 include/dt-bindings/reset/imx8mn-reset.h
> >
> > --
> > 2.25.1
> >
