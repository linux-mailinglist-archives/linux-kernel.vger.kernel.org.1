Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE1D92CB0A5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 00:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgLAXHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 18:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgLAXHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 18:07:09 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3187AC0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 15:06:23 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id z21so8082292lfe.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 15:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LkvyS2XwAUCBG0T0sNi/1VUrEbEkR9dvlUAWjQGxroE=;
        b=xo/yQHm9fnuzKkRWd2G26TvO6DmqQuLw3krYpZy5V5t3MW1AafKECSZ78/R3s5aDXY
         t0i9Qzgn9PhzIWBgxcD7i8XdJA8E9DX4/gBexSTqb+ohp/W++aVErJwjRdgQqOMA8rCb
         I5PwcV5lWtIC8ObwiKY3hgAiaQgPumyCOWjhRi7XBMUACdZaNgnAh84GBy5y/E/Su6Ry
         YUcbmB8ratAVfIjgaOIytkzHdz9rdJe2tWViSUqIZj5zqgDDQzz5qE2QDCI5UsYx6TQ+
         QyMqoN1nnJENPZMTSZgUo0PmGmqnP74ws1lEHsHv3/t//sV/sAPZ2fvDKo0KcPbGi/1H
         yhQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LkvyS2XwAUCBG0T0sNi/1VUrEbEkR9dvlUAWjQGxroE=;
        b=E9G5BWX0Z/eLG2KJ1Xy+ttddh1gAnTT3f4vr3pmq17djL7qRs3FpM1eF2CBV9waHz5
         EZCwinwzJByDPwh/WX2L5piM3J1j+AjoTBwEsDDw5A71HQhBVlRKKMPsexr1F2HX7P4n
         /mlYSxNch8zeMQtueWg0KX6xXDuPpM949ZUNK/pw44QyOT65AGy+zupVT5Y8hYJkjtI8
         +EGfBdnOuFq4+qjXYzU69Da976HBLTM71/rOkXEuV+bF0ta4tkTvaQr1YJpXbLOiuy0e
         uZT5bLd2QIs/J/fpGjZFp0J91AJdv89meHmoL8PjS/Qgmm9xP21jIGPBEEdqrZ5+Ma60
         jfzw==
X-Gm-Message-State: AOAM532KWYfpdFAD+8ktGoBMwYCLXm9KQ1XepHRCFnR+MSVpg8ndrK0m
        DUyy0ttm98fCkIrqJi1zgui2BiVJHi+znUeB/attww==
X-Google-Smtp-Source: ABdhPJwJpkEJa2W03wohD7Ix8jmmuqkCNfNJAbp0Hj6t9Pli3rRF9RLzMEEx7hjWWK1/zYH0ZDcyhRTNuRDn27QFsE0=
X-Received: by 2002:a19:5f11:: with SMTP id t17mr2147583lfb.572.1606863981608;
 Tue, 01 Dec 2020 15:06:21 -0800 (PST)
MIME-Version: 1.0
References: <d1a71663e96239ced28509980ea484cadc10c80a.1606170299.git.writetopawan@gmail.com>
In-Reply-To: <d1a71663e96239ced28509980ea484cadc10c80a.1606170299.git.writetopawan@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 2 Dec 2020 00:06:10 +0100
Message-ID: <CACRpkdYDWGN3iJbEP9F_8vw1+R-farPbKT6x9ZqyksH6cQ4fTA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: core: Fix unused variable build warnings
To:     Pawan Gupta <writetopawan@gmail.com>, He Zhe <zhe.he@windriver.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Drew Fustini <drew@beagleboard.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 11:41 PM Pawan Gupta <writetopawan@gmail.com> wrote=
:

> A recent commit f1b206cf7c57 ("pinctrl: core: print gpio in pins debugfs
> file") added build warnings when CONFIG_GPIOLIB=3Dn. Offcourse the kernel
> fails to build when warnings are treated as errors. Below is the error
> message:
>
>   $ make CFLAGS_KERNEL+=3D-Werror
>
>   drivers/pinctrl/core.c: In function =E2=80=98pinctrl_pins_show=E2=80=99=
:
>   drivers/pinctrl/core.c:1607:20: error: unused variable =E2=80=98chip=E2=
=80=99 [-Werror=3Dunused-variable]
>    1607 |  struct gpio_chip *chip;
>         |                    ^~~~
>   drivers/pinctrl/core.c:1606:15: error: unused variable =E2=80=98gpio_nu=
m=E2=80=99 [-Werror=3Dunused-variable]
>    1606 |  unsigned int gpio_num;
>         |               ^~~~~~~~
>   drivers/pinctrl/core.c:1605:29: error: unused variable =E2=80=98range=
=E2=80=99 [-Werror=3Dunused-variable]
>    1605 |  struct pinctrl_gpio_range *range;
>         |                             ^~~~~
>   cc1: all warnings being treated as errors
>
> These variables are only used inside #ifdef CONFIG_GPIOLIB, fix the
> build warnings by wrapping the definition inside the config.
>
> Fixes: f1b206cf7c57 ("pinctrl: core: print gpio in pins debugfs file")
> Signed-off-by: Pawan Gupta <writetopawan@gmail.com>

This was fixed in
commit b507cb92477ad85902783a183c5ce01d16296687
"pinctrl: core: Add missing #ifdef CONFIG_GPIOLIB"
On october 28.

Thanks anyways!

Yours,
Linus Walleij
