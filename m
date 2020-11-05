Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1EB2A80E6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 15:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731117AbgKEOab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 09:30:31 -0500
Received: from foss.arm.com ([217.140.110.172]:34116 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726874AbgKEOab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 09:30:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9462114BF;
        Thu,  5 Nov 2020 06:30:30 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.58.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D2363F719;
        Thu,  5 Nov 2020 06:30:26 -0800 (PST)
Date:   Thu, 5 Nov 2020 14:30:23 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
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
Message-ID: <20201105143023.GI82102@C02TD0UTHF1T.local>
References: <20201105125656.25259-1-andre.przywara@arm.com>
 <20201105125656.25259-5-andre.przywara@arm.com>
 <20201105134142.GA4856@sirena.org.uk>
 <20201105140322.GH82102@C02TD0UTHF1T.local>
 <CAMj1kXEsaZAGT0jnPNyj_K1Q4W7E1+WP=tQf3bTPQi=KOCUv4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEsaZAGT0jnPNyj_K1Q4W7E1+WP=tQf3bTPQi=KOCUv4g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 05, 2020 at 03:04:57PM +0100, Ard Biesheuvel wrote:
> On Thu, 5 Nov 2020 at 15:03, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Thu, Nov 05, 2020 at 01:41:42PM +0000, Mark Brown wrote:
> > > On Thu, Nov 05, 2020 at 12:56:55PM +0000, Andre Przywara wrote:

> > That said, I'm not sure it's great to plumb this under the
> > arch_get_random*() interfaces, e.g. given this measn that
> > add_interrupt_randomness() will end up trapping to the host all the time
> > when it calls arch_get_random_seed_long().
> 
> As it turns out, add_interrupt_randomness() isn't actually used on ARM.

It's certainly called on arm64, per a warning I just hacked in:

[    1.083802] ------------[ cut here ]------------
[    1.084802] add_interrupt_randomness called
[    1.085685] WARNING: CPU: 1 PID: 0 at drivers/char/random.c:1267 add_interrupt_randomness+0x2e8/0x318
[    1.087599] Modules linked in:
[    1.088258] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.10.0-rc2-dirty #13
[    1.089672] Hardware name: linux,dummy-virt (DT)
[    1.090659] pstate: 60400085 (nZCv daIf +PAN -UAO -TCO BTYPE=--)
[    1.091910] pc : add_interrupt_randomness+0x2e8/0x318
[    1.092965] lr : add_interrupt_randomness+0x2e8/0x318
[    1.094021] sp : ffff80001000be80
[    1.094732] x29: ffff80001000be80 x28: ffff2d0c80209840 
[    1.095859] x27: 00000000137c3e3a x26: ffff8000100abdd0 
[    1.096978] x25: 0000000000000035 x24: ffff67918bda8000 
[    1.098100] x23: ffffc57c31923fe8 x22: 00000000fffedc14 
[    1.099224] x21: ffff2d0dbef796a0 x20: ffffc57c331d16a0 
[    1.100339] x19: ffffc57c33720a48 x18: 0000000000000010 
[    1.101459] x17: 0000000000000000 x16: 0000000000000002 
[    1.102578] x15: 00000000000000e7 x14: ffff80001000bb20 
[    1.103706] x13: 00000000ffffffea x12: ffffc57c337b56e8 
[    1.104821] x11: 0000000000000003 x10: ffffc57c3379d6a8 
[    1.105944] x9 : ffffc57c3379d700 x8 : 0000000000017fe8 
[    1.107073] x7 : c0000000ffffefff x6 : 0000000000000001 
[    1.108186] x5 : 0000000000057fa8 x4 : 0000000000000000 
[    1.109305] x3 : 00000000ffffffff x2 : ffffc57c337455d0 
[    1.110428] x1 : db8dc9c2a1e0f600 x0 : 0000000000000000 
[    1.111552] Call trace:
[    1.112083]  add_interrupt_randomness+0x2e8/0x318
[    1.113074]  handle_irq_event_percpu+0x48/0x90
[    1.114016]  handle_irq_event+0x48/0xf8
[    1.114826]  handle_fasteoi_irq+0xa4/0x130
[    1.115689]  generic_handle_irq+0x30/0x48
[    1.116528]  __handle_domain_irq+0x64/0xc0
[    1.117392]  gic_handle_irq+0xc0/0x138
[    1.118194]  el1_irq+0xbc/0x180
[    1.118870]  arch_cpu_idle+0x20/0x30
[    1.119630]  default_idle_call+0x8c/0x350
[    1.120479]  do_idle+0x224/0x298
[    1.121163]  cpu_startup_entry+0x28/0x70
[    1.121994]  secondary_start_kernel+0x184/0x198

... and I couldn't immediately spot why 32-bit arm  would be different.

Thanks,
Mark.
