Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0262A09AA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 16:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgJ3PWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 11:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbgJ3PWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 11:22:53 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F172DC0613D2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 08:22:52 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id a7so8334177lfk.9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 08:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5sSkbnbDNPQyj7tIyOHf0OZ0EnyY+U+Tr7Q/pQTsliQ=;
        b=wU+xx2bxR8RyIDjURsVJrhnOKOfcFiQYDMWEvIaeuyW5aGNhZqWf1dtpN2n4F3NsJU
         HppUrs7H0lk2qIrSgTeFcNiE1h+/1/elHdKv2wBA/d3Cb+Yn/qVc5aHqDX2kTRM0FlS3
         nIVVV0Oy4OkmdCIJ8AKJt8+jrvs0gfNjrKK5kQeR4X3twWg+3zGMFU4Hyzs987aPU5DC
         1OTUdauKuFPZWjob1v3N8JTmx5MTcCoWOPGmX0D5W73tJhSWN3+F5ksSdNjv+Chq4veK
         oyNBDfrWv3q2nrzVucDlW9OJlVKLQCeMpMTrtiyse23US5OjWuYJC8Eg07Fh6gR6Kzqd
         NT1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5sSkbnbDNPQyj7tIyOHf0OZ0EnyY+U+Tr7Q/pQTsliQ=;
        b=qtq6isdBftavbshSIbfu+4OLb76RT1SFjQsJ+XtlzRwql1LMqkBveICDlUfZLYeZ0n
         4J3YZwVyZQMnZSJBECguTLGvWIHGm67BedznRQCwnFy0zfuAJ+u5SOO9ZFlqNO24WFh+
         XFnxdBv4dA0MZYE/R70/jiSr0mKmQbxe05caUw+7c8l4ZrKjEDcfYAeu+n2V+XoMBWBK
         sV4E7U3J6LjlIo9S9von1uNtON2YsdwV8QKakLCwW8RDy2qDkYxpAdcWtR0ZK2FEA5ro
         Od1cojWimUbnWLJkV7LvIH9EDkKwJF870GrxzTz6ZsiBj2EeSXiltjwC8bXbHZFWTJr5
         LAKg==
X-Gm-Message-State: AOAM531vt/PwNUPijv/zNs4Zw2kX/vKSgXEwXwWYmR+3pC1VHAh5w/EN
        dVjUGN7JWiSKvMSL532K3E0l/elZlpGNxT3McKRkaw==
X-Google-Smtp-Source: ABdhPJwLZMfK+/wKcVf/f3wxYqaH0PlYsimcp5h9RqJlxCzfH0SY3Zlp7ANGGJQDqEL2L9l6kszh99qZ39iPqxje9Z8=
X-Received: by 2002:a05:6512:51a:: with SMTP id o26mr1098326lfb.381.1604071371166;
 Fri, 30 Oct 2020 08:22:51 -0700 (PDT)
MIME-Version: 1.0
References: <20201029131649.182037-1-elver@google.com> <20201029131649.182037-3-elver@google.com>
 <CAG48ez1n7FrRA8Djq5685KcUJp1YgW0qijtBYNm2c9ZqQ1M4rw@mail.gmail.com> <CANpmjNNBoiL2=JDD=vC5dB_TPW1Ybe5k7SqqhvUE2B7GmzRLyg@mail.gmail.com>
In-Reply-To: <CANpmjNNBoiL2=JDD=vC5dB_TPW1Ybe5k7SqqhvUE2B7GmzRLyg@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 30 Oct 2020 16:22:24 +0100
Message-ID: <CAG48ez1=uad2yMeffArw7Nem3Hea3pnL9rqAFsB7fFzBd+4Hcw@mail.gmail.com>
Subject: Re: [PATCH v6 2/9] x86, kfence: enable KFENCE for x86
To:     Marco Elver <elver@google.com>
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
        =?UTF-8?Q?J=C3=B6rn_Engel?= <joern@purestorage.com>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 2:00 PM Marco Elver <elver@google.com> wrote:
> On Fri, 30 Oct 2020 at 03:49, Jann Horn <jannh@google.com> wrote:
> > On Thu, Oct 29, 2020 at 2:17 PM Marco Elver <elver@google.com> wrote:
> > > Add architecture specific implementation details for KFENCE and enable
> > > KFENCE for the x86 architecture. In particular, this implements the
> > > required interface in <asm/kfence.h> for setting up the pool and
> > > providing helper functions for protecting and unprotecting pages.
> > >
> > > For x86, we need to ensure that the pool uses 4K pages, which is done
> > > using the set_memory_4k() helper function.
> > >
> > > Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> > > Co-developed-by: Marco Elver <elver@google.com>
> > > Signed-off-by: Marco Elver <elver@google.com>
> > > Signed-off-by: Alexander Potapenko <glider@google.com>
> > [...]
> > > diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> > [...]
> > > @@ -725,6 +726,9 @@ no_context(struct pt_regs *regs, unsigned long error_code,
> > >         if (IS_ENABLED(CONFIG_EFI))
> > >                 efi_recover_from_page_fault(address);
> > >
> > > +       if (kfence_handle_page_fault(address))
> > > +               return;
[...]
> > Unrelated sidenote: Since we're hooking after exception fixup
> > handling, the debug-only KFENCE_STRESS_TEST_FAULTS can probably still
> > cause some behavioral differences through spurious faults in places
> > like copy_user_enhanced_fast_string (where the exception table entries
> > are used even if the *kernel* pointer, not the user pointer, causes a
> > fault). But since KFENCE_STRESS_TEST_FAULTS is exclusively for KFENCE
> > development, the difference might not matter. And ordering them the
> > other way around definitely isn't possible, because the kernel relies
> > on being able to fixup OOB reads. So there probably isn't really
> > anything we can do better here; it's just something to keep in mind.
> > Maybe you can add a little warning to the help text for that Kconfig
> > entry that warns people about this?
>
> Thanks for pointing it out, but that option really is *only* to stress
> kfence with concurrent allocations/frees/page faults. If anybody
> enables this option for anything other than testing kfence, it's their
> own fault. ;-)

Sounds fair. :P

> I'll try to add a generic note to the Kconfig entry, but what you
> mention here seems quite x86-specific.

(FWIW, I think it could currently also happen on arm64 in the rare
cases where KERNEL_DS is used. But luckily Christoph Hellwig has
already gotten rid of most places that did that.)
