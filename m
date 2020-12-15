Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61B8C2DAD56
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 13:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbgLOMay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 07:30:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:39712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728439AbgLOMPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 07:15:33 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A53042078D;
        Tue, 15 Dec 2020 12:14:52 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kp9EA-001TN0-IX; Tue, 15 Dec 2020 12:14:50 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 15 Dec 2020 12:14:50 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Andrew Lunn <andrew@lunn.ch>,
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
In-Reply-To: <jhjim93tj6l.mognet@arm.com>
References: <20201109094121.29975-1-valentin.schneider@arm.com>
 <20201109094121.29975-4-valentin.schneider@arm.com>
 <20201215002134.GA182208@roeck-us.net>
 <38f8fbe9ceb7a0adb47e62d62260b297@kernel.org> <jhjim93tj6l.mognet@arm.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <cf5a56440a7d0162036a73438428256d@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: valentin.schneider@arm.com, linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, andrew@lunn.ch, Lorenzo.Pieralisi@arm.com, jason@lakedaemon.net, sbranden@broadcom.com, gregory.clement@bootlin.com, f.fainelli@gmail.com, rjui@broadcom.com, tglx@linutronix.de, sebastian.hesselbarth@gmail.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-12-15 11:14, Valentin Schneider wrote:
> On 15/12/20 10:19, Marc Zyngier wrote:
>> Hi Gunter,
>> 
>> On 2020-12-15 00:21, Guenter Roeck wrote:
>>> On Mon, Nov 09, 2020 at 09:41:19AM +0000, Valentin Schneider wrote:
>>>> As done for the Arm GIC irqchips, move IPIs to
>>>> handle_percpu_devid_irq() as
>>>> handle_percpu_devid_fasteoi_ipi() isn't actually required.
>>>> 
>>>> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
>>> 
>>> This patch results in boot failures (silent stall) for the qemu
>>> raspi2 emulation. Unfortunately it can not be reverted because
>>> handle_percpu_devid_fasteoi_ipi no longer exists in next-20201214,
>>> so I don't know if it is the only problem.
>> 
>> This is odd. This works just fine for me on both the RPi2 and 3
>> emulation, running a full Debian userspace. Could this be caused
>> by the version of QEMU you are using? Here's what I have:
>> 
>> $ qemu-system-arm --version
>> QEMU emulator version 5.1.0 (Debian 1:5.1+dfsg-4+b1)
>> 
>> Could you try the following hack and let me know if that helps?
>> 
> 
> Thanks for looking into this. It does look like I inverted the ordering 
> of
> that mailbox write vs the handling of the IPI. I don't see how the IPI
> could mess with the mailbox (unless some creative use of irq_work /
> smp_call), but in any case having the write in irq_ack() as you've done
> below should restore said ordering.

This hack indeed brings us back to the previous situation, where we
allowed the interrupt to be re-generated while handling the IPI.

Still, that doesn't explain why I'm not experiencing any issue here.
I hope that the various CI bots will let us know if anything is broken
on real HW.

         M.
-- 
Jazz is not dead. It just smells funny...
