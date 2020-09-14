Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B21268354
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 06:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbgINEBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 00:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgINEBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 00:01:17 -0400
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [IPv6:2001:67c:2050::465:103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55539C06174A
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 21:01:15 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4BqXhv6PDgzKm5r;
        Mon, 14 Sep 2020 06:01:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :references:in-reply-to:message-id:subject:subject:from:from
        :date:date:received; s=mail20150812; t=1600056059; bh=u2N1iGQ5Ry
        rPoJ4wPSwEtNRozwsxBrBa8UjILKgriug=; b=SLaUl321hdh3LTbn4NFUmkBFCa
        V5NZ8DtBwd3Kn1kMyF/DjI8ZszH9uUIFfdY2iWINqqs2k4F5uz/kD+Uue+a421en
        chiWMlrhTZkQfpncPMiPNAHF++y6AzdvA6671e889DkY42P8E24LMj1Ig1yOmnzb
        qaeEB8MQOfKiXJDZJCrCZQggMtB5s28N6hu7qZ+NaFrijI8dgQfvq8SYu+3cue4a
        fXty6R687lW+t3g6IdLdq6LRxxBch7H90FSkc1/qLGW4C1u66p1kdcCUU1ROqNkF
        FGnk1yOlErdXvxm0FADjNRGqCDEG4lTZ18CpKeyS/CxGwnC/W6mAYnPgpbwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1600056061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xNcN5pFfS47S5v0FqgeoS7MCarmrBnGbcZV8cgQdMhs=;
        b=eNo/47UGdkFUqby2ALgADSSvj1bl4Di7od2GxoKeC+ToPneWy29Tw8o+Zdw8QZ8RvTIaHJ
        JV9Ky3WFHukJRxqRXpLSSxgEmKMZgfjliG4lgvNBMZ7yPVx3gGP2nefiJKYPt6BFDYw9Hn
        g2njcnds+oJN38YSdejR/uxNDI1D/MlqPSXiUjBSjxfWoEfrDhsl8Vjh82kjjciiPebkfS
        5VK/LhtwsDiwVlAzwVBb067e0f1f91+cjVJ354tpb7JtNQKg+g9WyytS5f+AWFCEwHKxSl
        CA0BM3QyrjL7WJLj1lQVKy8p/WuuyodnP1XYgJJYZ49bI9raLTQMqWoUU71QQQ==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id kxQbw5SoYGEu; Mon, 14 Sep 2020 06:00:59 +0200 (CEST)
Date:   Mon, 14 Sep 2020 06:00:56 +0200
From:   Wilken Gottwalt <wilken.gottwalt@mailbox.org>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH] dt-bindings: arm: sunxi: update H2+/H3 cpu clocks
Message-ID: <20200914060056.7c2edc1f@monster.powergraphx.local>
In-Reply-To: <20200909155307.pjlebalzo3jqqhfj@gilmour.lan>
References: <20200903100708.GA466735@monster.powergraphx.local>
        <20200909120859.yosl2vgs3rj34stu@gilmour.lan>
        <20200909155446.382cf06d@monster.powergraphx.local>
        <20200909155307.pjlebalzo3jqqhfj@gilmour.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -6.01 / 15.00 / 15.00
X-Rspamd-Queue-Id: 560DB14E4
X-Rspamd-UID: a23c4a
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Sep 2020 17:53:07 +0200
Maxime Ripard <maxime@cerno.tech> wrote:

> On Wed, Sep 09, 2020 at 03:54:46PM +0200, Wilken Gottwalt wrote:
> > On Wed, 9 Sep 2020 14:08:59 +0200
> > Maxime Ripard <maxime@cerno.tech> wrote:
> > > Hi!
> > > 
> > > Thanks for contributing
> > > 
> > > The prefix isn't right though.
> > > 
> > > dt-bindings is used when you're modifying the binding itself, ie the
> > > description of what the node is supposed to look like, not when you
> > > actually use that node in a DT.
> > > 
> > > In that case, that would be ARM: dts: sunxi:
> > > 
> > > (we're on the ARM architecture, modifying dts's, for the sunxi platform)
> > 
> > Ah, I see, it was my first attempt to contribute and wasn't 100% sure, just
> > took the line from similar patches on the LKML. Thanks for the correction.
> > 
> > > On Thu, Sep 03, 2020 at 12:07:08PM +0200, Wilken Gottwalt wrote:
> > > > Change H2+/H3 clocks to 8 steps from 528 MHz up to 1200 MHz to support a
> > > > more fine-grained powersave setup. The SoCs are made for 1296 MHz, so
> > > > these clocks are still in a safe range. Tested on a NanoPi Duo and
> > > > OrangePi Zero.
> > > 
> > > How was this tested?
> > 
> > This is a longer story. It actually runs on hardware which is in production
> > for about 2-3 years, some use H2+ with full voltage regulators and some are
> > similar to the NanoPi DUO, where the voltage regulator can only switch
> > between 1.1 and 1.3 volts. It runs in two ways: A fully dynamic setup where
> > the ondemand scheduler is used and the second way where it is switched to
> > fixed values (based on load and temperature) using the cpufrequtils. The
> > devices running a 4.14.x kernel and are tested against 4.19.x kernels.
> > These devices are routers running a custom tcp/ip stack and have a high I/O
> > load. I also prepared devices based on a custom H3 design, which ran stable
> > at 1.392 GHz (but had passive coolers attached). Do these explanations
> > help?
> 
> To some extent, but not entirely. Depending on the governor / workload,
> some OPPs might never be used at all.

