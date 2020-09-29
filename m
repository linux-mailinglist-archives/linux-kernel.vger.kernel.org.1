Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A54B27C2F1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 12:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbgI2K4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 06:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgI2K4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 06:56:54 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CDEC0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 03:56:52 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id o8so14327269ejb.10
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 03:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KuB6v1Z/cxaw+tkBcRkrNd8FIvmhihG+BlVshB3rkPY=;
        b=Fdlaw10dczFFn8MNkevPHnqslMdFK7TLzB4yoHVlqpvK0Y5T1DkC0greHZY+A3NkMN
         bGqP6juODF0rt4ySzD8nh0czdS2HmOe1vBsExYUnL6joorfe8wf/9GrP3MSHpF4C6RPT
         ZBR0DwLWgOD7ZYHj+ukL4sibP0YMH2xIPdXxjE0Af1QUGV52+oqL2VZRtgmK5kmb6Pnf
         LHOn+xfGAq6+qRvQAj5Dr/RXunwAvNCDf31YSUdQTV5nYeIOeh84n48n4nMm/J7HdDMb
         uulN8/4rEqwuCB2ehzbKwgN6A0NDl7GGHmxWrIuBaK2OCh94ywo9/qKujmQzIF8k4iUr
         cxZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KuB6v1Z/cxaw+tkBcRkrNd8FIvmhihG+BlVshB3rkPY=;
        b=ovO7g639bPgVmVVv5clp9PZzU3VzAbWP7FI4//vf1+PSLt7jvGecpdigdeWWDNPOu7
         J+/xWxhj/ZP2QwPAiWsgoNv39xZonC1uTds56+xAWHyqoIs8VeS7IHU04EX/k9HW89i6
         9fmqEWkEKNkrahcc8QK9lfHcBmeeAq6Ik092asPZJgGQ1nc0VwOccAO531bXe7UJU7tD
         cxiX9tMRrr6Iv8wM+FhqECqEUVV7MI/g0ulDykXI/B2Mc34cfZI1/cJapFYhJLBSJCRx
         Yhh9ChwBpHg9Mzlopnvyks6V5DVpeaHKRSUWLySA3YC20Ixkw04e94n6IbYsP+lJAGGC
         QALw==
X-Gm-Message-State: AOAM5321RvtpU0T8rKtbR5sJl6y3CSuyPtMSLMt1iCgoRBPdYDS3oE8i
        YR4XgM9S7OUEAydmbpc8MV+2EbWh5O/atS4qN7Dcp7/f1nU=
X-Google-Smtp-Source: ABdhPJz1nj7/dZxqSczWRbM/uy/cM4dozQJLS8KAvvTusXkFzcgyTBee2Ak37tiJcAKDq1Nczxn49z8bodUSf+04Lsg=
X-Received: by 2002:a17:906:95cd:: with SMTP id n13mr3101144ejy.297.1601377010890;
 Tue, 29 Sep 2020 03:56:50 -0700 (PDT)
MIME-Version: 1.0
References: <cc294ae1a79ef845af6809ddb4049f0c0f5bb87a.1598259551.git.michal.simek@xilinx.com>
In-Reply-To: <cc294ae1a79ef845af6809ddb4049f0c0f5bb87a.1598259551.git.michal.simek@xilinx.com>
From:   Michal Simek <monstr@monstr.eu>
Date:   Tue, 29 Sep 2020 12:56:39 +0200
Message-ID: <CAHTX3dLF1GRi2nMCt0u8TQc96bu3a4OoxKjwQB54MRx87DOn4w@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: zynqmp: Remove additional compatible string
 for i2c IPs
To:     LKML <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git <git@xilinx.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Manish Narani <manish.narani@xilinx.com>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Moritz Fischer <mdf@kernel.org>,
        Nava kishore Manne <nava.manne@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

po 24. 8. 2020 v 10:59 odes=C3=ADlatel Michal Simek <michal.simek@xilinx.co=
m> napsal:
>
> DT binding permits only one compatible string which was decribed in past =
by
> commit 63cab195bf49 ("i2c: removed work arounds in i2c driver for Zynq
> Ultrascale+ MPSoC").
> The commit aea37006e183 ("dt-bindings: i2c: cadence: Migrate i2c-cadence
> documentation to YAML") has converted binding to yaml and the following
> issues is reported:
> ...: i2c@ff030000: compatible: Additional items are not allowed
> ('cdns,i2c-r1p10' was unexpected)
>         From schema:
> .../Documentation/devicetree/bindings/i2c/cdns,i2c-r1p10.yaml fds
> ...: i2c@ff030000: compatible: ['cdns,i2c-r1p14', 'cdns,i2c-r1p10'] is to=
o
> long
>
> The commit c415f9e8304a ("ARM64: zynqmp: Fix i2c node's compatible string=
")
> has added the second compatible string but without removing origin one.
> The patch is only keeping one compatible string "cdns,i2c-r1p14".
>
> Fixes: c415f9e8304a ("ARM64: zynqmp: Fix i2c node's compatible string")
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts=
/xilinx/zynqmp.dtsi
> index 6a8ff4bcc09b..165a95a106c8 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -500,7 +500,7 @@ gpio: gpio@ff0a0000 {
>                 };
>
>                 i2c0: i2c@ff020000 {
> -                       compatible =3D "cdns,i2c-r1p14", "cdns,i2c-r1p10"=
;
> +                       compatible =3D "cdns,i2c-r1p14";
>                         status =3D "disabled";
>                         interrupt-parent =3D <&gic>;
>                         interrupts =3D <0 17 4>;
> @@ -511,7 +511,7 @@ i2c0: i2c@ff020000 {
>                 };
>
>                 i2c1: i2c@ff030000 {
> -                       compatible =3D "cdns,i2c-r1p14", "cdns,i2c-r1p10"=
;
> +                       compatible =3D "cdns,i2c-r1p14";
>                         status =3D "disabled";
>                         interrupt-parent =3D <&gic>;
>                         interrupts =3D <0 18 4>;
> --
> 2.28.0
>

Applied.
M

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
