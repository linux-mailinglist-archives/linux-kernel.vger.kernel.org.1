Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D952CEA73
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 10:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729168AbgLDJEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 04:04:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728211AbgLDJEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 04:04:36 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FEBC061A52
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 01:03:56 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id v14so6681292lfo.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 01:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9eIl/TfXf3DAnCHJTvjBTc2NPdhLLKlNS7U/UUzxHKU=;
        b=va2ghVLb3DmX1s39aM+Iex7op7cd9cU0tApBoKhZsQNzHsUugDe6hXp8iUdQLKFCJF
         4kVBSccSEqu4KZ/F6TwouW7QKCNnqIE/D8aRTwq5lmVh06c+WJ0ewJfxNQaqtgPrcX4/
         1wxB/CD360gFYd0AAfLnWYiTqmdPrLGF+pgEG2V2zxasXn++UvbL6Hd452/7y5DjT6Io
         CEnUiwTNsGBG2n5l3sgRZwaCzVnrZ6I2yYS4tBgNI41+vxEIHfK6yZmA+TwiESDiQVZd
         BsTOULm+bREEs5t9ExGw8yNWKYLrt4k6jNVKisPFaKU+A9TesItNET9OpWfyN6xYUl62
         M2nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9eIl/TfXf3DAnCHJTvjBTc2NPdhLLKlNS7U/UUzxHKU=;
        b=Bjs+B5fs9DYK+kCUCQ3MwEhDB1b/X7w6NV6iL22cG2/0mQ2ZSS6xAvVHjDERAsJlYe
         icCHVgzMW2loiVgIm0MaPVf0ZG50dECM9/PsySx6k1r2nVooeVvnrVL6HJnF3FbkC37D
         SE2fyx4HnaVoXF4l4MzENqGPAV8iec6XUjfOW6OlNKCAR3Dxvq5imrXQ9+IMefS1AzWL
         l87tJ7/1MQHIfDDXY1oHPNOwXumi6GeYuTZaK/uYxBQ6fcmbqE/CRLV3YFfgXpFYNwMR
         blaSe1+9tRU+0+5sOnC2EkR1fi6j1bBpPfbt0+qOvSG67/xon8nCm0yTpJFUwDQlCuqT
         KuKQ==
X-Gm-Message-State: AOAM533XC/1FVppH/l6KWek/b2utWmB1sykpBBmQ+23ZH4SXa627Fc9k
        HUmZRigObNQnxg9CsAmmMGwusd0RBa9JFIl6izV18Q==
X-Google-Smtp-Source: ABdhPJyoHESKYA7IrkIFAt32QtmombtH52ErTrcHhA9JhPlHGC/3rwDAqReT28YMaTsKNRSqbUvel8daR4JYsosWa28=
X-Received: by 2002:a05:6512:3e7:: with SMTP id n7mr2784417lfq.585.1607072634424;
 Fri, 04 Dec 2020 01:03:54 -0800 (PST)
MIME-Version: 1.0
References: <20201125130320.311059-1-coiby.xu@gmail.com>
In-Reply-To: <20201125130320.311059-1-coiby.xu@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 4 Dec 2020 10:03:43 +0100
Message-ID: <CACRpkdaYJZxj1QS190dd-hftO+VpAdFWQ8iRezoyw3WAa8h+AQ@mail.gmail.com>
Subject: Re: [PATCH v4] pinctrl: amd: remove debounce filter setting in IRQ
 type setting
To:     Coiby Xu <coiby.xu@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Baq Domalaq <domalak@gmail.com>,
        Pedro Ribeiro <pedrib@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        stable <stable@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 2:03 PM Coiby Xu <coiby.xu@gmail.com> wrote:

> Debounce filter setting should be independent from IRQ type setting
> because according to the ACPI specs, there are separate arguments for
> specifying debounce timeout and IRQ type in GpioIo() and GpioInt().
>
> Together with commit 06abe8291bc31839950f7d0362d9979edc88a666
> ("pinctrl: amd: fix incorrect way to disable debounce filter") and
> Andy's patch "gpiolib: acpi: Take into account debounce settings" [1],
> this will fix broken touchpads for laptops whose BIOS set the
> debounce timeout to a relatively large value. For example, the BIOS
> of Lenovo AMD gaming laptops including Legion-5 15ARH05 (R7000),
> Legion-5P (R7000P) and IdeaPad Gaming 3 15ARH05, set the debounce
> timeout to 124.8ms. This led to the kernel receiving only ~7 HID
> reports per second from the Synaptics touchpad
> (MSFT0001:00 06CB:7F28).
>
> Existing touchpads like [2][3] are not troubled by this bug because
> the debounce timeout has been set to 0 by the BIOS before enabling
> the debounce filter in setting IRQ type.
>
> [1] https://lore.kernel.org/linux-gpio/20201111222008.39993-11-andriy.shevchenko@linux.intel.com/
> [2] https://github.com/Syniurge/i2c-amd-mp2/issues/11#issuecomment-721331582
> [3] https://forum.manjaro.org/t/random-short-touchpad-freezes/30832/28
>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Cc: stable@vger.kernel.org
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> BugLink: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1887190
> Link: https://lore.kernel.org/linux-gpio/CAHp75VcwiGREBUJ0A06EEw-SyabqYsp%2Bdqs2DpSrhaY-2GVdAA%40mail.gmail.com/
> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
> ---
> Changelog v4:
>  - Note in the commit message that this patch depends on other two
>    patches to fix the broken touchpad [Hans de Goede]
>  - Add in the commit message that one more touchpad could be fixed.

Patch applied for fixes adding a reference to Andy's commit.
Thanks for sorting this out!

Yours,
Linus Walleij
