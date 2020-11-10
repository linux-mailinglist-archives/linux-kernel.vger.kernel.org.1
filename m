Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD1F2AD3FA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 11:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgKJKmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 05:42:05 -0500
Received: from relay3.mymailcheap.com ([217.182.119.157]:58538 "EHLO
        relay3.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgKJKmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 05:42:04 -0500
Received: from filter2.mymailcheap.com (filter2.mymailcheap.com [91.134.140.82])
        by relay3.mymailcheap.com (Postfix) with ESMTPS id CCD443F207;
        Tue, 10 Nov 2020 11:42:00 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by filter2.mymailcheap.com (Postfix) with ESMTP id AEEA92A7EE;
        Tue, 10 Nov 2020 11:42:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1605004920;
        bh=tnNbkV5hJ1TlcMxRPyWz8QfirS3ipn1gcWeawuKN/JY=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=BZ2u5Ms+L5GiE8yN4WvSxIEZvo278Jn5swBamVzzkllk5Ke1pUQYoi+H1bh44IJ6u
         r6C/3dhdoYTogAKhBN1LgA4jkZqp8gyHFkVtfFSgk1kK5ByRI87bBYZkxF0f+BI+J0
         kKvAkyQE8LAIYwtyowJmt2Hn3DYb/6l1LNDbaCx8=
X-Virus-Scanned: Debian amavisd-new at filter2.mymailcheap.com
Received: from filter2.mymailcheap.com ([127.0.0.1])
        by localhost (filter2.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NHnQX8awu1RP; Tue, 10 Nov 2020 11:41:59 +0100 (CET)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter2.mymailcheap.com (Postfix) with ESMTPS;
        Tue, 10 Nov 2020 11:41:59 +0100 (CET)
Received: from [148.251.23.173] (ml.mymailcheap.com [148.251.23.173])
        by mail20.mymailcheap.com (Postfix) with ESMTP id 8BB3241F21;
        Tue, 10 Nov 2020 10:41:58 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="UjT5Tq0Q";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from [172.19.0.1] (unknown [64.225.114.122])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id 088A241F21;
        Tue, 10 Nov 2020 10:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1605004907; bh=tnNbkV5hJ1TlcMxRPyWz8QfirS3ipn1gcWeawuKN/JY=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=UjT5Tq0Q8Ap3Pq0tR2W3qI9/AzWxcJNiOVM7LviY09tCSxqOkdPIW4MkD+MTGHjur
         5vA2tK4N2COXg4MyxeZmlSMpb4HM2ig3+LerbFwDw9gd++ZAu31xH29Vs+HBRtbWf0
         kofm7Q54woQUzMbDTC4dHpX14YvBq8DG5MnZOZsI=
Date:   Tue, 10 Nov 2020 18:41:37 +0800
User-Agent: K-9 Mail for Android
In-Reply-To: <20201110103925.rbej5ueo2fefbmlp@gilmour.lan>
References: <20201107124958.2222253-1-icenowy@aosc.io> <20201107125332.2223197-1-icenowy@aosc.io> <20201110103925.rbej5ueo2fefbmlp@gilmour.lan>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3/3] arm64: allwinner: dts: a64: add DT for PineTab developer sample
To:     Maxime Ripard <maxime@cerno.tech>
CC:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <6175E674-E8BC-4199-8BE8-A983065C32D5@aosc.io>
X-Rspamd-Queue-Id: 8BB3241F21
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
         ML_SERVERS(-3.10)[148.251.23.173];
         DKIM_TRACE(0.00)[aosc.io:+];
         RCPT_COUNT_SEVEN(0.00)[8];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:24940, ipnet:148.251.0.0/16, country:DE];
         RCVD_COUNT_TWO(0.00)[2];
         SUSPICIOUS_RECIPS(1.50)[];
         HFILTER_HELO_BAREIP(3.00)[148.251.23.173,1]
X-Rspamd-Server: mail20.mymailcheap.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



=E4=BA=8E 2020=E5=B9=B411=E6=9C=8810=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=88=
6:39:25, Maxime Ripard <maxime@cerno=2Etech> =E5=86=99=E5=88=B0:
>On Sat, Nov 07, 2020 at 08:53:32PM +0800, Icenowy Zheng wrote:
>> Some developers received PineTab samples that used an old LCD panel=2E
>>=20
>> Add device tree for these samples=2E
>>=20
>> Signed-off-by: Icenowy Zheng <icenowy@aosc=2Eio>
>> ---
>>  arch/arm64/boot/dts/allwinner/Makefile        |  1 +
>>  =2E=2E=2E/dts/allwinner/sun50i-a64-pinetab-dev=2Edts  | 28
>+++++++++++++++++++
>>  2 files changed, 29 insertions(+)
>>  create mode 100644
>arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab-dev=2Edts
>>=20
>> diff --git a/arch/arm64/boot/dts/allwinner/Makefile
>b/arch/arm64/boot/dts/allwinner/Makefile
>> index 211d1e9d4701=2E=2Ea221dcebfad4 100644
>> --- a/arch/arm64/boot/dts/allwinner/Makefile
>> +++ b/arch/arm64/boot/dts/allwinner/Makefile
>> @@ -13,6 +13,7 @@ dtb-$(CONFIG_ARCH_SUNXI) +=3D
>sun50i-a64-pinephone-1=2E0=2Edtb
>>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a64-pinephone-1=2E1=2Edtb
>>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a64-pinephone-1=2E2=2Edtb
>>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a64-pinetab=2Edtb
>> +dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a64-pinetab-dev=2Edtb
>>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a64-sopine-baseboard=2Edtb
>>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a64-teres-i=2Edtb
>>  dtb-$(CONFIG_ARCH_SUNXI) +=3D sun50i-a100-allwinner-perf1=2Edtb
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab-dev=2Edts
>b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab-dev=2Edts
>> new file mode 100644
>> index 000000000000=2E=2E3a4153890f3e
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab-dev=2Edts
>> @@ -0,0 +1,28 @@
>> +// SPDX-License-Identifier: (GPL-2=2E0+ OR MIT)
>> +/*
>> + * Copyright (C) 2020 Icenowy Zheng <icenowy@aosc=2Eio>
>> + *
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "sun50i-a64-pinetab=2Edts"
>> +
>> +/ {
>> +	model =3D "PineTab Developer Sample";
>> +	compatible =3D "pine64,pinetab-dev", "allwinner,sun50i-a64";
>> +};
>
>Changing the DT and the compatible half-way through it isn't ok=2E Please
>add a new DT with the newer revision like we did for the pinephone

We did this on Pine H64=2E

>
>Maxime
