Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2D112EB569
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 23:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728694AbhAEWel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 17:34:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbhAEWek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 17:34:40 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FCD9C061574
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 14:34:00 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id m12so2205673lfo.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 14:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3aYQmDWH67E4Z9TSjXGHOTi1uXdKxTFUY+iwwP2uIQM=;
        b=xnBsXz8YhrnPFT3oKbuP6bhwJBjzpkA9uhZpSkmPh4EYmmnE6yxWcEYTSNS4fTDOZQ
         KEKY1pkkkGFgYGuuiIIA7nX9+A2OJeIcmaFPreus6ugOtfVvEVYinlhXtXoUy5EbIIGy
         nVt0dyoMw42w6iotFPScbdV3DoNweA7+ok1xcBGeWc/BZP12Xb4UBXSl3SY9512SJ/C4
         JL5oCs1kdJ5xi65WeZmyOB7pA6071OX+6O3iz+YcZNwbWicaQekkXDiG/PZcpyiyy53S
         ZXjvUkMqziTHxzo3WzFRxzHuhfB5/c3lykR6WqfSaMWvI5j6IB06Ze/TzcBgfhTkmd6S
         OWKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3aYQmDWH67E4Z9TSjXGHOTi1uXdKxTFUY+iwwP2uIQM=;
        b=Gb/rZNVFVX33XAuIlpknbaKi/SH5+nIt0/G72Hm2/0uUl9YXkzedCjK3wXLXE7JDpQ
         EXhczbXNWv/Uboo81SJRX7AENE+sxc6k0RgX61jjcT8F9PeYEgidL6aMHoVdg7hg3XqB
         ZmCnGTH0v4tBWSBYtOOy+OAtx7AOyesKHsu5KBZ07phfy41PhuvBDz/WSWsCCGeChtKC
         X+bbhc6g2j6ls33ZEB7TSqOuh9FtLVFrFrrWWd37aG2UsyhWflAFi7PxhbADI+ht3MnH
         8txEqVXMvib7b/tvjRAgF48KGvn7ZnH4rBI7Jc3IQhJxL4h9XAexLxO+jIiLPs0yL9Ze
         xUGg==
X-Gm-Message-State: AOAM533teIJlf5shoBKmSLo32HBxSt/E9X4yMTMzB8AmE+u5ICWzrtLZ
        GCJeNfki43UR8az66JXuyB6eqgq/AEZ3no9iVl7ytA==
X-Google-Smtp-Source: ABdhPJxAz5mRIyyOUrUQQy4+/XvPQsq2YxFLxv9A+C2lNderBtEiRic2qPIvB8xxY1GGP3OLfr0tGv50pEYfQi4ijAc=
X-Received: by 2002:a05:651c:1312:: with SMTP id u18mr770588lja.200.1609886038870;
 Tue, 05 Jan 2021 14:33:58 -0800 (PST)
MIME-Version: 1.0
References: <20210103135955.3808976-1-arnd@kernel.org>
In-Reply-To: <20210103135955.3808976-1-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 5 Jan 2021 23:33:48 +0100
Message-ID: <CACRpkdYUS+-Fpxn6TiGNZwq3WRkxdAdxmao9VFMKp+ZiEttc3w@mail.gmail.com>
Subject: Re: [PATCH] clocksource: ixp4xx: select TIMER_OF when needed
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 3, 2021 at 3:00 PM Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> Compile-testing the ixp4xx timer with CONFIG_OF enabled but
> CONFIG_TIMER_OF disabled leads to a harmless warning:
>
> arm-linux-gnueabi-ld: warning: orphan section `__timer_of_table' from `drivers/clocksource/timer-ixp4xx.o' being placed in section `__timer_of_table'
>
> Move the select statement from the platform code into the driver
> so it always gets enabled in configurations that rely on it.
>
> Fixes: 40df14cc5cc0 ("clocksource/drivers/ixp4xx: Add OF initialization support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

That's a nice fix!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
