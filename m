Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C16BF29F4DA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 20:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgJ2TYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 15:24:41 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:39849 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgJ2TYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 15:24:40 -0400
Received: by mail-ej1-f68.google.com with SMTP id bn26so5374103ejb.6;
        Thu, 29 Oct 2020 12:24:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=na9861zvKblYf7ep02+TOiwBVQurVwpRiruVXN88s4s=;
        b=DzUfE+UtY14oZ2RtuIioCJaZ00Xc2NZV2lJj1MMi0/0WTq+cZfmu+ACjTfw6W/GzWI
         ZaJ5jaB1UyJalHht3aPPHdu7S7FBPCbARlAUQ4gT35sIVgWnvRvfx2QqXnnX7d/MXh67
         ppcEMDWn89su7poQUS4G0Ddq/woQBeX4Vs6oaPBqlnfa0+WAREbWLcP2UpiCAYAEpmOP
         y7qUc/tTibumcOveygRor0kB8/szRyZx07VAM92mFCHhjPSvaSgPgXzcdAYonKOB91HY
         QRNOawGVHmLSiQS82nbTTK+k17d3Mq/J9WXCajj/YfXYThkyerQutpn6oGt5i2ZUcjRJ
         rDbQ==
X-Gm-Message-State: AOAM532skqnRji0j8i6SgEfboO0E2mGLVXDa4wa2VR2PrI1tPLK2vaIg
        GH2DesrS0e1yX2tavpMTCk0=
X-Google-Smtp-Source: ABdhPJzB9KT5TbeTYxKSFEl6Fns3ceKUsdLvWJoSB5ZkN1ehwSpJWfCN82qTQTPElYeou9wVCwNhqA==
X-Received: by 2002:a17:906:1614:: with SMTP id m20mr5528468ejd.258.1603999478926;
        Thu, 29 Oct 2020 12:24:38 -0700 (PDT)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id dp1sm1965399ejc.74.2020.10.29.12.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 12:24:37 -0700 (PDT)
Date:   Thu, 29 Oct 2020 20:24:36 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        aford@beaconemedded.com, Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: imx8mm: Add support for micfil
Message-ID: <20201029192436.GB308501@kozik-lap>
References: <20200502125949.194032-1-aford173@gmail.com>
 <20200502125949.194032-2-aford173@gmail.com>
 <20200520010348.GE11739@dragon>
 <CAHCN7xKBx_YXCGSUJWO3YCaGfx4oc7iuv6S4qi500_NjV9pW=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHCN7xKBx_YXCGSUJWO3YCaGfx4oc7iuv6S4qi500_NjV9pW=w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 07:10:37AM -0500, Adam Ford wrote:
> On Tue, May 19, 2020 at 8:03 PM Shawn Guo <shawnguo@kernel.org> wrote:
> >
> > On Sat, May 02, 2020 at 07:59:48AM -0500, Adam Ford wrote:
> > > The i.MX8M Mini has supports the MICFIL digital interface.
> > > It's a 16-bit audio signal from a PDM microphone bitstream.
> > > The driver is already in the kernel, but the node is missing.
> > >
> > > This patch adds the micfil node.
> > >
> > > Signed-off-by: Adam Ford <aford173@gmail.com>
> > >
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > > index c63685ae80ee..d46e727fc362 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > > +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > > @@ -339,6 +339,25 @@ sai6: sai@30060000 {
> > >                               status = "disabled";
> > >                       };
> > >
> > > +                     micfil: micfil@30080000 {
> >
> > Find a generic node name, audio-controller maybe?
> 
> The SAI's nodes are called SAI@xxxx
> 
> If that's a deal-breaker, I can push a V3.
> 
> I didn't see anyone from the device tree side comment, and the device
> tree binding doc states 'micfil@xxxxxx' so I used what was documented
> in the fsl,micfil.txt

Hi,

The example in the binding is not a binding itself. It can be misleading
or even incorrect and it is not a reason to use such in DTS.

Could be also audio-codec but it is not accurate (as it is only from the
microphone to digital).

Shawn's proposal is the best, I think.

Best regards,
Krzysztof
