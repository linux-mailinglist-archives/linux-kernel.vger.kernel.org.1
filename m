Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD302FFD87
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 08:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbhAVHm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 02:42:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbhAVHmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 02:42:52 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2EAC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 23:42:11 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id v1so4256607ott.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 23:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ud04sL0ngxTmBKk3QDvBP7fg9gK0x9WhAV54oM9t5TA=;
        b=wFgNhL5TrI3bf8PRmjBHQaypL93M9wUz40xAfmpC3+BlarDT1KJSiHmCG3VQfAouBm
         XBw40TkMpYV6xE76LcJ3xo+IesxaMoamzG5xmq+mly7VLVJXsc3o+3krozLdUxwDCZeO
         TNqOyzPPwaz5kbaazDy6H5eFTa9EBnaZ4IdA9u1IIaCdxn3wmTIbTfOfLU7zcwWItEcH
         JM69ifMrV9Cjx2zaJqLrY4E4RV1qQ8QgUyVy6lAEjr1My5WSdsuBtzhMHFa2WvmHZRW9
         ZDo2Yb7y2+iIrVMJtkf/ppPirkjSJwMwWPxThlgfXR//Za19A4URcJ5v0WCa3R0mgO2b
         gyuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ud04sL0ngxTmBKk3QDvBP7fg9gK0x9WhAV54oM9t5TA=;
        b=qvR5dlo9JXAas26CEuoPjloJ/SQrtTvf4eaUmpCz3Flo33OQi34RHzwlWA2luTNQ+6
         fH5FEtRqV12BDGiZWh/WeM8s8wD+dZ7fWqgoAISsZKAY6NLL0NqdVdijInXRFtQi38+F
         tClNa6nnhyGa7r/ujiFmPoL4+bhSyLp+yBIi/3o9ciFa1jkw9E2/JWVazFHou9y7u79+
         rytADUzedja8J4Mi3PCE1BU7/D7WyEP1tdty3siIR3y/zuBYyw9y8zwnwOoc4hXK2A4o
         pdj1ACZuDPv+IgYqMPDJlIDFio4xbATLyYYOq1AmGCunVICa2n+3FVeCM/0dErJHhSWd
         PXZg==
X-Gm-Message-State: AOAM531sp6CH7mxdo7FXt/WqjaMIi/grWUeeMKBbM3CkOtg/b3VW3Aj9
        bdChnO3e+CyOlST7Nlf6LRuA/0DbrJdmqxLL8ZLFiNKdho4=
X-Google-Smtp-Source: ABdhPJwn3X06GStrb+UrC8NrjExKfgZDKcUwDdKXzVFYjMqpU1SuhVvkS7VxLE8TLj8V6LDC+VAGEBGQRqma/KHa+4U=
X-Received: by 2002:a05:6830:1312:: with SMTP id p18mr2447636otq.324.1611301331210;
 Thu, 21 Jan 2021 23:42:11 -0800 (PST)
