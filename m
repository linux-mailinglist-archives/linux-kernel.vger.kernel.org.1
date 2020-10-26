Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6BFE2993C5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 18:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1787786AbgJZR20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 13:28:26 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38905 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1787778AbgJZR20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 13:28:26 -0400
Received: by mail-pl1-f195.google.com with SMTP id f21so712103plr.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 10:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=RZLa3K0yUyDDt6WL3NskNHHGlNOc6iTJzksW2X6flDM=;
        b=y0kJ3u3yZkSwyiAYhnsxoLLHT8X+UqAZTzY9WS0EI0KtA6qAfQUteGA+GRFKdOk6BL
         aJ2hh7qb4B6fUQfgJKiBKIOVhWDYR0tdnltyaUAQjfKog/ErX1TZxA0MSVCvZK/7KlLD
         01eDQbjcjixE0TmOkBmMDjtsw58tTn8XyUzY+9ciGdXnYHLXvY6j8WbKviRTHpVaP6sT
         CG9SSThfXQEd9Mb+AcM0gxkOjCOI09ZVUSIkxOxldchuj6hz8ToRcb4I3CJx3/mCrO6Y
         ULQZ6S87e+elRcet6mjt+UEd4A1BMKowqJ8M8sf6QrGFAhaZG1gIony+M/ec9SYb+2bG
         kYdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=RZLa3K0yUyDDt6WL3NskNHHGlNOc6iTJzksW2X6flDM=;
        b=pnAGkgz1KEvBdelt2Iz+QgT8M0PCbCFBWX+GyFODQlNg//EeQm8c6kxoSG8/Flrf/c
         dRsOBlA6Sc7pAF5ZNXFMeKTaW4Fj9fwlLl8XyfZ7BboMGZvOhMApwaMXMgOfuIi4bRNm
         RnOxnJgYgqr/f2r7D/En2AtnvMoszQesgyKyMj91yGVsV0OiO/U5a3+/2/I0TlD2httK
         EH2tIj2mIQg90bqbr6lvW9reIvIk8/J5lEDYdoGasAYKjx8xf93B8eL7t+HFUoowyElj
         sYY9DY1jxOQTaAXYmTOD1YZGfrk0tDE9nU09Ooindonr262/kGszS3rIEPIEe54p138k
         wDUw==
X-Gm-Message-State: AOAM531+WqCQTKfWmqoEYJhOfnpmmReFLY2Lt00pM9EPTPwN657qNeDM
        n3MoGmY0Rrm7j0ZIc92sNKCKdx447AiYvkad
X-Google-Smtp-Source: ABdhPJzaEZwwz+BQVXD1x3jUrw7XUO725+SjVzU1V/pq3tDCWnUZ2mD5YSqI+kMyVe9g2QCRxNkv9A==
X-Received: by 2002:a17:90a:ef81:: with SMTP id m1mr17959155pjy.212.1603733304302;
        Mon, 26 Oct 2020 10:28:24 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id i24sm12289572pfd.15.2020.10.26.10.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 10:28:23 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Neil Armstrong <narmstrong@baylibre.com>, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] irq-meson-gpio: make it possible to build as a module
In-Reply-To: <b0780e423d5fa527835ba55c64dba473@kernel.org>
References: <20201020072532.949137-1-narmstrong@baylibre.com> <87v9eyo75s.wl-maz@kernel.org> <7ha6w9hsfm.fsf@baylibre.com> <b0780e423d5fa527835ba55c64dba473@kernel.org>
Date:   Mon, 26 Oct 2020 10:28:23 -0700
Message-ID: <7hy2jshp6w.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Zyngier <maz@kernel.org> writes:

> On 2020-10-26 16:18, Kevin Hilman wrote:
>> Marc Zyngier <maz@kernel.org> writes:
>> 
>>> On Tue, 20 Oct 2020 08:25:30 +0100,
>>> Neil Armstrong <narmstrong@baylibre.com> wrote:
>>>> 
>>>> In order to reduce the kernel Image size on multi-platform 
>>>> distributions,
>>>> make it possible to build the Amlogic GPIO IRQ controller as a module
>>>> by switching it to a platform driver.
>>>> 
>>>> The second patch removes MESON_IRQ_GPIO selection from ARCH_MESON to 
>>>> allow
>>>> building the driver as module.
>>>> 
>>>> Neil Armstrong (2):
>>>>   irqchip: irq-meson-gpio: make it possible to build as a module
>>>>   arm64: meson: remove MESON_IRQ_GPIO selection
>>>> 
>>>>  arch/arm64/Kconfig.platforms     |  1 -
>>>>  drivers/irqchip/Kconfig          |  5 +-
>>>>  drivers/irqchip/irq-meson-gpio.c | 89 
>>>> ++++++++++++++++++++------------
>>>>  3 files changed, 59 insertions(+), 36 deletions(-)
>>> 
>>> I've tried this series on my vim3l with the this driver compiled as a
>>> module, and lost the Ethernet interface in the process, as the phy
>>> wasn't able to resolve its interrupt and things fail later on:
>>> 
>>> [   72.238291] meson8b-dwmac ff3f0000.ethernet eth1: no phy at addr -1
>>> [   72.238917] meson8b-dwmac ff3f0000.ethernet eth1: stmmac_open: 
>>> Cannot attach to PHY (error: -19)
>>> 
>>> This is a generic problem with making DT-based interrupt controllers
>>> modular when not *all* the drivers can deal with probing deferral.
>> 
>> Yes, but this series still keeps the default as built-in.
>> 
>> If you build as a module, and you add `fw_devlink=on` to the kernel
>> command-line, device-links will be created based on DT dependencies
>> which will ensure the right module load order.
>
> It doesn't work here. I get the exact same error (well, with eth0 
> instead
> of eth1). In my experience, fw_devlink isn't reliable yet. Config on 
> request.

Other than CONFIG_MESON_IRQ_GPIO=m, are you using default upstream
defconfig?

I just double-checked with this series on top of v5.10-rc1, and I have
eth0 working with interrupts without needing fw_devlink=on.

With the default upstream defconfig all the networking for these devices
is already configured as modules.

Kevin
