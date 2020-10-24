Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44925297E05
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 20:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1763928AbgJXSj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 14:39:28 -0400
Received: from relay5.mymailcheap.com ([159.100.248.207]:35910 "EHLO
        relay5.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762388AbgJXSj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 14:39:28 -0400
Received: from relay2.mymailcheap.com (relay2.mymailcheap.com [151.80.165.199])
        by relay5.mymailcheap.com (Postfix) with ESMTPS id 15CD8260EB;
        Sat, 24 Oct 2020 18:39:26 +0000 (UTC)
Received: from filter2.mymailcheap.com (filter2.mymailcheap.com [91.134.140.82])
        by relay2.mymailcheap.com (Postfix) with ESMTPS id C3B653EDFC;
        Sat, 24 Oct 2020 20:39:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by filter2.mymailcheap.com (Postfix) with ESMTP id A14A32A7E8;
        Sat, 24 Oct 2020 20:39:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1603564763;
        bh=ZMgbFiRedhTIRTbfEoY4V1pIM8O1cbU//OATnSZebF4=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=ASNI2OK02dOZtRHpDOAqB+SToMKJse2w/izxDgAza5tB1mRyFbytvDx30BQgxhEuR
         7wamDVo54Opz1FvE6W7+LY30WyX7Mu2elzpBFMz030UtkmrTivahW6wVoxWcBMG2H+
         sAOE8Iiqo5LWmQfW0iiU1hcCbT1B/dJoMRlSoeqQ=
X-Virus-Scanned: Debian amavisd-new at filter2.mymailcheap.com
Received: from filter2.mymailcheap.com ([127.0.0.1])
        by localhost (filter2.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Ofb3BrPE4lyR; Sat, 24 Oct 2020 20:39:22 +0200 (CEST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter2.mymailcheap.com (Postfix) with ESMTPS;
        Sat, 24 Oct 2020 20:39:22 +0200 (CEST)
Received: from [213.133.102.83] (ml.mymailcheap.com [213.133.102.83])
        by mail20.mymailcheap.com (Postfix) with ESMTP id 801ED400C0;
        Sat, 24 Oct 2020 18:39:21 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="IVZHaYP6";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from [172.19.0.1] (unknown [64.225.114.122])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id BF4D9400C0;
        Sat, 24 Oct 2020 18:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1603564755; bh=ZMgbFiRedhTIRTbfEoY4V1pIM8O1cbU//OATnSZebF4=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=IVZHaYP6UG3fsPOTBjnzMXsmqdcbviMgqQ0HV88aEODkW8TOLXKGyWbZsubBGRJP7
         vmlLPTjhlN9Wkt9SM2ZIa9vjSqEq3/smzzCgjpXjuEMn54SZAzoWsWqTAVLzO95Omu
         GamYU0Y3nw+XrK4AU171ZKbymKEl7qwciwpxtOh0=
Date:   Sun, 25 Oct 2020 02:39:05 +0800
User-Agent: K-9 Mail for Android
In-Reply-To: <2859076.BEgH6Mo0Pn@jernej-laptop>
References: <20201024162515.30032-1-wens@kernel.org> <20201024162515.30032-2-wens@kernel.org> <79894e1266db69e463ee74a52551101298cae03e.camel@aosc.io> <2859076.BEgH6Mo0Pn@jernej-laptop>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [linux-sunxi] [PATCH 02/10] ARM: dts: sun6i: a31-hummingbird: Enable RGMII RX/TX delay on Ethernet PHY
To:     jernej.skrabec@siol.net,
        =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@siol.net>,
        wens@kernel.org, Maxime Ripard <mripard@kernel.org>
CC:     linux-sunxi@googlegroups.com, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <9D317C52-5F28-41A9-80DA-DBADA142B042@aosc.io>
X-Rspamd-Queue-Id: 801ED400C0
X-Spamd-Result: default: False [1.40 / 10.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         ARC_NA(0.00)[];
         R_DKIM_ALLOW(0.00)[aosc.io:s=default];
         MID_RHS_MATCH_FROM(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(0.00)[aosc.io];
         R_SPF_SOFTFAIL(0.00)[~all];
         ML_SERVERS(-3.10)[213.133.102.83];
         DKIM_TRACE(0.00)[aosc.io:+];
         RCPT_COUNT_SEVEN(0.00)[9];
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



=E4=BA=8E 2020=E5=B9=B410=E6=9C=8825=E6=97=A5 GMT+08:00 =E4=B8=8A=E5=8D=88=
2:30:35, "Jernej =C5=A0krabec" <jernej=2Eskrabec@siol=2Enet> =E5=86=99=E5=
=88=B0:
>Dne sobota, 24=2E oktober 2020 ob 19:51:06 CEST je Icenowy Zheng
>napisal(a):
>> =E5=9C=A8 2020-10-25=E6=98=9F=E6=9C=9F=E6=97=A5=E7=9A=84 00:25 +0800=EF=
=BC=8CChen-Yu Tsai=E5=86=99=E9=81=93=EF=BC=9A
>>=20
>> > From: Chen-Yu Tsai <wens@csie=2Eorg>
>> >=20
>> > The Ethernet PHY on the A31 Hummingbird has the RX and TX delays
>> > enabled on the PHY, using pull-ups on the RXDLY and TXDLY pins=2E
>> >=20
>> > Fix the phy-mode description to correct reflect this so that the
>> > implementation doesn't reconfigure the delays incorrectly=2E This
>> > happened with commit bbc4d71d6354 ("net: phy: realtek: fix rtl8211e
>> > rx/tx delay config")=2E
>>=20
>> Personally I think they should revert this commit, and consider other
>> solution=2E
>>=20
>> This commit breaks everything=2E
>>=20
>
>Previously broken driver allowed inproper DT to work, so you have to
>fix=20
>everything eventually=2E

There is no "improper DT" if it's already shipped, DT should suffer driver
change, not changed to match driver=2E

I think at least Fedora tends to ship a DT with a system image that will
not get updated when kernel gets updated=2E

>
>Plus side, there is no need to have hack for Pine64 Plus ethernet
>anymore=2E
>
>Best regards,
>Jernej
>
>> (Although the patch on individual DT patches are technically correct)
>>=20
>> > Fixes: c220aec2bb79 ("ARM: dts: sun6i: Add Merrii A31 Hummingbird
>> > support")
>> > Signed-off-by: Chen-Yu Tsai <wens@csie=2Eorg>
>> > ---
>> >=20
>> >  arch/arm/boot/dts/sun6i-a31-hummingbird=2Edts | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >=20
>> > diff --git a/arch/arm/boot/dts/sun6i-a31-hummingbird=2Edts
>> > b/arch/arm/boot/dts/sun6i-a31-hummingbird=2Edts
>> > index 049e6ab3cf56=2E=2E73de34ae37fd 100644
>> > --- a/arch/arm/boot/dts/sun6i-a31-hummingbird=2Edts
>> > +++ b/arch/arm/boot/dts/sun6i-a31-hummingbird=2Edts
>> > @@ -154,7 +154,7 @@ &gmac {
>> >=20
>> >  	pinctrl-names =3D "default";
>> >  	pinctrl-0 =3D <&gmac_rgmii_pins>;
>> >  	phy-handle =3D <&phy1>;
>> >=20
>> > -	phy-mode =3D "rgmii";
>> > +	phy-mode =3D "rgmii-id";
>> >=20
>> >  	status =3D "okay";
>> > =20
>> >  };
