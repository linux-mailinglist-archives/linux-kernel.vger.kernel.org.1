Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 359231A7A37
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 14:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439752AbgDNMA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 08:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729744AbgDNMAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 08:00:47 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74880C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 05:00:47 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id m19so9107414lfq.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 05:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZmGIxHI3FXPe1uOVzwYGqaafdS9fb+JmB1L9gJHvcAs=;
        b=FX4wKUFve8tVnmcr9Y6h6962FnDHlik5I6kmSv+tR5M9DDFWZX5MWhqyDwdJwYG3lR
         S9jDfg40ahIO27guu3KXfySFq9RhrDm0so6i3EIWIzf8p4t7dFt0JfuaNjzukaBhBdku
         JrVYuvqS3CF15DfJQ8HnMAOolChFLEjXTNGqjI3cycH3+lS8+4+6U1UeW2ow22Ey20P5
         MI/DdnK98eeGdxUW6ii3KgM0em5gAQ/4ly0qr7z7aH2kAOHZqGT5bsWj3f85u/Lr6lfX
         WAdTpgmv1b/jBU9dGuGa1SzX5JQSxrtiMplMnzGF0oGqsQMeLz2LHGBg7TlIqvmLUrUS
         HDRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZmGIxHI3FXPe1uOVzwYGqaafdS9fb+JmB1L9gJHvcAs=;
        b=s0UUKlDeCefuivPfVH1StpsSRnUxo+xgDIixaj9awGbcVvpTEOUAhhKGxdnrpsB0Yh
         q7zWXfOVC3uIMfi1unN8Lb6suXb3bAJmUUvM9y68iECaE8Bgj08w+E5fWWUbjLa9zBJ9
         tzwK6FHVEGHCMeqWwBcu0WXlg+zbjxLKtLEf6oGskGAiB+jgzyXkifSRS51lN5jzGZa7
         E8m/jMecCn8WLgph9yIfUKi1fUyvL9ALAR0+lktximETndLmAKvoyb0DERbstUwJ6V0q
         86I9G/6dcOsMhknvEuDrjYVK0Hw0Kbo7e1xJ9yTI4kcmOCPDMqfo1udGHyoqOOrXHPvW
         3OfA==
X-Gm-Message-State: AGi0PuYsJx4qKJtIK21pu8UOZclknbuBYZCkIJCGQgekELzwckbGwss/
        zYBV1IhZufJORaBwZQJA9hh2g4zcW/i+zD0JvxsklQ==
X-Google-Smtp-Source: APiQypJ6lIUsCPoi62ew7+9IHVqVz4vNLnSVLqPKzjfKAcFWzWH71rwT9E290Bpz2eKy0PdSRxQUc6h2H/itDa14g8Y=
X-Received: by 2002:a05:6512:52c:: with SMTP id o12mr13105282lfc.217.1586865645738;
 Tue, 14 Apr 2020 05:00:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200320093125.23092-1-brgl@bgdev.pl>
In-Reply-To: <20200320093125.23092-1-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 14 Apr 2020 14:00:34 +0200
Message-ID: <CACRpkdZgWUwmmuXn12DS3TsQS0yQxcweqK6HGxBm=V_2LBLBMw@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: don't call sleeping functions with a spinlock taken
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 10:31 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> We must not call pinctrl_gpio_can_use_line() with the gpio_lock taken
> as it takes a mutex internally. Let's move the call before taking the
> spinlock and store the return value.
>
> This isn't perfect - there's a moment between calling
> pinctrl_gpio_can_use_line() and taking the spinlock where the situation
> can change but it isn't a regression either: previously this part wasn't
> protected at all and it only affects the information user-space is
> seeing.
>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Fixes: d2ac25798208 ("gpiolib: provide a dedicated function for setting lineinfo")
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

I'm sorry that I lost track of this patch :(

Do we still need something like this or has it been fixed
by some other patches?

Yours,
Linus Walleij
