Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC8F3018BE
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 23:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbhAWWxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 17:53:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbhAWWxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 17:53:05 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F27C061788
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jan 2021 14:52:24 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id i17so10858416ljn.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jan 2021 14:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n0tDe4dWa1x8WvnlKKi99bBSxdrEPTwHy1sQmKWnyxQ=;
        b=uLnJUCS4seiH2j5DOKHCsC1OReFukio8W8hqbi06KDpdnoXwdRq8tYEdhWJGZ/F3rz
         jm8kmJYWR3j1csq1EYZFZMm4n6AkTtVO97eWx5M3plPilDB2zxg/DV2RQWMV8hlcaUZV
         /RaYBIPWmS42daewUvnbxsEn+qqPQla2S5XBaTV/0VydNIHTXNw5yFTEXUIG5weJ20hu
         jyKgJHMV2yMmGMz8AzfGGhv9niUxEBUkVp7S6myv8ce+eCxKQbV2+NcGzw6Xl1GaUz+R
         +pgxifF7qV7AwuSGKkzTc6k1xHxy0YT2GFy9aMlNSglAAZOrQoiH+hPrvoBXeOameIG+
         3e7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n0tDe4dWa1x8WvnlKKi99bBSxdrEPTwHy1sQmKWnyxQ=;
        b=mApjUmfQE3Mit2dAGEXOPWjglsW+ARFk9QoGZZIIKn9qveG4VIX7tsQC66NOtdJMDv
         FB329PL8O38B1iInZRh0u+PJlOksetVbFrLxpTm/NMgGxmCstB8jVvh0i5XxjFgptdUw
         Vuy/n78nvf1asI4Ja+yRvcT0p41WK07T7OiheK49YQ6nF0qg0lvOXJCKMSi/Of4iDs4y
         ekLlfnXiyYEbV/Ehi7XdHSVnPfhY1T82M9SccSCKBVFff9OVDJaTgKjyVXuhTmOCSABz
         lGoHkjl0QsiAn32mF42F65k0R+7vL1cZ5chbsuW4LgtXJW5p4gikNjcKzptXjBx2OhSn
         h9Qg==
X-Gm-Message-State: AOAM5319lzY1qKRAsQxp4u8E96Fz/2OVZzsroECud8GzdLXfc/qk1rRS
        q8RZWjbDhzYhFoR9cv56bNuzQt3GiQoIGw0Yx/nkWA==
X-Google-Smtp-Source: ABdhPJwFT/IgjWmPH5mu0rbAmUVaSP0n9Z49x1pmX8KE4VuDE/McDMB+EbHZe+UaqIMdXtYSKAED9Vljfmr2Iv0bRGo=
X-Received: by 2002:a2e:b047:: with SMTP id d7mr4546ljl.467.1611442343188;
 Sat, 23 Jan 2021 14:52:23 -0800 (PST)
MIME-Version: 1.0
References: <20210122193600.1415639-1-saravanak@google.com>
In-Reply-To: <20210122193600.1415639-1-saravanak@google.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 23 Jan 2021 23:52:12 +0100
Message-ID: <CACRpkdYtToLVxyMxC=24AoGVk89c9FyQt899OTz9Jx8yJeu+mw@mail.gmail.com>
Subject: Re: [PATCH v5] gpiolib: Bind gpio_device to a driver to enable
 fw_devlink=on by default
To:     Saravana Kannan <saravanak@google.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marc Zyngier <maz@kernel.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Android Kernel Team <kernel-team@android.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 8:36 PM Saravana Kannan <saravanak@google.com> wrote:

> There are multiple instances of GPIO device tree nodes of the form:
>
> foo {
>         compatible = "acme,foo";
>         ...
>
>         gpio0: gpio0@xxxxxxxx {
>                 compatible = "acme,bar";
>                 ...
>                 gpio-controller;
>         };
>
>         gpio1: gpio1@xxxxxxxx {
>                 compatible = "acme,bar";
>                 ...
>                 gpio-controller;
>         };
>
>         ...
> }
>
> bazz {
>         my-gpios = <&gpio0 ...>;
> }
>
> Case 1: The driver for "foo" populates struct device for these gpio*
> nodes and then probes them using a driver that binds with "acme,bar".
> This driver for "acme,bar" then registers the gpio* nodes with gpiolib.
> This lines up with how DT nodes with the "compatible" property are
> typically converted to struct devices and then registered with driver
> core to probe them. This also allows the gpio* devices to hook into all
> the driver core capabilities like runtime PM, probe deferral,
> suspend/resume ordering, device links, etc.
>
> Case 2: The driver for "foo" doesn't populate struct devices for these
> gpio* nodes before registering them with gpiolib. Instead it just loops
> through its child nodes and directly registers the gpio* nodes with
> gpiolib.
>
> Drivers that follow case 2 cause problems with fw_devlink=on. This is
> because fw_devlink will prevent bazz from probing until there's a struct
> device that has gpio0 as its fwnode (because bazz lists gpio0 as a GPIO
> supplier). Once the struct device is available, fw_devlink will create a
> device link with gpio0 device as the supplier and bazz device as the
> consumer. After this point, since the gpio0 device will never bind to a
> driver, the device link will prevent bazz device from ever probing.
>
> Finding and refactoring all the instances of drivers that follow case 2
> will cause a lot of code churn and it is not something that can be done
> in one shot. In some instances it might not even be possible to refactor
> them cleanly. Examples of such instances are [1] [2].
>
> This patch works around this problem and avoids all the code churn by
> simply setting the fwnode of the gpio_device and creating a stub driver
> to bind to the gpio_device. This allows all the consumers to continue
> probing when the driver follows case 2.
>
> [1] - https://lore.kernel.org/lkml/20201014191235.7f71fcb4@xhacker.debian/
> [2] - https://lore.kernel.org/lkml/e28e1f38d87c12a3c714a6573beba6e1@kernel.org/
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> Cc: Kever Yang <kever.yang@rock-chips.com>
> Fixes: e590474768f1 ("driver core: Set fw_devlink=on by default")
> Signed-off-by: Saravana Kannan <saravanak@google.com>

This v5 version is a beauty!

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