MIME-Version: 1.0
References: <20210105102843.11254-1-r.czerwinski@pengutronix.de>
In-Reply-To: <20210105102843.11254-1-r.czerwinski@pengutronix.de>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Fri, 22 Jan 2021 08:42:00 +0100
Message-ID: <CAHUa44HBrRUOX4y+bee957APWtknxb=X8RMPw0xA_qF=CmgEGQ@mail.gmail.com>
Subject: Re: [PATCH v2] tee: optee: replace might_sleep with cond_resched
To:     Rouven Czerwinski <r.czerwinski@pengutronix.de>
Cc:     kernel@pengutronix.de, op-tee@lists.trustedfirmware.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 5, 2021 at 11:29 AM Rouven Czerwinski
<r.czerwinski@pengutronix.de> wrote:
>
> might_sleep() is a debugging aid and triggers rescheduling only for
> certain kernel configurations. Replace with an explicit check and
> reschedule to work for all kernel configurations. Fixes the following
> trace:
>
>   [  572.945146] rcu: INFO: rcu_sched self-detected stall on CPU
>   [  572.949275] rcu:     0-....: (2099 ticks this GP) idle=572/1/0x40000002 softirq=7412/7412 fqs=974
>   [  572.957964]  (t=2100 jiffies g=10393 q=21)
>   [  572.962054] NMI backtrace for cpu 0
>   [  572.965540] CPU: 0 PID: 165 Comm: xtest Not tainted 5.8.7 #1
>   [  572.971188] Hardware name: STM32 (Device Tree Support)
>   [  572.976354] [<c011163c>] (unwind_backtrace) from [<c010b7f8>] (show_stack+0x10/0x14)
>   [  572.984080] [<c010b7f8>] (show_stack) from [<c0511e4c>] (dump_stack+0xc4/0xd8)
>   [  572.991300] [<c0511e4c>] (dump_stack) from [<c0519abc>] (nmi_cpu_backtrace+0x90/0xc4)
>   [  572.999130] [<c0519abc>] (nmi_cpu_backtrace) from [<c0519bdc>] (nmi_trigger_cpumask_backtrace+0xec/0x130)
>   [  573.008706] [<c0519bdc>] (nmi_trigger_cpumask_backtrace) from [<c01a5184>] (rcu_dump_cpu_stacks+0xe8/0x110)
>   [  573.018453] [<c01a5184>] (rcu_dump_cpu_stacks) from [<c01a4234>] (rcu_sched_clock_irq+0x7fc/0xa88)
>   [  573.027416] [<c01a4234>] (rcu_sched_clock_irq) from [<c01acdd0>] (update_process_times+0x30/0x8c)
>   [  573.036291] [<c01acdd0>] (update_process_times) from [<c01bfb90>] (tick_sched_timer+0x4c/0xa8)
>   [  573.044905] [<c01bfb90>] (tick_sched_timer) from [<c01adcc8>] (__hrtimer_run_queues+0x174/0x358)
>   [  573.053696] [<c01adcc8>] (__hrtimer_run_queues) from [<c01aea2c>] (hrtimer_interrupt+0x118/0x2bc)
>   [  573.062573] [<c01aea2c>] (hrtimer_interrupt) from [<c09ad664>] (arch_timer_handler_virt+0x28/0x30)
>   [  573.071536] [<c09ad664>] (arch_timer_handler_virt) from [<c0190f50>] (handle_percpu_devid_irq+0x8c/0x240)
>   [  573.081109] [<c0190f50>] (handle_percpu_devid_irq) from [<c018ab8c>] (generic_handle_irq+0x34/0x44)
>   [  573.090156] [<c018ab8c>] (generic_handle_irq) from [<c018b194>] (__handle_domain_irq+0x5c/0xb0)
>   [  573.098857] [<c018b194>] (__handle_domain_irq) from [<c052ac50>] (gic_handle_irq+0x4c/0x90)
>   [  573.107209] [<c052ac50>] (gic_handle_irq) from [<c0100b0c>] (__irq_svc+0x6c/0x90)
>   [  573.114682] Exception stack(0xd90dfcf8 to 0xd90dfd40)
>   [  573.119732] fce0:                                                       ffff0004 00000000
>   [  573.127917] fd00: 00000000 00000000 00000000 00000000 00000000 00000000 d93493cc ffff0000
>   [  573.136098] fd20: d2bc39c0 be926998 d90dfd58 d90dfd48 c09f3384 c01151f0 400d0013 ffffffff
>   [  573.144281] [<c0100b0c>] (__irq_svc) from [<c01151f0>] (__arm_smccc_smc+0x10/0x20)
>   [  573.151854] [<c01151f0>] (__arm_smccc_smc) from [<c09f3384>] (optee_smccc_smc+0x3c/0x44)
>   [  573.159948] [<c09f3384>] (optee_smccc_smc) from [<c09f4170>] (optee_do_call_with_arg+0xb8/0x154)
>   [  573.168735] [<c09f4170>] (optee_do_call_with_arg) from [<c09f4638>] (optee_invoke_func+0x110/0x190)
>   [  573.177786] [<c09f4638>] (optee_invoke_func) from [<c09f1ebc>] (tee_ioctl+0x10b8/0x11c0)
>   [  573.185879] [<c09f1ebc>] (tee_ioctl) from [<c029f62c>] (ksys_ioctl+0xe0/0xa4c)
>   [  573.193101] [<c029f62c>] (ksys_ioctl) from [<c0100060>] (ret_fast_syscall+0x0/0x54)
>   [  573.200750] Exception stack(0xd90dffa8 to 0xd90dfff0)
>   [  573.205803] ffa0:                   be926bf4 be926a78 00000003 8010a403 be926908 004e3cf8
>   [  573.213987] ffc0: be926bf4 be926a78 00000000 00000036 be926908 be926918 be9269b0 bffdf0f8
>   [  573.222162] ffe0: b6d76fb0 be9268fc b6d66621 b6c7e0d8
>
> seen on STM32 DK2 with CONFIG_PREEMPT_NONE.
>
> Signed-off-by: Rouven Czerwinski <r.czerwinski@pengutronix.de>
> Tested-by: Sumit Garg <sumit.garg@linaro.org>
> ---
> v2:
> - Add tested-by from Sumit Garg
> - Adjust commit message as agreed upon with Lucas Stach
>
>  drivers/tee/optee/call.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

I'm picking this up.

Thanks,
Jens
