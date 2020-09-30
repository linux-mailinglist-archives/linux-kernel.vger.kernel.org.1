Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F369E27F514
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 00:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731424AbgI3WZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 18:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731067AbgI3WZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 18:25:00 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBB4C0613D0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 15:25:00 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id o8so5111722ejb.10
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 15:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KwjzYmhHb/l5tPkyGm+gWxyB3dKnDLT96damvVDsJ2o=;
        b=TaMaeVg9pan0BW7Akk6/bQquEKr7WnaOhi8gWvSoFshHON6Z74AABiNZztSTaCTogI
         qcX7baxYxrulvGyDRZTM4bOhqpi0Sqza7QEDiz2rMZJ1EO73ptKJa4+1P98+vP6Ew7xK
         LEzbLI+LRCtpYBYt9ofUPwxVymoVTFDdpGnSucOjI7Zacw1Gco3t6vRlLt9OuQja6AMJ
         OjLIUusdonw9sNDn7NsiKujPO7Y/Fh6L89W3AWXDeWbLe7fsimcVZuFyFq3IziQnjhG2
         +lGUtU2S6fhEnlpGkuF+RMWZl0Jg3W5ZGxhNGSCKsM26TJaMdAznAWum0J+/CdK6Dcc0
         Q/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KwjzYmhHb/l5tPkyGm+gWxyB3dKnDLT96damvVDsJ2o=;
        b=fnbHLKktPgm1i9uThBBCvRbaWS40E4XbF0gB+ipvyEhHmhfuqhdJIDrtZk4JvC0XKV
         BpAwDtK0xYrXcKQHmlUeyOh3YxfiXJJKFmIG6LsrhCRRgUFGZ02Q+jewlJszegAC+v7T
         6ccv+iNlpJfotgcszzSqhD9RkT7+aw3/tzW61tm4u/TA6u5mIe8A5uhMG5HjV36/Uu7W
         k3tMOra928dW9BpNfQkODG3ws7EisMCKXKs9BRn1Myl62spUL0vqAvIvcW46ISX8fyop
         A1taZ0PLfS8G86dzBxbAGLMIxdREjMWemD2DQkhoXynMQssY6xV1sdXcTsO8glJ6ehCG
         mtcA==
X-Gm-Message-State: AOAM531PUsiPv5ICUBcqnM4BI6gKrpbfibigXilpX6eiWcHbmnKcCQoo
        J6eN2NydH8JHl68zIwfGLylN9dzbXJfrLvQOjFjQXA==
X-Google-Smtp-Source: ABdhPJwf2Ih9sOkNH0XKF+uPNFVAplx37AhDqvFCkipTk5tzsR8+wlzRLDPvzToK+HK8NAJ25kPUij91WMm94qh9eCg=
X-Received: by 2002:a17:906:9389:: with SMTP id l9mr5200759ejx.537.1601504698740;
 Wed, 30 Sep 2020 15:24:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1601478774.git.yifeifz2@illinois.edu> <b16456e8dbc378c41b73c00c56854a3c30580833.1601478774.git.yifeifz2@illinois.edu>
In-Reply-To: <b16456e8dbc378c41b73c00c56854a3c30580833.1601478774.git.yifeifz2@illinois.edu>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 1 Oct 2020 00:24:32 +0200
Message-ID: <CAG48ez0Njm0oS+9k-cgUqzyUWXV=cHPope2Xe9vVNPUVZ1PB4w@mail.gmail.com>
Subject: Re: [PATCH v3 seccomp 2/5] seccomp/cache: Add "emulator" to check if
 filter is constant allow
To:     YiFei Zhu <zhuyifei1999@gmail.com>
Cc:     Linux Containers <containers@lists.linux-foundation.org>,
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
        Kees Cook <keescook@chromium.org>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 5:20 PM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
> SECCOMP_CACHE_NR_ONLY will only operate on syscalls that do not
> access any syscall arguments or instruction pointer. To facilitate
> this we need a static analyser to know whether a filter will
> return allow regardless of syscall arguments for a given
> architecture number / syscall number pair. This is implemented
> here with a pseudo-emulator, and stored in a per-filter bitmap.
>
> Each common BPF instruction are emulated. Any weirdness or loading
> from a syscall argument will cause the emulator to bail.
>
> The emulation is also halted if it reaches a return. In that case,
> if it returns an SECCOMP_RET_ALLOW, the syscall is marked as good.
>
> Emulator structure and comments are from Kees [1] and Jann [2].
>
> Emulation is done at attach time. If a filter depends on more
> filters, and if the dependee does not guarantee to allow the
> syscall, then we skip the emulation of this syscall.
>
> [1] https://lore.kernel.org/lkml/20200923232923.3142503-5-keescook@chromium.org/
> [2] https://lore.kernel.org/lkml/CAG48ez1p=dR_2ikKq=xVxkoGg0fYpTBpkhJSv1w-6BG=76PAvw@mail.gmail.com/
[...]
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 1ab22869a765..ff5289228ea5 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -150,6 +150,7 @@ config X86
>         select HAVE_ARCH_COMPAT_MMAP_BASES      if MMU && COMPAT
>         select HAVE_ARCH_PREL32_RELOCATIONS
>         select HAVE_ARCH_SECCOMP_FILTER
> +       select HAVE_ARCH_SECCOMP_CACHE_NR_ONLY
>         select HAVE_ARCH_THREAD_STRUCT_WHITELIST
>         select HAVE_ARCH_STACKLEAK
>         select HAVE_ARCH_TRACEHOOK

If you did the architecture enablement for X86 later in the series,
you could move this part over into that patch, that'd be cleaner.

> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index ae6b40cc39f4..f09c9e74ae05 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -143,6 +143,37 @@ struct notification {
>         struct list_head notifications;
>  };
>
> +#ifdef CONFIG_SECCOMP_CACHE_NR_ONLY
> +/**
> + * struct seccomp_cache_filter_data - container for cache's per-filter data
> + *
> + * Tis struct is ordered to minimize padding holes.

I think this comment can probably go away, there isn't really much
trickery around padding holes in the struct as it is now.

> + * @syscall_allow_default: A bitmap where each bit represents whether the
> + *                        filter willalways allow the syscall, for the

nit: s/willalways/will always/

[...]
> +static void seccomp_cache_prepare_bitmap(struct seccomp_filter *sfilter,
> +                                        void *bitmap, const void *bitmap_prev,
> +                                        size_t bitmap_size, int arch)
> +{
> +       struct sock_fprog_kern *fprog = sfilter->prog->orig_prog;
> +       struct seccomp_data sd;
> +       int nr;
> +
> +       for (nr = 0; nr < bitmap_size; nr++) {
> +               if (bitmap_prev && !test_bit(nr, bitmap_prev))
> +                       continue;
> +
> +               sd.nr = nr;
> +               sd.arch = arch;
> +
> +               if (seccomp_emu_is_const_allow(fprog, &sd))
> +                       set_bit(nr, bitmap);

set_bit() is atomic, but since we only do this at filter setup, before
the filter becomes globally visible, we don't need atomicity here. So
this should probably use __set_bit() instead.