I am aware of this and the devices had 24 hours burnin tests with a selfwritten
tool very similar to your posted cpuburn + scripts. I will try to run your
pointed out tool, but I may need some time for doing so. Getting a ruby
installation into this embedded Linux is not easy and a whole compiler won't
be possible at all. If you are interested I could put our test tool to github.

> > > cpufreq OPP misconfiguration on Allwinner SoCs has been known to create
> > > some errors that are fairly hard to spot and be quite easy to go
> > > unnoticed (like caches corruptions).
> > 
> > Yeah, I noticed that in the beginning where I prepared the first kernels
> > for these devices. But after switching to multiples of 48MHz and bigger
> > steps these issues disappeared. I'm aware that this does not proof that
> > these issues do not appear, but thougth I share the values which I
> > consider stable.
> 
> The only really reliable test we've had so far is the one I pointed out,
> so please run it on one board at least
> 
> > > The only reliable test we have is:
> > > https://github.com/ssvb/cpuburn-arm/blob/master/cpufreq-ljt-stress-test
> > > 
> > > > Signed-off-by: Wilken Gottwalt <wilken.gottwalt@mailbox.org>
> > > > ---
> > > >  arch/arm/boot/dts/sun8i-h3.dtsi | 34 +++++++++++++++++++++++++++++++--
> > > >  1 file changed, 32 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
> > > > index 4e89701df91f..5517fcc02b7d 100644
> > > > --- a/arch/arm/boot/dts/sun8i-h3.dtsi
> > > > +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
> > > > @@ -48,23 +48,53 @@ cpu0_opp_table: opp_table0 {
> > > >  		compatible = "operating-points-v2";
> > > >  		opp-shared;
> > > >  
> > > > -		opp-648000000 {
> > > > -			opp-hz = /bits/ 64 <648000000>;
> > > > +		opp-528000000 {
> > > > +			opp-hz = /bits/ 64 <528000000>;
> > > > +			opp-microvolt = <1020000 1020000 1300000>;
> > > > +			clock-latency-ns = <244144>; /* 8 32k periods */
> > > > +		};
> > > > +
> > > > +		opp-624000000 {
> > > > +			opp-hz = /bits/ 64 <624000000>;
> > > >  			opp-microvolt = <1040000 1040000 1300000>;
> > > >  			clock-latency-ns = <244144>; /* 8 32k periods */
> > > >  		};
> > > >  
> > > > +		opp-720000000 {
> > > > +			opp-hz = /bits/ 64 <720000000>;
> > > > +			opp-microvolt = <1060000 1060000 1300000>;
> > > > +			clock-latency-ns = <244144>; /* 8 32k periods */
> > > > +		};
> > > > +
> > > >  		opp-816000000 {
> > > >  			opp-hz = /bits/ 64 <816000000>;
> > > >  			opp-microvolt = <1100000 1100000 1300000>;
> > > >  			clock-latency-ns = <244144>; /* 8 32k periods */
> > > >  		};
> > > >  
> > > > +		opp-912000000 {
> > > > +			opp-hz = /bits/ 64 <912000000>;
> > > > +			opp-microvolt = <1140000 1140000 1300000>;
> > > > +			clock-latency-ns = <244144>; /* 8 32k periods */
> > > > +		};
> > > > +
> > > >  		opp-1008000000 {
> > > >  			opp-hz = /bits/ 64 <1008000000>;
> > > >  			opp-microvolt = <1200000 1200000 1300000>;
> > > >  			clock-latency-ns = <244144>; /* 8 32k periods */
> > > >  		};
> > > > +
> > > > +		opp-1104000000 {
> > > > +			opp-hz = /bits/ 64 <1104000000>;
> > > > +			opp-microvolt = <1240000 1240000 1300000>;
> > > > +			clock-latency-ns = <244144>; /* 8 32k periods */
> > > > +		};
> > > > +
> > > > +		opp-1200000000 {
> > > > +			opp-hz = /bits/ 64 <1200000000>;
> > > > +			opp-microvolt = <1300000 1300000 1300000>;
> > > > +			clock-latency-ns = <244144>; /* 8 32k periods */
> > > > +		};
> > > >  	};
> > > 
> > > IIRC U-Boot will start the CPU at 1008 MHz on the H3, so in the
> > > situation where a board doesn't list the regulators attached to the CPU,
> > > the kernel will happily use the 1104 and 1200 MHz frequencies, even
> > > though it won't adjust the voltage accordingly, causing errors.
> > 
> > Yeah, I know that. The u-boot running on the mentioned devices also have
> > these modifications, including a higher clocked DRAM (actually running at
> > 624 MHz).
> > 
> > > The way we worked around that is to provide the extra OOPs in a separate
> > > DTSI so that the boards with regulator support can opt-in.
> > 
> > Oh, did I overlooked something? I was working on 4.14 up to 4.19 kernels
> > and may be a bit to eager to post the modifications.
> 
> It's not really my point :)
> 
> My point is that since it's in the DTSI, every board using an H2/H3 will
> now get to use those OPPs, even if they don't have the regulator support
> and the voltage set for the highest frequency, so you can end up on
> those boards with the CPU running at 1.2GHz and the voltage associated
> to 1GHz

Yeah, I understand. So the solution would be to drop the two highest OPPs
or make these changes only for the tested devices. What would you prefer?

Will
