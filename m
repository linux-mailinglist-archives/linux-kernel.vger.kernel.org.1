Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB03727F5B2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 01:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732065AbgI3XId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 19:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732012AbgI3XId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 19:08:33 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A58C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 16:08:31 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id z23so5201495ejr.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 16:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oSjyCndmSDw71eE/BIT10kmAi2CWzQm4Fdkl0rDwsVs=;
        b=HIKXee3AjLR1yKNiCxpi/lY3cYYCKNhBnzExJFzXfKnsypgwzwfgjzM0tb17O4Vgyp
         lhgXkKM9j2PeIgZpOnVu++oMi7gJvxIjizwMo703OTz8iXPRoqS8aax65sRSbVXVQhaN
         tvjeuhg5mYZ8mUI0vBLvW61A38C6uccE8YKBXI8V0m4NvbBCXtfIlsDBT4jZHcnedOEg
         PO51mrwjnCCJ8TSH0ZBojL0RZxbyHtHcw2Xb7KRra7wZgBheblTerBSatg5051UvvYcT
         ITGkQ01vRidlmaOwJA9wdrUJhVLTQwm8L4zEsmgVhT/kFZfXhq9Mntu4wkm3OmlCTSg/
         IPLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oSjyCndmSDw71eE/BIT10kmAi2CWzQm4Fdkl0rDwsVs=;
        b=bseGmL09bfYvfzV1MAh+WRXvsGz1vt5EKDDMXdwTXSj3kWVpWthUX7QAnNUEmom+rK
         eaUQe/izC+ODKEkOt6WZKLXvhv0mQXXZ3ojmDLXuiL4YoWUN8mjcYc10hJ0gZN7VhACP
         0dvPgILFTNMd3ALydVBFnBBzlaJbzOMi9MWITpBucyPJ2V7Ces64a2T664ynYNXIZDci
         dGI6Cem38V9a4F59VsKHf+MYBq4WHt8JFv7pEW693/NZo+cZpfskpZ/YhvhbinGI1/Fr
         J/PjF9QESjjCbHDzY+t0DiN3M7+7dMQPbqcBdU56j70/WHjcDtsSqpdWSwT2XwY57IOP
         pJjw==
X-Gm-Message-State: AOAM530KDP0I2NaDzvw27LrubCx0TvasDd+CLy8Bxr+c14u3IQ3bNl+o
        BRRVuh4HQUT1+VJxfFiX2b1T6Hd4+q/H8rYeCF7XuQ==
X-Google-Smtp-Source: ABdhPJyC+4DouNB+AJFTmGjbAtJDvRkfFxZToj/svy2V/efpofZpBJvCX/A3ee/XkublfA579qMlv91dBfLYJ/TEfyE=
X-Received: by 2002:a17:906:33c8:: with SMTP id w8mr574212eja.233.1601507310348;
 Wed, 30 Sep 2020 16:08:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1601478774.git.yifeifz2@illinois.edu> <d3d1c05ea0be2b192f480ec52ad64bffbb22dc9d.1601478774.git.yifeifz2@illinois.edu>
 <202009301554.590642EBE@keescook>
In-Reply-To: <202009301554.590642EBE@keescook>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 1 Oct 2020 01:08:04 +0200
Message-ID: <CAG48ez077wMkh-sJebjxd3nAmBsNRCF2U8Vmmy-Fc7dr8KRyqw@mail.gmail.com>
Subject: Re: [PATCH v3 seccomp 5/5] seccomp/cache: Report cache data through /proc/pid/seccomp_cache
To:     Kees Cook <keescook@chromium.org>
Cc:     YiFei Zhu <zhuyifei1999@gmail.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        David Laight <David.Laight@aculab.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[adding x86 folks to enhance bikeshedding]

On Thu, Oct 1, 2020 at 12:59 AM Kees Cook <keescook@chromium.org> wrote:
> On Wed, Sep 30, 2020 at 10:19:16AM -0500, YiFei Zhu wrote:
> > From: YiFei Zhu <yifeifz2@illinois.edu>
> >
> > Currently the kernel does not provide an infrastructure to translate
> > architecture numbers to a human-readable name. Translating syscall
> > numbers to syscall names is possible through FTRACE_SYSCALL
> > infrastructure but it does not provide support for compat syscalls.
> >
> > This will create a file for each PID as /proc/pid/seccomp_cache.
> > The file will be empty when no seccomp filters are loaded, or be
> > in the format of:
> > <arch name> <decimal syscall number> <ALLOW | FILTER>
> > where ALLOW means the cache is guaranteed to allow the syscall,
> > and filter means the cache will pass the syscall to the BPF filter.
> >
> > For the docker default profile on x86_64 it looks like:
> > x86_64 0 ALLOW
> > x86_64 1 ALLOW
> > x86_64 2 ALLOW
> > x86_64 3 ALLOW
> > [...]
> > x86_64 132 ALLOW
> > x86_64 133 ALLOW
> > x86_64 134 FILTER
> > x86_64 135 FILTER
> > x86_64 136 FILTER
> > x86_64 137 ALLOW
> > x86_64 138 ALLOW
> > x86_64 139 FILTER
> > x86_64 140 ALLOW
> > x86_64 141 ALLOW
[...]
> > diff --git a/arch/x86/include/asm/seccomp.h b/arch/x86/include/asm/seccomp.h
> > index 7b3a58271656..33ccc074be7a 100644
> > --- a/arch/x86/include/asm/seccomp.h
> > +++ b/arch/x86/include/asm/seccomp.h
> > @@ -19,13 +19,16 @@
> >  #ifdef CONFIG_X86_64
> >  # define SECCOMP_ARCH_DEFAULT                        AUDIT_ARCH_X86_64
> >  # define SECCOMP_ARCH_DEFAULT_NR             NR_syscalls
> > +# define SECCOMP_ARCH_DEFAULT_NAME           "x86_64"
> >  # ifdef CONFIG_COMPAT
> >  #  define SECCOMP_ARCH_COMPAT                        AUDIT_ARCH_I386
> >  #  define SECCOMP_ARCH_COMPAT_NR             IA32_NR_syscalls
> > +#  define SECCOMP_ARCH_COMPAT_NAME           "x86_32"
>
> I think this should be "ia32"? Is there a good definitive guide on this
> naming convention?

"man 2 syscall" calls them "x86-64" and "i386". The syscall table
files use ABI names "i386" and "64". The syscall stub prefixes use
"x64" and "ia32".

I don't think we have a good consistent naming strategy here. :P
