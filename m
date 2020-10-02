Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61505281B2F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 20:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388369AbgJBSxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 14:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgJBSxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 14:53:42 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052BDC0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 11:53:41 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id j136so2749988wmj.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 11:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Bi95YrOflmCtEoOhXnI8Z0xAJsTGAyx0xGj5b0E1L7c=;
        b=1nnog1OLxCpMXXuFlADcmPeGCJ/QHqFKFhIq/t1rQCNKzrYh0yiQ+GhfU//AXbXxHb
         3VgjX6NMdoQzb8Na0u6NhDoyTb2BdPEiDOij0AfnfPhoAZe5gaptQCFSNfXGFxVLVs07
         pTt8CUSgDV+I6u+qmcG0diLv+89NPRJRRl3rkGB1MA15VKboQ57gMjk3AUoNLEQjFWWb
         ej56NX3cqgdzWK6FmAeA6gZT4RllxDHIgipo4z9gb3pJRxLOvtg4QBFP+9K6aV7g/s3/
         r8QIbhwmWsPv6c7qi5LH5KxWSpQjNV8kUDEDB6PsvRiUiQ7Ji22cRgSqECstvwPVdn0o
         lQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=Bi95YrOflmCtEoOhXnI8Z0xAJsTGAyx0xGj5b0E1L7c=;
        b=Y/Wmj6tWIt6BubLlqL8qATna/DOJN+xfJCVWgU/xuURekYegieg90YPCEkqlQAyNa5
         ATyPFoVw7QTBYhpShvTcK0VCbJqLOSVwYqmPvYzfTeyrhi+aALyk9/zyTczpXbj9+FZ2
         mziTIjvwnTvrGoy2mhQiJ9DmfdzjsQTziRi5q6Q6xgtwoYhDUiGSGPx8cpVTMFIsBcZV
         V5hce8Wtf5Cd5qcvTgeKggn5nE1ILqyn9UUJmaBoP2mtChpTo7woqIu0/dRJjtQpDBmc
         LQ6p7VngnUDGlDqM5j8TxNP9v36xBFstMkCjpDqt5x4kCcopfvchQrgSJ85w9SP4LSso
         jR7g==
X-Gm-Message-State: AOAM531JPDBSc1/XzBhZAsScy7E/q9gk6ZjcnKyyxUmexNSIWGc7bzvw
        mC0bc5/Y9hYt2ypXkH+jJOeJog==
X-Google-Smtp-Source: ABdhPJz1DJ7fedQ9xXPzzG6tOyY3pmkIAuRiazX88TRgzwY0ixzeUtcdm58X+KNyh1+Vgx6cQzHjxQ==
X-Received: by 2002:a1c:750d:: with SMTP id o13mr4568217wmc.54.1601664819623;
        Fri, 02 Oct 2020 11:53:39 -0700 (PDT)
Received: from localhost (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id c14sm2610530wrv.12.2020.10.02.11.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 11:53:39 -0700 (PDT)
References: <20201002141619.14387-1-christianshewitt@gmail.com> <1jzh54it6f.fsf@starbuckisacylon.baylibre.com> <785296E3-FA91-4F5E-A8C0-1FAA8C576A17@gmail.com> <7h7ds8mppz.fsf@baylibre.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Christian Hewitt <christianshewitt@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: meson: add SM1 soundcard name to VIM3L
In-reply-to: <7h7ds8mppz.fsf@baylibre.com>
Date:   Fri, 02 Oct 2020 20:53:37 +0200
Message-ID: <1jmu14qx1q.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri 02 Oct 2020 at 20:45, Kevin Hilman <khilman@baylibre.com> wrote:

> Christian Hewitt <christianshewitt@gmail.com> writes:
>
>>> On 2 Oct 2020, at 6:44 pm, Jerome Brunet <jbrunet@baylibre.com> wrote:
>>>=20
>>> On Fri 02 Oct 2020 at 16:16, Christian Hewitt <christianshewitt@gmail.c=
om> wrote:
>>>=20
>>>> VIM3L now inherits the sound node from the VIM3 common dtsi but is
>>>> an SM1 device, so label it as such, and stop users blaming future
>>>> support issues on the distro/app "wrongly detecting" their device.
>>>>=20
>>>> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
>>>> ---
>>>> arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts | 4 ++++
>>>> 1 file changed, 4 insertions(+)
>>>>=20
>>>> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts b/=
arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
>>>> index 4b517ca72059..f46f0ecc37ec 100644
>>>> --- a/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
>>>> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
>>>> @@ -32,6 +32,10 @@
>>>> 		regulator-boot-on;
>>>> 		regulator-always-on;
>>>> 	};
>>>> +
>>>> +	sound {
>>>> +		model =3D "SM1-KHADAS-VIM3L";
>>>> +	};
>>>=20
>>> The sound card is the same so I don't see why the sm1 board should have
>>> a different name. If you are not happy with the name, please update it
>>> in the common file.
>>
>> It=E2=80=99s a nice-to-have not a must-have, but the current LE images t=
hat are
>> in circulation use 5.7 with the previous board-correct name so I was
>> looking for continuity. We do see user forum reports (infrequent but
>> recurring) of wrongly detected hardware with other SoC platforms where
>> similar name inheritance surfaces the =E2=80=98wrong=E2=80=99 device nam=
e in GUIs, and
>> I like anything that avoids support work.
>>
>> I=E2=80=99d suggest KHADAS-VIM3-VIM3L as a common name, but then it=E2=
=80=99s the only
>> device in the current device-tree set that is not prefixed with the SoC
>> identifier, which (OCD) feels wrong.
>
> True, but turns out there's nothing SoC specific about this sound block
> since it's identical across SoCs, so specifying the SoC is being too
> specific.=20
>
> OTOH, while I agree it looks "wrong", it's pretty common in Linux DT to
> have the SoC prefix to mean only that it's "compatible" with that SoC,
> not that it *is* that SoC.
>
> However, I agree that that can lead to confusion with end users, so
> since this change has not functional change, and only a UX issue in
> userspace, I'm fine to apply it.

It is not UX only. This string is used by alsa-utils to match the
card. For example, the string will be matched to restore the controls
settings with alsactl on boot. VIM3 and VIM3L are the same sound card
AFAICT, so it should be the same string.

>
> Kevin

