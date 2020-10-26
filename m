Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5E5299334
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 18:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1775558AbgJZRAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 13:00:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:49416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2443346AbgJZRA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 13:00:27 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7ADDF223B0;
        Mon, 26 Oct 2020 17:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603731626;
        bh=Wk5C6AUNf5Rr1fEwHl+3seiMfHFBEAh2bYObiBXLLX8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gdSIPYRyIpe/ZiMe9+II8R3w/Q5DiXCBun6pAQDRIAwQw8M+JPaVNaxoVmwuXDu6F
         ZGxBvlO2AiSwjUnczyLL8j/XuVhZWATASl4r1ZZQKUsQDStM9ly9RnTTPNe6B/8CuU
         LtmytiLl0WgVhtcG6POJPHmyUoecnSNtC2CKceyY=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kX5r6-004OVS-Jc; Mon, 26 Oct 2020 17:00:24 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 26 Oct 2020 17:00:24 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] irq-meson-gpio: make it possible to build as a module
In-Reply-To: <7ha6w9hsfm.fsf@baylibre.com>
References: <20201020072532.949137-1-narmstrong@baylibre.com>
 <87v9eyo75s.wl-maz@kernel.org> <7ha6w9hsfm.fsf@baylibre.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <b0780e423d5fa527835ba55c64dba473@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: khilman@baylibre.com, narmstrong@baylibre.com, jbrunet@baylibre.com, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-26 16:18, Kevin Hilman wrote:
> Marc Zyngier <maz@kernel.org> writes:
> 
>> On Tue, 20 Oct 2020 08:25:30 +0100,
>> Neil Armstrong <narmstrong@baylibre.com> wrote:
>>> 
>>> In order to reduce the kernel Image size on multi-platform 
>>> distributions,
>>> make it possible to build the Amlogic GPIO IRQ controller as a module
>>> by switching it to a platform driver.
>>> 
>>> The second patch removes MESON_IRQ_GPIO selection from ARCH_MESON to 
>>> allow
>>> building the driver as module.
>>> 
>>> Neil Armstrong (2):
>>>   irqchip: irq-meson-gpio: make it possible to build as a module
>>>   arm64: meson: remove MESON_IRQ_GPIO selection
>>> 
>>>  arch/arm64/Kconfig.platforms     |  1 -
>>>  drivers/irqchip/Kconfig          |  5 +-
>>>  drivers/irqchip/irq-meson-gpio.c | 89 
>>> ++++++++++++++++++++------------
>>>  3 files changed, 59 insertions(+), 36 deletions(-)
>> 
>> I've tried this series on my vim3l with the this driver compiled as a
>> module, and lost the Ethernet interface in the process, as the phy
>> wasn't able to resolve its interrupt and things fail later on:
>> 
>> [   72.238291] meson8b-dwmac ff3f0000.ethernet eth1: no phy at addr -1
>> [   72.238917] meson8b-dwmac ff3f0000.ethernet eth1: stmmac_open: 
>> Cannot attach to PHY (error: -19)
>> 
>> This is a generic problem with making DT-based interrupt controllers
>> modular when not *all* the drivers can deal with probing deferral.
> 
> Yes, but this series still keeps the default as built-in.
> 
> If you build as a module, and you add `fw_devlink=on` to the kernel
> command-line, device-links will be created based on DT dependencies
> which will ensure the right module load order.

It doesn't work here. I get the exact same error (well, with eth0 
instead
of eth1). In my experience, fw_devlink isn't reliable yet. Config on 
request.

> I've tested this series with `fw_devlink=on` on several Amlogic
> platforms and it works just fine, but since it requires the extra
> cmdline option, I think the default should remain built-in.
> 
> So, I'd still like to see this series merged so that at least it's an
> option to enable this as a module.

I have taken similar patches in 5.9 for other SoC families (qcomm, mtk),
and ended up reverting them in -rc2, because there is simply too much
breakage. Even keeping it as built in changes the init order, which
tons of drivers depend on. I proposed a middle-of-the-road approach
(modules can break, built-in stays the same) which Rob pushed back on.

So either we fix fw_devlink to work for everything and be on by default,
or we keep the current setup.

> Also, another reason to make it optional is that not all platforms need
> this feature at all, but right now we select it for all Amlogic SoCs.

I understand that, but I don't want another episode of widespread
breakages, and this series definitely breaks things.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
