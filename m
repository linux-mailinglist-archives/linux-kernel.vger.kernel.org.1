Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1212E7224
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 17:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgL2QNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 11:13:05 -0500
Received: from mail-ej1-f53.google.com ([209.85.218.53]:39521 "EHLO
        mail-ej1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbgL2QNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 11:13:04 -0500
Received: by mail-ej1-f53.google.com with SMTP id n26so18710906eju.6;
        Tue, 29 Dec 2020 08:12:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+YkJE2LcLSD3EE6sqVw1hwvBfVG/re4CMN303q9UJPI=;
        b=Zcvj2OmH8H8t4/GN4APKNJSLkiqSOHlWgv0qvnbKcf0YN9iwuGiW1eSYio4q1JqOHQ
         LNIdJqDPn4rFXLOCWDAx/5Bii0jLEsS0eszvCaXLHNuNEQtRkMdetpjOLzx5bztpLGJG
         rIBl5Ed29+z5ZFFW3IYlK7HvNQFRuF1Bh006CJayYDohW+fiYvOy381gdYqa1zIUYjBZ
         OOScLou+m13bFAmZP7bq1QupCZf5iYW+PM5Ely/DLLfmjvCdCvhgwCSXZbSr3XXGyEG3
         KqB5e35c6+eIjZNii+0V5t03UKTInEvIgrxLpqmx67wlu4zP+zwJo19rwdBjOxkyjDxB
         lvbA==
X-Gm-Message-State: AOAM532kDMRXnX+jdL6BowRrvTdabC+yfhkd1FRCrznfheVFVbQvg38W
        q54V8zMnInkAznTq41uAZLs=
X-Google-Smtp-Source: ABdhPJyU2Jskq6lY2JPdVpTOdnHIeCIBF4ZPQop85MeCfQzVuVKl7vpA9H+qywu4qjOJrdr6vnGxVw==
X-Received: by 2002:a17:906:9345:: with SMTP id p5mr45349274ejw.40.1609258343104;
        Tue, 29 Dec 2020 08:12:23 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id f11sm38247122edy.59.2020.12.29.08.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Dec 2020 08:12:22 -0800 (PST)
Date:   Tue, 29 Dec 2020 17:12:20 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     Peng Fan <peng.fan@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        arm-soc <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/4] arm64: dts: imx8mn: add spba bus node
Message-ID: <20201229161220.GA17229@kozik-lap>
References: <1609243245-9671-1-git-send-email-peng.fan@nxp.com>
 <1609243245-9671-3-git-send-email-peng.fan@nxp.com>
 <CAHCN7x+=ebLn8vrrT=fyByQDydDNfkESFZHjdUrw=OHBz_E0hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHCN7x+=ebLn8vrrT=fyByQDydDNfkESFZHjdUrw=OHBz_E0hw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 29, 2020 at 06:26:41AM -0600, Adam Ford wrote:
> On Tue, Dec 29, 2020 at 6:15 AM <peng.fan@nxp.com> wrote:
> >
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > According to RM, there is a spba bus inside aips3 and aips1, add it.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 362 +++++++++++-----------
> >  1 file changed, 189 insertions(+), 173 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > index c824f2615fe8..91f85b8cee9a 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > @@ -269,117 +269,125 @@ aips1: bus@30000000 {
> >                         #size-cells = <1>;
> >                         ranges = <0x30000000 0x30000000 0x400000>;
> >
> > -                       sai1: sai@30010000 {
> > -                               #sound-dai-cells = <0>;
> > -                               compatible = "fsl,imx8mm-sai", "fsl,imx8mq-sai";
> > -                               reg = <0x30010000 0x10000>;
> > -                               interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
> > -                               clocks = <&clk IMX8MM_CLK_SAI1_IPG>,
> > -                                        <&clk IMX8MM_CLK_SAI1_ROOT>,
> > -                                        <&clk IMX8MM_CLK_DUMMY>, <&clk IMX8MM_CLK_DUMMY>;
> > -                               clock-names = "bus", "mclk1", "mclk2", "mclk3";
> > -                               dmas = <&sdma2 0 2 0>, <&sdma2 1 2 0>;
> > -                               dma-names = "rx", "tx";
> > -                               status = "disabled";
> > -                       };
> > +                       bus@30000000 {
> 
> There is already a bus@30000000 (aips1), and I think the system
> doesn't like it when there are multiple busses with the same name.
> 
> There was some discussion on fixing the 8mn [1], but it doesn't look
> like it went anywhere.
> 
> I am guessing the Mini will need something similar to the nano.
> 
> [1] - https://patchwork.kernel.org/project/linux-arm-kernel/patch/1607324004-12960-1-git-send-email-shengjiu.wang@nxp.com/

Several replies from S.j. Wang are missing from LKML (and maybe
patchwork?) but we reached a conclusion:
https://lore.kernel.org/linux-arm-kernel/20201208090601.GA8347@kozik-lap/

Either you do some remapping of address space or just rename the "bus"
nodes (e.g. generic bus-1 or a specific spba-bus).

Best regards,
Krzysztof
