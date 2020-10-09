Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C505289026
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 19:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387745AbgJIRlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 13:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387445AbgJIRk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 13:40:29 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC746C0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 10:40:28 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id j136so10623858wmj.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 10:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jlGJz5/Gwof+W4rud68ka3SNYNEZKejaW6R1zlgBIpo=;
        b=teg3EY+1daVLL0UdvTTQTJ0cy289r3xD9FwLsKpXsFfjHK/YF7s1tBVchWh/5qS/jo
         Ux3Ag+UmrWT0xiVPy1R/AMi2+O0LtwiooU7LdxZtDro4PEX/5quBf8iitVVyCxMClNnQ
         DDEwvbh0F1iAJheGaGxNqzmIerDKwPEwrjOlMpeodZXGdXVgI1mtzmA+rZ1WO6zvHim0
         4ouzfObX9uOCK/Emr+TXtMBQvx29tXWw0Hvxl+4nhB/cDJyyMG0rF30602bDJcL7COBl
         QbUxsr2C4nFQj2MApHkMIgURwGIK9nFW5/GEuzeXib+A3QBW/LMC1kE7v8dTAlaBu5aX
         vp3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jlGJz5/Gwof+W4rud68ka3SNYNEZKejaW6R1zlgBIpo=;
        b=FFlM6oj3UnzjJOsG5SDignhWoIVnCuW4mt1UgaVkQbaCa01HRMd6wwQKdCbEi5l6UP
         8/rCIoLLGQ6QoTi3nC2iKoEmMqSJzI9/xCM6vL1YD5NLNODkDiXKtsAruav2nPNBLVoI
         W3jUoHsEltBeCurw7zvr5/PXqU01horFjoZOPmTBVIyCrlfksmwFZ2cF4XjgnNFCNVoq
         qfjG/awXyrBpQY3jn543riCO4IJg+pGKO92Hp94hDb2uhDENAis3fKaLO6yecjE49T+r
         9JovlWGQiBS757wUFwe/CCkL/04k5+ZKIhtZPr/fGYm28J0uYRdBD3GcV8zfMKS2zVAE
         ByHQ==
X-Gm-Message-State: AOAM531sGqYgF+VMiMbpH0AZ+CPg4UjJIp9/M2QkNRpxq+fZpzAJddN6
        OZfzpxxYlMEMCL8WR++YzJf67g==
X-Google-Smtp-Source: ABdhPJyVg356+1RWEQY7Mynabzoo2cJm6jwNSIHCdWOgWgbdGifWNPtV/sTRf4yAdVbyrUaeL6Q8yQ==
X-Received: by 2002:a1c:c28a:: with SMTP id s132mr16271717wmf.13.1602265227336;
        Fri, 09 Oct 2020 10:40:27 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id n9sm12465852wrq.72.2020.10.09.10.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 10:40:26 -0700 (PDT)
Date:   Fri, 9 Oct 2020 19:40:20 +0200
From:   Marco Elver <elver@google.com>
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hillf Danton <hdanton@sina.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        SeongJae Park <sjpark@amazon.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH v4 02/11] x86, kfence: enable KFENCE for x86
Message-ID: <20201009174020.GA2263081@elver.google.com>
References: <20200929133814.2834621-1-elver@google.com>
 <20200929133814.2834621-3-elver@google.com>
 <CAG48ez3OKj5Y8BURmqU9BAYWFJH8E8B5Dj9c0=UHutqf7r3hhg@mail.gmail.com>
 <CANpmjNP6mukCZ931_aW9dDqbkOyv=a2zbS7MuEMkE+unb7nYeg@mail.gmail.com>
 <CAG48ez0sYZof_PDdNrqPUnNOCz1wcauma+zWJbF+VdUuO6x31w@mail.gmail.com>
 <CANpmjNOZtkFcyL8FTRTZ6j2yqCOb2Hgsy8eF8n5zgd7mDYezkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNOZtkFcyL8FTRTZ6j2yqCOb2Hgsy8eF8n5zgd7mDYezkw@mail.gmail.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 04:41PM +0200, Marco Elver wrote:
> On Wed, 7 Oct 2020 at 16:15, Jann Horn <jannh@google.com> wrote:
[...]
> > > > > +               return false;
> > > > > +
> > > > > +       if (protect)
> > > > > +               set_pte(pte, __pte(pte_val(*pte) & ~_PAGE_PRESENT));
> > > > > +       else
> > > > > +               set_pte(pte, __pte(pte_val(*pte) | _PAGE_PRESENT));
> > > >
> > > > Hmm... do we have this helper (instead of using the existing helpers
> > > > for modifying memory permissions) to work around the allocation out of
> > > > the data section?
> > >
> > > I just played around with using the set_memory.c functions, to remind
> > > myself why this didn't work. I experimented with using
> > > set_memory_{np,p}() functions; set_memory_p() isn't implemented, but
> > > is easily added (which I did for below experiment). However, this
> > > didn't quite work:
> > [...]
> > > For one, smp_call_function_many_cond() doesn't want to be called with
> > > interrupts disabled, and we may very well get a KFENCE allocation or
> > > page fault with interrupts disabled / within interrupts.
> > >
> > > Therefore, to be safe, we should avoid IPIs.
> >
> > set_direct_map_invalid_noflush() does that, too, I think? And that's
> > already implemented for both arm64 and x86.
> 
> Sure, that works.
> 
> We still want the flush_tlb_one_kernel(), at least so the local CPU's
> TLB is flushed.

