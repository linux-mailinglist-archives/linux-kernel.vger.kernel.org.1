Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEA032DB070
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 16:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730503AbgLOPrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 10:47:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:39876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730363AbgLOPri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 10:47:38 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 079A62184D;
        Tue, 15 Dec 2020 15:46:58 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kpCXP-001WcH-V4; Tue, 15 Dec 2020 15:46:56 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 15 Dec 2020 15:46:55 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Andrew Lunn <andrew@lunn.ch>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Scott Branden <sbranden@broadcom.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH 3/5] irqchip/bcm2836: Make IPIs use
 handle_percpu_devid_irq()
In-Reply-To: <c9fb4ab3-a5cb-648c-6de3-c6a871e60870@roeck-us.net>
References: <20201109094121.29975-1-valentin.schneider@arm.com>
 <20201109094121.29975-4-valentin.schneider@arm.com>
 <20201215002134.GA182208@roeck-us.net>
 <38f8fbe9ceb7a0adb47e62d62260b297@kernel.org>
 <1795afb5-a4fd-3a90-99c4-71373476ad65@roeck-us.net>
 <9007dd8a0d5334141d083b14121ba11c@kernel.org>
 <c9fb4ab3-a5cb-648c-6de3-c6a871e60870@roeck-us.net>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <dff83a32c64bad6e3880dba8804cea6c@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: linux@roeck-us.net, valentin.schneider@arm.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, andrew@lunn.ch, Lorenzo.Pieralisi@arm.com, jason@lakedaemon.net, sbranden@broadcom.com, gregory.clement@bootlin.com, f.fainelli@gmail.com, rjui@broadcom.com, tglx@linutronix.de, sebastian.hesselbarth@gmail.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-12-15 15:39, Guenter Roeck wrote:
> On 12/15/20 7:26 AM, Marc Zyngier wrote:
>> On 2020-12-15 15:21, Guenter Roeck wrote:
>>> Hi Marc,
>>> 
>>> On 12/15/20 2:19 AM, Marc Zyngier wrote:
>>>> Hi Gunter,
>>>> 
>>>> On 2020-12-15 00:21, Guenter Roeck wrote:
>>>>> On Mon, Nov 09, 2020 at 09:41:19AM +0000, Valentin Schneider wrote:
>>>>>> As done for the Arm GIC irqchips, move IPIs to 
>>>>>> handle_percpu_devid_irq() as
>>>>>> handle_percpu_devid_fasteoi_ipi() isn't actually required.
>>>>>> 
>>>>>> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
>>>>> 
>>>>> This patch results in boot failures (silent stall) for the qemu
>>>>> raspi2 emulation. Unfortunately it can not be reverted because
>>>>> handle_percpu_devid_fasteoi_ipi no longer exists in next-20201214,
>>>>> so I don't know if it is the only problem.
>>>> 
>>>> This is odd. This works just fine for me on both the RPi2 and 3
>>>> emulation, running a full Debian userspace. Could this be caused
>>>> by the version of QEMU you are using? Here's what I have:
>>>> 
>>>> $ qemu-system-arm --version
>>>> QEMU emulator version 5.1.0 (Debian 1:5.1+dfsg-4+b1)
>>>> 
>>> 
>>> I used qemu 5.0 which - up to now - worked fine. Let me try with
>>> 5.1 and 5.2. Sorry, I should have tried first before bothering you.
>> 
>> No bother at all. If this works for you on more recent versions of
>> QEMU, that'd be an interesting data point. I'm also interested in
>> the result of the patch either way.
>> 
> 
> It doesn't work for me with qemu 5.1, nor with qemu 5.2. My userspace
> is generated with buildroot, busybox-based, and very basic.

OK, so something is definitely different between our setups.
Mind pointing me to your config and your QEMU invocation?

> 
> Your patch fixes the problem for me, though, so feel free to add
> 
> Tested-by: Guenter Roeck <linux@roeck-us.net>
> 
> if/when you submit it.

Thanks for that.

         M.
-- 
Jazz is not dead. It just smells funny...
