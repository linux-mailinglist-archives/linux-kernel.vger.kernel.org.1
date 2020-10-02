Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 058BE281B04
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 20:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387789AbgJBSpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 14:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgJBSpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 14:45:32 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCD9C0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 11:45:30 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id q4so1405686pjh.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 11:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version:content-transfer-encoding;
        bh=OSungDavzwrTiZitRW4ghbMXabyB4bs5Qc5OzKDq14w=;
        b=gLCNZCVKKahjlsvR18a1O6cNIq2HtJv6UlSb74OlnEVAGqsjVvDkQh8w5ZSpdqkx3N
         pggXv8wRYZBZKGMCAQwkVdO1idWpZjAmwtg/KwUJDIxfJKNefy25Utm40i866Xc2oDVx
         zeRutie6M7Dr2442uL2N1EYvuTPrJsYK6rUyU7Usw7ArZlqk4uw85EssAlV1xohVKqlY
         ZSYt62dHPPnwpez7VNe1fnliX6/4r0fS+Oz+g4F08Wf6By6nzPQTu3yC0FtOTiRzD3/0
         HzA604+V+2YM3hcCadwt9aY5VJbTS/z97cvOQFKtYJcEm/xkh936gNCROucrktaZvtL1
         ayMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=OSungDavzwrTiZitRW4ghbMXabyB4bs5Qc5OzKDq14w=;
        b=g9zBMCLW+NfBCogZdkDrgK3RUOY8AnQuuJaekmSovZt8ycZCYXmm8/QxlKbqU1DGJ2
         cF4zw/CPBWqdxQ+Cb3LJ5UTWZulEOu1+Re2fZKEETJ+7QPBeYqHzluuHdkYsHHbWXcRl
         nOYrneq2l4NqmFRidfcB4YD4AJ4OlA+TX3UomjTOcH0aig2shEWJPt7IXfuwovE+JrWH
         t4QW685a6OTAxc3nuLh+nHgAyjWz09/OizBSkQEs1mzMjGY81quhIZMOE0RVT2QXoQdy
         /um17Fz5EGUkhB3w6OkwdDfbBo0Iqz4HlaLqWxjmaq8p8xAi/bIZkjzFrQ0wIvymWMfm
         QX3g==
X-Gm-Message-State: AOAM532Wc77xKSLKwPWE4oEJomoErqY/pnK99Db4CCdIE8h5tWp4R02L
        c/8ccP8DRyPiVRK3iTqWLtNZYA==
X-Google-Smtp-Source: ABdhPJzgkgvjeIzrjdaYP7uHPa/1T6V4wPyIUOvMTxYeSE4X1Re7n+1ESMdqoVJI7bFRzhx0ItfoIQ==
X-Received: by 2002:a17:90b:3882:: with SMTP id mu2mr3411253pjb.29.1601664329904;
        Fri, 02 Oct 2020 11:45:29 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id h2sm2932622pfk.90.2020.10.02.11.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 11:45:29 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: meson: add SM1 soundcard name to VIM3L
In-Reply-To: <785296E3-FA91-4F5E-A8C0-1FAA8C576A17@gmail.com>
References: <20201002141619.14387-1-christianshewitt@gmail.com> <1jzh54it6f.fsf@starbuckisacylon.baylibre.com> <785296E3-FA91-4F5E-A8C0-1FAA8C576A17@gmail.com>
Date:   Fri, 02 Oct 2020 11:45:28 -0700
Message-ID: <7h7ds8mppz.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Hewitt <christianshewitt@gmail.com> writes:

>> On 2 Oct 2020, at 6:44 pm, Jerome Brunet <jbrunet@baylibre.com> wrote:
>>=20
>> On Fri 02 Oct 2020 at 16:16, Christian Hewitt <christianshewitt@gmail.co=
m> wrote:
>>=20
>>> VIM3L now inherits the sound node from the VIM3 common dtsi but is
>>> an SM1 device, so label it as such, and stop users blaming future
>>> support issues on the distro/app "wrongly detecting" their device.
>>>=20
>>> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
>>> ---
>>> arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts | 4 ++++
>>> 1 file changed, 4 insertions(+)
>>>=20
>>> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts b/a=
rch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
>>> index 4b517ca72059..f46f0ecc37ec 100644
>>> --- a/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
>>> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
>>> @@ -32,6 +32,10 @@
>>> 		regulator-boot-on;
>>> 		regulator-always-on;
>>> 	};
>>> +
>>> +	sound {
>>> +		model =3D "SM1-KHADAS-VIM3L";
>>> +	};
>>=20
>> The sound card is the same so I don't see why the sm1 board should have
>> a different name. If you are not happy with the name, please update it
>> in the common file.
>
> It=E2=80=99s a nice-to-have not a must-have, but the current LE images th=
at are
> in circulation use 5.7 with the previous board-correct name so I was
> looking for continuity. We do see user forum reports (infrequent but
> recurring) of wrongly detected hardware with other SoC platforms where
> similar name inheritance surfaces the =E2=80=98wrong=E2=80=99 device name=
 in GUIs, and
> I like anything that avoids support work.
>
> I=E2=80=99d suggest KHADAS-VIM3-VIM3L as a common name, but then it=E2=80=
=99s the only
> device in the current device-tree set that is not prefixed with the SoC
> identifier, which (OCD) feels wrong.

True, but turns out there's nothing SoC specific about this sound block
since it's identical across SoCs, so specifying the SoC is being too
specific.=20

OTOH, while I agree it looks "wrong", it's pretty common in Linux DT to
have the SoC prefix to mean only that it's "compatible" with that SoC,
not that it *is* that SoC.

However, I agree that that can lead to confusion with end users, so
since this change has not functional change, and only a UX issue in
userspace, I'm fine to apply it.

Kevin

