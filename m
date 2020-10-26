Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F23FF299AF5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 00:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408136AbgJZXp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 19:45:56 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42656 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408106AbgJZXpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 19:45:55 -0400
Received: by mail-pg1-f195.google.com with SMTP id s22so6951469pga.9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 16:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=CEpRSfPNTBvlxfYwUVnXYQlXTvWMOmV50TdlaJw1/KM=;
        b=0SMOf1DBVnGfkBYKzhH2a0tJ+REpXkXynH4K1FkevO4XwOsdbUkx67P1TdxjmRFFi4
         LRYeADD/+TG5cvbQ8AQVgAEJjxqRsOuyvQ0OJbeK5+P+e6MQqzqUIKNdjMZYSzgMDCZD
         8edAwLsdoDn763JJSKRFFFjhStAohpC+RGJUEl7GScZzII7FCVA36BUrGlNfJaypKh76
         E9B0j2acaeKPCe/r18hK6ezi+PEG7U0Xy34wvBgFxhs2Ubh2b/HmoPSctVSKwVKf4g+v
         xrxQy9/nrV7XkafX1N87z4jsZ+G3W3pp75b5wvgZCMEOWFq0h6CiAPHQBFECayg6YImW
         Mdzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=CEpRSfPNTBvlxfYwUVnXYQlXTvWMOmV50TdlaJw1/KM=;
        b=gAFu0AaBomnAkAQSXIR8Oh9TL9Xo3QgSI5KwdrKv1ZECV3/7S2HQO0L8I7ti1aE3b0
         yOstRWyF+2zL4981jfzHTzU5DtIDjHz+zUv4+lX1LPADF40Spxr94r46xXwArtK5PSL1
         9jIIyHihIwsreJ2A0t9YDd2paVeRU70gLFDTeKSo3qvWtgIKa9Tf+1fi+9PWNAyjOdRF
         5X6hzV/SFE19J4tyLUF/mruMlcXpA/KU+OFuv6EuA/bQH7onxpZKdln+rgQxzx/wbZtU
         wez+SWWbOmaO0raFyunedNtwzvb+NhF78LmOivAr7IjlzRReuHrhrz4T6OA3ABMSTAhY
         BwaA==
X-Gm-Message-State: AOAM531hcVc/qWKDspF1z5Ua2goWhSbpkBKVamkuOnsSR7hDbkVCkIzM
        1LXD7KhPLelLw7s79SouGQGc2A==
X-Google-Smtp-Source: ABdhPJzOSOKqn3r6Vv7s50wlTif70FjRaXnKyAMdNoynVTsKPMFy/tAzUXWNhP3B1BlCZCSsjArYSw==
X-Received: by 2002:a63:609:: with SMTP id 9mr6412492pgg.381.1603755954650;
        Mon, 26 Oct 2020 16:45:54 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id w10sm13228085pjy.13.2020.10.26.16.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 16:45:53 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Neil Armstrong <narmstrong@baylibre.com>, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] irq-meson-gpio: make it possible to build as a module
In-Reply-To: <b0780e423d5fa527835ba55c64dba473@kernel.org>
References: <20201020072532.949137-1-narmstrong@baylibre.com> <87v9eyo75s.wl-maz@kernel.org> <7ha6w9hsfm.fsf@baylibre.com> <b0780e423d5fa527835ba55c64dba473@kernel.org>
Date:   Mon, 26 Oct 2020 16:45:53 -0700
Message-ID: <7hblgoft5a.fsf@baylibre.com>
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
>
>> I've tested this series with `fw_devlink=on` on several Amlogic
>> platforms and it works just fine, but since it requires the extra
>> cmdline option, I think the default should remain built-in.
>> 
>> So, I'd still like to see this series merged so that at least it's an
>> option to enable this as a module.
>
> I have taken similar patches in 5.9 for other SoC families (qcomm, mtk),
> and ended up reverting them in -rc2, because there is simply too much
> breakage. Even keeping it as built in changes the init order, which
> tons of drivers depend on. I proposed a middle-of-the-road approach
> (modules can break, built-in stays the same) which Rob pushed back on.
>
> So either we fix fw_devlink to work for everything and be on by default,
> or we keep the current setup.
>
>> Also, another reason to make it optional is that not all platforms need
>> this feature at all, but right now we select it for all Amlogic SoCs.
>
> I understand that, but I don't want another episode of widespread
> breakages, and this series definitely breaks things.

Yeah, I understand there's potential breakage things if you enable build
as a module, but that's not the default with this series so one would
have to do that on purpose.

If you don't manually enable as a module and leave the default as
built-in (e.g. CONFIG_MESON_IRQ_GPIO=y) does it work for you?  Using
your .config, I used the default to built-in and this series booted fine
for me on top of v5.10-rc1 on my VIM3L.

Using your .config, I do see issues with this driver when explicity
enabling as a module, and I'll debug those, but again, leaving it as
built-in, it's working fine for me with your .config.

I understand that even building as a built-in might change link order,
but I'd be pretty surprised if just changing from OF_DECLARE to a
built-in module made things break.

If so, I can commit to helping find/fix any issues there.

For that matter, I'm actively working on making all amlogic drivers
modular (including clocks, pinctrl, reset, etc.) and I have it all
working locally several SoCs, so I will also commit to actively help
find/fix any issues this uncovers with ordering.

My goal is to enable the *option* of building everything as modules (but
leave them as built-in by default) so I can help debug any remaining
fw_devlink issues.

Kevin

