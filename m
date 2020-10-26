Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC1AD2990B8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 16:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1783402AbgJZPNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 11:13:09 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39873 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1783315AbgJZPNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 11:13:08 -0400
Received: by mail-io1-f67.google.com with SMTP id p7so10436305ioo.6;
        Mon, 26 Oct 2020 08:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WfVXOQ6HZ8B3DTPHU0OH7XejWVvcViIgMuVhxNRQhVo=;
        b=oDEIENQX+qKEhmg/sgw8uTcJoEVCDgSwV8n1/0aSDMGcTeFUhN7q7CE7llA8X+XN8B
         GtOF0+q0ReFof9N9iG3thWkoEk0zbUYwkufph9w9H8cR++s8geWg6BV5E+CkemamK6QF
         rWe5l6GXMNEbe+SjlyFQcy0dC837zlnUsPdJ/8ZlJKnYmvox+sFY7KGEdAzQWSlbkero
         qic0R3j9+iOWysQu4WsuVdcnud7cgedtn3LugSTqKbYBDkkE3g6O6zs/dRo/s50pKFJE
         Xj99doXR3bgYEdlFbAxe6rkrdpD/JhGCPEP9Pfgv8ltvxZppwROK/yYcSd4Ii3yX3kLB
         p1Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WfVXOQ6HZ8B3DTPHU0OH7XejWVvcViIgMuVhxNRQhVo=;
        b=nibZzRDpAtxtJgsVTdOtBlYNmFNvU9gAmSnXBt+uLzF/Bw62iEShHEbEtotkuZhGpE
         53Ul5gto3SRA7FWn6BLO4XpoMvDXTimuGJgD5HBSDnAOkYdY19gIcBgrg8u8sO2RO0Ah
         IJJ9dwGRAS3DOzYPWrnPvwc1jZ53Qk1QkLA0hsb3UwuXNkKirkEuXC5W/aqL0ssR71/U
         m394c5uczZDWoJC7avVjUWx7C7bVJvMIgSP67DS35iCwxBiuLGp0FoeqgSARNwQ56aM5
         B6uiTm84XOWfvR6LD3bu0N5VTQHI+Ty8vmaOa/EhRt3cG9Ruu8a/uGH/8ozEiwXulZin
         qrrQ==
X-Gm-Message-State: AOAM530vy5+vEXZ/cc6FcZoHUQEMvgJim5JOlDwNjQD642OAGb1OSy8T
        9k7C9HkatEqCZqDGy2g6bOVWkc/oSzMIeD0gwKI=
X-Google-Smtp-Source: ABdhPJxlZcu4+YbojVlCg5cEerIpH+PsyfCTkvkf6aEWwuNsGUHJrDZ8hpk7rXPKbsWTaRPF6839rIq2jFOJXTDIGko=
X-Received: by 2002:a02:8562:: with SMTP id g89mr11944624jai.65.1603725186325;
 Mon, 26 Oct 2020 08:13:06 -0700 (PDT)
MIME-Version: 1.0
References: <20201024162016.1003041-1-aford173@gmail.com> <20201024202335.y3npwtgragpp5wcz@fsr-ub1664-175>
 <CAHCN7xJiygvLStO56v4xSnOEqR_5fbYQHn5juA8YeDiWh2awbg@mail.gmail.com>
 <20201025120509.r5kl76wo5mdmapo5@fsr-ub1664-175> <3dadade8-6e77-e27f-d5a6-307de17a4dd0@denx.de>
 <CAHCN7xLC-gKquDNS3ToQCff=g610PscQE+T4zfO=_05GpLyK4w@mail.gmail.com> <20201026145516.shmb55gaeh6u7oru@fsr-ub1664-175>
In-Reply-To: <20201026145516.shmb55gaeh6u7oru@fsr-ub1664-175>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 26 Oct 2020 10:12:55 -0500
Message-ID: <CAHCN7xJOczT1B03Am4A645Xrk6-VF_7VDgAq13F-81=oCkixjw@mail.gmail.com>
Subject: Re: [RFC 0/3] clk: imx: Implement blk-ctl driver for i.MX8MN
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Marek Vasut <marex@denx.de>, linux-clk <linux-clk@vger.kernel.org>,
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 9:55 AM Abel Vesa <abel.vesa@nxp.com> wrote:
>
> On 20-10-25 11:05:32, Adam Ford wrote:
> > On Sun, Oct 25, 2020 at 7:19 AM Marek Vasut <marex@denx.de> wrote:
> > >
> > > On 10/25/20 1:05 PM, Abel Vesa wrote:
> > >
> > > [...]
> > >
> > > >> Together, both the GPC and the clk-blk driver should be able to pu=
ll
> > > >> the multimedia block out of reset.  Currently, the GPC can handle =
the
> > > >> USB OTG and the GPU, but the LCDIF and MIPI DSI appear to be gated=
 by
