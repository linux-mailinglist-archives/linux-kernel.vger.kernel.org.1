Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6F9128161F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 17:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388290AbgJBPJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 11:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgJBPJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 11:09:12 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8A6C0613D0;
        Fri,  2 Oct 2020 08:09:10 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 13so2034576wmf.0;
        Fri, 02 Oct 2020 08:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=LA4N4jwS0PM24KWIm/8qeSLtdV8HPanZoxEuo3h48PY=;
        b=jseWkh5pBPjazyMAyGSHiMg0Ha+iXNOXhLiD7wDqBFnp9LiCvVd1+moRbGfEqUouCy
         3DOb8O5GzLj1ptgrqS8yUVXNEyQAmmcm4W4N7FhmuGDYUxotP/z4gZgf2xTzFAoNYruL
         Fhsqa+6hB+K8DtgdvyM6UrOY8ruARnsBZqSRZ33GqAkspuUwIKAOQRBvglz6WxSc1dUU
         SA9+KL4vgv4V0C60gFtJSbJJ1Cta92i7waK97HsumCNnv5oBlduFYEw7FcLk/PKZAqx+
         /cP12scpSp/asOpPfxlHNk++S9KISLJO5+TlaDp2SIm9lTdDgwmSd31DqiPoyepORFdD
         1lkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=LA4N4jwS0PM24KWIm/8qeSLtdV8HPanZoxEuo3h48PY=;
        b=oPhdpjb7FJQT6JMOFFpmv0Qqz7iqiqy37+ErZxFZArCuDwThlR3XXEKrAIsOWV47L0
         /ZiwRM2J6YTkTR9vQCvK0HouDPUVJIKPgDPihpE3R4XRotUsoEuq+znOX4j6LYEtjJ+r
         ph/wr+hjITV0OXP5QuUrmHIKyUpDqs9bAB1bfwiRt0YgzIGgh5wcp5QOOoO1lBLpjYDV
         g8r84znCZ2d4pysfqbUWPJiIqpHrG9AuChMButwXYea9y17J8CPV/OS8q1lAWDySHA4j
         HiXkzPqinE01WS1ujk6mM5n1t0hHFzvvWZ6oEAt9e/8ECHpmXA1zTgmpXNbI34dcyA8W
         sddQ==
X-Gm-Message-State: AOAM5303kZo07fKOpOB37qTc/81+gbKjvFPn/Ab/No4Qu519s+SeHLjl
        HsQ2cQIhbvIVvJW8SHOpEuc=
X-Google-Smtp-Source: ABdhPJy1UdAGLpPyCGcyX46dxAc9Yql4f7DxMt0bgH3n4ih/eN2TUqsMYB4u6qexjgTR/Tgu+Axnsg==
X-Received: by 2002:a1c:6341:: with SMTP id x62mr3435509wmb.70.1601651349030;
        Fri, 02 Oct 2020 08:09:09 -0700 (PDT)
Received: from [172.16.20.20] ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id y1sm2126241wma.36.2020.10.02.08.09.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Oct 2020 08:09:08 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.15\))
Subject: Re: [PATCH] arm64: dts: meson: add SM1 soundcard name to VIM3L
From:   Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <1jzh54it6f.fsf@starbuckisacylon.baylibre.com>
Date:   Fri, 2 Oct 2020 19:09:05 +0400
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <785296E3-FA91-4F5E-A8C0-1FAA8C576A17@gmail.com>
References: <20201002141619.14387-1-christianshewitt@gmail.com>
 <1jzh54it6f.fsf@starbuckisacylon.baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: Apple Mail (2.3445.104.15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 2 Oct 2020, at 6:44 pm, Jerome Brunet <jbrunet@baylibre.com> wrote:
>=20
> On Fri 02 Oct 2020 at 16:16, Christian Hewitt =
<christianshewitt@gmail.com> wrote:
>=20
>> VIM3L now inherits the sound node from the VIM3 common dtsi but is
>> an SM1 device, so label it as such, and stop users blaming future
>> support issues on the distro/app "wrongly detecting" their device.
>>=20
>> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
>> ---
>> arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts | 4 ++++
>> 1 file changed, 4 insertions(+)
>>=20
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts =
b/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
>> index 4b517ca72059..f46f0ecc37ec 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
>> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
>> @@ -32,6 +32,10 @@
>> 		regulator-boot-on;
>> 		regulator-always-on;
>> 	};
>> +
>> +	sound {
>> +		model =3D "SM1-KHADAS-VIM3L";
>> +	};
>=20
> The sound card is the same so I don't see why the sm1 board should =
have
> a different name. If you are not happy with the name, please update it
> in the common file.

It=E2=80=99s a nice-to-have not a must-have, but the current LE images =
that are
in circulation use 5.7 with the previous board-correct name so I was
looking for continuity. We do see user forum reports (infrequent but
recurring) of wrongly detected hardware with other SoC platforms where
similar name inheritance surfaces the =E2=80=98wrong=E2=80=99 device =
name in GUIs, and
I like anything that avoids support work.

I=E2=80=99d suggest KHADAS-VIM3-VIM3L as a common name, but then it=E2=80=99=
s the only
device in the current device-tree set that is not prefixed with the SoC
identifier, which (OCD) feels wrong.

Christian=
