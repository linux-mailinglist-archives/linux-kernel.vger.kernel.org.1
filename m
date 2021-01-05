Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0031D2EAB2C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 13:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728919AbhAEMtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 07:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbhAEMtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 07:49:05 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF44C061574;
        Tue,  5 Jan 2021 04:48:25 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id q137so28033018iod.9;
        Tue, 05 Jan 2021 04:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CCTyf1sf2ZU7h0cZkeoRQ1POMJK2PzlWyw0VjZ882R0=;
        b=LNb2SJ/6IKS1JI2IAIJzBNognHzy8pNMScBDz392rTPu3OyZxNZStZXmpSq+K1/Fyh
         v+kxUmGcDuPXpa4etSFLIBtXEkGYoO50D+wQyY6kDdF+FTSA8lQbRd6mozjFhAbSnFPC
         q/U4FidfqfI7tRnsGMgJBlbVMwK7D6tKfkxgL7Iv1CTg5lpGY58UWh9x0JURGYTxi9FS
         LVJmRQpPrz89l4m52Uq2w57e42C4bQXHmBPU0djON2BEj2i7BTvkv7QqKEo/1rRMH5N7
         wWu7nFUmye2/of/14PWepW+MUV1q/6SmOXEJsJ9roV/gF0QEhzACt8qsRbx5g13GDdNx
         Z/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CCTyf1sf2ZU7h0cZkeoRQ1POMJK2PzlWyw0VjZ882R0=;
        b=Cxc5ySq4t7oLKi6PivwJhf537yk7uhJDPVIgIzsSDzwSAU/14n807tLB+pS4dT9aYm
         R9h5LRv7ZW95vrgFButkzrykDtbrKGDrKdJAFVScIK5MKzcqt1ZyGopBqvTR0J06tvHT
         Ae3WTejOijfjW/MM9Nngiuzf/xxT3bIKqUT6ph9meASCM4JZDVVeiTDE5inSoIYMcU5G
         2i3JmVxTFcS1MsdAgpZj3VytOXNrfF13au/hXXJNWx16Jh4M5TBOmDUfDSR9xNE4Z2SE
         SwPDGdYKARNJ8zATnhCcvmuE/2fmmD7jV4HEbL6wZYYMftH7x7FYySkFuLUXwgZKv+lu
         E/3g==
X-Gm-Message-State: AOAM532nRILoOgL/32T6dZMcxN949t4iBzZCtBtR/085zm0J3tiz05tZ
        XqLO0e9arU3u/hOUEgdIF+eowyOMTn3Zx/AJD1EgUm0X
X-Google-Smtp-Source: ABdhPJyGOGrjcyejMcrDu5EvsuKeaTBNFVKHaU8l74qNkF/Xo02ZNxPPYfivkyFMT99aFuslZk2q/Ft5edW37rlxkKk=
X-Received: by 2002:a5d:9a8e:: with SMTP id c14mr63948716iom.178.1609850904542;
 Tue, 05 Jan 2021 04:48:24 -0800 (PST)
MIME-Version: 1.0
References: <20201202135950.22164-1-aford173@gmail.com> <20210105030308.GK4142@dragon>
In-Reply-To: <20210105030308.GK4142@dragon>
From:   Adam Ford <aford173@gmail.com>
Date:   Tue, 5 Jan 2021 06:48:13 -0600
Message-ID: <CAHCN7xJV11LqTwsJ=3Xz9gxHAjRg0B37RnMWgcx3CWDT+DiJHg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mm-beacon: Fix WiFi Pinmuxing
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     arm-soc <linux-arm-kernel@lists.infradead.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 4, 2021 at 9:03 PM Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Wed, Dec 02, 2020 at 07:59:50AM -0600, Adam Ford wrote:
> > The WiFi chip is capable of communication at SDR104 speeds, and
> > the pinmux was configured to support this, but the sdhc1 controller
> > didn't properly reference the pinmux.  Enable 100Mhz and 200MHz pinmux
> > as was originally intended.
> >
> > Fixes: 593816fa2f35 ("arm64: dts: imx: Add Beacon i.MX8m-Mini development kit")
>
> This looks more like an improvement than bug fix.

Do you want me to resubmit without the fixes tag?

adam
>
> Shawn
>
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
> > index 6de86a4f0ec4..90fd15e95798 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
> > @@ -217,8 +217,10 @@
> >  &usdhc1 {
> >       #address-cells = <1>;
> >       #size-cells = <0>;
> > -     pinctrl-names = "default";
> > +     pinctrl-names = "default", "state_100mhz", "state_200mhz";
> >       pinctrl-0 = <&pinctrl_usdhc1>;
> > +     pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
> > +     pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
> >       bus-width = <4>;
> >       non-removable;
> >       cap-power-off-card;
> > --
> > 2.17.1
> >
