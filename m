Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D55128AE6D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 08:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgJLGxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 02:53:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:43528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726363AbgJLGw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 02:52:57 -0400
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C72420757;
        Mon, 12 Oct 2020 06:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602485576;
        bh=VcoPrFYGRrVs/edsst5tXJ1r1Y245Ir/p9Cq897BJvM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=a1LeWFIYksoBOiGqgcGXGCUlfDzn76wyLLOOitZF2gTrsX03EWPzAjAawY/RUSoIX
         ZUU+WH+521SNu4krNHIVzNTPhDUqu2lHYiW1mu4I8xQvn+l6sDdr9hHqynmqLLc/LP
         zfnxOYA4NJZ9/1gF2aukNiEYX6FdpIAtqhQILXLk=
Received: by mail-ej1-f42.google.com with SMTP id lw21so21655578ejb.6;
        Sun, 11 Oct 2020 23:52:56 -0700 (PDT)
X-Gm-Message-State: AOAM531kwiKUwT2ozfR0ZUcNfVlJ/gaSOcxv7xOeR/S2eovi3AMCkrcr
        qTDx2ngALw6zDgYSU9NVSqGeavGu7+2K2Lk7YUk=
X-Google-Smtp-Source: ABdhPJxTerAC+l0eWBQXcoYZNr8qxgpFCzY8zq8tWwY1txLt4b4icsuCDF5TCXHvwyDZIwzYV+VWTH3i8skBhSiZpgo=
X-Received: by 2002:a17:906:8401:: with SMTP id n1mr25466215ejx.215.1602485574591;
 Sun, 11 Oct 2020 23:52:54 -0700 (PDT)
MIME-Version: 1.0
References: <1602229667-13165-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1602229667-13165-1-git-send-email-Anson.Huang@nxp.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 12 Oct 2020 08:52:42 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdwsoN1Dnqs9gZTibqoy5vRTPwpLLmohHoguSCiq+UWHA@mail.gmail.com>
Message-ID: <CAJKOXPdwsoN1Dnqs9gZTibqoy5vRTPwpLLmohHoguSCiq+UWHA@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm64: dts: imx8mm: Correct WDOG_B pin configuration
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, aford173@gmail.com,
        daniel.baluta@nxp.com, shengjiu.wang@nxp.com, peter.chen@nxp.com,
        alifer.wsdm@gmail.com, abel.vesa@nxp.com, yibin.gong@nxp.com,
        jun.li@nxp.com, l.stach@pengutronix.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-imx@nxp.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Oct 2020 at 09:52, Anson Huang <Anson.Huang@nxp.com> wrote:
>
> Different revision of i.MX8MM EVK boards may have different external
> pull up registor design, some are enabled while some are NOT, to make
> sure the WDOG_B pin works properly, better to enable internal pull up
> resistor. Since enabling internal pull up resistor is NOT harmful and
> having benefit of flexibility on different board design, just enable
> it for all i.MX8MM boards.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi | 2 +-
>  arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi        | 2 +-
>  arch/arm64/boot/dts/freescale/imx8mm-var-som.dtsi    | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
> index 6de86a4..a941301 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
> @@ -398,7 +398,7 @@
>
>                 pinctrl_wdog: wdoggrp {
>                         fsl,pins = <
> -                               MX8MM_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B            0xc6
> +                               MX8MM_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B            0x166

Enabling pull up makes sense but you change other bits - disable
Schmitt input and enable open drain. This change is not documented /
explained in commit msg.

Best regards,
Krzysztof
