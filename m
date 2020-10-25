Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61E85298271
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 17:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1417101AbgJYQFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 12:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1417082AbgJYQFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 12:05:44 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9195EC0613CE;
        Sun, 25 Oct 2020 09:05:44 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id q1so5937598ilt.6;
        Sun, 25 Oct 2020 09:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a+vqcSmOOY97IzaN1+1HCH355O2NZAY2HbI1jkN79hI=;
        b=maK0k18LOlWzmcfX5FXU4OHIBpi6XXy2fqu4lstMQYTI4yzpfEEspmuoyHji6l7g8v
         iTZuFTrSeqHCzSF1WlPyLE+pEoxwmIRwfPmAxCtcCh/Ee6YKH1MimIrI7hmCEqYIxdnS
         3u0vlKwhTERYGrqNlfif+c5n5tp2Z4Ybm2NzzOmILBn9ch3A89L3QmWOUoTTsN3oUYgm
         GG+IsAYrU8R7zC+cj/cs6++7A04oABXFoe7XzDH68lBAcudOsGDqbvWvPYDkIUOXa+wZ
         qF+bpht1aG2Nn3xAn74ii4CY8/XkwQ/sI+bpoomfn4vO4/L3s4zEB0DVe5G7IguyE+O2
         bNIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a+vqcSmOOY97IzaN1+1HCH355O2NZAY2HbI1jkN79hI=;
        b=L3ci2Rr/d7R1ZwEObU/L8tGoNo3U9KVDFYPLpJGL79ZbchXldn22LyRpN6jr7CBNkP
         mnGA5MwGtXdsPIQiLPvd/8u5ysaiK9Uw7+vMD4zm5weY8sRZRxDlH/K+rAHXZqKyb22X
         s3EN93cgEe4in2pTyCBmB+tMgG1BoutUvv6aZLZMAOOXvxzA6xHH7TpDvu+Svc/glJCJ
         hKa61f0PxfO+QULB1N9QvWd/6ZaupT9tR2QYWYEPc/4o+R1DiuVAhlla8Yiyc8QOY6ib
         43z5mk6SqbSslDA+BGgvw/Yvbyw0HGgPTLfFFGpkA+MVZNQ0W26R7lF4d4J7T8+l0PpL
         QZxw==
X-Gm-Message-State: AOAM530yUJdH86ig1k9dH53ZF6wddchX43xu5uJ7mBYpA8i5KVettgfj
        0URZEecwVSpN98GkNQcj9gWkuNd8h34AqzAzZxQ=
X-Google-Smtp-Source: ABdhPJy2SHNZr1Dd8yNo+sGV/CJn5rnBcSlG2J20vuJGPkaYNODFUa+hQZqgdDqFhUPKeLpwICVWIzmkCNuY08MMUc0=
X-Received: by 2002:a05:6e02:52c:: with SMTP id h12mr7774166ils.196.1603641943584;
 Sun, 25 Oct 2020 09:05:43 -0700 (PDT)
MIME-Version: 1.0
References: <20201024162016.1003041-1-aford173@gmail.com> <20201024202335.y3npwtgragpp5wcz@fsr-ub1664-175>
 <CAHCN7xJiygvLStO56v4xSnOEqR_5fbYQHn5juA8YeDiWh2awbg@mail.gmail.com>
 <20201025120509.r5kl76wo5mdmapo5@fsr-ub1664-175> <3dadade8-6e77-e27f-d5a6-307de17a4dd0@denx.de>
In-Reply-To: <3dadade8-6e77-e27f-d5a6-307de17a4dd0@denx.de>
From:   Adam Ford <aford173@gmail.com>
Date:   Sun, 25 Oct 2020 11:05:32 -0500
Message-ID: <CAHCN7xLC-gKquDNS3ToQCff=g610PscQE+T4zfO=_05GpLyK4w@mail.gmail.com>
Subject: Re: [RFC 0/3] clk: imx: Implement blk-ctl driver for i.MX8MN
To:     Marek Vasut <marex@denx.de>
Cc:     Abel Vesa <abel.vesa@nxp.com>,
        linux-clk <linux-clk@vger.kernel.org>,
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

On Sun, Oct 25, 2020 at 7:19 AM Marek Vasut <marex@denx.de> wrote:
>
> On 10/25/20 1:05 PM, Abel Vesa wrote:
>
> [...]
>
> >> Together, both the GPC and the clk-blk driver should be able to pull
> >> the multimedia block out of reset.  Currently, the GPC can handle the
> >> USB OTG and the GPU, but the LCDIF and MIPI DSI appear to be gated by
> >> the clock block
> >>
> >> My original patch RFC didn't include the imx8mn node, because it
> >> hangs, but the node I added looks like:
> >>
> >> media_blk_ctl: clock-controller@32e28000 {
> >>      compatible = "fsl,imx8mn-media-blk-ctl", "syscon";
> >>      reg = <0x32e28000 0x1000>;
> >>      #clock-cells = <1>;
> >>      #reset-cells = <1>;
> >> };
> >>
> >> I was hoping you might have some feedback on the 8mn clk-blk driver
> >> since you did the 8mp clk-blk drive and they appear to be very
> >> similar.
> >>
> >
> > I'll do you one better still. I'll apply the patch in my tree and give it
> > a test tomorrow morning.

I do have some more updates on how to get the system to not hang, and
to enumerate more clocks.
Looking at Marek's work on enabling clocks in the 8MM, he added a
power-domain in dispmix_blk_ctl pointing to the dispmix in the GPC.
By forcing the GPC driver to write 0x1fff  to 32e28004, 0x7f to
32e28000 and 0x30000 to 32e28008, the i.MX8MM can bring the display
clocks out of reset.

Unfortunately, the i.MX8MN needs to have 0x100 written to both
32e28000 and 32e28004, and the values written for the 8MM are not
compatible.
By forcing the GPC to write those values, I can get  lcdif_pixel_clk
and the mipi_dsi_clkref  appearing on the Nano.

 video_pll1_ref_sel                0        0        0    24000000
     0     0  50000
       video_pll1                     0        0        0   594000000
        0     0  50000
          video_pll1_bypass           0        0        0   594000000
        0     0  50000
             video_pll1_out           0        0        0   594000000
        0     0  50000
                disp_pixel            0        0        0   594000000
        0     0  50000
                   lcdif_pixel_clk       0        0        0
594000000          0     0  50000
                   disp_pixel_clk       0        0        0
594000000          0     0  50000
                dsi_phy_ref           0        0        0    27000000
        0     0  50000
                   mipi_dsi_clkref       0        0        0
27000000          0     0  50000

I am not 100% certain the clock parents  in the clk block driver for
the 8MN are correct, and I am not seeing the mipi_dsi_pclk

Once the dust settles on the GPC decision for Mini and Nano, I think
we'll need a more generic way to pass the bits we need to set in clock
block to the GPC.

adam
>
> You can also apply the one for 8MM:
> https://lore.kernel.org/linux-arm-kernel/20201003224555.163780-5-marex@denx.de/
