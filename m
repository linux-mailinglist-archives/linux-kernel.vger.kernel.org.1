Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 593342FE767
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 11:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbhAUKTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 05:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729092AbhAUKS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 05:18:27 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56DDC061757
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 02:17:46 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id d22so1808990edy.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 02:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RD/8ns8LC0PdbNWt+iQG/KV2R5v83Sdo9CyiF4bWX1o=;
        b=vf5Jbu/q5u7SHlc4hZuiryXWtFKPfUFP+bZ3uqbgPYpdThKM6PeiFDtm3XSaqfM/da
         6cEK56z+I7PBPiHlgyInHRJy+T3ZxrE5XGHWK3FoBuTSGr1amVlZCEN5G9e509Em8fp/
         aVy4ldv+lK/7wOc2TUUj4c+eeFd1O8pXnQqFGh7xOs3qWXrt/wpx4hAZHTkRs4hPp6WI
         ENCxzR8T/G6Gq06iD/pxtGB+WGz0kWzQZLjIaKN/FqZmGkIy9rdr0/CE/71yqzYDGp7M
         n/SxSoAXoUIn48J3NGOXFQfmLpXueEYEzEOQdPK1PNfkl0bNKNtkgcnRlcGM51Epb5Jg
         T9uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RD/8ns8LC0PdbNWt+iQG/KV2R5v83Sdo9CyiF4bWX1o=;
        b=ma08Py58VlkKOoW3hGWLjGhccyLIvdbP9pf10UcrZVcZPFA89J1H9lFTSdYHbiziMT
         ToVKwqaiJUnmldvCAvd9aw99kOiPT32jQAAbVEKfYZ60ymJMrA/zt9nNyVsiS40Ii1sJ
         DAnuQK4SD2UI+b2qSIPujd6G//fSf9ozUEmeigiuaElgA/haUb/1xvzZpEVFRlNanOA+
         omRp/jEmfHTrRGhRINEJrF8vyYjMsT0KGbGmZmWuM8MTt2KQgy2pra9zf3vp7FmJmvr2
         Smhf2JwT2tKSTlDLvqhV6w3kcyTxPISp0fCREmK7dZp0Tn+exuH9mvfDRnpnWJ2GRejB
         pLqA==
X-Gm-Message-State: AOAM531ZSaS4GflWwZUxtQAOBjHNA6p6FbOKp/1GIPqjnMwPfktNdpu/
        it+XJXp9GYpBECb5M3r0doNHl+rdwmRvtH21BuVucy9tZhpLjQ==
X-Google-Smtp-Source: ABdhPJxI3jGQxl+dd58Z+ityvuWkj1UAYYO/jX7lXr/vGjwCCTSkE0EF1ZxzbObxO4A1IzUUFOqTovb8ayXFoLT3XRY=
X-Received: by 2002:a50:c94c:: with SMTP id p12mr4465602edh.154.1611224265265;
 Thu, 21 Jan 2021 02:17:45 -0800 (PST)
MIME-Version: 1.0
References: <e4f54ddce33b79a783aa7c76e0dc6e9787933610.1606918493.git.michal.simek@xilinx.com>
In-Reply-To: <e4f54ddce33b79a783aa7c76e0dc6e9787933610.1606918493.git.michal.simek@xilinx.com>
From:   Michal Simek <monstr@monstr.eu>
Date:   Thu, 21 Jan 2021 11:17:34 +0100
Message-ID: <CAHTX3d+dubuetK634YnM3UM-ZFz8b6xCY8CxQ5FFCBoT+dVsWQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: zynqmp: Add address-cells property to
 interrupt controllers
To:     LKML <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git <git@xilinx.com>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Kalyani Akula <kalyani.akula@xilinx.com>,
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

st 2. 12. 2020 v 15:14 odes=C3=ADlatel Michal Simek <michal.simek@xilinx.co=
m> napsal:
>
> The commit 3eb619b2f7d8 ("scripts/dtc: Update to upstream version
> v1.6.0-11-g9d7888cbf19c") updated dtc version which also contained DTC
> commit
> "81e0919a3e21 checks: Add interrupt provider test"
> where reasons for this checking are mentioned as
> "A missing #address-cells property is less critical, but creates
> ambiguities when used in interrupt-map properties, so warn about this as
> well now."
>
> That's why add address-cells property to gic and gpio nodes to get rid of
> this warning.
>
> CC: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>
> I was grepping DTSes in the kernel and most of them list it as 0.
> In gicv3 case where its node is added it needs to be filled property that=
's
> why also non 0 values are there.
> Definitely please let me know if 0 is not the right value here.
>
> Based on https://lore.kernel.org/r/cover.1606917949.git.michal.simek@xili=
nx.com/
>
> ---
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts=
/xilinx/zynqmp.dtsi
> index 14a2e69cf98b..5b2051ac6965 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -368,6 +368,7 @@ fpd_dma_chan8: dma@fd570000 {
>
>                 gic: interrupt-controller@f9010000 {
>                         compatible =3D "arm,gic-400";
> +                       #address-cells =3D <0>;
>                         #interrupt-cells =3D <3>;
>                         reg =3D <0x0 0xf9010000 0x0 0x10000>,
>                               <0x0 0xf9020000 0x0 0x20000>,
> @@ -574,6 +575,7 @@ gem3: ethernet@ff0e0000 {
>                 gpio: gpio@ff0a0000 {
>                         compatible =3D "xlnx,zynqmp-gpio-1.0";
>                         status =3D "disabled";
> +                       #address-cells =3D <0>;
>                         #gpio-cells =3D <0x2>;
>                         gpio-controller;
>                         interrupt-parent =3D <&gic>;
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
