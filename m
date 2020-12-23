Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 667AC2E1C12
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 13:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbgLWMHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 07:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgLWMHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 07:07:42 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DEEC0613D3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 04:07:01 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id g20so22556853ejb.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 04:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hjKQjuQoKD2q9gzo/lVA/yHzN3PsEkizr5B2xb2YIp4=;
        b=Om+TVYSLlUSRd9v/7enNjZ+qvVI7YBMFg2+Otq0uvS0ALs3h6MeZbZAmajWOdNmnb0
         CMAF1/L24nYQqpCVtx0bvEGBnhas0AAP3muts724MexC4LfmU+1zvBsrH/NP0CGXwew5
         1rFNC1+/aelZ9qP5qb5qkrfG5qUBr6VF67XKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hjKQjuQoKD2q9gzo/lVA/yHzN3PsEkizr5B2xb2YIp4=;
        b=LRPP1oEPxSU3VDKBVYx+zbqFQ3WOnHc8l8MlofDZQG4pJzPE1Kf8Cgr5MVAdO3QJx8
         5LC1Q/w45zP/wPVVw+FJQnplD+a34Vtz4aYc99JBcG3Xvo22Gro/GY0a62kb68RejawM
         jCxBV1sxwFJCg6gsq2DpB0zmbWLuXkE1usdJz9jH8ygP32mSo7c1djE+b3A/hsNG4smJ
         u9czeAu6KmEV4Z4HR73bkhd0jVGqMo5fLUapQPRijWJeOzs7RIDN/cBIkhbCflOEJHj7
         +6PiDFQBeeg007gEkmzkWrHHQqL7wWBjBIt+tv1h+r5PqGGyORQ164zE4O9JSjY+Zig9
         Ln/Q==
X-Gm-Message-State: AOAM530/tI6u3XOh73tbVsjDWOBvewHrN/347z+EzQFvHpO/iundGW9h
        55ZWJWNg7bpSAlB9Xj+m7EjhjVTftJqkzmq3FnCcCA==
X-Google-Smtp-Source: ABdhPJzx4HRDP+pH7MueBvvBYlfjpuVLflUi0cShbm5TTZfT7h0hDzahuGKg+YA5nPb/AjSKWikuUMRENBNsrYwQoaY=
X-Received: by 2002:a17:906:1c92:: with SMTP id g18mr17024396ejh.522.1608725220384;
 Wed, 23 Dec 2020 04:07:00 -0800 (PST)
MIME-Version: 1.0
References: <20201223110343.126638-1-jagan@amarulasolutions.com>
 <20201223110343.126638-5-jagan@amarulasolutions.com> <20201223115933.GC21091@kozik-lap>
In-Reply-To: <20201223115933.GC21091@kozik-lap>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Wed, 23 Dec 2020 17:36:49 +0530
Message-ID: <CAMty3ZA0zrHS_wVKm8gdqU1q5ONokoT7aG_MBcWtXTJK59Bozg@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] arm64: dts: imx8mm: Add Engicam i.Core MX8M Mini
 C.TOUCH 2.0
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Matteo Lisi <matteo.lisi@engicam.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 23, 2020 at 5:29 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Wed, Dec 23, 2020 at 04:33:41PM +0530, Jagan Teki wrote:
> > Engicam C.TOUCH 2.0 is an EDIMM compliant general purpose Carrier
> > board.
> >
> > Genaral features:
> > - Ethernet 10/100
> > - Wifi/BT
> > - USB Type A/OTG
> > - Audio Out
> > - CAN
> > - LVDS panel connector
> >
> > i.Core MX8M Mini is an EDIMM SoM based on NXP i.MX8M Mini from Engicam.
> >
> > i.Core MX8M Mini needs to mount on top of this Carrier board for
> > creating complete i.Core MX8M Mini C.TOUCH 2.0 board.
> >
> > Add support for it.
> >
> > Signed-off-by: Matteo Lisi <matteo.lisi@engicam.com>
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> > Changes for v3:
> > - don't maintain common nodes and include it, if no feature diff
> > Changes for v2:
> > - enabled fec1 node
> > - updated commit message
> > - dropped engicam from filename since it aligned with imx6 engicam
> >   dts files naming conventions.
> > - add i2c nodes
> > - fixed v1 comments
> >
> >  arch/arm64/boot/dts/freescale/Makefile        |  1 +
> >  .../dts/freescale/imx8mm-engicam-ctouch2.dtsi | 82 +++++++++++++++++++
> >  .../freescale/imx8mm-icore-mx8mm-ctouch2.dts  | 21 +++++
> >  3 files changed, 104 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-engicam-ctouch2.dtsi
>
> You split some common part to ctouch2.dtsi so it can be reused in
> multiple places. I saw so far only one usage, where are the others?

To be clear, ctouch2.dtsi not mean for common it is C.TOUCH2 carrier
board dtsi. The other carrier is C.TOUCH2 10.1" Open Frame(display),
since DSI is not yet mainlined, I didn't add this yet.

Jagan.
