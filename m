Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4900F28FFF2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 10:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394581AbgJPI2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 04:28:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:51726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394263AbgJPI2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 04:28:10 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32FD620872;
        Fri, 16 Oct 2020 08:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602836890;
        bh=ZZegHMak87TajMY10OWw6LCtohliHZNDqTt6ZofnSYI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vMCKjsRFDUtcDBDROKN0lU5jNOLL+zVmJkJP8v197ic0kP9Ub7BZBTsl0yzThaFZB
         zGkm5YIOT1k8sEOD9JKe87dLb+HSOQYkHDGEJFJRCJFJ0HUQ5NL0IZP7zQA7AJkZfo
         sBhDPVtbED1n5OW3YZGmF+KISFG2GFI2LAfu5xjw=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kTL5s-001clU-49; Fri, 16 Oct 2020 09:28:08 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 16 Oct 2020 09:28:07 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 5.10-rc0: build error in ipi.c
In-Reply-To: <87d01jul7x.fsf@nanos.tec.linutronix.de>
References: <20201015101222.GA32747@amd>
 <87imbba7qk.fsf@nanos.tec.linutronix.de>
 <3e6b7c98fd8221a7878aaaa6c1bf86f4@kernel.org>
 <20201015171829.GB5636@duo.ucw.cz>
 <1d6af6a15b71e77c268428ffbc519d6a@kernel.org>
 <87d01jul7x.fsf@nanos.tec.linutronix.de>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <3ba522d1351445bc8a488ac10df80e7b@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: tglx@linutronix.de, pavel@ucw.cz, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-16 00:24, Thomas Gleixner wrote:
> On Thu, Oct 15 2020 at 20:41, Marc Zyngier wrote:
>> On 2020-10-15 18:18, Pavel Machek wrote:
>> diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
>> index 10a5aff4eecc..db923e0da162 100644
>> --- a/kernel/irq/Kconfig
>> +++ b/kernel/irq/Kconfig
>> @@ -81,6 +81,7 @@ config IRQ_FASTEOI_HIERARCHY_HANDLERS
>> 
>>   # Generic IRQ IPI support
>>   config GENERIC_IRQ_IPI
>> +	select IRQ_DOMAIN_HIERARCHY
>>   	bool
> 
> which makes some of the MIPS GENERIC_IRQ_IPI/IRQ_DOMAIN_HIERARCHY
> Kconfig magic in drivers/irqchip/Kconfig obsolete.

Good point. I'll queue this on top:

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index cd734df57c42..d2a651372e15 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -180,7 +180,6 @@ config IRQ_MIPS_CPU
  	select GENERIC_IRQ_CHIP
  	select GENERIC_IRQ_IPI if SYS_SUPPORTS_MULTITHREADING
  	select IRQ_DOMAIN
-	select IRQ_DOMAIN_HIERARCHY if GENERIC_IRQ_IPI
  	select GENERIC_IRQ_EFFECTIVE_AFF_MASK

  config CLPS711X_IRQCHIP

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
