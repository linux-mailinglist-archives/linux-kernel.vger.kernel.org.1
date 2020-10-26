Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6BD5299228
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 17:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1785591AbgJZQS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 12:18:27 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35764 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1775395AbgJZQS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 12:18:27 -0400
Received: by mail-wr1-f67.google.com with SMTP id n15so13343996wrq.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 09:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=pQ0aH8vkh/RuMG2EbCkeHZofkPtOKcG6AGLMjFaIfKo=;
        b=V/fE40tcYq1luuBZ0MbaRboqBRgpBc7MEkmzkf07U4AC4J7Ip1aq5NP3Ywo4ZyXeo7
         aEash4Aw1EkEc5Y2yMZwJ6ptcOX0POFo91TkimvhjZJGNIS1oxXv4/7nRngjAwyQuruu
         GAqKTHRRsul8vNs+qi/8Nw2l7E8Yq3jQkwloQXPchJuYJ/lwhEnQx9oWJEVA13e57AtX
         J/vQMC7Zx9NYr4RC3hBH/gsEPdEV8aRD55c6ORJniQqixVmSvOFkS8jImVgwDbDlmb5k
         jB2WYwxmM0v6qnOhy6v/XfD8L9npr3kgFO9hdkZyJspRMW/wFTPrvgDZXt2aVCbCL6AX
         OikA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=pQ0aH8vkh/RuMG2EbCkeHZofkPtOKcG6AGLMjFaIfKo=;
        b=uEcQg6XKQmmSWQ8bTAFZs120CpuR+2/9NVAs1zl9Jtr3htyNXJr42Ptke12KdsP+NB
         LhZ09uTQmIL0aoDmrdvoBSTYoFAz+QlUSolW1UVDfLXJ9Zm547WDv2V399th962RdhTm
         oxN7MVHg0gQKy5THMea0wowOW8OUf1WJCZQD9FhMzSfG8ji7zgLz7yZFGXAyZxeUzOe8
         8gUp5wAE6x/3H5cJsUOUgkpryZAh0nyzAlH14mRH9woiHS21sMAFo4CJaWahp6m4hc2y
         7BQ+WsjeBesRRwkK3bLN6GhN03MPwtBLNdR0vHMfnuAyTmhYyFiS2PKPUch+okHoj/VD
         R//A==
X-Gm-Message-State: AOAM530AG1x4hFYeoLHWoA5IGEXI/EUfSFwMvrSJ4Wl8DvwXuzJhQg3T
        1Q2kVpWJLQE/ykhpRVNJygncVP+I7rHqPPWK
X-Google-Smtp-Source: ABdhPJzOdjlZHc+JYLpJI68Uu0skwrGhj3rHqIryTu3Qk/DA8usP1837G8FFeL8i/MVqFwkCNNlEyw==
X-Received: by 2002:adf:f2c1:: with SMTP id d1mr19756169wrp.179.1603729104988;
        Mon, 26 Oct 2020 09:18:24 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id y2sm20017573wmi.21.2020.10.26.09.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 09:18:23 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Marc Zyngier <maz@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     jbrunet@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] irq-meson-gpio: make it possible to build as a module
In-Reply-To: <87v9eyo75s.wl-maz@kernel.org>
References: <20201020072532.949137-1-narmstrong@baylibre.com> <87v9eyo75s.wl-maz@kernel.org>
Date:   Mon, 26 Oct 2020 09:18:21 -0700
Message-ID: <7ha6w9hsfm.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Zyngier <maz@kernel.org> writes:

> On Tue, 20 Oct 2020 08:25:30 +0100,
> Neil Armstrong <narmstrong@baylibre.com> wrote:
>> 
>> In order to reduce the kernel Image size on multi-platform distributions,
>> make it possible to build the Amlogic GPIO IRQ controller as a module
>> by switching it to a platform driver.
>> 
>> The second patch removes MESON_IRQ_GPIO selection from ARCH_MESON to allow
>> building the driver as module.
>> 
>> Neil Armstrong (2):
>>   irqchip: irq-meson-gpio: make it possible to build as a module
>>   arm64: meson: remove MESON_IRQ_GPIO selection
>> 
>>  arch/arm64/Kconfig.platforms     |  1 -
>>  drivers/irqchip/Kconfig          |  5 +-
>>  drivers/irqchip/irq-meson-gpio.c | 89 ++++++++++++++++++++------------
>>  3 files changed, 59 insertions(+), 36 deletions(-)
>
> I've tried this series on my vim3l with the this driver compiled as a
> module, and lost the Ethernet interface in the process, as the phy
> wasn't able to resolve its interrupt and things fail later on:
>
> [   72.238291] meson8b-dwmac ff3f0000.ethernet eth1: no phy at addr -1
> [   72.238917] meson8b-dwmac ff3f0000.ethernet eth1: stmmac_open: Cannot attach to PHY (error: -19)
>
> This is a generic problem with making DT-based interrupt controllers
> modular when not *all* the drivers can deal with probing deferral.

Yes, but this series still keeps the default as built-in.

If you build as a module, and you add `fw_devlink=on` to the kernel
command-line, device-links will be created based on DT dependencies 
which will ensure the right module load order.

I've tested this series with `fw_devlink=on` on several Amlogic
platforms and it works just fine, but since it requires the extra
cmdline option, I think the default should remain built-in.

So, I'd still like to see this series merged so that at least it's an
option to enable this as a module.

Also, another reason to make it optional is that not all platforms need
this feature at all, but right now we select it for all Amlogic SoCs.

Kevin