Nope, sorry, set_direct_map_invalid_noflush() does not work -- this
results in potential deadlock.

	================================
	WARNING: inconsistent lock state
	5.9.0-rc4+ #2 Not tainted
	--------------------------------
	inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
	ksoftirqd/1/16 [HC0[0]:SC1[1]:HE1:SE0] takes:
	ffffffff89fcf9b8 (cpa_lock){+.?.}-{2:2}, at: spin_lock include/linux/spinlock.h:354 [inline]
	ffffffff89fcf9b8 (cpa_lock){+.?.}-{2:2}, at: __change_page_attr_set_clr+0x1b0/0x2510 arch/x86/mm/pat/set_memory.c:1658
	{SOFTIRQ-ON-W} state was registered at:
	  lock_acquire+0x1f3/0xae0 kernel/locking/lockdep.c:5006
	  __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
	  _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
	  spin_lock include/linux/spinlock.h:354 [inline]
	  __change_page_attr_set_clr+0x1b0/0x2510 arch/x86/mm/pat/set_memory.c:1658
	  change_page_attr_set_clr+0x333/0x500 arch/x86/mm/pat/set_memory.c:1752
	  change_page_attr_set arch/x86/mm/pat/set_memory.c:1782 [inline]
	  set_memory_nx+0xb2/0x110 arch/x86/mm/pat/set_memory.c:1930
	  free_init_pages+0x73/0xc0 arch/x86/mm/init.c:876
	  alternative_instructions+0x155/0x1a4 arch/x86/kernel/alternative.c:738
	  check_bugs+0x1bd0/0x1c77 arch/x86/kernel/cpu/bugs.c:140
	  start_kernel+0x486/0x4b6 init/main.c:1042
	  secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:243
	irq event stamp: 14564
	hardirqs last  enabled at (14564): [<ffffffff8828cadf>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:160 [inline]
	hardirqs last  enabled at (14564): [<ffffffff8828cadf>] _raw_spin_unlock_irqrestore+0x6f/0x90 kernel/locking/spinlock.c:191
	hardirqs last disabled at (14563): [<ffffffff8828d239>] __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:108 [inline]
	hardirqs last disabled at (14563): [<ffffffff8828d239>] _raw_spin_lock_irqsave+0xa9/0xce kernel/locking/spinlock.c:159
	softirqs last  enabled at (14486): [<ffffffff8147fcff>] run_ksoftirqd kernel/softirq.c:652 [inline]
	softirqs last  enabled at (14486): [<ffffffff8147fcff>] run_ksoftirqd+0xcf/0x170 kernel/softirq.c:644
	softirqs last disabled at (14491): [<ffffffff8147fcff>] run_ksoftirqd kernel/softirq.c:652 [inline]
	softirqs last disabled at (14491): [<ffffffff8147fcff>] run_ksoftirqd+0xcf/0x170 kernel/softirq.c:644

	other info that might help us debug this:
	 Possible unsafe locking scenario:

	       CPU0
	       ----
	  lock(cpa_lock);
	  <Interrupt>
	    lock(cpa_lock);

	 *** DEADLOCK ***

	1 lock held by ksoftirqd/1/16:
	 #0: ffffffff8a067e20 (rcu_callback){....}-{0:0}, at: rcu_do_batch kernel/rcu/tree.c:2418 [inline]
	 #0: ffffffff8a067e20 (rcu_callback){....}-{0:0}, at: rcu_core+0x55d/0x1130 kernel/rcu/tree.c:2656

	stack backtrace:
	CPU: 1 PID: 16 Comm: ksoftirqd/1 Not tainted 5.9.0-rc4+ #2
	Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1 04/01/2014
	Call Trace:
	 __dump_stack lib/dump_stack.c:77 [inline]
	 dump_stack+0x198/0x1fd lib/dump_stack.c:118
	 print_usage_bug kernel/locking/lockdep.c:3350 [inline]
	 valid_state kernel/locking/lockdep.c:3361 [inline]
	 mark_lock_irq kernel/locking/lockdep.c:3575 [inline]
	 mark_lock.cold+0x12/0x17 kernel/locking/lockdep.c:4006
	 mark_usage kernel/locking/lockdep.c:3905 [inline]
	 __lock_acquire+0x1159/0x5780 kernel/locking/lockdep.c:4380
	 lock_acquire+0x1f3/0xae0 kernel/locking/lockdep.c:5006
	 __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
	 _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
	 spin_lock include/linux/spinlock.h:354 [inline]
	 __change_page_attr_set_clr+0x1b0/0x2510 arch/x86/mm/pat/set_memory.c:1658
	 __set_pages_np arch/x86/mm/pat/set_memory.c:2184 [inline]
	 set_direct_map_invalid_noflush+0xd2/0x110 arch/x86/mm/pat/set_memory.c:2189
	 kfence_protect_page arch/x86/include/asm/kfence.h:62 [inline]
	 kfence_protect+0x10e/0x120 mm/kfence/core.c:124
	 kfence_guarded_free+0x380/0x880 mm/kfence/core.c:375
	 rcu_do_batch kernel/rcu/tree.c:2428 [inline]
	 rcu_core+0x5ca/0x1130 kernel/rcu/tree.c:2656
	 __do_softirq+0x1f8/0xb23 kernel/softirq.c:298
	 run_ksoftirqd kernel/softirq.c:652 [inline]
	 run_ksoftirqd+0xcf/0x170 kernel/softirq.c:644
	 smpboot_thread_fn+0x655/0x9e0 kernel/smpboot.c:165
	 kthread+0x3b5/0x4a0 kernel/kthread.c:292
	 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294


