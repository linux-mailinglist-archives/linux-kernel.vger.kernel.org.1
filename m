Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2C742C4026
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 13:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729408AbgKYM3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 07:29:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729312AbgKYM3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 07:29:11 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F63CC0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 04:29:11 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id 7so2793841ejm.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 04:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hddbZosietvPAsnHP23A/ubJ9TPKAFFanPN6jxLs4SY=;
        b=t6NEphUxIKF0hBMXIZrd0vg7g6jIN6Y3QZ9wCliWjTZ0rgzKvYcEgO7pSwYFDh7J3f
         PaY+BLmaQE61kCCX7YWtT03COJCfNrR2Rql+Jytr60ujDaq2p5/47iDU/WMVhKDK905v
         +1PVroIETib/a3gkz9ABuwccJ+yBJ5FWJJ5LF3MAeqj/Oolxt3/vIfRABGoSJArFrMaW
         M4VMClPoXZaLVtuQrOGA/aUokBTCRE6epmneVHhdHvf+UIb/829xbtI9yFdFoMyozcDe
         PPX3Y2NZnF0vLBBatzz49dsgoC+z+Tk77ZyhjVUW67BASy7+THPRzsGAl1SiEZoU43n6
         Yzow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hddbZosietvPAsnHP23A/ubJ9TPKAFFanPN6jxLs4SY=;
        b=lnSCtCJSDFOFESFpQH410vPZA8j0gx3s8PT5lt0DSrOABeDku0kGz4CYlyvSh1lEXq
         bWPJuIfucmi9vHzBfLFrV+NBDGsbjynXAMgjFFwGfSdTKcZn3BcY8EXHPfsvgBhFAmWC
         /KMcORObhVF4SBdPHdA+7C0eIFJcdsJp/5FQHTakk0tM4BpuWvIAkIVI9ySTGX2NtSeC
         L7zArTVQPx9aSYCTAbxOQKdoHbMj0XMKx2TJh6wDLrUsHo0Z3/3xDZWE5IHR5xB3bgkh
         hFfBq5VrnNF9HoMtCy0uA8x1NGgdwq7yQlkznCkE0ysfW6g/864H/B9awBptk/K5ZkAS
         1Xvg==
X-Gm-Message-State: AOAM531ZpIxHD04asRUsKSvB8fAY84Sl6Iqk5PIr6xJZh5krvwYILdq0
        30+lMnCMmy4X9l+RulNH98Fxzs1F9XMwFSIKSSCd6amkAJqAOQ==
X-Google-Smtp-Source: ABdhPJxtRWGldej9h5hpcjUbdriItl5cAYppe19WBElhXOZwBO/z2VEQREO+KhByzJfQxcMRq4eDmHJ6//Dc3xV124M=
X-Received: by 2002:a17:906:b847:: with SMTP id ga7mr1486813ejb.200.1606307349609;
 Wed, 25 Nov 2020 04:29:09 -0800 (PST)
MIME-Version: 1.0
References: <f59a63d8cb941592de6d2dee8afa6f120b2e40c8.1601379794.git.michal.simek@xilinx.com>
In-Reply-To: <f59a63d8cb941592de6d2dee8afa6f120b2e40c8.1601379794.git.michal.simek@xilinx.com>
From:   Michal Simek <monstr@monstr.eu>
Date:   Wed, 25 Nov 2020 13:28:58 +0100
Message-ID: <CAHTX3dK1q4S_DzT-1Wdf-W=ac7ZTBCGPC46yeAhd4RgM-1+8Qw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: zynqmp: Fix pcie ranges description
To:     LKML <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git <git@xilinx.com>
Cc:     Kalyani Akula <kalyani.akula@xilinx.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Manish Narani <manish.narani@xilinx.com>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Nava kishore Manne <nava.manne@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C3=BAt 29. 9. 2020 v 13:43 odes=C3=ADlatel Michal Simek <michal.simek@xili=
nx.com> napsal:
>
> DT schema is checking tuples which should be properly separated. The patc=
h
> is doing this separation to avoid the following warning:
> ..yaml: axi: pcie@fd0e0000:ranges: [[33554432, 0, 3758096384, 0,
> 3758096384, 0, 268435456, 1124073472, 6, 0, 6, 0, 2, 0]] is not valid und=
er
> any of the given schemas (Possible causes of the failure):
> ...dt.yaml: axi: pcie@fd0e0000:ranges: True was expected
> ...dt.yaml: axi: pcie@fd0e0000:ranges:0: [33554432, 0, 3758096384, 0,
> 3758096384, 0, 268435456, 1124073472, 6, 0, 6, 0, 2, 0] is too long
>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>
> I have seen one conversation about it but don't have link which I can poi=
nt
> to.
> ---
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts=
/xilinx/zynqmp.dtsi
> index 771f60e0346d..98073f3223e5 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -542,8 +542,8 @@ pcie: pcie@fd0e0000 {
>                               <0x0 0xfd480000 0x0 0x1000>,
>                               <0x80 0x00000000 0x0 0x1000000>;
>                         reg-names =3D "breg", "pcireg", "cfg";
> -                       ranges =3D <0x02000000 0x00000000 0xe0000000 0x00=
000000 0xe0000000 0x00000000 0x10000000  /* non-prefetchable memory */
> -                                 0x43000000 0x00000006 0x00000000 0x0000=
0006 0x00000000 0x00000002 0x00000000>;/* prefetchable memory */
> +                       ranges =3D <0x02000000 0x00000000 0xe0000000 0x00=
000000 0xe0000000 0x00000000 0x10000000>,/* non-prefetchable memory */
> +                                <0x43000000 0x00000006 0x00000000 0x0000=
0006 0x00000000 0x00000002 0x00000000>;/* prefetchable memory */
>                         bus-range =3D <0x00 0xff>;
>                         interrupt-map-mask =3D <0x0 0x0 0x0 0x7>;
>                         interrupt-map =3D <0x0 0x0 0x0 0x1 &pcie_intc 0x1=
>,
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
