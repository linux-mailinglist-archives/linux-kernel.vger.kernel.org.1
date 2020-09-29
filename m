Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5D127BAB2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 04:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbgI2CKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 22:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbgI2CKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 22:10:46 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21B4C061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 19:10:45 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id c2so2654850ljj.12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 19:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gLr8Z7Rn+k6xtP+O2pjS6Cg+Bi+oXKuYYjg0H8cJs6U=;
        b=Ipym1f9s49GvoWcB1oSdajKFUhW/V9N2vVVmUsXuGIsJ8VNrlvaDeviWgVz7v1fHof
         3fSSm6SXKd7V+rXqbNot2def1KmDLv8Rqgg64KMOm5Lj+pmpKtGPS1J4dBelPUeiznXW
         GJS58YOo+gC+4JKeaZXoZMU5e3foORrCTh/k0Eq4NeaugBZy0EGItiwuitSDZaLVYuYO
         qzCpbd/Ab0eijao8eAFxT57BgPefID7+6PaQ8nbYjHHb88LB1c7vrPOLRlCuU1cTbzvw
         FzP+CWYiTl4ijJ9uTXFlA7gcQ4KrPpNhfDjRwGvRZA5XLNkhM5YibuKh0pQeZ3DG1EK0
         6zPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gLr8Z7Rn+k6xtP+O2pjS6Cg+Bi+oXKuYYjg0H8cJs6U=;
        b=QAkUPkbgko1ZuAHL1hzA4pMqU7PHpUO8gsrx/dfvZrm50V1kNBtvXITqPd1oUzY3J9
         0wt1vvQuqzOXbnrMEpf8u/Pu0q1GnBvDzieTgf6pilhSUxuW+k15CDEOjJ+w1FUHRbS3
         8JDEkjvz9gXizJux2gYhKF46NSJrxoDnkgBomwJEFkLFRtnb5d4AvrnPgb8frIjLxiG/
         KyF9YiQxvbb44AxSzEuoKiR7QJvPzmO1gb3pQJtZbYY4/0+SuHdVcDLzUYSmbKi9ggPi
         U0xMLkYn0EJpPoKw003FDnjMiYdRf00pOVCUCuFzTIB+IEp6ENl6aB19iK9Fds3lT6oB
         TGIA==
X-Gm-Message-State: AOAM53103ZXg0toCuJejPVLFLgR15tGXMEj0dEpxe4hO+khfgpIQUo1Q
        fY5lr++QP8ldkIa4Li34N7pq7L1B244orjJxgHpWg6IASNTHgRI=
X-Google-Smtp-Source: ABdhPJwt8hUV/s2VYjbpaSPjQgFwTwisMlQAs9O6KoqDk1M2Tqy5xLUgMPQV8DVCcMC4AHnwW+CZHGEiWtyr8gzHMdY=
X-Received: by 2002:a2e:141c:: with SMTP id u28mr473364ljd.72.1601345443228;
 Mon, 28 Sep 2020 19:10:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200921110020.GA2139@willie-the-truck> <20200922092153.978003-1-asteinhauser@google.com>
 <20200928130208.GA11356@willie-the-truck>
In-Reply-To: <20200928130208.GA11356@willie-the-truck>
From:   Anthony Steinhauser <asteinhauser@google.com>
Date:   Mon, 28 Sep 2020 22:10:32 -0400
Message-ID: <CAN_oZf36S=eX5qgyXg+dRi+thN5tRWxp7=SWYvjO0hZhxTAhrQ@mail.gmail.com>
Subject: Re: [PATCH v2] PR_SPEC_DISABLE_NOEXEC support for arm64.
To:     Will Deacon <will@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, catalin.marinas@arm.com,
        maz@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

...
>
> Are you sure copy_thread() is the right place for this? afaict, that would
> also apply to plain fork(), which isn't what we want. It looks like
> arch_setup_new_exec() is a better fit, and matches what x86 does. Any reason
> not to use that?
>
> This also looks like we basically want to issue the PR_SPEC_ENABLE prctl()
> on execve(). We can implement it like that to keep things simple and not
> have to worry about the actual underlying state (aside: why doesn't the
> core code do this?).
>
> Anyway, I've had a crack at this. Please take a look at the diff below.
>
> Will

