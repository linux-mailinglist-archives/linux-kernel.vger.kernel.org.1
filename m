Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4DF41C70D2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 14:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbgEFMvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 08:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728131AbgEFMvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 08:51:19 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C42C0610D5
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 05:51:17 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id e25so2217217ljg.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 05:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=COqQCzJ4auJxawCeL75BevJEbAnSN1myQOD2Q4QlS6o=;
        b=aUP/Sxk2re3PRk+ECqewTQ+F6wOEpuHPLfG7pOjR67sNQWZCZXm7Pfzn/ZAYrBQSbY
         HVhJOF8T1bwfgCt/z4GB6Ow72DCwp+iAHjSoprUUYF5vtKSY8Cy5Xl4kJdlz2Hn/zH5o
         4C3uG3jkQiChJm4nW6t0LQ5NEH4t3yE246s/ohqdudan45YcDTTSmK71uwDs+nHhvsvW
         Y5igS6gapbGHcIHtefdk9vrArC3GRfr+RqBbTaLOzZxsy1IWVjbepibeT/Lb4UK0thrP
         y5pz35U+/XWr9Bm+eiGtlMLF/XRlRGyQ/eEX64km/9WDAVpPOMdw+gSlGnegG2NrgeXY
         E2WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=COqQCzJ4auJxawCeL75BevJEbAnSN1myQOD2Q4QlS6o=;
        b=l5PdTvU5/goMYW7xchlyThdYJFRTFYz1mZYZhuGLtv+PAajqaGQNQPHvYAN1gSmeOO
         Td1c0AB2d9T7FJmd3hFky7f5/5IMoRm97oaX482iFyY4pAxhbgQxw0Y2jrgkJdsc+Kov
         DHqjZYuNcDaSSu3xLDri9DZU6PNYEVJ4qbnrXY/D6d106AMssp+kbrcK7QTPOnen8455
         XD/VmNrxHKr1mJ2cCi37oADIryo4WlElKMuUUHxQBqGAyYiB5hzDJlS5wUdRSp8D7Sv+
         EntLn7taSw1E4+YJAbypJ7qx++DuiQvejRrI4zsss+7921VgJ03CIjOrKko6fSAaw5tK
         ngVQ==
X-Gm-Message-State: AGi0PuaEJofuPcseMDCg0/7yFJIcn5Z8U3J1IL8aNxPIfICmzmMpLT9u
        yVn3BtxdUD05lVlwVaT1iHP6XexeeadaSLMN8+JCmMpW
X-Google-Smtp-Source: APiQypImbwPouCSTKAxAbrKj370TdmOTHAg/3XPenrNSIG2xSYlnZPNpgYrCuSMEoTyq02M+FrCmk94OR5vDtNs6eq8=
X-Received: by 2002:a2e:81d5:: with SMTP id s21mr4764927ljg.258.1588769476101;
 Wed, 06 May 2020 05:51:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200503172206.13782-1-xc-racer2@live.ca> <BN6PR04MB0660C583D9538853C8296398A3A90@BN6PR04MB0660.namprd04.prod.outlook.com>
In-Reply-To: <BN6PR04MB0660C583D9538853C8296398A3A90@BN6PR04MB0660.namprd04.prod.outlook.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 6 May 2020 14:51:04 +0200
Message-ID: <CACRpkdasEU0ao0OZBoeQ9x5Efe8tFwtpkLMOU_=Xn639anJxbA@mail.gmail.com>
Subject: Re: [PATCH 5/5] iio: accel: bma180: Add support for bma023
To:     Jonathan Bakker <xc-racer2@live.ca>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Input <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 3, 2020 at 7:22 PM Jonathan Bakker <xc-racer2@live.ca> wrote:

> The bma023 chip is similar enough to the bma180 and bma25x that the
> same driver can support all of them.  The biggest differences are
> the lack of a temperature channel and no low power but still working
> mode.
>
> The bma150 is a close relative of the bma023, but it does have a
> temperature channel so support is not added for it.
>
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>

Looks good to me!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
