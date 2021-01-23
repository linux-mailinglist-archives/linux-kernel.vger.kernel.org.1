Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5693018DE
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 00:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbhAWXWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 18:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbhAWXWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 18:22:07 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222A1C0613D6
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jan 2021 15:21:26 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id o10so12648486lfl.13
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jan 2021 15:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qagM0m0Ne7exzQc7D+nxb7xrSis3ioyasnLHWjTOwEI=;
        b=aNCoUPOtfcenk0mjU7bVGiHXANroTF3BoeOZ9uWUGlcT3BjbQV/0btCzBpPtHMiyry
         zkul8ohQy08JT2n/bLJw5HpSVrp3YZHc6GYSqjImAO/y0PC22QRap2SGG9f1Ztnk8HUT
         bmkalV0qPWaj9/tCGpUxxHGB9H4/tzkJjK4ze+xlkqUobayE3ekw3+BvReawNUAfsbIE
         KMkwcjGFWh+1PybLkfHmSdhcuwNUpqdMKgeTxBVoJz8C5DKlBlDd4bdeIIGAIyG6QkQ0
         hZFg1jTubjg6sCLCETYy9wP9GzVnA4CIa6WKfAFXWT5zWRM9UazSjkIccehSDlF8BgPN
         uzhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qagM0m0Ne7exzQc7D+nxb7xrSis3ioyasnLHWjTOwEI=;
        b=U1nSlPjtbtYUJDX2CLLUkL5lo7htaBt2ASU2rNH0dmPyRIz1R3ROoEGghuRhtBm1y+
         ezbk0Zt/arW71EkxBHI5bd4B78qQakgb+VB3T5QAlM5NbI9HOc6TET2a/trQhkmWeV/B
         W8M9xSxnv/pe6Qlc6+eLJWy42lxGtPLxayJ+Rcpt66HBhE8xEoIZTkxaCZ+/SCLiLZ2B
         zRWOXSf/RkydXNFAaSqVM4/7WPt8cBK8EDv4slQop2V+edKj4P+F0asWrFxX+TXGG6WK
         N/bFE3efaGnAZN4xIdA1meNpB7NLnmZXmawNE7SU7uozv2cS89ZnMdiEXUXItEUPjkwI
         I5lw==
X-Gm-Message-State: AOAM531NOdYkDoK5YqaST2m+UOJbZjSXPMXXeUy/DmgTcW9KXcKS531A
        wcceqEZxg6Zq3A8CJWICcKbSJ1GbcX0qH09Ps0QEog==
X-Google-Smtp-Source: ABdhPJzxdSjDvwqayFyUDH3wXFFC6QI7cOiEKiMhgJgzYqRLFq9Q7Fi5AJIcFuHywIu0M6AdkwPanKezurMEY1x3NlM=
X-Received: by 2002:a19:8bc6:: with SMTP id n189mr1073086lfd.291.1611444084447;
 Sat, 23 Jan 2021 15:21:24 -0800 (PST)
MIME-Version: 1.0
References: <20210119124622.9490-1-mike.looijmans@topic.nl>
 <20210119124622.9490-2-mike.looijmans@topic.nl> <CACRpkdbFgskpPUoVK7bU1EyChEvD4e9WHhvcUJh4e1UUO2WFdA@mail.gmail.com>
 <20210123153511.1802a15a@archlinux>
In-Reply-To: <20210123153511.1802a15a@archlinux>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 24 Jan 2021 00:21:13 +0100
Message-ID: <CACRpkdZTJbAFK0j8U84pyW6za-SGJqGWnvertj8sXxc8Ou8VeA@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] iio: accel: Add support for the Bosch-Sensortec BMI088
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Mike Looijmans <mike.looijmans@topic.nl>,
        linux-iio <linux-iio@vger.kernel.org>,
        Dan Robertson <dan@dlrobertson.com>,
        =?UTF-8?B?R2HDq3RhbiBBbmRyw6k=?= <rvlander@gaetanandre.eu>,
        Jonathan Bakker <xc-racer2@live.ca>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 23, 2021 at 4:35 PM Jonathan Cameron <jic23@kernel.org> wrote:
> [Me]
> > Next, I think it is better to let suspend/resume, i.e. system PM
> > reuse runtime PM since you're implementing that. This is why
> > we invented PM runtime force resume and force suspend.
>
> Here the driver is turning more off for full suspend than in the
> runtime path.  If that results in significant extra delay then
> it's not appropriate to have that in the runtime suspend path.

I see the point.

The resume path calls bmi088_accel_enable() which incurs
a 5ms delay.

The runtime resume path incurs a 1 ms delay.

The runtime autosuspend kicks in after 2 ms.

> Maybe the simplification of not doing the deeper power saving
> mode is worth the extra power cost or extra delay, but
> I'm not yet convinced.

I would personally set the autosuspend to ~20ms and just use
one path and take a hit of 5 ms whenever we go down between
measures if it is a system that is for human interaction, but for
control systems this more complex set-up may be better for
response latencies.

The current approach may be better tuned to perfection and
we are all perfectionists :D

I'm just worrying a little about bugs and maintainability.

Yours,
Linus Walleij
