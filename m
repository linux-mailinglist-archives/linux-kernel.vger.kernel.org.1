Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 863C71A53F0
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Apr 2020 00:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgDKWfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Apr 2020 18:35:00 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38254 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgDKWe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 18:34:59 -0400
Received: by mail-wm1-f65.google.com with SMTP id f20so6263613wmh.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Apr 2020 15:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=XTdhg+Xlf5WPZXZz0XSsY6zvLdLYzEpOReg3X3kD96s=;
        b=JpZPZ5IJaM6K9R8SqSPXG0qjQfqrwlkbzbZZRg+FRlF+C+xU5GZNWXJIuJjaMVjvsH
         WOmjPIa1UTU0gYkdITU0E91PWY2iqfSD3OCc0sRJOH53X6dgyk/nnS+ubn5oMIkBP4Ef
         wjRUmkDWldZPFhHGJw++v2MKpYpolwfx3SDEL75DY9Sg9zCmG8ITuKyvcWyDOo6w+TbB
         uEOIm9N59Kp5eueUtfhc/c085zbWjQP9uLYQeqM7tBG6cULZx5EE56zjVVROlWNxzjNt
         X54RVEx/HGh3owKuNAoLOU0ihXq7+DyCkriblVSHtjjS1RD8Uev1Eyz6FLns7U34cZcI
         vEZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=XTdhg+Xlf5WPZXZz0XSsY6zvLdLYzEpOReg3X3kD96s=;
        b=nUebI/Q4YG7yomvborjbxuROPBC3k+4wMH7NcWQOTs8Trve3ajSUA1Qov+QrsX5Te3
         XCMm4tIjP08bMAxQjfexvjvvI9Krwg4l4MTrCdvZZnt8B908elnO1emAe34vzLSkApVf
         2zVLUTg9y95EzjnTINpO0lzDhhnc5kTG/rJeEX7Zk7+c+4Xhm+KxqeXrBVVmZBZKtEjh
         64HeTbYetY252M+eorK6qgk8d0UYogUJD9Iujragk7FjIIOoxYeOiCNGi2Y/Yf7A+I0o
         7tLHHyRwI8+JeeAG3uzGZFywUIYNo2mXrm73auO+fLmkiyiF12Bsi3tr4XG+Z/It4Tib
         SiRA==
X-Gm-Message-State: AGi0Pub4YJBe6w7tOgt37kerI3tuApqieUf4hJnzC1xPZ3Wn5R3nTVbN
        WzoseKmC0a6E37uV+5Kcxrl9wA==
X-Google-Smtp-Source: APiQypLX5XnwJtkOI7FJ21vIuZMoYF8VfN0lscJ3iVpl8y6O/opkC8sIkWHHFQs0s3CaoWUAM16DZQ==
X-Received: by 2002:a1c:7308:: with SMTP id d8mr12144840wmb.31.1586644498242;
        Sat, 11 Apr 2020 15:34:58 -0700 (PDT)
Received: from localhost (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id s24sm7127097wmj.28.2020.04.11.15.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2020 15:34:57 -0700 (PDT)
References: <20200411170356.1578031-1-martin.blumenstingl@googlemail.com> <20200411170356.1578031-3-martin.blumenstingl@googlemail.com> <1jlfn2szqp.fsf@starbuckisacylon.baylibre.com> <CAFBinCDut=qY9f8BTwRrHC6zKMGK4DEqXFnd8BxN6S2OatXrWg@mail.gmail.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v1 2/2] pinctrl: meson: wire up the gpio_chip's set_config callback
In-reply-to: <CAFBinCDut=qY9f8BTwRrHC6zKMGK4DEqXFnd8BxN6S2OatXrWg@mail.gmail.com>
Date:   Sun, 12 Apr 2020 00:34:56 +0200
Message-ID: <1jk12ltzvz.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat 11 Apr 2020 at 22:53, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

>
>> There is an example of that in meson-gx-libretech-pc.dtsi with the phy
>> irq pin.
> I'm still hoping that pinctrl-meson will gain interrupt support one
> day, then the driver will (hopefully) take care of that :-)

I don't see why it should. If the meson gpio driver was able to provide
an irq related to gpio, I don't think it should do more than that.

In most case the gpio will be an input, yes, but nothing says it must.

>
>
> Martin

