Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88C2B2CDB0D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 17:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389348AbgLCQV4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 3 Dec 2020 11:21:56 -0500
Received: from mail-lj1-f170.google.com ([209.85.208.170]:38664 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730647AbgLCQV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 11:21:56 -0500
Received: by mail-lj1-f170.google.com with SMTP id j10so3166948lja.5;
        Thu, 03 Dec 2020 08:21:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GDxZu8krGkmPz12TN2YLbqm9qi44Llf9RP8PVDYN3bI=;
        b=GKuTYjcb9TYeQbShn0CEar0HVImUmekIYCYltroa5hS/P7DI2awr8zFJUXjoU/ee/4
         4Zf9uOqeo4P1tRscw0SWdk3HgsMHsyz1lgdeNFRs/4V+TGhcF5vbr1AsnZ3CSwl/Gno3
         GRbhVmcgsO6HkOS5yKaURVFwwc+WhDleiO3nThaHHCDx7NtRJQhhT0YrAd3AbCuncn6a
         hQ1eWaW9jI+dO3LUHtLmf6dSCcT4f0OYM5+U2qfq7/mSNc8CjT/JTPzCbGTHLd4QDfGK
         08baFNlZrkHxzZG6tHw4EZb3j6t25lTG0UxXTb75aEa2wty0XpZHFC5DDWu7Vxplfw4S
         7aTQ==
X-Gm-Message-State: AOAM532Wy2oHovqDqF7IB99Yi7DtfdEq59ovLwd9kEef7FAO0GqmdrP+
        WI+Q9+x14D5Ocb3rHRgC3wf0VFPXZT7CYw==
X-Google-Smtp-Source: ABdhPJzz4/pe1rAX0i2hqMMe7UVELwTno/IOkK6JbQhlqmpRVIBEkN6eIDX6sDGhj3t7HGsAPr+MQg==
X-Received: by 2002:a2e:90c1:: with SMTP id o1mr1483211ljg.130.1607012471577;
        Thu, 03 Dec 2020 08:21:11 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id o9sm683844lff.271.2020.12.03.08.21.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Dec 2020 08:21:10 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id d8so3586757lfa.1;
        Thu, 03 Dec 2020 08:21:10 -0800 (PST)
X-Received: by 2002:a19:be85:: with SMTP id o127mr1553051lff.356.1607012470417;
 Thu, 03 Dec 2020 08:21:10 -0800 (PST)
MIME-Version: 1.0
References: <20201202135409.13683-1-andre.przywara@arm.com>
 <20201202135409.13683-8-andre.przywara@arm.com> <3b4f4bf6-2fba-5d35-bdf5-74b8ced10357@sholland.org>
 <34e5618e-4a3d-9a46-5077-179c82592fce@arm.com> <CAGb2v67+Bfhnw9hFv8vOLTOqmb-hoYxRnk4Q7CQZjzJbzkQxqg@mail.gmail.com>
 <3dc67c21-f649-cca5-ec54-c639c54ee56a@arm.com>
In-Reply-To: <3dc67c21-f649-cca5-ec54-c639c54ee56a@arm.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Fri, 4 Dec 2020 00:20:57 +0800
X-Gmail-Original-Message-ID: <CAGb2v65KL=Bsv-GC2FOt24wZRX3Ta+VQ44eeSs1Kt32EGBv+yg@mail.gmail.com>
Message-ID: <CAGb2v65KL=Bsv-GC2FOt24wZRX3Ta+VQ44eeSs1Kt32EGBv+yg@mail.gmail.com>
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

On Thu, Dec 3, 2020 at 11:45 PM André Przywara <andre.przywara@arm.com> wrote:
>
> On 03/12/2020 15:02, Chen-Yu Tsai wrote:
> > On Thu, Dec 3, 2020 at 6:54 PM André Przywara <andre.przywara@arm.com> wrote:
> >>
> >> On 03/12/2020 03:16, Samuel Holland wrote:
> >>
> >> Hi,
> >>
> >>> On 12/2/20 7:54 AM, Andre Przywara wrote:
> >>> ...
> >>>> +    soc {
> >>>> +            compatible = "simple-bus";
> >>>> +            #address-cells = <1>;
> >>>> +            #size-cells = <1>;
> >>>> +            ranges = <0x0 0x0 0x0 0x40000000>;
> >>>> +
> >>>> +            syscon: syscon@3000000 {
> >>>> +                    compatible = "allwinner,sun50i-h616-system-control",
> >>>> +                                 "allwinner,sun50i-a64-system-control";
> >>>> +                    reg = <0x03000000 0x1000>;
> >>>> +                    #address-cells = <1>;
> >>>> +                    #size-cells = <1>;
> >>>> +                    ranges;
> >>>> +
> >>>> +                    sram_c: sram@28000 {
> >>>> +                            compatible = "mmio-sram";
> >>>> +                            reg = <0x00028000 0x30000>;
> >>>> +                            #address-cells = <1>;
> >>>> +                            #size-cells = <1>;
> >>>> +                            ranges = <0 0x00028000 0x30000>;
> >>>> +                    };
> >>>> +
> >>>> +                    sram_c1: sram@1a00000 {
> >>>> +                            compatible = "mmio-sram";
> >>>> +                            reg = <0x01a00000 0x200000>;
> >>>> +                            #address-cells = <1>;
> >>>> +                            #size-cells = <1>;
> >>>> +                            ranges = <0 0x01a00000 0x200000>;
> >>>> +
> >>>> +                            ve_sram: sram-section@0 {
> >>>> +                                    compatible = "allwinner,sun50i-h616-sram-c1",
> >>>> +                                                 "allwinner,sun4i-a10-sram-c1";
> >>>> +                                    reg = <0x000000 0x200000>;
> >>>> +                            };
> >>>> +                    };
> >>>> +            };
> >>>
> >>> You mentioned that you could not find a SRAM A2. How were these SRAM ranges
> >>> verified? If you can load eGON.BT0 larger than 32 KiB, then presumably NBROM
> >>> uses SRAM C, and it is in the manual, but I see no mention of SRAM C1.
> >>
> >> The manual says that SRAM C *can* be used by "the system", at boot time,
> >> as long as it's configured correctly. I couldn't find any details on how
> >> to switch clock sources for SRAM C, and the manual stanza on this is
> >> quite gibberish. I presume it's configured either by BROM or by reset
> >> default this way. I think the idea is that the later users (VE, DE) take
> >> ownership at some point (which means we can't run any firmware in there).
> >> The BSP boot0 is 48KB already, so reaching into SRAM C, and the code
> >> itself heavily uses SRAM C (found by hacking boot0 to drop to FEL and
> >> inspecting the memory afterwards).
> >>
> >> For C1: I copied this name from the H6 .dtsi, the manual calls this
> >> "VE-SRAM", in both manuals, and the description looks identical there
> >> for both SoCs. I think this will be later used by the video engine, so I
> >> kept it in. The large size made me suspicious, and from former
> >> experiments it looks like being aliased to (parts of) SRAM C.
> >
> > I would just call it sram_ve or ve_sram. SRAM C1 would make more sense if
> > it were part of SRAM C, not the other way around.
>
> But isn't that what we do? "sram_c1" is just the node name alias used
> for the parent node. That is actually never referenced anywhere (in any
> of the the H6 .dts), so we can actually remove it, I guess.
> The actual SRAM section is called ve_sram already.

This is what I had in mind:

syscon: {
        sram_c: sram@28000 {
                compatible = "mmio-sram";
                reg = <0x00028000 0x30000>;
                #address-cells = <1>;
                #size-cells = <1>;
                ranges = <0 0x00028000 0x30000>;

                /* starting address might not be correct */
                sram_c_ve: sram-section@0 {
                        compatible = "allwinner,sun50i-h616-ve-sram-c",
                                     "allwinner,sun4i-a10-sram-c1";
                       /* 64 kiB borrowed from ve_sram */
                        reg = <0x0 0x10000>;
                };
        };

        ve_sram: sram@1a00000 {
                compatible = "mmio-sram";
                reg = <0x01a00000 0x200000>;
                #address-cells = <1>;
                #size-cells = <1>;
        };
};

Another variant, trying to describe the aliasing, though it seems
quite confusing:

syscon: {
        ve_sram: sram@1a00000 {
                compatible = "mmio-sram";
                reg = <0x01a00000 0x200000>;
                #address-cells = <1>;
                #size-cells = <1>;
                ranges;

                ve_sram_c: sram-section@28000 {
                        compatible = "allwinner,sun50i-h616-ve-sram-c",
                                     "allwinner,sun4i-a10-sram-c1";
                        reg = <0x28000 0x10000>;
                };
        };
};


Just out of curiosity, is the whole SRAM @1a00000 accessible by the CPU?
Does it require the system control SRAM bits to be set, or does that only
affect the portion that SRAM C "borrows"? If it isn't accessible to the
CPU at all, then we might as well not put it in the device tree.

> And I can't change the compatible name, for the fallback, at least.
>
> I can make the new compatible string read
> "allwinner,sun50i-h616-ve-sram", if that helps, but that would mean
> deviating from the H6 and other SoCs.

Matching what the documents say makes more sense to me.

Regards
ChenYu

> Cheers,
> Andre
>
>
> >
> > Also the sram-section node would make more sense if it were in sram_c, as
> > that is the part that gets switched around, not the full region @ 1a00000.
> >
> > ChenYu
> >
> >> Maybe some guys with more VE knowledge can shine some light on this?
> >>
> >> Cheers,
> >> Andre
> >>
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> To view this discussion on the web, visit https://groups.google.com/d/msgid/linux-sunxi/3dc67c21-f649-cca5-ec54-c639c54ee56a%40arm.com.
