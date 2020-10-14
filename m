Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15BF828E4D3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 18:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388406AbgJNQul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 12:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727440AbgJNQuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 12:50:40 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3AAC061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 09:50:39 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id v6so155772lfa.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 09:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wuBPfResUSYyKIfZ5ftJfMdcgNsOdysiwgfFsxwVLOk=;
        b=Up9k1hmuJ3kQYCc/XiiZHeN6dxC3+Bt4DXTUrZ0NInm0Fv3mzKgsGybP05RAJynIda
         wcRLSsd72x7Z10Br5P7MB+uj08NwnOnz4n+UuiHKT9qmbalwarQbSv1POTDEGTi+WWlQ
         Py4YTDI4zmSAjy6qGOi1NgBJDRqd+sy9wEldc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wuBPfResUSYyKIfZ5ftJfMdcgNsOdysiwgfFsxwVLOk=;
        b=M+fFSSds7AcaTNKjJjkZyqxq0N1+hiwt0PnNRiBWbJgvWjZxIi8ghJiv0SkD54mzm2
         sXRqKqq4g5RsWCmJyh/Jsin0HS8YDhmfSqM/MUDDXSR/FgY2LRNQZO790Tw2AP7ZApJj
         vnlSEDgOzCzC3lXdzY0fUcWHQECPxdmWCLpBp8YbiNyHICnF3q8bUedRcTsb8n8WRv6h
         tWuw1rF7xaEBBZyDLX+JQ2Y0+i0jh0Ht5RwAIjCKTqtutGLZnk+OUqcqRiNvRPCSWb8M
         v+m9Ob9nzDKq0d0EgTYubN+svz+84hUMEuy7CqkLqMhmju/JJDMTgp+tx/QQFfW6ERio
         UmrA==
X-Gm-Message-State: AOAM531eKmhqk/PCqko28l2HQOE0FxggfEViHteoveqhuJhRW33HgYWL
        FkN5Hj/FXJZuwjVWos2sZv6Xz4/L4Ppt6w==
X-Google-Smtp-Source: ABdhPJwH1dqMkt83QJXz5cPj4Wu8loTGPXbKvrUicGq0W2SmdsV9tlZlnRtVv6yy6g065JwxqVRRlg==
X-Received: by 2002:a19:c1ce:: with SMTP id r197mr87180lff.266.1602694236914;
        Wed, 14 Oct 2020 09:50:36 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id m132sm1342823lfa.34.2020.10.14.09.50.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2020 09:50:36 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id m20so169334ljj.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 09:50:36 -0700 (PDT)
X-Received: by 2002:adf:f1cd:: with SMTP id z13mr6554663wro.197.1602693817757;
 Wed, 14 Oct 2020 09:43:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200722155533.252844-1-helen.koike@collabora.com>
 <20200722155533.252844-9-helen.koike@collabora.com> <20200926130005.GC3781977@chromium.org>
 <905118dd-f108-6bc0-4cf0-9544fab51690@collabora.com>
In-Reply-To: <905118dd-f108-6bc0-4cf0-9544fab51690@collabora.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 14 Oct 2020 18:43:25 +0200
X-Gmail-Original-Message-ID: <CAAFQd5C4BcXyee58DpL4TfVJmaLQ-58_mwQucEm-df899va2Lw@mail.gmail.com>
Message-ID: <CAAFQd5C4BcXyee58DpL4TfVJmaLQ-58_mwQucEm-df899va2Lw@mail.gmail.com>
Subject: Re: [PATCH v5 8/9] arm64: dts: rockchip: add isp0 node for rk3399
To:     Helen Koike <helen.koike@collabora.com>
Cc:     linux-devicetree <devicetree@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devel@driverdev.osuosl.org, Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>, kernel@collabora.com,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Mark Rutland <mark.rutland@arm.com>, karthik.poduval@gmail.com,
        jbx6244@gmail.com, Eddie Cai <eddie.cai.linux@gmail.com>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 6:27 PM Helen Koike <helen.koike@collabora.com> wrote:
>
> Hi Tomasz,
>
> On 9/26/20 10:00 AM, Tomasz Figa wrote:
> > Hi Helen,
> >
> > On Wed, Jul 22, 2020 at 12:55:32PM -0300, Helen Koike wrote:
> >> From: Shunqian Zheng <zhengsq@rock-chips.com>
> >>
> >> RK3399 has two ISPs, but only isp0 was tested.
> >> Add isp0 node in rk3399 dtsi
> >>
> >> Verified with:
> >> make ARCH=arm64 dtbs_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/media/rockchip-isp1.yaml
> >>
> >> Signed-off-by: Shunqian Zheng <zhengsq@rock-chips.com>
> >> Signed-off-by: Jacob Chen <jacob2.chen@rock-chips.com>
> >> Signed-off-by: Helen Koike <helen.koike@collabora.com>
> >>
> >> ---
> >>
> >> V4:
> >> - update clock names
> >>
> >> V3:
> >> - clean up clocks
> >>
> >> V2:
> >> - re-order power-domains property
> >>
> >> V1:
> >> This patch was originally part of this patchset:
> >>
> >>     https://patchwork.kernel.org/patch/10267431/
> >>
> >> The only difference is:
> >> - add phy properties
> >> - add ports
> >> ---
> >>  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 25 ++++++++++++++++++++++++
> >>  1 file changed, 25 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> >> index dba9641947a3a..ed8ba75dbbce8 100644
> >> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> >> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> >> @@ -1721,6 +1721,31 @@ vopb_mmu: iommu@ff903f00 {
> >>              status = "disabled";
> >>      };
> >>
> >> +    isp0: isp0@ff910000 {
> >> +            compatible = "rockchip,rk3399-cif-isp";
> >> +            reg = <0x0 0xff910000 0x0 0x4000>;
> >> +            interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH 0>;
> >> +            clocks = <&cru SCLK_ISP0>,
> >> +                     <&cru ACLK_ISP0_WRAPPER>,
> >> +                     <&cru HCLK_ISP0_WRAPPER>;
> >> +            clock-names = "isp", "aclk", "hclk";
> >> +            iommus = <&isp0_mmu>;
> >> +            phys = <&mipi_dphy_rx0>;
> >> +            phy-names = "dphy";
> >> +            power-domains = <&power RK3399_PD_ISP0>;
> >
> > Should this have status = "disabled" too? The mipi_dphy_rx0 node is
> > disabled by default too, so in the default configuration the driver
> > would always fail to probe.
>
> I'm thinking what is the overall guideline here.
> Since isp and mipi_dphy are always present in the rk3399, shouldn't they always be enabled?
> Or since they are only useful if a sensor is present, we should let the dts of the board to
> enable it?

I don't have a strong opinion. I'm fine with enabling both by default
as well, as it shouldn't hurt.

That said, I recall some alternative CIF IP block being present on
this SoC as well (and patches posted recently), which AFAIR can't be
activated at the same time as the ISP, so perhaps both of the
alternatives should be disabled by default?

Best regards,
Tomasz
