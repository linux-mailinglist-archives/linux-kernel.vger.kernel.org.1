Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C76071DA25C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 22:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgESUQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 16:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgESUQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 16:16:34 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551FBC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 13:16:34 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id l21so517234eji.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 13:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=INNWQgEJELQngwwhy6eg/obm2/GktGgLWdTQhfY0CV8=;
        b=ncT46C2CCIlRlD9oKb8qTENHsiQHsETpfNsQLv3RtXvjIeAxdCk6CIwanXVgLvhVmf
         UbVJf4QTPRtDtsmr2ZYJZJVNwLbCZcoTE2ClRKeA4XYAL0Hbldy1Yk0ULHGy4f7bJqdU
         8JJtusgbljBVrJcYdWHr3ESGTfWMQmLTg+BgRD4JJD/AuA9Oh0ZLGvTvscikn0DPU7Lf
         aYTDD9W/c/APP3NolF4BguFu66frbEpVuXzJiOZIqi6qpfhVkV5Vs8RUDHj26OvRn6Ul
         +x8FfcjNTObfBXwUT1IdvmqReLcBeSXrgATCdlTc7AmlfmVEOxBe9SG3VzcRBMh7+pC+
         gzEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=INNWQgEJELQngwwhy6eg/obm2/GktGgLWdTQhfY0CV8=;
        b=fupZ46+XZ8xdBqJwGqEf7veUvaDq8DkS4RgjZeGY/fpo4sIE0lYO7OFys6B8BDTb07
         3gBz/mccORwRTng99nQw4qTjqynU5WTHiDH38eicmAtiWk9lvJi5652sll5asMhzusSC
         eqruyB/iBBkRYXseJVVqM/rS8LUhths63IjQfanoB6RBc5kNt5oV4YAO88ZiCUfu5kjn
         woVV/L3pU4nS8xPD4T0o/Kz8AL6J0Hq6pcJFq3CXbipHDTp30CklB6bMUtKZZnM2Slp8
         NeI2f4wYJaJ0zz4Bzxz14w884uaeFFgXiCCk3V9tIJ5mX9m/JCmB5uV0uCXA4UJ4OeWl
         oIJw==
X-Gm-Message-State: AOAM531bu6Qb4ExFtVJ9V46DWjJwCFsFkcPOlLKSV2+CrgQ5OZk9awSR
        kl58daaPmZh2yUX5T/IgIscFMtVlvuM8P+JdgTs=
X-Google-Smtp-Source: ABdhPJxZXd9ovEa8xgwJjYQOv7+XsSSRfqBIU4qYRoVhJZNVHVMvhjVRaYW/U9OaxX/2bdpiVxlfy6B7W6op/ci8VNQ=
X-Received: by 2002:a17:906:ece4:: with SMTP id qt4mr870528ejb.162.1589919392959;
 Tue, 19 May 2020 13:16:32 -0700 (PDT)
MIME-Version: 1.0
References: <bcefba5b-107c-716b-bb60-5b4b2476894b@o2online.de>
 <CAFBinCD8-tr97GCVhBi5R1nzxLhy=_6VuLY8ubUO1SDTFjiELw@mail.gmail.com>
 <22af498b-44a0-ced3-86f3-114427a73910@o2online.de> <CAFBinCCGAkhPCwOW=mAvsV2qdixq8Gf8yQw1gYErHpz7KmuAZg@mail.gmail.com>
 <5de6db87-a71f-d14c-390d-b0caeab5d650@o2online.de> <CAFBinCDB9c2uMRXO9DKSX4hC7EBgnRfBa+BM5-VdEPZeieKn_w@mail.gmail.com>
 <813dfc08-f13a-dcac-0bd9-821d188bba08@o2online.de> <CAFBinCCgZF5Pu944q-_+V0yQ-nc6q82xDjJHjsnj6=uOQL+DEw@mail.gmail.com>
 <8cbbf90c-54ba-8fa3-3386-022c9c997a20@o2online.de> <CAFBinCBukGbzgO-Y1dCRYXZHhX2PcSEQQ_XvhHqLcnw0fGDP8w@mail.gmail.com>
 <a95f5fe1-4376-f872-961a-c2237c36811c@o2online.de> <CAFBinCCgFtv=u4ZKW3rdoDPZ_jh3jU03MDxHoDk=pbi+4pxB_w@mail.gmail.com>
 <c244b34f-8958-0cbd-38e6-a786aef56e7c@o2online.de>
In-Reply-To: <c244b34f-8958-0cbd-38e6-a786aef56e7c@o2online.de>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 19 May 2020 22:16:22 +0200
Message-ID: <CAFBinCDvwy7xCYdJzRHV0ACJ=CF+A5efD-WpPvyE62gfUribUw@mail.gmail.com>
Subject: Re: RTL8723BS driver doesn't work for,me but I can help testing
To:     Tobias Baumann <017623705678@o2online.de>
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tobias,

On Tue, May 19, 2020 at 8:21 AM Tobias Baumann <017623705678@o2online.de> wrote:
>
> good morning
>
> i got the new image from oleg(balbes150) 20200518 RC5  and some more
> feedback
>
> with my patch and oleg RC5 hotstart(shutdown now)  do not work with my
> box ( wlan goes back to sleep mode always)
I'm not sure what you mean here.
if you run "shutdown now" then the system does not shut down and only
wifi goes to sleep mode?

> with my patch chance  1 of 5 till 1 of 3 that my wlan is up and not
> sleep from cold start
>
> with oleg chance 1 of 2 till 1of 3 from cold start that wlan is up  .
> (maybe because of phandle order?)
>
> i thing there is maybe a timming problem between  wlan dis , sdio  data
> and  host wake up wlan .
the power sequence driver supports the following two properties, see [0]:
- post-power-on-delay-ms
- power-off-delay-us

Those are not set, meaning no delay is applied.
For reference, these are the delays which are used on the Endless Mini
(which also has a RTL8723BS module): [1]
Do you know more about these delays (whether they are needed and how
long they are supposed to be)?

> it could be that GPIOAO_6 is the host wake up wlan ? is it possible to
> change the activation order for the gpio pins by change it in dts ?
please check my previous mails. I think that GPIOX_21 is the wifi host
wakeup pin because it is marked as "input" on the 3.10 kernel.
you can change the order of the GPIOs inside the sdio_pwrseq node, but
all GPIOs are managed together (meaning there's virtually no delay
between enabling the first and the second one).
I am not sure if using an MMC power sequence is the right thing to do,
because the card is detected for me regardless of whether GPIOX_11 is
HIGH or LOW. The RTL8723BS driver currently does not manage any GPIOs.


Martin


[0] https://github.com/torvalds/linux/blob/c477ebe21fabe0010a2ed324ce3a1762c757d867/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
[1] https://github.com/endlessm/linux-meson/blob/4c76999c5c707fba9c390466efca093c3befa908/drivers/amlogic/wifi/wifi_dt.c#L153
