Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 767AE2CD9C5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 16:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730989AbgLCPDc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 3 Dec 2020 10:03:32 -0500
Received: from mail-vs1-f49.google.com ([209.85.217.49]:37594 "EHLO
        mail-vs1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730838AbgLCPDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 10:03:32 -0500
Received: by mail-vs1-f49.google.com with SMTP id j140so1401692vsd.4;
        Thu, 03 Dec 2020 07:03:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2WaJxAlpW9TnndwUkLLX4Wv0ulKsbd7eJDXS4f4tvpU=;
        b=h5inxeScKSaoQEr9QHSI2f/iVBuDpQERLbSJbzyhKmYiRNEjAAHiPi46L9vK3DKtR9
         3TMNd+HUntGy8xWab43qoPMoyymsIwqEWF2pfGdXRxuZkTpL2yGy9f+BPLgP1TU9fm0B
         pxhhBtn/QXFPFG2K66P6WyghRYrD0iyvLYom/oDRAzQ6PxV2is+TI+xkzmAMMoHGv4Tg
         2Rx957nUPoT2HAXu7C0s9CZ6ySTvYZkapr+s9SKXVtUbxyQ4H6B5Y6vQcaAkvM02YyFp
         Wfk7kx+dOtgW4qrujJhep8pJ43rGlZcrCYpks2+9uaRG5IOqRy4G3CBxQ+jgBC8yoIVL
         iveQ==
X-Gm-Message-State: AOAM530Z6HmVTiURNJKp7EVU3IbW6Uw/v6c0wzhFa0nVif7OhwhQ+0N0
        L4/xd1LTxwmA2Bp2meVpOPOY4fODcxwPAA==
X-Google-Smtp-Source: ABdhPJzyPmY00Zd2q14rGNk3LziYu6A+dp1TwuYCA10/8mSquHywzD5IKZGU92wxRYu70p+zUGyPNQ==
X-Received: by 2002:a67:2901:: with SMTP id p1mr2500006vsp.43.1607007770083;
        Thu, 03 Dec 2020 07:02:50 -0800 (PST)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com. [209.85.221.178])
        by smtp.gmail.com with ESMTPSA id g194sm172054vkf.48.2020.12.03.07.02.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Dec 2020 07:02:46 -0800 (PST)
Received: by mail-vk1-f178.google.com with SMTP id e5so459064vkd.4;
        Thu, 03 Dec 2020 07:02:45 -0800 (PST)
X-Received: by 2002:ac5:c995:: with SMTP id e21mr2117725vkm.5.1607007764960;
 Thu, 03 Dec 2020 07:02:44 -0800 (PST)
MIME-Version: 1.0
References: <20201202135409.13683-1-andre.przywara@arm.com>
 <20201202135409.13683-8-andre.przywara@arm.com> <3b4f4bf6-2fba-5d35-bdf5-74b8ced10357@sholland.org>
 <34e5618e-4a3d-9a46-5077-179c82592fce@arm.com>
In-Reply-To: <34e5618e-4a3d-9a46-5077-179c82592fce@arm.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 3 Dec 2020 23:02:31 +0800
X-Gmail-Original-Message-ID: <CAGb2v67+Bfhnw9hFv8vOLTOqmb-hoYxRnk4Q7CQZjzJbzkQxqg@mail.gmail.com>
Message-ID: <CAGb2v67+Bfhnw9hFv8vOLTOqmb-hoYxRnk4Q7CQZjzJbzkQxqg@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH 7/8] arm64: dts: allwinner: Add
 Allwinner H616 .dtsi file
To:     =?UTF-8?Q?Andr=C3=A9_Przywara?= <andre.przywara@arm.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        devicetree <devicetree@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Rob Herring <robh+dt@kernel.org>,
        Icenowy Zheng <icenowy@aosc.xyz>,
        Yangtao Li <frank@allwinnertech.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 3, 2020 at 6:54 PM André Przywara <andre.przywara@arm.com> wrote:
>
> On 03/12/2020 03:16, Samuel Holland wrote:
>
> Hi,
>
> > On 12/2/20 7:54 AM, Andre Przywara wrote:
> > ...
> >> +    soc {
> >> +            compatible = "simple-bus";
> >> +            #address-cells = <1>;
> >> +            #size-cells = <1>;
> >> +            ranges = <0x0 0x0 0x0 0x40000000>;
> >> +
> >> +            syscon: syscon@3000000 {
> >> +                    compatible = "allwinner,sun50i-h616-system-control",
> >> +                                 "allwinner,sun50i-a64-system-control";
> >> +                    reg = <0x03000000 0x1000>;
> >> +                    #address-cells = <1>;
> >> +                    #size-cells = <1>;
> >> +                    ranges;
> >> +
> >> +                    sram_c: sram@28000 {
> >> +                            compatible = "mmio-sram";
> >> +                            reg = <0x00028000 0x30000>;
> >> +                            #address-cells = <1>;
> >> +                            #size-cells = <1>;
> >> +                            ranges = <0 0x00028000 0x30000>;
> >> +                    };
> >> +
> >> +                    sram_c1: sram@1a00000 {
> >> +                            compatible = "mmio-sram";
> >> +                            reg = <0x01a00000 0x200000>;
> >> +                            #address-cells = <1>;
> >> +                            #size-cells = <1>;
> >> +                            ranges = <0 0x01a00000 0x200000>;
> >> +
> >> +                            ve_sram: sram-section@0 {
> >> +                                    compatible = "allwinner,sun50i-h616-sram-c1",
> >> +                                                 "allwinner,sun4i-a10-sram-c1";
> >> +                                    reg = <0x000000 0x200000>;
> >> +                            };
> >> +                    };
> >> +            };
> >
> > You mentioned that you could not find a SRAM A2. How were these SRAM ranges
> > verified? If you can load eGON.BT0 larger than 32 KiB, then presumably NBROM
> > uses SRAM C, and it is in the manual, but I see no mention of SRAM C1.
>
> The manual says that SRAM C *can* be used by "the system", at boot time,
> as long as it's configured correctly. I couldn't find any details on how
> to switch clock sources for SRAM C, and the manual stanza on this is
> quite gibberish. I presume it's configured either by BROM or by reset
> default this way. I think the idea is that the later users (VE, DE) take
> ownership at some point (which means we can't run any firmware in there).
> The BSP boot0 is 48KB already, so reaching into SRAM C, and the code
> itself heavily uses SRAM C (found by hacking boot0 to drop to FEL and
> inspecting the memory afterwards).
>
> For C1: I copied this name from the H6 .dtsi, the manual calls this
> "VE-SRAM", in both manuals, and the description looks identical there
> for both SoCs. I think this will be later used by the video engine, so I
> kept it in. The large size made me suspicious, and from former
> experiments it looks like being aliased to (parts of) SRAM C.

I would just call it sram_ve or ve_sram. SRAM C1 would make more sense if
it were part of SRAM C, not the other way around.

Also the sram-section node would make more sense if it were in sram_c, as
that is the part that gets switched around, not the full region @ 1a00000.

ChenYu

> Maybe some guys with more VE knowledge can shine some light on this?
>
> Cheers,
> Andre
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> To view this discussion on the web, visit https://groups.google.com/d/msgid/linux-sunxi/34e5618e-4a3d-9a46-5077-179c82592fce%40arm.com.
