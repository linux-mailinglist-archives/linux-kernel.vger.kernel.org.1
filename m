Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A41027DB7B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 00:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbgI2WMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 18:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727922AbgI2WMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 18:12:46 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C0AC061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 15:12:46 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id f15so6537914ilj.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 15:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q5rZuNG2apCosJKlhEHrUGVcJLAmcdJlisM6/km9BsY=;
        b=cgZF4707763NhXAo5cgeyeXCGk4m/CVAb7kaXk4vjMegAl8/fDo48iXC3wAUXrpLo/
         d0eCel9G0LE/2b2V/x86mkuBTo2Zgkav5jnCQHadVPKZnNXTS7c0B0erhS4BnfBuzpVi
         iXJ8CoMvszXAqjCfeDoDZgokej+dF0hmA46QY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q5rZuNG2apCosJKlhEHrUGVcJLAmcdJlisM6/km9BsY=;
        b=ChXedF0w0CZyNSqj+fdIhzzLXB9XsYLr7BMYi7ROZ7qgTdpEpQnnqgeeswTPeBkPLs
         vm8XSoU+q40qrvKzN74U8t3ArCcll/A2syco4NfsCvC6SYYU/dlL8utj+hyT14HhxQT/
         arF5ZuqKfFDtKm3O6lfX5Y21/WNw+id0W0EC7DxZHRdZ9hjI5sG28yIer9hzhINgW/qL
         8A27RDWea7tkz87kbKYi/m8GfmRd5MLztVfdVpO2+Mt54iPd3YSV/c2pwbXPfRLnI81M
         9y4cUIq2o0e1RnMZXD5qgFqkBcFk8aN2cEDAq9DR1eqWRulUn0MASecj0jJtVRYrGVcU
         q2IQ==
X-Gm-Message-State: AOAM532xmTy79O9hja362FCkqAz79ASAjcNtQFvjXeFsHo3YNxSqX9Vw
        +yqzNIVm7jbPGm6WcSageyFZj5N0Wzeq1mvqp1+R
X-Google-Smtp-Source: ABdhPJysY6J9rnXYsfREUHOiC+nMpH1IVzBdA0+w4kYMeCgHlOEXszC/A0gVNL0FPQVDY10Pdw33hk4VxU6+gWT07Og=
X-Received: by 2002:a92:9ac7:: with SMTP id c68mr4818119ill.126.1601417565143;
 Tue, 29 Sep 2020 15:12:45 -0700 (PDT)
MIME-Version: 1.0
References: <1593266228-61125-1-git-send-email-guoren@kernel.org> <1593266228-61125-3-git-send-email-guoren@kernel.org>
In-Reply-To: <1593266228-61125-3-git-send-email-guoren@kernel.org>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Tue, 29 Sep 2020 15:12:33 -0700
Message-ID: <CAOnJCUJ-Jdk2GCgvrHVCxVoekysFKZyDWWmSFjmKaJOEcczQSQ@mail.gmail.com>
Subject: Re: [PATCH V2 2/3] riscv: Fixup lockdep_assert_held with wrong param cpu_running
To:     Guo Ren <guoren@kernel.org>
Cc:     Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Zong Li <zong.li@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>, tycho@tycho.ws,
        Nick Hu <nickhu@andestech.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 27, 2020 at 6:58 AM <guoren@kernel.org> wrote:
>
> From: Zong Li <zong.li@sifive.com>
>
> The cpu_running is not a lock-class, it lacks the dep_map member in
> completion. It causes the error as follow:
>
> arch/riscv/kernel/smpboot.c: In function '__cpu_up':
> ./include/linux/lockdep.h:364:52: error: 'struct completion' has no member named 'dep_map'
>   364 | #define lockdep_is_held(lock)  lock_is_held(&(lock)->dep_map)
>       |                                                    ^~
> ./include/asm-generic/bug.h:113:25: note: in definition of macro 'WARN_ON'
>   113 |  int __ret_warn_on = !!(condition);    \
>       |                         ^~~~~~~~~
> ./include/linux/lockdep.h:390:27: note: in expansion of macro 'lockdep_is_held'
>   390 |   WARN_ON(debug_locks && !lockdep_is_held(l)); \
>       |                           ^~~~~~~~~~~~~~~
> arch/riscv/kernel/smpboot.c:118:2: note: in expansion of macro 'lockdep_assert_held'
>   118 |  lockdep_assert_held(&cpu_running);
>
> There are a lot of archs which use cpu_running in smpboot.c (arm,
> arm64, openrisc, xtensa, s390, x86, mips), but none of them try
> lockdep_assert_held(&cpu_running.wait.lock). So Just remove it.
>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> ---
>  arch/riscv/kernel/smpboot.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> index 4e99227..defc4e1 100644
> --- a/arch/riscv/kernel/smpboot.c
> +++ b/arch/riscv/kernel/smpboot.c
> @@ -121,7 +121,6 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
>
>         ret = start_secondary_cpu(cpu, tidle);
>         if (!ret) {
> -               lockdep_assert_held(&cpu_running);
>                 wait_for_completion_timeout(&cpu_running,
>                                             msecs_to_jiffies(1000));
>
> --
> 2.7.4
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

Thanks for catching this.

Reviewed-by: Atish Patra <atish.patra@wdc.com>

-- 
Regards,
Atish
