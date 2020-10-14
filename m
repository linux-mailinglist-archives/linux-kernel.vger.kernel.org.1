Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABA0B28E017
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 13:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgJNL4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 07:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgJNL4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 07:56:23 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DE2C061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 04:56:21 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id h6so3387344lfj.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 04:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ojnlDIDsOWgUSdYrgvw+i7T7eF4l0q3VHVTzWBNpi0g=;
        b=Q45bXx63DkzjHNdgIKinvyzV1zgcoG5ePXx4OVtKRv1jxQgvmtRRjLRuHRpGonsCYR
         9cXXLIewX4iPdF72OO1lidME2aT5yDQEVnKTKhctz6woQySS8zgjFgJUaOMBtAXZdG/Z
         l2JvoUAwFXLliiMLCIFdxYasTd059FHBT7PFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ojnlDIDsOWgUSdYrgvw+i7T7eF4l0q3VHVTzWBNpi0g=;
        b=PVald12up7AvXxpA1LWT113ImhUa9klAiJ8ZqQvzzxzRCWV2+hyyaqqp+Nneg/r+3l
         yjZ7hKk5HvYm8EfGBgkAciinXeP4to+PAkPA+0EO/h0uKYdpJHMcO1AEdArKs/hW2+Fh
         5i0+qlhuNHqVgPJ9BTL/nZeNFrjY5qUvW/DxOyeBlVhxuyTzgAqvzo2hgZ/2sz3aUKwg
         OAUdOvfJo0PsVV2P32HTwwCm42NQxxKLHW8Ovd9dUc1xQ4htv0mhLVwezNfqZWhshMHo
         1Sijv3PnQQp0Fh/meBmJahtnhpBpuishNFHQ8sxOJZAZ+VLc4FpRuhbwYKU+sZUG46vN
         9dkg==
X-Gm-Message-State: AOAM532v+xBl/75++dYDIF4WDYA9faI5YoGrCEE8TrHev+J+jE60LnZx
        hoqNtwBTl7utX9l8fcKHaXv7MaXO37bJaGid7z0=
X-Google-Smtp-Source: ABdhPJyurqiaJVZz/jGKXOQ0lmM25Tye5vb7oT1almi3VJ7j9ZxyO7GfWz7WAPntlqvwM4GC94UFyw==
X-Received: by 2002:a05:6512:3053:: with SMTP id b19mr1351958lfb.338.1602676579551;
        Wed, 14 Oct 2020 04:56:19 -0700 (PDT)
Received: from [172.16.11.132] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id o4sm1064388lfg.247.2020.10.14.04.56.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2020 04:56:18 -0700 (PDT)
Subject: Re: using one gpio for multiple dht22 sensors
To:     Peter Rosin <peda@axentia.se>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <91c25030-d5d1-e3e7-2d26-ac631dddc756@rasmusvillemoes.dk>
 <1c0d4c55-1d76-8256-ac45-6e0e150309d9@axentia.se>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <c00049d4-14b2-e250-0d7c-a6b677d4c9c7@rasmusvillemoes.dk>
Date:   Wed, 14 Oct 2020 13:56:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1c0d4c55-1d76-8256-ac45-6e0e150309d9@axentia.se>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/2020 11.12, Peter Rosin wrote:
> Hi Rasnus,
> 
> On 2020-10-13 23:34, Rasmus Villemoes wrote:
>> Hi Peter
>>
>> I'm going to hook up a bunch of dht22 humidity (and temperature) sensors
>> [1] (drivers/iio/humidity/dht11.c), but partly due to limited number of
>> available gpios, I'm also going to use a 74hc4051 multiplexer [2], so
>> that all the dht22's actually sit on the same gpio.
>>
>> It's pretty obvious how the multiplexer is to be described in
>> device-tree (I'm probably going to send a patch to add support for an
>> optional "enable-gpio", as on the 74hc4051, so that MUX_IDLE_DISCONNECT
>> gets supported).
>>
>> It also seems like io-channel-mux should somehow magically apply to all
>> kinds of iio devices, but it can't be that simple. And if it is, I can't
>> figure out how to write the DT. So:
> 
> The io-channel-mux is for the situation where you have only one iio-device,
> and where you can control its environment with a mux. I.e. it is not about
> how the device communicates with the host. You then get one new "virtual"
> iio-device for every (valid) state of the mux, and when you access those
> iio-devices, the mux is configured to select the correct input/output for
> the iio-device in question. At least, it should be possible for output
> devices as well, but I guess you kind of get into trouble with the output
> signal not persisting when the mux changes state, but that is a problem
> for the HW people ;-). I originally used it for a single adc device where
> the mux simply selected what to measure.

I see, so it's not really applicable here.

>> - do I need to teach the dht11.c driver to be mux-aware?
>> - currently, a dht11/dht22 shows up in sysfs with just two files,
>> in_humidityrelative_input and in_temp_input. Now, should I end up with
>> one device and, say, 2*8 files (so that it seems like one sensor with
>> eight input channels), or should it show up as eight different devices?
>> If the latter, I guess the device tree would end up with the same "gpios
>> = " spec for all eight - is that even allowed?
> 
> It's not 100% clear to me how this is connected, but I'm guessing that you
> have the "DATA-signal" pin of the dht22s connected to the Y pins of the 4051,
> and that Z pin of the 4051 is connected to some gpio, so that you are able
> to communicate with the various dht22s by controlling the mux.

Exactly. And currently, I just have one dht22 in DT, listing the gpio
the Z-pin is connected to, and have tested that I can talk to all of
them by manipulating the mux from userspace (well, the driver thinks
there's only one dht22, so it imposes a 2 second delay before trying to
talk to "it" again - which is one reason I want to do this right).

> This calls for a mux on the single source of communication from the host
> to the various real devices that share this single source of communication.
> In other words, more like an i2c-mux than an io-channel-mux.
> 
> I.e., what you need is "the other kind" of mux/gpio driver, i.e. a driver
> that "fans out" a single gpio so that other drivers can treat the pins on
> the other side of the mux as gpios.

Hm, so I should create a new "gpio-controller" driver that presents each
of the Y pins as a separate gpio to other DT consumers? But while all
the devm_gpiod_get() would then succeed, only one of them could be
usable at a time. The "gpio-controller" driver would have to handle any
gpiod_xxx call by setting the mux appropriately, then forward the
gpiod_xxx call to the Z pin - but it can't really know when the consumer
is actually done with the gpio. And the consumer (dht11.c) has no way to
know that it should somehow "acquire" and "release" the gpiod when it's
not in use.

> I guess you'd have to sort out irq-routing through this new mux-gpio driver
> since the dht22 driver uses irqs to read input,

Well... I've had to monkeypatch the dht11 driver to do
local_irq_save()/read the gpio tightly in a loop until 80something edges
have been seen/local_irq_restore() to get stable readings (maybe I'll do
that as a real patch hanging off a module parameter - the dht22 "1-wire"
protocol is kinda crappy...), so that's not really a problem.

> 
> I'm not an expert on the intricacies of the gpio subsystem...
> 
> Does that help?

Somewhat. Thanks for the quick reply, I'll have to do some more digging
and experimentation.

Rasmus
