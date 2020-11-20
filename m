Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8A7C2BBA2C
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 00:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbgKTXaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 18:30:30 -0500
Received: from relay2.mymailcheap.com ([151.80.165.199]:54558 "EHLO
        relay2.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbgKTXa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 18:30:29 -0500
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com [149.56.130.247])
        by relay2.mymailcheap.com (Postfix) with ESMTPS id A3AD43EDEC;
        Sat, 21 Nov 2020 00:30:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by filter1.mymailcheap.com (Postfix) with ESMTP id D4E4E2A35F;
        Fri, 20 Nov 2020 18:30:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1605915024;
        bh=iR0cU9oltmHjm8/AfYrCgb5O58IorirptInirIsoOWk=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=uTwSzm4MibuVQOPj/8V/3Mlxx3cZa/RXOvVf4kzl2Da3S4blNak7vaXuIRhHFKFrA
         eihaCaEVkyfgRs2/HT92OUIOjJzg9hIecUDGDvUvbmHNSaDBJvBKEMK3ZAH8ZQYE7c
         2bsITRo7/O3sU4jL2KePs3PEXK0a/zl7bpy/llUw=
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
        by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KpSJFJO20zdW; Fri, 20 Nov 2020 18:30:23 -0500 (EST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter1.mymailcheap.com (Postfix) with ESMTPS;
        Fri, 20 Nov 2020 18:30:23 -0500 (EST)
Received: from [213.133.102.83] (ml.mymailcheap.com [213.133.102.83])
        by mail20.mymailcheap.com (Postfix) with ESMTP id D45DF41F66;
        Fri, 20 Nov 2020 23:30:21 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="AN7NFZQJ";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from [172.19.0.1] (unknown [64.225.114.122])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id 782CB41F66;
        Fri, 20 Nov 2020 23:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1605915016; bh=iR0cU9oltmHjm8/AfYrCgb5O58IorirptInirIsoOWk=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=AN7NFZQJxFPPntJbQj0j/eEbW4G5TvCjd/wcI3eb1IkmLSlNprQfY6dB8jIdwsD3A
         olnsOZ9p9VK4MXPK7mt7kMN372x6i15cExieyXrH1EqsTNV15lfNnexpQcih6IBNzd
         COAa1yHG7L86ZApz5tsCPFXQmtkdODwz7RrslJLc=
Date:   Sat, 21 Nov 2020 07:30:05 +0800
User-Agent: K-9 Mail for Android
In-Reply-To: <20201120155939.3ajmbny2pka2vsnf@gilmour>
References: <20201107124958.2222253-1-icenowy@aosc.io> <20201107125332.2223197-1-icenowy@aosc.io> <20201110103925.rbej5ueo2fefbmlp@gilmour.lan> <6175E674-E8BC-4199-8BE8-A983065C32D5@aosc.io> <20201116155508.364dg6ycklwylswe@gilmour.lan> <8FFC1A6C-9CA4-4F94-91C4-F111A7519979@aosc.io> <20201120155939.3ajmbny2pka2vsnf@gilmour>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [linux-sunxi] Re: [PATCH 3/3] arm64: allwinner: dts: a64: add DT for PineTab developer sample
To:     Maxime Ripard <maxime@cerno.tech>
CC:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <A8E91BA0-22FD-47F4-A5B2-A80A38FE9A0E@aosc.io>
X-Rspamd-Queue-Id: D45DF41F66
X-Spamd-Result: default: False [1.40 / 10.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         ARC_NA(0.00)[];
         R_DKIM_ALLOW(0.00)[aosc.io:s=default];
         MID_RHS_MATCH_FROM(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(0.00)[aosc.io];
         R_SPF_SOFTFAIL(0.00)[~all];
         ML_SERVERS(-3.10)[213.133.102.83];
         DKIM_TRACE(0.00)[aosc.io:+];
         RCPT_COUNT_SEVEN(0.00)[8];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:24940, ipnet:213.133.96.0/19, country:DE];
         RCVD_COUNT_TWO(0.00)[2];
         SUSPICIOUS_RECIPS(1.50)[];
         HFILTER_HELO_BAREIP(3.00)[213.133.102.83,1]
X-Rspamd-Server: mail20.mymailcheap.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



=E4=BA=8E 2020=E5=B9=B411=E6=9C=8820=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=88=
11:59:39, Maxime Ripard <maxime@cerno=2Etech> =E5=86=99=E5=88=B0:
>On Tue, Nov 17, 2020 at 02:36:48AM +0800, Icenowy Zheng wrote:
>>=20
>>=20
>> =E4=BA=8E 2020=E5=B9=B411=E6=9C=8816=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=
=8811:55:08, Maxime Ripard <maxime@cerno=2Etech>
>=E5=86=99=E5=88=B0:
>> >On Tue, Nov 10, 2020 at 06:41:37PM +0800, Icenowy Zheng wrote:
>> >>=20
>> >>=20
>> >> =E4=BA=8E 2020=E5=B9=B411=E6=9C=8810=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=
=8D=886:39:25, Maxime Ripard
><maxime@cerno=2Etech>
>> >=E5=86=99=E5=88=B0:
>> >> >On Sat, Nov 07, 2020 at 08:53:32PM +0800, Icenowy Zheng wrote:
>> >> >> Some developers received PineTab samples that used an old LCD
>> >panel=2E
>> >> >>=20
>> >> >> Add device tree for these samples=2E
>> >> >>=20
>> >> >> Signed-off-by: Icenowy Zheng <icenowy@aosc=2Eio>
>> >> >> ---
>> >> >>  arch/arm64/boot/dts/allwinner/Makefile        |  1 +
>> >> >>  =2E=2E=2E/dts/allwinner/sun50i-a64-pinetab-dev=2Edts  | 28
>> >> >+++++++++++++++++++
>> >> >>  2 files changed, 29 insertions(+)
>> >> >>  create mode 100644
>> >> >arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab-dev=2Edts
>> >> >>=20
>> >> >> diff --git a/arch/arm64/boot/dts/allwinner/Makefile
>> >> >b/arch/arm64/boot/dts/allwinner/Makefile
>> >> >> index 211d1e9d4701=2E=2Ea221dcebfad4 100644
>> >> >> --- a/arch/arm64/boot/dts/allwinner/Makefile
>> >> >> +++ b/arch/arm64/boot/dts/allwinner/Makefile
>> >> >> @@ -13,6 +13,7 @@ dtb-$(CONFIG_ARCH_SUNXI) +=3D
>> >> >sun50i-a64-pinephone-1=2E0=2Edtb
>> >> >>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a64-pinephone-1=2E1=2Edtb
>> >> >>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a64-pinephone-1=2E2=2Edtb
>> >> >>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a64-pinetab=2Edtb
>> >> >> +dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a64-pinetab-dev=2Edtb
>> >> >>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a64-sopine-baseboard=2Edtb
>> >> >>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a64-teres-i=2Edtb
>> >> >>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a100-allwinner-perf1=2Edtb
>> >> >> diff --git
>> >a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab-dev=2Edts
>> >> >b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab-dev=2Edts
>> >> >> new file mode 100644
>> >> >> index 000000000000=2E=2E3a4153890f3e
>> >> >> --- /dev/null
>> >> >> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab-dev=2Edts
>> >> >> @@ -0,0 +1,28 @@
>> >> >> +// SPDX-License-Identifier: (GPL-2=2E0+ OR MIT)
>> >> >> +/*
>> >> >> + * Copyright (C) 2020 Icenowy Zheng <icenowy@aosc=2Eio>
>> >> >> + *
>> >> >> + */
>> >> >> +
>> >> >> +/dts-v1/;
>> >> >> +
>> >> >> +#include "sun50i-a64-pinetab=2Edts"
>> >> >> +
>> >> >> +/ {
>> >> >> +	model =3D "PineTab Developer Sample";
>> >> >> +	compatible =3D "pine64,pinetab-dev", "allwinner,sun50i-a64";
>> >> >> +};
>> >> >
>> >> >Changing the DT and the compatible half-way through it isn't ok=2E
>> >Please
>> >> >add a new DT with the newer revision like we did for the
>pinephone
>> >>=20
>> >> We did this on Pine H64=2E
>> >
>> >What are you referring to? I couldn't find a commit where we did
>what
>> >you suggested in that patch to the pine H64=2E
>>=20
>> Oh the situation is complex=2E On Pine H64, we didn't specify anything
>at
>> start (which is the same here), the DT is originally version-neutral
>> but then transitioned to model B, then reverted to model A=2E Here the
>DT is always
>> for the sample=2E
>>=20
>> However, for Pine H64 there's model A/B names, but for PineTab
>there's no
>> any samples that are sold, thus except who got the samples, all
>PineTab
>> owners simply owns a "PineTab", not a "PineTab xxx version"=2E
>
>It's fairly simple really, we can't really predict the future, so any
>DT
>submitted is for the current version of whatever board there is=2E This
>is
>what we (somewhat messily) did for the PineH64, for the pinephone, or
>really any other board that has several revisions

Okay=2E But I'm not satisfied with a non-public sample occupies
the pinetab name=2E Is rename it to pinetab-dev and add a
pinetab-retail okay?

>
>Maxime
