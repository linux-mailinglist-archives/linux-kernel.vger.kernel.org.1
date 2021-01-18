Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB0382FA366
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 15:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405133AbhAROoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 09:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393143AbhAROlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 09:41:51 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3FBC061574
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 06:41:10 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id m25so24362284lfc.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 06:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SIhA1mF+BYpThO8i2Iyz2DMFBxR5yWu2mUjR9REROfY=;
        b=gNacpnhbFHkDpwBHhaGHWGA3LLhitKbhOUvUv/KRjimoxCcZNhsr6Iy5M8mOD1mXHz
         JlxWIIy2UpK9eLy8n8+Gp27vMZmN4N45DTJei4m1JmW9MOEIw95Ulnl5+A8EZoUYORGU
         1mqaj0OvgSStl+z0KxXy/mrNovipqXAXiu8avgzEDcm9DBV4bkktBi40QJ9MOwPlxLBr
         cNtph0/TrpFgh77VSjqh2IA42rLousGy4TGLGxZS9asRN/ql4iq7+sX/MLfJ9AcZjU3H
         HzlS7EGiPCCdkzcHgLohe3dcavIWUpJiTHFnArqtsSmhE0iLhDyt3mn+GY6nubCfL+9e
         u8Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SIhA1mF+BYpThO8i2Iyz2DMFBxR5yWu2mUjR9REROfY=;
        b=UOsdfUXgSTX/RgUpDSNgebc4TZfLRG633yC5K8VolBEaM6r3+gR7n/TpiEFIXrcbhR
         Fjz8TSKWi5bBLnoQvhRnTNx4vS/WHCxE9RqulMW0eVlg0GLXGXOyB6AeMIpInc0GGBb1
         4hyrUE8KkJ2uPuAKmuWJ1OE7+wmCzR/EO42V3FUiuA5yHF6PeVoUeLzzz4xyXouqD3ni
         t5QLeL/Oy6g18ufTg7EqeueTYsy/OOX8k5mTarhd21ov4BXXy3rOJBw8Sh1YVm1LmjBK
         jKfilxuSUlhS8u0Hicv9QovJfhu/bdYGWdvDC8Mss8pGCRBaDZIeTxmXefrCWvVq2v3y
         /nsQ==
X-Gm-Message-State: AOAM533KweUcb0dRY9luimipeNq5HOmkvvsM8+rq1HTInk4DX7/909J1
        Pj2P8uIZ1qeCiT4KAJtYllN/sZadZOEu8g1gvdgnel7m33j4/Q==
X-Google-Smtp-Source: ABdhPJwqmgpPf8hJv9vGP5zEfW/r8eJtUSojunYR0APxeBQ1zFaQZN2Yp8arPP/uXr5O1AhiV5/uXYk3DE/AChKvJ9I=
X-Received: by 2002:a05:6512:3f3:: with SMTP id n19mr11634965lfq.586.1610980869125;
 Mon, 18 Jan 2021 06:41:09 -0800 (PST)
MIME-Version: 1.0
References: <20210113223808.31626-1-hongweiz@ami.com> <20210113223808.31626-2-hongweiz@ami.com>
In-Reply-To: <20210113223808.31626-2-hongweiz@ami.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 18 Jan 2021 15:40:57 +0100
Message-ID: <CACRpkdYpPkCvoEHH6Nu1LPv24JwRWANRTiwVa9cvjZaJeaa02Q@mail.gmail.com>
Subject: Re: [PATCH, v1 1/1] gpio: aspeed: Add gpio base address reading
To:     Hongwei Zhang <hongweiz@ami.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 11:38 PM Hongwei Zhang <hongweiz@ami.com> wrote:

> Add gpio base address reading in the driver; in old code, it just
> returns -1 to gpio->chip.base.
>
> Fixes: 7ee2d5b4d4340353 ("ARM: dts: nuvoton: Add Fii Kudo system")
> Signed-off-by: Hongwei Zhang <hongweiz@ami.com>

NAK, sorry.

We never allow the device tree to specify this.

First, it is a Linux-only base so it would have to be a
"linux,..." property.

Even if it is a Linux-only property, it is a bad idea.

Only people using sysfs should have any need to specify global
GPIO numbers. Don't use sysfs. Use the GPIO character device
instead. See further:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpio/TODO

Yours,
Linus Walleij
