Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD062BB9A9
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 00:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbgKTXFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 18:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727808AbgKTXFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 18:05:06 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D043C061A04
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 15:05:06 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id x9so11729736ljc.7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 15:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WsItiRlY2ZsY1kLHaN9bW+mg6xUUzDuK1HmeXy3qoOM=;
        b=LULwD43R9K6cuWxcFQ3hXHCXYhiJN+3GbIfFgwF3U+9D4uK3QRYGXhUNIUm/phAvgJ
         O1+dQBQPdrOTkni7W+oLdBOBc2AuCnoiRAW66303aXkiViycOcEDheImdEnAvuTIjXzp
         eLP5Sjq1o7lBd24nmSshBGwl7Y0U5t7ogW/mH3gP2dUJ1nM4usf4NwpQS82BRv6K9Yap
         EMrQjrG/eD9JrD4ypfMMHEas9+4anxoeUxQJeMNfyj46BkBpdcwCf7RtWmInwVepP2GK
         gV24+8jJQZTCASDuFsakteAbIMTSJCXGpatnCUddjQGQYa13xtA2KiDV3arQoVCzVSqZ
         QhLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WsItiRlY2ZsY1kLHaN9bW+mg6xUUzDuK1HmeXy3qoOM=;
        b=LlKz0OQCiiq9YMjLDwCj/xAAPRC3oMH6e4zpSUfcAGjSAH/BED6AiFdWeywpOuSsaw
         RXZ/HfEfZkhOe6Jc1qNnZAPP3hpOtz/PEiPldzA4/cK2ELoF07D7wT6ZGxrT9BQgf2W2
         6gkkJ+1pq7oCnQWnsTIFakOsszB5lZ6greShBxak1pz6DinLIHGNTu1MYCRRyvHLBBc1
         MrLozeqmJPRHoujHuRXiVdxosJt133/QLDitZCFbZU9pkQosIPZxv8AJ1ttBif+Barbn
         dz64tDN2eLeh7Bv+YZVrMx2rIiQM8tBahCXCZbAO+RKv/bhEgltM6JwUHEkmAD80B21l
         F9sA==
X-Gm-Message-State: AOAM532Ctw9IuHYTsijKlvI3EPGa58gzhwbBe+H/sjEMYW+VN/84I/wE
        2vnE6WkITUQtrZ/NMmdr9IvO9MiSF+imJRlwiiYPZw==
X-Google-Smtp-Source: ABdhPJymlpDCBYMRse6yxmhBac3FkYvw4MIKvsrIx7Zv7EbYRWZkOmL5ixX8POB9rfwViL1vOrupv+a/zLsoSj3iJio=
X-Received: by 2002:a2e:8891:: with SMTP id k17mr8457473lji.326.1605913504291;
 Fri, 20 Nov 2020 15:05:04 -0800 (PST)
MIME-Version: 1.0
References: <20201119190237.626-1-chang.seok.bae@intel.com> <20201119190237.626-4-chang.seok.bae@intel.com>
In-Reply-To: <20201119190237.626-4-chang.seok.bae@intel.com>
From:   Jann Horn <jannh@google.com>
Date:   Sat, 21 Nov 2020 00:04:38 +0100
Message-ID: <CAG48ez1aKtwYMEHfGX6_FuX9fOruwvCqEGYVL8eLdV8bg-wHCQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] x86/signal: Prevent an alternate stack overflow
 before a signal delivery
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Dave Martin <Dave.Martin@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Tony Luck <tony.luck@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        libc-alpha@sourceware.org, linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>,
        Roland McGrath <roland@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 8:40 PM Chang S. Bae <chang.seok.bae@intel.com> wrote:
> The kernel pushes data on the userspace stack when entering a signal. If
> using a sigaltstack(), the kernel precisely knows the user stack size.
>
> When the kernel knows that the user stack is too small, avoid the overflow
> and do an immediate SIGSEGV instead.
>
> This overflow is known to occur on systems with large XSAVE state. The
> effort to increase the size typically used for altstacks reduces the
> frequency of these overflows, but this approach is still useful for legacy
> binaries.
>
> Here the kernel expects a bit conservative stack size (for 64-bit apps).
> Legacy binaries used a too-small sigaltstack would be already overflowed
> before this change, if they run on modern hardware.
[...]
> diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
> index ee6f1ceaa7a2..cee41d684dc2 100644
> --- a/arch/x86/kernel/signal.c
> +++ b/arch/x86/kernel/signal.c
> @@ -251,8 +251,13 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size,
>
>         /* This is the X/Open sanctioned signal stack switching.  */
>         if (ka->sa.sa_flags & SA_ONSTACK) {
> -               if (sas_ss_flags(sp) == 0)
> +               if (sas_ss_flags(sp) == 0) {
> +                       /* If the altstack might overflow, die with SIGSEGV: */
> +                       if (!altstack_size_ok(current))
> +                               return (void __user *)-1L;
> +
>                         sp = current->sas_ss_sp + current->sas_ss_size;
> +               }

A couple lines further down, we have this (since commit 14fc9fbc700d):

        /*
         * If we are on the alternate signal stack and would overflow it, don't.
         * Return an always-bogus address instead so we will die with SIGSEGV.
         */
        if (onsigstack && !likely(on_sig_stack(sp)))
                return (void __user *)-1L;

Is that not working?


(It won't handle the case where the kernel fills up almost all of the
alternate stack, and the userspace signal handler then overflows out
of the alternate signal stack. But there isn't much the kernel can do
about that...)
