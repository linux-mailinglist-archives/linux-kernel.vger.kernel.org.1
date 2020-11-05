Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA202A814B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 15:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731108AbgKEOsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 09:48:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:51264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731220AbgKEOsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 09:48:09 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 717DC21D81;
        Thu,  5 Nov 2020 14:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604587688;
        bh=aHz4dg7WvhycQghc/La8ISUG6i/rU5i6Rmao6nbknIc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SwaEFeS+xnZtw2fBfjfhj3u9SrgDRnAxU2/QyxDE/+rSe2OURcAaVWM+rv5INV0/r
         lxDTWGoYAk/az/cxpm9OB7zrj+ToJV+AOHYmTshevTuOB5AvPnj+lkFvguzR3EBEnM
         82Ie209vhHCEtuJ5C0r1OEuO6KIhvp7BfAz+ExoE=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kagYY-007rTY-8w; Thu, 05 Nov 2020 14:48:06 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 05 Nov 2020 14:48:06 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 4/5] arm64: Add support for SMCCC TRNG entropy source
In-Reply-To: <CAMj1kXEoot13bFKywPRVf4BFhA5tSp+Nate=+Z+JsQdLW1oRrg@mail.gmail.com>
References: <20201105125656.25259-1-andre.przywara@arm.com>
 <20201105125656.25259-5-andre.przywara@arm.com>
 <20201105134142.GA4856@sirena.org.uk>
 <20201105140322.GH82102@C02TD0UTHF1T.local>
 <CAMj1kXEsaZAGT0jnPNyj_K1Q4W7E1+WP=tQf3bTPQi=KOCUv4g@mail.gmail.com>
 <20201105143023.GI82102@C02TD0UTHF1T.local>
 <CAMj1kXEoot13bFKywPRVf4BFhA5tSp+Nate=+Z+JsQdLW1oRrg@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <299b7ec794a5f114757078b3eb1bbb8c@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: ardb@kernel.org, mark.rutland@arm.com, broonie@kernel.org, andre.przywara@arm.com, will@kernel.org, catalin.marinas@arm.com, linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, sudeep.holla@arm.com, lorenzo.pieralisi@arm.com, linus.walleij@linaro.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-05 14:34, Ard Biesheuvel wrote:
> On Thu, 5 Nov 2020 at 15:30, Mark Rutland <mark.rutland@arm.com> wrote:
>> 
>> On Thu, Nov 05, 2020 at 03:04:57PM +0100, Ard Biesheuvel wrote:
>> > On Thu, 5 Nov 2020 at 15:03, Mark Rutland <mark.rutland@arm.com> wrote:
>> > > On Thu, Nov 05, 2020 at 01:41:42PM +0000, Mark Brown wrote:
>> > > > On Thu, Nov 05, 2020 at 12:56:55PM +0000, Andre Przywara wrote:
>> 
>> > > That said, I'm not sure it's great to plumb this under the
>> > > arch_get_random*() interfaces, e.g. given this measn that
>> > > add_interrupt_randomness() will end up trapping to the host all the time
>> > > when it calls arch_get_random_seed_long().
>> >
>> > As it turns out, add_interrupt_randomness() isn't actually used on ARM.
>> 
>> It's certainly called on arm64, per a warning I just hacked in:
>> 
>> [    1.083802] ------------[ cut here ]------------
>> [    1.084802] add_interrupt_randomness called
>> [    1.085685] WARNING: CPU: 1 PID: 0 at drivers/char/random.c:1267 
>> add_interrupt_randomness+0x2e8/0x318
>> [    1.087599] Modules linked in:
>> [    1.088258] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 
>> 5.10.0-rc2-dirty #13
>> [    1.089672] Hardware name: linux,dummy-virt (DT)
>> [    1.090659] pstate: 60400085 (nZCv daIf +PAN -UAO -TCO BTYPE=--)
>> [    1.091910] pc : add_interrupt_randomness+0x2e8/0x318
>> [    1.092965] lr : add_interrupt_randomness+0x2e8/0x318
>> [    1.094021] sp : ffff80001000be80
>> [    1.094732] x29: ffff80001000be80 x28: ffff2d0c80209840
>> [    1.095859] x27: 00000000137c3e3a x26: ffff8000100abdd0
>> [    1.096978] x25: 0000000000000035 x24: ffff67918bda8000
>> [    1.098100] x23: ffffc57c31923fe8 x22: 00000000fffedc14
>> [    1.099224] x21: ffff2d0dbef796a0 x20: ffffc57c331d16a0
>> [    1.100339] x19: ffffc57c33720a48 x18: 0000000000000010
>> [    1.101459] x17: 0000000000000000 x16: 0000000000000002
>> [    1.102578] x15: 00000000000000e7 x14: ffff80001000bb20
>> [    1.103706] x13: 00000000ffffffea x12: ffffc57c337b56e8
>> [    1.104821] x11: 0000000000000003 x10: ffffc57c3379d6a8
>> [    1.105944] x9 : ffffc57c3379d700 x8 : 0000000000017fe8
>> [    1.107073] x7 : c0000000ffffefff x6 : 0000000000000001
>> [    1.108186] x5 : 0000000000057fa8 x4 : 0000000000000000
>> [    1.109305] x3 : 00000000ffffffff x2 : ffffc57c337455d0
>> [    1.110428] x1 : db8dc9c2a1e0f600 x0 : 0000000000000000
>> [    1.111552] Call trace:
>> [    1.112083]  add_interrupt_randomness+0x2e8/0x318
>> [    1.113074]  handle_irq_event_percpu+0x48/0x90
>> [    1.114016]  handle_irq_event+0x48/0xf8
>> [    1.114826]  handle_fasteoi_irq+0xa4/0x130
>> [    1.115689]  generic_handle_irq+0x30/0x48
>> [    1.116528]  __handle_domain_irq+0x64/0xc0
>> [    1.117392]  gic_handle_irq+0xc0/0x138
>> [    1.118194]  el1_irq+0xbc/0x180
>> [    1.118870]  arch_cpu_idle+0x20/0x30
>> [    1.119630]  default_idle_call+0x8c/0x350
>> [    1.120479]  do_idle+0x224/0x298
>> [    1.121163]  cpu_startup_entry+0x28/0x70
>> [    1.121994]  secondary_start_kernel+0x184/0x198
>> 
>> ... and I couldn't immediately spot why 32-bit arm  would be 
>> different.
>> 
> 
> Hmm, I actually meant both arm64 and ARM.
> 
> Marc looked into this at my request a while ago, and I had a look
> myself as well at the time, and IIRC, we both concluded that we don't
> hit that code path. Darn.

Yes, I remember checking this. Obviously, I need a new pair of 
glasses...

         M.
-- 
Jazz is not dead. It just smells funny...