> > > >> the clock block
> > > >>
> > > >> My original patch RFC didn't include the imx8mn node, because it
> > > >> hangs, but the node I added looks like:
> > > >>
> > > >> media_blk_ctl: clock-controller@32e28000 {
> > > >>      compatible =3D "fsl,imx8mn-media-blk-ctl", "syscon";
> > > >>      reg =3D <0x32e28000 0x1000>;
> > > >>      #clock-cells =3D <1>;
> > > >>      #reset-cells =3D <1>;
> > > >> };
> > > >>
> > > >> I was hoping you might have some feedback on the 8mn clk-blk drive=
r
> > > >> since you did the 8mp clk-blk drive and they appear to be very
> > > >> similar.
> > > >>
> > > >
> > > > I'll do you one better still. I'll apply the patch in my tree and g=
ive it
> > > > a test tomorrow morning.
> >
> > I do have some more updates on how to get the system to not hang, and
> > to enumerate more clocks.
> > Looking at Marek's work on enabling clocks in the 8MM, he added a
> > power-domain in dispmix_blk_ctl pointing to the dispmix in the GPC.
> > By forcing the GPC driver to write 0x1fff  to 32e28004, 0x7f to
> > 32e28000 and 0x30000 to 32e28008, the i.MX8MM can bring the display
> > clocks out of reset.
> >
>
> Yeah, that makes sense. Basically, it was trying to disable unused clocks
> (see clk_disable_unused) but in order to disable the clocks from the
> media BLK_CTL (which I think should be renamed in display BLK_CTL) the
> PD need to be on. Since you initially didn't give it any PD, it was tryin=
g
> to blindly write/read the gate bit and therefore freeze.
>
> > Unfortunately, the i.MX8MN needs to have 0x100 written to both
> > 32e28000 and 32e28004, and the values written for the 8MM are not
> > compatible.
> > By forcing the GPC to write those values, I can get  lcdif_pixel_clk
> > and the mipi_dsi_clkref  appearing on the Nano.
>
> I'm trying to make a branch with all the patches for all i.MX8M so I
> can keep track of it all. On this branch I've also applied the
> following patchset from Lucas Stach:
> https://www.spinics.net/lists/arm-kernel/msg843007.html
> but I'm getting the folowing errors:
>
> [   16.690885] imx-pgc imx-pgc-domain.3: failed to power up ADB400
> [   16.716839] imx-pgc imx-pgc-domain.3: failed to power up ADB400
> [   16.730500] imx-pgc imx-pgc-domain.3: failed to power up ADB400
>
> Lucas, any thoughts?
>
> Maybe it's something related to 8MN.
>
I will go back and double check this now that we have both the
blt_crl->power-domain and the power-domain->blk_ctl.

> Will dig further, see what pops out.

I wasn't sure which direction to go with the name.  I can rename the
media_blk_ctl  driver to display_blk_ctl.  I used Media based on the
imx8mp naming convention and the fact that it's controlling both the
display and the camera interface, however it's depending on the
dispmix GPC.

I'll submit a RFC V2 with the cross referencing to the GPC based on
Marek's Mini patch set, but we'll still have an issue where the Mini
and Nano have different syscon values to enable the clocks, and
Marek's branch has it card-coded, so my patch would effectively break
the Mini in order to make the Nano operate until we find a better
solution.

adam

>
> >
> >  video_pll1_ref_sel                0        0        0    24000000
> >      0     0  50000
> >        video_pll1                     0        0        0   594000000
> >         0     0  50000
> >           video_pll1_bypass           0        0        0   594000000
> >         0     0  50000
> >              video_pll1_out           0        0        0   594000000
> >         0     0  50000
> >                 disp_pixel            0        0        0   594000000
> >         0     0  50000
> >                    lcdif_pixel_clk       0        0        0
> > 594000000          0     0  50000
> >                    disp_pixel_clk       0        0        0
> > 594000000          0     0  50000
> >                 dsi_phy_ref           0        0        0    27000000
> >         0     0  50000
> >                    mipi_dsi_clkref       0        0        0
> > 27000000          0     0  50000
> >
> > I am not 100% certain the clock parents  in the clk block driver for
> > the 8MN are correct, and I am not seeing the mipi_dsi_pclk
> >
> > Once the dust settles on the GPC decision for Mini and Nano, I think
> > we'll need a more generic way to pass the bits we need to set in clock
> > block to the GPC.
> >
> > adam
> > >
> > > You can also apply the one for 8MM:
> > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fl=
ore.kernel.org%2Flinux-arm-kernel%2F20201003224555.163780-5-marex%40denx.de=
%2F&amp;data=3D04%7C01%7Cabel.vesa%40nxp.com%7Cae966cce11204214fb1908d878ff=
d492%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637392387462398200%7CUnkn=
own%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXV=
CI6Mn0%3D%7C1000&amp;sdata=3DM944BaOI7Sa1RmI0nwrshKaM7MGMEN5pWgjmYqXZkns%3D=
&amp;reserved=3D0
