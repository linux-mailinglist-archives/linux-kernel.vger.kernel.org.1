Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16A382C4FF8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 09:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388624AbgKZIFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 03:05:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727678AbgKZIFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 03:05:44 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03D4C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 00:05:43 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id z136so959286iof.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 00:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lw0YKN6KnE42RHTMlHiZQcsRrfFD108gywhUinVx830=;
        b=WLPTwXxT0xTGx8riQxZ6T8gOHeuatYlBack5jtNCQHtadZyh+9eRD58RCDTuLF9TpM
         2xir6GI9MLZ//y0QcniaDrWpP5XFeHCNInH6yGUjDJtELv6alqxFxcLryIvV1A8/VI79
         9oMTCvO8iggJ4sTwkL53hPnody8MHorfS0n8NWPC5LvPJkEgbMmeXVith8FcqtCyW+X9
         UZ2NWiNaXElwioTOr6lGmV96haR9H/xL6jbwYDQuO4td26K2fdpOcgmRfKUBB5cGZGok
         8+1ge40vqWtPaiTxz2Ie7sXVHFFyhPgSaXScdd8XfnvPvB7rcyO8w5+Yq83tyOlWbsPi
         TNyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lw0YKN6KnE42RHTMlHiZQcsRrfFD108gywhUinVx830=;
        b=HA0lU4KIoYDsEwjZcax4qn2zcHRgpB4n2uoOpHO8tWny4qGCJnoS2H2KKUXXtnjdBD
         VgArdcbUJd7zQcVrG5LM0ssqSHLX9hWNoBzj3cafvx6/9YZJA8ZjumEGbdgFKWnhTYeg
         +rKo1vPMvigfnqDdO3Cs/2wDA3efFUmhz9uk9+dHvMIPH76G/pdIRyePHHOA/1d6W1cF
         JEK6/ui8YJGGDuUqdMygYnoKncOdS+OgVuxW+UtSID3ugT3zlkbMgQ3OaNMAGM9EZJZy
         +EdZLEjvoFyvf4dVlBKEYIDtXkcfUS2MAyBnVYC/IBfVrfRonltsR6Bub7h9ejtu0lFR
         TPqg==
X-Gm-Message-State: AOAM532KfkeuxbmdPpBkbjN633JXkbGlz+nHYS2pOfyFsgmy0uEHbRbf
        +Vpavc1/H2ykBmJEnw8NgZJxGdEbnDST97AK9g==
X-Google-Smtp-Source: ABdhPJzGzkGEOEfF8tgJN97LWcjPSNBh3g/wEejo1sr4cSIZJNobmfopS78mNBdjFDKRJ3oyKdEGFk+aY7v4lVZkozA=
X-Received: by 2002:a05:6602:1305:: with SMTP id h5mr1499568iov.41.1606377943263;
 Thu, 26 Nov 2020 00:05:43 -0800 (PST)
MIME-Version: 1.0
References: <1606109846-13688-1-git-send-email-kernelfans@gmail.com> <1606109846-13688-2-git-send-email-kernelfans@gmail.com>
In-Reply-To: <1606109846-13688-2-git-send-email-kernelfans@gmail.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Thu, 26 Nov 2020 16:05:31 +0800
Message-ID: <CAFgQCTtUFxDZ0WE3wFZVXeHWe0OyB7R1WdVf45+USJ5CS=kiWA@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86/machine_kexec: disable PMU before jumping to new kernel
To:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Omar Sandoval <osandov@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry that I had made a misunderstanding of the code.

Nacked it

On Mon, Nov 23, 2020 at 1:37 PM Pingfan Liu <kernelfans@gmail.com> wrote:
>
> During jumping to the new kernel, on the crashed cpu, the memory mapping
> switches from an old one to an identity one. It had better disable PMU to
> suppress NMI, which can be delivered using the old mapping.
>
> Also on x86_64, idt_invalidate() to clear idt as on 32 bits.
>
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mike Rapoport <rppt@kernel.org>
> To: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  arch/x86/kernel/machine_kexec_32.c | 1 +
>  arch/x86/kernel/machine_kexec_64.c | 3 +++
>  2 files changed, 4 insertions(+)
>
> diff --git a/arch/x86/kernel/machine_kexec_32.c b/arch/x86/kernel/machine_kexec_32.c
> index 64b00b0..72c6100 100644
> --- a/arch/x86/kernel/machine_kexec_32.c
> +++ b/arch/x86/kernel/machine_kexec_32.c
> @@ -191,6 +191,7 @@ void machine_kexec(struct kimage *image)
>         /* Interrupts aren't acceptable while we reboot */
>         local_irq_disable();
>         hw_breakpoint_disable();
> +       perf_pmu_disable_all();
>
>         if (image->preserve_context) {
>  #ifdef CONFIG_X86_IO_APIC
> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> index a29a44a..238893e 100644
> --- a/arch/x86/kernel/machine_kexec_64.c
> +++ b/arch/x86/kernel/machine_kexec_64.c
> @@ -17,6 +17,7 @@
>  #include <linux/suspend.h>
>  #include <linux/vmalloc.h>
>  #include <linux/efi.h>
> +#include <linux/perf_event.h>
>
>  #include <asm/init.h>
>  #include <asm/tlbflush.h>
> @@ -338,6 +339,8 @@ void machine_kexec(struct kimage *image)
>         /* Interrupts aren't acceptable while we reboot */
>         local_irq_disable();
>         hw_breakpoint_disable();
> +       perf_pmu_disable_all();
> +       idt_invalidate(phys_to_virt(0));
>
>         if (image->preserve_context) {
>  #ifdef CONFIG_X86_IO_APIC
> --
> 2.7.5
>
