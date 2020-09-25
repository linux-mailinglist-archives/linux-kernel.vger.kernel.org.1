Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B899277C90
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 02:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgIYABF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 20:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726662AbgIYABE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 20:01:04 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53796C0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 17:01:04 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 34so888751pgo.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 17:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=/OTxLvYfK8xiR41MGEfuvkgKyuS84smKQAqFrQ02ILY=;
        b=DtM19Zce3SGpX2cE2G7n4o55fRUBl0rHICjJ75Y7xKtq2kBxVGsVg9S2nGRZtPunUf
         L8zI2GaelK5W3oPAZqUnfZ1IuQkpnWFxdLBw1kcVvgMXeTe48FdAhKcGxvwmjrrjEBfc
         LUvZyp28iYLW68aNMVZC8eLcA3LBVnx6n0y+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=/OTxLvYfK8xiR41MGEfuvkgKyuS84smKQAqFrQ02ILY=;
        b=E7OMMjkmA2mHb7RqlHp2/EqOMsfrHlEPiaACCY6PV4Czw3Gq+XuVsfbeGCXgJCwoof
         zgwChDgLwr82bCiSQ1uRkPEKF0isrB+y2Rz7UdzrWn23TX0gW2avz12vT3N1qnAlHuwH
         6q1SPEfYC5ZSW0MwxFgFokE+Z3kDwOMQk0AxIgP5852OPqICebfMLzdw9rqKC9B3nROz
         4msadvVROwwFbt1NlUi3YCK7rlo+Xoe0nVjKlyuPdmXoAPumbVVDillCKDdPEiNUyh+J
         oXU01xhvNYUuVepUz1JKyX/M2dbfTIDAQ2cdZMqEU6WSRi7GjrZ2+ANqssdwHm6KWTZ8
         lJmw==
X-Gm-Message-State: AOAM533X1jZ/TJc3ZPzcF024vPQDHIxkc40Iu9SVtlcOTtAzhYQgXbgg
        LDu6cFGLLTIcGHdhNObz/kppyg==
X-Google-Smtp-Source: ABdhPJzFgb+I/zUJIdM3HtyobzSa8FdBgx88dp5VT/DNVzwJHBDqG5NLMOsVAnQdibYUioz9uKHzRw==
X-Received: by 2002:a17:902:8bca:b029:d2:42fe:20a8 with SMTP id r10-20020a1709028bcab02900d242fe20a8mr1633137plo.47.1600992063785;
        Thu, 24 Sep 2020 17:01:03 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y1sm423332pgr.3.2020.09.24.17.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 17:01:02 -0700 (PDT)
Date:   Thu, 24 Sep 2020 17:01:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     YiFei Zhu <yifeifz2@illinois.edu>
Cc:     YiFei Zhu <zhuyifei1999@gmail.com>,
        containers@lists.linux-foundation.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Jann Horn <jannh@google.com>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
Subject: Re: [PATCH v2 seccomp 2/6] asm/syscall.h: Add syscall_arches[] array
Message-ID: <202009241658.A062D6AE@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b792335294ee5598d0fb42702a49becbce2f925f.1600661419.git.yifeifz2@illinois.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[resend, argh, I didn't reply-all, sorry for the noise]

On Thu, Sep 24, 2020 at 07:44:17AM -0500, YiFei Zhu wrote:
> From: YiFei Zhu <yifeifz2@illinois.edu>
> 
> Seccomp cache emulator needs to know all the architecture numbers
> that syscall_get_arch() could return for the kernel build in order
> to generate a cache for all of them.
> 
> The array is declared in header as static __maybe_unused const
> to maximize compiler optimiation opportunities such as loop
> unrolling.

Disregarding the "how" of this, yeah, we'll certainly need something to
tell seccomp about the arrangement of syscall tables and how to find
them.

However, I'd still prefer to do this on a per-arch basis, and include
more detail, as I've got in my v1.

Something missing from both styles, though, is a consolidation of
values, where the AUDIT_ARCH* isn't reused in both the seccomp info and
the syscall_get_arch() return. The problems here were two-fold:

1) putting this in syscall.h meant you do not have full NR_syscall*
   visibility on some architectures (e.g. arm64 plays weird games with
   header include order).

2) seccomp needs to handle "multiplexed" tables like x86_x32 (distros
   haven't removed CONFIG_X86_X32 widely yet, so it is a reality that
   it must be dealt with), which means seccomp's idea of the arch
   "number" can't be the same as the AUDIT_ARCH.

So, likely a combo of approaches is needed: an array (or more likely,
enum), declared in the per-arch seccomp.h file. And I don't see a way
to solve #1 cleanly.

Regardless, it needs to be split per architecture so that regressions
can be bisected/reverted/isolated cleanly. And if we can't actually test
it at runtime (or find someone who can) it's not a good idea to make the
change. :)

> [...]
> diff --git a/arch/x86/include/asm/syscall.h b/arch/x86/include/asm/syscall.h
> index 7cbf733d11af..e13bb2a65b6f 100644
> --- a/arch/x86/include/asm/syscall.h
> +++ b/arch/x86/include/asm/syscall.h
> @@ -97,6 +97,10 @@ static inline void syscall_set_arguments(struct task_struct *task,
>  	memcpy(&regs->bx + i, args, n * sizeof(args[0]));
>  }
>  
> +static __maybe_unused const int syscall_arches[] = {
> +	AUDIT_ARCH_I386
> +};
> +
>  static inline int syscall_get_arch(struct task_struct *task)
>  {
>  	return AUDIT_ARCH_I386;
> @@ -152,6 +156,13 @@ static inline void syscall_set_arguments(struct task_struct *task,
>  	}
>  }
>  
> +static __maybe_unused const int syscall_arches[] = {
> +	AUDIT_ARCH_X86_64,
> +#ifdef CONFIG_IA32_EMULATION
> +	AUDIT_ARCH_I386,
> +#endif
> +};

I'm leaving this section quoted because I'll refer to it in a later
patch review...

-- 
Kees Cook
