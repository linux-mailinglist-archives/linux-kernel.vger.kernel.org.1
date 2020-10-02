Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAC1281B6D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 21:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388393AbgJBTPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 15:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgJBTPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 15:15:11 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D04C0613E2
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 12:15:09 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id l126so1941684pfd.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 12:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version:content-transfer-encoding;
        bh=udoo1e1K/MJO7dXdLeUJ+C+ApV9G4bFA1xKDqjW6WKA=;
        b=lOHqSdGoeeYtkwNeXBZSY9F/sQyhvVzrfw+wrxQmBlkhxA12pGqgWkC0qIuDzemZi/
         u/ZsKociQof3/6FY+W4OT6JAnoISFxCGNva5ue2cNpW1unRaGMlsW+JxB2bo/nfQHImX
         aLHT3oLkOm2g6b1v+JFy2eLEtagA3Z+dvDZxXlobcPm/8zeD3stsj2MCSOtoQAJVIJ/N
         Ri/7dPIjq0sJF49P+KY8EpQpVntIIVKpbp0MjhiLpHBGtKHjrHWVxA9rP/hyngNVq8K3
         qaL9dbAaMMUa2U8OarsQEamDbRfoxw+dKRkezLiKzy803cyv5kclZIx3MoPAdaL0iemV
         C7cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=udoo1e1K/MJO7dXdLeUJ+C+ApV9G4bFA1xKDqjW6WKA=;
        b=PoC+fVftaTxun9H1g264IuLBPeOZyPLlsPe4/X/LDaF7Y3W+fwc6pY6O9cjEvKqQxh
         yxbYfa+AxzQVGxyzPtoTLAgrWu7THyeIWyPUJGyKydQ67VG0DjkMQTk/shMPlym/dOmw
         +O4NkI0lBb+FSG1DK9S8yz9jyI6fw6mvBOeqArMO1pZc1t3OChD6fdpTv5FANnBsT+Qq
         BV+dZrxg1Nj7/ZAUVIcSUJPGH+Pr1TkmscHY4/K1jVR0R3RBK5Mj5IceGacKFAhYNSfG
         DGz8JW2eLL1/Z2pGddlODpvm0tYkpGk/0ZwyXz+1XHZ88t0FSYmlkl5pV4ATu8rAo7U+
         eWww==
X-Gm-Message-State: AOAM531oKgcKyRCKxUKGQudKYi5hO91rcFUIdtHACCzcAEAohnVbgF2u
        4isjtrfgvEMrklUBD1d9d8+xIA==
X-Google-Smtp-Source: ABdhPJzC3SlwPqprCyyrT3tGHnKVwg9vLOUka3Wr13DIo2hHV3LZWIEZhJLHAbOEX+rIAC7yrf6AXg==
X-Received: by 2002:aa7:8c09:0:b029:142:2501:3983 with SMTP id c9-20020aa78c090000b029014225013983mr4007479pfd.72.1601666108837;
        Fri, 02 Oct 2020 12:15:08 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id gb17sm2357323pjb.15.2020.10.02.12.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 12:15:08 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Christian Hewitt <christianshewitt@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: meson: add SM1 soundcard name to VIM3L
In-Reply-To: <1jmu14qx1q.fsf@starbuckisacylon.baylibre.com>
References: <20201002141619.14387-1-christianshewitt@gmail.com> <1jzh54it6f.fsf@starbuckisacylon.baylibre.com> <785296E3-FA91-4F5E-A8C0-1FAA8C576A17@gmail.com> <7h7ds8mppz.fsf@baylibre.com> <1jmu14qx1q.fsf@starbuckisacylon.baylibre.com>
Date:   Fri, 02 Oct 2020 12:15:07 -0700
Message-ID: <7hy2kol9s4.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> On Fri 02 Oct 2020 at 20:45, Kevin Hilman <khilman@baylibre.com> wrote:
>
>> Christian Hewitt <christianshewitt@gmail.com> writes:
>>
>>>> On 2 Oct 2020, at 6:44 pm, Jerome Brunet <jbrunet@baylibre.com> wrote:
>>>>=20
>>>> On Fri 02 Oct 2020 at 16:16, Christian Hewitt <christianshewitt@gmail.=
com> wrote:
>>>>=20
>>>>> VIM3L now inherits the sound node from the VIM3 common dtsi but is
>>>>> an SM1 device, so label it as such, and stop users blaming future
>>>>> support issues on the distro/app "wrongly detecting" their device.
>>>>>=20
>>>>> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
>>>>> ---
>>>>> arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts | 4 ++++
>>>>> 1 file changed, 4 insertions(+)
>>>>>=20
>>>>> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts b=
/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
>>>>> index 4b517ca72059..f46f0ecc37ec 100644
>>>>> --- a/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
>>>>> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
>>>>> @@ -32,6 +32,10 @@
>>>>> 		regulator-boot-on;
>>>>> 		regulator-always-on;
>>>>> 	};
>>>>> +
>>>>> +	sound {
>>>>> +		model =3D "SM1-KHADAS-VIM3L";
>>>>> +	};
>>>>=20
>>>> The sound card is the same so I don't see why the sm1 board should have
>>>> a different name. If you are not happy with the name, please update it
>>>> in the common file.
>>>
>>> It=E2=80=99s a nice-to-have not a must-have, but the current LE images =
that are
>>> in circulation use 5.7 with the previous board-correct name so I was
>>> looking for continuity. We do see user forum reports (infrequent but
>>> recurring) of wrongly detected hardware with other SoC platforms where
>>> similar name inheritance surfaces the =E2=80=98wrong=E2=80=99 device na=
me in GUIs, and
>>> I like anything that avoids support work.
>>>
>>> I=E2=80=99d suggest KHADAS-VIM3-VIM3L as a common name, but then it=E2=
=80=99s the only
>>> device in the current device-tree set that is not prefixed with the SoC
>>> identifier, which (OCD) feels wrong.
>>
>> True, but turns out there's nothing SoC specific about this sound block
>> since it's identical across SoCs, so specifying the SoC is being too
>> specific.=20
>>
>> OTOH, while I agree it looks "wrong", it's pretty common in Linux DT to
>> have the SoC prefix to mean only that it's "compatible" with that SoC,
>> not that it *is* that SoC.
>>
>> However, I agree that that can lead to confusion with end users, so
>> since this change has not functional change, and only a UX issue in
>> userspace, I'm fine to apply it.
>
> It is not UX only. This string is used by alsa-utils to match the
> card. For example, the string will be matched to restore the controls
> settings with alsactl on boot. VIM3 and VIM3L are the same sound card
> AFAICT, so it should be the same string.

Ah, OK, thanks for clarifying.   Then I would say if it gets changed, it
gets changed in the common file.

Kevin
