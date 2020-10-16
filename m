Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3BA8290078
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 11:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404259AbgJPJDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 05:03:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43274 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404106AbgJPJDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 05:03:30 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602839009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DlhML45alUVZOL1V9Q1TKHn+FPJpfatJ3TzBlDvnowU=;
        b=B1jse21eG8p0HT5p7bLGobTjlNdrNznh+IeJUcYAHHNO921ekWlz5HnOJ2+ToN1e1BjLdj
        D6msEAP0D8sI7qPJKNQTiYet3XwZaj2fzyXB9JC/X9D5RdQmgVqnfeIDDr1Jf+aZ3gGjcT
        JsvFqc/Q8UV8C3BokgY0firLMPAoo88EsbxEsUFuu467++fBqFJeygF1I0ALkHTZZLMSE3
        1ZzdgR4xofL+xCgzpgnQKZaGRt0cn70bBaF7wyY2vAj/ztoc2tiWBQEQCl5ejZu+SWtcgT
        WWRKXx7+heI09+TeZuaxiAIyGT+OcUyCT3yYPTraQsQ483CyZhcjznv/AoAq1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602839009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DlhML45alUVZOL1V9Q1TKHn+FPJpfatJ3TzBlDvnowU=;
        b=1fo9AYUrf3V6YZVVnOgGYR/sUmPQAI+P0Jba70NYztooVeqkPggvMh9Evg9AUj/jfo1NPa
        Y5lLCTQbsplUMZBw==
To:     Marc Zyngier <maz@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 5.10-rc0: build error in ipi.c
In-Reply-To: <3ba522d1351445bc8a488ac10df80e7b@kernel.org>
References: <20201015101222.GA32747@amd> <87imbba7qk.fsf@nanos.tec.linutronix.de> <3e6b7c98fd8221a7878aaaa6c1bf86f4@kernel.org> <20201015171829.GB5636@duo.ucw.cz> <1d6af6a15b71e77c268428ffbc519d6a@kernel.org> <87d01jul7x.fsf@nanos.tec.linutronix.de> <3ba522d1351445bc8a488ac10df80e7b@kernel.org>
Date:   Fri, 16 Oct 2020 11:03:28 +0200
Message-ID: <877drqv8yn.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16 2020 at 09:28, Marc Zyngier wrote:

> On 2020-10-16 00:24, Thomas Gleixner wrote:
>> On Thu, Oct 15 2020 at 20:41, Marc Zyngier wrote:
>>> On 2020-10-15 18:18, Pavel Machek wrote:
>>> diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
>>> index 10a5aff4eecc..db923e0da162 100644
>>> --- a/kernel/irq/Kconfig
>>> +++ b/kernel/irq/Kconfig
>>> @@ -81,6 +81,7 @@ config IRQ_FASTEOI_HIERARCHY_HANDLERS
>>> 
>>>   # Generic IRQ IPI support
>>>   config GENERIC_IRQ_IPI
>>> +	select IRQ_DOMAIN_HIERARCHY
>>>   	bool
>> 
>> which makes some of the MIPS GENERIC_IRQ_IPI/IRQ_DOMAIN_HIERARCHY
>> Kconfig magic in drivers/irqchip/Kconfig obsolete.
>
> Good point. I'll queue this on top:
>
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index cd734df57c42..d2a651372e15 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -180,7 +180,6 @@ config IRQ_MIPS_CPU
>   	select GENERIC_IRQ_CHIP
>   	select GENERIC_IRQ_IPI if SYS_SUPPORTS_MULTITHREADING
>   	select IRQ_DOMAIN
> -	select IRQ_DOMAIN_HIERARCHY if GENERIC_IRQ_IPI
>   	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
>
>   config CLPS711X_IRQCHIP

There's another one for MIPS_GIC :)
