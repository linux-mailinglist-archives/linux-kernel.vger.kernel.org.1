Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECCAC1BA1F8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 13:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgD0LKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 07:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726539AbgD0LKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 07:10:01 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71FDBC0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 04:10:01 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jT1e2-0000nL-Fs; Mon, 27 Apr 2020 13:09:50 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id D89C5100606; Mon, 27 Apr 2020 13:09:49 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ingo Molnar <mingo@kernel.org>, Leon Romanovsky <leon@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86 <x86@kernel.org>,
        Suresh Siddha <suresh.b.siddha@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/apic: Fix circular locking dependency between console and hrtimer locks
In-Reply-To: <20200414062454.GA84326@gmail.com>
References: <20200407170925.1775019-1-leon@kernel.org> <20200414054836.GA956407@unreal> <20200414062454.GA84326@gmail.com>
Date:   Mon, 27 Apr 2020 13:09:49 +0200
Message-ID: <87tv15qj5u.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@kernel.org> writes:
> * Leon Romanovsky <leon@kernel.org> wrote:
> The fix definitely looks legit, lockdep is right that we shouldn't take 
> the console_sem.lock even under trylock.
>
> It's only a printk_once(), yet I'm wondering why in the last ~8 years 
> this never triggered. Nobody ever ran lockdep and debug console level 
> enabled on such hardware, or did something else change?
>
> One possibility would be that apic_check_deadline_errata() marked almost 
> all Intel systems as broken and the TSC-deadline hardware never actually 
> got activated. In that case you have triggered rarely tested code and 
> might see other weirdnesses. Just saying. :-)
>
> Or a bootup with "debug" specified is much more rare in production 
> systems, hence the 8 years old bug.

None of this makes any sense at all.

The local APIC timer (in this case the TSC deadline timer) is set up
during early boot on the boot CPU (before SMP setup) with this call
chain:

smp_prepare_cpus()
 native_smp_prepare_cpus()
   x86_init.timers.setup_percpu_clockev()
     setup_boot_APIC_clock()
       setup_APIC_timer()
         clockevents_config_and_register()
           tick_check_new_device()
             tick_setup_device()
               tick_setup_oneshot()
                 clockevents_switch_state()
                   lapic_timer_set_oneshot()
                     __setup_APIC_LVTT()
                       printk_once(...)

Nothing holds hrtimer.base_lock in this call chain.

But the lockdep splat clearly says:

 [  735.324357] stack backtrace:
 [  735.324360] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 5.6.0-for-upstream-dbg-2020-04-03_10-44-43-70 #1

...

So how can that be the first invocation of that printk_once()?

While the patch looks innocent, it papers over the underlying problem
and wild theories are not really helping here.

Here is a boot log excerpt with lockdep enabled and 'debug' on the
command line:

[    0.000000] Linux version 5.7.0-rc3 ...
...
[    3.992125] TSC deadline timer enabled
[    3.995820] smpboot: CPU0: Intel(R) ....
...
[    4.050766] smp: Bringing up secondary CPUs ...

No splat nothing. The real question is WHY this triggers on Leons
machine 735 seconds after boot and on CPU3.

Thanks,

        tglx