You're right that arch_setup_new_exec is a better place. You're also
correct that the context-switch code in the x86 implementation seems
unnecessarily complicated.

However, your version seems to allow behaviors which are not possible
in the x86 implementation and they seem a bit counterintuitive to me.
When PR_SPEC_FORCE_DISABLE is set to true, you can now set
PR_SPEC_DISABLE_NOEXEC and it succeeds.

Afterwards, on the new exec the arch_prctl_spec_ctrl_set will fail, so
the PR_SPEC_FORCE_DISABLE setting will be honored and the
PR_SPEC_DISABLE_NOEXEC ignored, but it's a question whether it's good
that PR_SPEC_DISABLE_NOEXEC succeeded (without an effect) instead of
just failing with EPERM as in the x86 implementation. Similarly
PR_SPEC_DISABLE_NOEXEC now succeeds (again without an effect) when the
mitigation is forced on (spectre_v4_mitigation_on() returns true).

But it's up to you whether those false successes of
PR_SPEC_DISABLE_NOEXEC and the doomed setting of the noexec flag are a
noteworthy problem. The main purpose of the PR_SPEC_DISABLE_NOEXEC
option on arm64 is fulfilled, so thanks for that.

>
> --->8
>
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 9dbd35b95253..085d8ca39e47 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -21,6 +21,7 @@
>  #include <linux/lockdep.h>
>  #include <linux/mman.h>
>  #include <linux/mm.h>
> +#include <linux/nospec.h>
>  #include <linux/stddef.h>
>  #include <linux/sysctl.h>
>  #include <linux/unistd.h>
> @@ -609,6 +610,11 @@ void arch_setup_new_exec(void)
>         current->mm->context.flags = is_compat_task() ? MMCF_AARCH32 : 0;
>
>         ptrauth_thread_init_user(current);
> +
> +       if (task_spec_ssb_noexec(current)) {
> +               arch_prctl_spec_ctrl_set(current, PR_SPEC_STORE_BYPASS,
> +                                        PR_SPEC_ENABLE);
> +       }
>  }
>
>  #ifdef CONFIG_ARM64_TAGGED_ADDR_ABI
> diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
> index 1fbaa0240d4c..c0d73d02b379 100644
> --- a/arch/arm64/kernel/proton-pack.c
> +++ b/arch/arm64/kernel/proton-pack.c
> @@ -692,6 +692,9 @@ static int ssbd_prctl_set(struct task_struct *task, unsigned long ctrl)
>
>                 task_set_spec_ssb_force_disable(task);
>                 fallthrough;
> +       case PR_SPEC_DISABLE_NOEXEC:
> +               /* Disable speculation until execve(): enable mitigation */
> +               fallthrough;
>         case PR_SPEC_DISABLE:
>                 /* Disable speculation: enable mitigation */
>                 /* Same as PR_SPEC_FORCE_DISABLE */
> @@ -705,6 +708,12 @@ static int ssbd_prctl_set(struct task_struct *task, unsigned long ctrl)
>                 return -ERANGE;
>         }
>
> +       /* Handle the 'noexec' flag separately to save bloating up the switch */
> +       if (ctrl == PR_SPEC_DISABLE_NOEXEC)
> +               task_set_spec_ssb_noexec(task);
> +       else
> +               task_clear_spec_ssb_noexec(task);
> +
>         spectre_v4_enable_task_mitigation(task);
>         return 0;
>  }
> @@ -744,6 +753,9 @@ static int ssbd_prctl_get(struct task_struct *task)
>         if (task_spec_ssb_force_disable(task))
>                 return PR_SPEC_PRCTL | PR_SPEC_FORCE_DISABLE;
>
> +       if (task_spec_ssb_noexec(task))
> +               return PR_SPEC_PRCTL | PR_SPEC_DISABLE_NOEXEC;
> +
>         if (task_spec_ssb_disable(task))
>                 return PR_SPEC_PRCTL | PR_SPEC_DISABLE;
>

Best,
Anthony
