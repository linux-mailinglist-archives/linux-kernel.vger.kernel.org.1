Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7545E28DCFE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 11:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388174AbgJNJVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 05:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730999AbgJNJUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 05:20:40 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB2AC061787
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 14:34:35 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id u21so1888538eja.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 14:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=to:from:subject:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=w10ZuoPIwCwbhv8a3DX0b8jne0U2O/g6VGYCUIOnuOY=;
        b=TSlPJwqpWYteMMobIirFJw6tjLSWYd+9weNNzZoSps+6TK28+53PrZDS/37/C3HeTC
         /t9Jf6XK3lZoDAtqNjbqY0sXTk69I1ndPvW7l/Aftvk6YeD758tOGMWA1yJQZODferrt
         AF7FndMJvuhYdqoZWn7iCIMqHAmeZ23i57jkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=w10ZuoPIwCwbhv8a3DX0b8jne0U2O/g6VGYCUIOnuOY=;
        b=MceVOQq1E6jYGq7pVN04KpVzFQBI+2xPnLevThf6PejN1OBHjPDp0VG+whgqUknJdY
         ZPJrgDYdgjdaU69nbxS242kTXJ9gCA1KysOEIdokBR1TaHa00qgA09UsxGBuG49fS7qR
         mC72/nk9Ko2oDIBPvqLVruINhoX3+t2yVOwMZYqJ/otBGi00/x+iQ2Xd2/Z9A95Z6vEZ
         EdqDHngzdFIryjvGwnU21C0ClromznZ199XpzWpPorHVROVNJ+qlF85T02q0tE0wug8o
         eHRhoHZVh0S0Ewy1S4rKhKjxERpxkCQEFFTJ70+TbNZ6PuVh1qhwJmS9QfaQajaYrMoS
         38qg==
X-Gm-Message-State: AOAM530WVZEIT3frTCrE+Qwlc/awE0pDm/acnHNS5WPTkDUcc2XZ9fOb
        XFJIaxGeOwH0dfMqh1pY1VYOsZ5grtWDCNdt5wM=
X-Google-Smtp-Source: ABdhPJysX1ptbLnz/IWRub4YDejyLxQ0jwHAbdYfzwDuuHTwovNpyVKwzZnCOZ00xobEvV/VewawVA==
X-Received: by 2002:a17:906:b04e:: with SMTP id bj14mr1996325ejb.254.1602624874233;
        Tue, 13 Oct 2020 14:34:34 -0700 (PDT)
Received: from [192.168.1.149] (5.186.115.188.cgn.fibianet.dk. [5.186.115.188])
        by smtp.gmail.com with ESMTPSA id ss7sm565707ejb.28.2020.10.13.14.34.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 14:34:33 -0700 (PDT)
To:     Peter Rosin <peda@axentia.se>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: using one gpio for multiple dht22 sensors
Cc:     LKML <linux-kernel@vger.kernel.org>
Message-ID: <91c25030-d5d1-e3e7-2d26-ac631dddc756@rasmusvillemoes.dk>
Date:   Tue, 13 Oct 2020 23:34:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter

Since you're the author of io-channel-mux.txt, gpio-mux.txt and
mux-controller.txt, I hope you don't mind me asking some perhaps silly
questions.

I'm going to hook up a bunch of dht22 humidity (and temperature) sensors
[1] (drivers/iio/humidity/dht11.c), but partly due to limited number of
available gpios, I'm also going to use a 74hc4051 multiplexer [2], so
that all the dht22's actually sit on the same gpio.

It's pretty obvious how the multiplexer is to be described in
device-tree (I'm probably going to send a patch to add support for an
optional "enable-gpio", as on the 74hc4051, so that MUX_IDLE_DISCONNECT
gets supported).

It also seems like io-channel-mux should somehow magically apply to all
kinds of iio devices, but it can't be that simple. And if it is, I can't
figure out how to write the DT. So:

- do I need to teach the dht11.c driver to be mux-aware?
- currently, a dht11/dht22 shows up in sysfs with just two files,
in_humidityrelative_input and in_temp_input. Now, should I end up with
one device and, say, 2*8 files (so that it seems like one sensor with
eight input channels), or should it show up as eight different devices?
If the latter, I guess the device tree would end up with the same "gpios
= " spec for all eight - is that even allowed?

If you can show how the DT is supposed to describe this situation, I'll
try to fill out the missing pieces on the driver side.

[I could also just not describe the multiplexer at all and control
everything about it by toggling gpios from userspace, and just have a
single dht22 in DT, but I prefer doing this "the right way" if it's
feasible.]

Thanks,
Rasmus

Just FTR:

[1]
https://www.electroschematics.com/wp-content/uploads/2015/02/DHT22-datasheet.pdf
[2] https://assets.nexperia.com/documents/data-sheet/74HC_HCT4051.pdf
