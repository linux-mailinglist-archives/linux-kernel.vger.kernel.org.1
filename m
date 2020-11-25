Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA052C4024
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 13:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729387AbgKYM2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 07:28:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729302AbgKYM2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 07:28:43 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C560C0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 04:28:43 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id m16so2367619edr.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 04:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7tKCW59S9tkeZMrBxE++iF0pY0CODmf4HaMU4TGx53c=;
        b=dg4K11RZfNeycfQ0q6kvqsBPy22ZKeSeQY74NBSBBvEpdb0jDOi+pjkHizrijcKWW2
         l+GKJGsJzeVP7kK9I4ERlN5Eq7JjBAqfcIoT29gKxRlj9XV1iwVOpNuKA+T/qfyKS/Wv
         GbMwxXQ2jcEQvaAcU1JO9Y6+QgWnfuhiEKCCUy9chAaFJng9hr0tkgcL8a1ny7MU1jAw
         +kHV9B1sVEhZtOSqnagDN/jtE4YekoIbLRKHG/vqe1RjJLyqSR5E9lJ9okoxjHVCEd0q
         aRIRHi3ie7cWK+406Ct7Om9Rp6YSwjs/9e+cXzmMujcOLPXAqj79d9yYLtAcoXh2+Z0U
         VLwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7tKCW59S9tkeZMrBxE++iF0pY0CODmf4HaMU4TGx53c=;
        b=WCbJ7rK21UKSEDh1fH842BWFLMV7phvXB2zxQ7L3De5Eze80VRa9qvtEY89Bb2HONn
         ePdepLqNXixJdMJXyFLZ9mpbPkN8pdMzCSFOxi3Bf0rcxJw7+Crn7AAio6ZEAb4q25Wy
         4ItfpC0mwAEFaPlw9GtRFYNOOCRq3iDBwN00VC/db24Z1FqfOiZiARq7wx8CexXjg2oC
         Lv5AL9vZexcYrWE/S+qqkS2bGIAvoLe2ZpIq8Wbng3p/kBjury8u2BBdIdQqN38z0iGn
         pYxHlWFD15s34wFL1KauHCvr6BK2MansjXVRttcSSFWng7+zAokpHklFZ8XSL3omU1ga
         SM/w==
X-Gm-Message-State: AOAM533AJqefcdxri2JQ5+yzV5JbENhCikhnL3mYNanLiJbYJ0+gNGGS
        3xho8lx1UYGXxKNZnlDWz9E0XcRu3dwHNZGZaS1bLVuCqbjnPQ==
X-Google-Smtp-Source: ABdhPJyABZxy4cXKJFrM84f8KC9j5weXhBw9rX4v1HPfA/pwFuq7kkn7UBXxa8Nn+JrsAa/ifUp8dGzYhDPf4Jlg7Is=
X-Received: by 2002:aa7:d545:: with SMTP id u5mr3179518edr.113.1606307321936;
 Wed, 25 Nov 2020 04:28:41 -0800 (PST)
MIME-Version: 1.0
References: <f767fe007e446a2299fda9905e75b723c650a424.1605021644.git.michal.simek@xilinx.com>
In-Reply-To: <f767fe007e446a2299fda9905e75b723c650a424.1605021644.git.michal.simek@xilinx.com>
From:   Michal Simek <monstr@monstr.eu>
Date:   Wed, 25 Nov 2020 13:28:30 +0100
Message-ID: <CAHTX3dJH88vLYqhYoKcMOBDMX62m1NKA16rKwbQyh5H+Q6o_PQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: zynqmp: Move gic node to axi bus
To:     LKML <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git <git@xilinx.com>
Cc:     Paul Thomas <pthomas8589@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Manish Narani <manish.narani@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C3=BAt 10. 11. 2020 v 16:20 odes=C3=ADlatel Michal Simek
<michal.simek@xilinx.com> napsal:
>
> The reason for this change is that after change from amba to axi U-Boot
> started to show error like:
> Unable to update property /axi/ethernet@ff0e0000:mac-address, err=3DFDT_E=
RR_NOTFOUND
> Unable to update property /axi/ethernet@ff0e0000:local-mac-address, err=
=3DFDT_ERR_NOTFOUND
>
> The reason is implementation in fdt_nodename_eq_() which is taken from dt=
c
> to the kernel and to the U-Boot. Especially DTC commit d2a9da045897 ("lib=
fdt:
> Make unit address optional for finding nodes") which is in DTC from 2007.
>
> The part of commit description is
> "   This is contrary to traditional OF-like finddevice() behaviour, which
>     allows the unit address to be omitted (which is useful when the devic=
e
>     name is unambiguous without the address)."
>
> The kernel commit dfff9066e60e ("arm64: dts: zynqmp: Rename buses to be
> align with simple-bus yaml") changed amba-apu/amba to axi@0/axi but
> fdt_nodename_eq_() detects /axi/ as match for /axi@0/ because of commit
> above.
>
> That's why it easier to fix one DT inside the kernel by moving GIC node
> from own bus to generic axi bus as is done by others SoCs. This will avoi=
d
> incorrect match because the unit address is omitted.
>
> Reported-by: Paul Thomas <pthomas8589@gmail.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 31 ++++++++++----------------
>  1 file changed, 12 insertions(+), 19 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts=
/xilinx/zynqmp.dtsi
> index 771f60e0346d..515b15ed634a 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -182,25 +182,6 @@ fpga_full: fpga-full {
>                 ranges;
>         };
>
> -       amba_apu: axi@0 {
> -               compatible =3D "simple-bus";
> -               #address-cells =3D <2>;
> -               #size-cells =3D <1>;
> -               ranges =3D <0 0 0 0 0xffffffff>;
> -
> -               gic: interrupt-controller@f9010000 {
> -                       compatible =3D "arm,gic-400";
> -                       #interrupt-cells =3D <3>;
> -                       reg =3D <0x0 0xf9010000 0x10000>,
> -                             <0x0 0xf9020000 0x20000>,
> -                             <0x0 0xf9040000 0x20000>,
> -                             <0x0 0xf9060000 0x20000>;
> -                       interrupt-controller;
> -                       interrupt-parent =3D <&gic>;
> -                       interrupts =3D <1 9 0xf04>;
> -               };
> -       };
> -
>         amba: axi {
>                 compatible =3D "simple-bus";
>                 #address-cells =3D <2>;
> @@ -339,6 +320,18 @@ fpd_dma_chan8: dma@fd570000 {
>                         power-domains =3D <&zynqmp_firmware PD_GDMA>;
>                 };
>
> +               gic: interrupt-controller@f9010000 {
> +                       compatible =3D "arm,gic-400";
> +                       #interrupt-cells =3D <3>;
> +                       reg =3D <0x0 0xf9010000 0x0 0x10000>,
> +                             <0x0 0xf9020000 0x0 0x20000>,
> +                             <0x0 0xf9040000 0x0 0x20000>,
> +                             <0x0 0xf9060000 0x0 0x20000>;
> +                       interrupt-controller;
> +                       interrupt-parent =3D <&gic>;
> +                       interrupts =3D <1 9 0xf04>;
> +               };
> +
>                 /* LPDDMA default allows only secured access. inorder to =
enable
>                  * These dma channels, Users should ensure that these dma
>                  * Channels are allowed for non secure access.
> --
> 2.29.2
>

Applied.
M

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
