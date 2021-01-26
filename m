Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5CA3040A8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 15:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405884AbhAZOlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 09:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732678AbhAZJqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 04:46:19 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76328C0613ED
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 01:45:39 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id p72so32297170iod.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 01:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gOpOeDQD5Go0RVdYH+VTIlpj6PaHDPuBI8q5wmtvzOg=;
        b=a/A3cexkUnnDK9ZGgLuDOiFeuS+vxOSHuV5qBm86n6bj7xrnraMi3lnPjJd+omzfQf
         ZZZJt6XGrtQfM4dt9ayuEt/FSgLWtchFjtyWb7RGBakPyB5XvS4Xr/z0+E64Qp+QeQnK
         SUXcThrcTB+zRAIaJwMt0thW39vuy545z6BmH7kL40MgX8tjWqB1A3S2Fr7IRDbHc+m3
         60Un2PWCjqF26G1DYTjcnRgXAtZIfg9Cm355tqzqL4h0Q+HvvH8xGxn8pjYxsfXSvPxP
         GSW2juxe7LX+p9GPNzrob4nXHZ3KSbmp1079QEQQudHQU2/vmPmdcocu7ALiLR8AU7el
         s5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gOpOeDQD5Go0RVdYH+VTIlpj6PaHDPuBI8q5wmtvzOg=;
        b=EQY4D468NwAs2YM6rjvMs7ClQKqo/J5JhEbBZmw+RQCk61kVfTbTSGAisyhJ5wlC/8
         g7eJ5JQ03pDFSlBeYLNo1cKOuXb9T9xGtn5dyh/VPrkJ3BcM2vKcp7gQo97OKffn4t9M
         md85z/KrswQDWg1yGtMIhJzBw1ttAJYWIOYp7RWMeHQAwh0f3/NxkrLqxAjcx7BG4odx
         csjSJnKlSUTPkzSjPyPHSsy+idb0ZBgQpM+4PC2biq/gL1pOXt9F5A9hMtVNfHjbLbIv
         RcqeZItabNvFZ+wmDvHWa+NNwXb2a/2QlgzVbcXNk/dKz4t9VW+aomNBI8eNPtVEq+N+
         8a4g==
X-Gm-Message-State: AOAM533k1ZWwh46qBT0spSbTHYa73qy60rEbpGqh36c+FL71VlbEDL3p
        v2DQZDtvPtsdUKF1Q6wLya4EYZQy1ua5uv5C8rDGnA==
X-Google-Smtp-Source: ABdhPJwGarMzyBQLp8/ym6smCnWYbz228goyl9dzwfGe6sTozFenoI0EWqNvfXUwR6ErJUVwjROTsxnSZKni/0czFNc=
X-Received: by 2002:a92:cda1:: with SMTP id g1mr3864461ild.267.1611654338730;
 Tue, 26 Jan 2021 01:45:38 -0800 (PST)
MIME-Version: 1.0
References: <20200907101937.10155-1-robert.marko@sartura.hr> <YA72ufb10QEZc5VH@builder.lan>
In-Reply-To: <YA72ufb10QEZc5VH@builder.lan>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Tue, 26 Jan 2021 10:45:28 +0100
Message-ID: <CA+HBbNHiya-4bbOr_iMbJXNaZ-e-+GfsJm3S7H8Y+ZD_=f7gyQ@mail.gmail.com>
Subject: Re: [PATCH] arm: dts: IPQ4019: add SDHCI VQMMC LDO node
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, robh+dt@kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luka Perkov <luka.perkov@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 5:50 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Mon 07 Sep 05:19 CDT 2020, Robert Marko wrote:
>
> > Since we now have driver for the SDHCI VQMMC LDO needed
> > for I/0 voltage levels lets introduce the necessary node for it.
> >
> > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > Cc: Luka Perkov <luka.perkov@sartura.hr>
> > ---
> >  arch/arm/boot/dts/qcom-ipq4019.dtsi | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
> > index 6741a1972e55..7774dbd3cec7 100644
> > --- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
> > +++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
> > @@ -211,6 +211,16 @@ tlmm: pinctrl@1000000 {
> >                       interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
> >               };
> >
> > +             vqmmc: regulator@1948000 {
> > +                     compatible = "qcom,vqmmc-ipq4019-regulator";
> > +                     reg = <0x01948000 0x4>;
>
> The actual hardware block where this register is found is the "TCSR"
> which is 0x01947000 of size 0x21000 - making this the register at offset
> 0x11000.
>
> Perhaps it would have been better represented as a simple-mfd with this
> regulator as a child node thereof.
>
>
> That said, this has been sitting long enough, so I'll merge it as is and
> we can rework it once we need more pieces of tcsr.

Thanks,
I was unaware that it is part of TCSR as I don't have datasheets
and this was ported from multiple versions of the downstream driver.

Regards,
Robert
>
> Thanks,
> Bjorn
>
> > +                     regulator-name = "vqmmc";
> > +                     regulator-min-microvolt = <1500000>;
> > +                     regulator-max-microvolt = <3000000>;
> > +                     regulator-always-on;
> > +                     status = "disabled";
> > +             };
> > +
> >               sdhci: sdhci@7824900 {
> >                       compatible = "qcom,sdhci-msm-v4";
> >                       reg = <0x7824900 0x11c>, <0x7824000 0x800>;
> > --
> > 2.26.2
> >
