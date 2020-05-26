Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C316E19F640
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Apr 2020 15:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbgDFNAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 09:00:03 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40835 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728077AbgDFNAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 09:00:02 -0400
Received: by mail-qt1-f195.google.com with SMTP id y25so12667104qtv.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 06:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=e6p2CS4Lx8Kl1OnF8Wel1pTuwVY9nphUpk15OX9vN4A=;
        b=HtLdCzNF6JSTJ8I3pF1U7iCb1S7X26Sj6k9UYN7+EBTMANu6mtSndMBHuk1oxovUm3
         z6V658/7DrWxr76XkC6YCIUpo8NiSdq5WbZTcjOjIAiE2yo+gZGF1cNGe9n+O6WFg7fB
         zOnFrtOEn4OnIpJG+sUu43zy/wTCCvbGYrN2Ykm6+VfhDwWgqM/DxRgeDstX38IZCIM8
         V3Riftc5mM91CdMn9wE2UtSID2mmcFR2M/RGIMUoCOwiN2gbKo5uUjbmuLuOO8M/5TI2
         pI0k+9G8iKgcEtTNgZ5g9oSrkmg1SL7spNtIxdlwfG+CmCvwbzYTH+3Rf455Sx1f3htt
         WFQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=e6p2CS4Lx8Kl1OnF8Wel1pTuwVY9nphUpk15OX9vN4A=;
        b=pMZg3y8GZgSum45ymxU6k6VgNJAh56fioKRur0rvzRQnis0Oyng0rq5NGLG6yzfgAx
         0+ysKto16wlg6ZonpnGulMwD05x3W4jVVwSjeuWsaFZcaVkZQ/1vBrh8tGk7X6C8QQ9b
         L6qB4IfaacjpZ2AfIpvHrs+a0CesE8Kmk2l1i39Wg8WtaIvkCmTq5WlIdSljFyOTRWle
         01Bs6ssIrj2gMCrHYyVssN2TLXn1fi/uvyHEh4n49Y06tXd7kCcatP8TjnB2M58ImQYV
         4Ow9ktzuqNVcs+LLb5ZnkXL9UX4cYw8MN+L0wmBbEYtWgCRZKqgXXlXYn5K/ReVT5ppd
         zmmw==
X-Gm-Message-State: AGi0PuakbgH3tt7L4BJnwtmenUQ2ScL93BMm+LlzJ222oscykSJCMxOX
        ImrG3N64DZy2p7wrmoxnGMGOEg==
X-Google-Smtp-Source: APiQypJjH/Z8ZFshzG9A86GLOVCgYAONI3TFyBCYvzwvoXs7GpY80ngOzZmNSSEUTkxa4XKD84iE5A==
X-Received: by 2002:aed:2bc1:: with SMTP id e59mr4697971qtd.313.1586177999774;
        Mon, 06 Apr 2020 05:59:59 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id f1sm13584767qkl.72.2020.04.06.05.59.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2020 05:59:59 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v3] kcsan: Add option for verbose reporting
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200221231027.230147-1-elver@google.com>
Date:   Mon, 6 Apr 2020 08:59:58 -0400
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Marco Elver <elver@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6A08FE59-AD3B-4209-AF57-D4CEF7E94B56@lca.pw>
References: <20200221231027.230147-1-elver@google.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 21, 2020, at 6:10 PM, Marco Elver <elver@google.com> wrote:
>=20
> Adds CONFIG_KCSAN_VERBOSE to optionally enable more verbose reports.
> Currently information about the reporting task's held locks and IRQ
> trace events are shown, if they are enabled.

This patch is no longer in today=E2=80=99s linux-next. I suppose that it =
is because Paul had sent
the initial pull request without this one that I had missed dearly.

Is there a way to get it back there?

>=20
> Signed-off-by: Marco Elver <elver@google.com>
> Suggested-by: Qian Cai <cai@lca.pw>
> ---
> v3:
> * Typos
> v2:
> * Rework obtaining 'current' for the "other thread" -- it now passes
>  'current' and ensures that we stall until the report was printed, so
>  that the lockdep information contained in 'current' is accurate. This
>  was non-trivial but testing so far leads me to conclude this now
>  reliably prints the held locks for the "other thread" (please test
>  more!).
> ---
> kernel/kcsan/core.c   |   4 +-
> kernel/kcsan/kcsan.h  |   3 ++
> kernel/kcsan/report.c | 103 +++++++++++++++++++++++++++++++++++++++++-
> lib/Kconfig.kcsan     |  13 ++++++
> 4 files changed, 120 insertions(+), 3 deletions(-)
>=20
> diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
> index e7387fec66795..065615df88eaa 100644
> --- a/kernel/kcsan/core.c
> +++ b/kernel/kcsan/core.c
> @@ -18,8 +18,8 @@
> #include "kcsan.h"
>=20
> static bool kcsan_early_enable =3D =
IS_ENABLED(CONFIG_KCSAN_EARLY_ENABLE);
> -static unsigned int kcsan_udelay_task =3D CONFIG_KCSAN_UDELAY_TASK;
> -static unsigned int kcsan_udelay_interrupt =3D =
CONFIG_KCSAN_UDELAY_INTERRUPT;
> +unsigned int kcsan_udelay_task =3D CONFIG_KCSAN_UDELAY_TASK;
> +unsigned int kcsan_udelay_interrupt =3D =
CONFIG_KCSAN_UDELAY_INTERRUPT;
> static long kcsan_skip_watch =3D CONFIG_KCSAN_SKIP_WATCH;
> static bool kcsan_interrupt_watcher =3D =
IS_ENABLED(CONFIG_KCSAN_INTERRUPT_WATCHER);
>=20
> diff --git a/kernel/kcsan/kcsan.h b/kernel/kcsan/kcsan.h
> index 892de5120c1b6..e282f8b5749e9 100644
> --- a/kernel/kcsan/kcsan.h
> +++ b/kernel/kcsan/kcsan.h
> @@ -13,6 +13,9 @@
> /* The number of adjacent watchpoints to check. */
> #define KCSAN_CHECK_ADJACENT 1
>=20
> +extern unsigned int kcsan_udelay_task;
> +extern unsigned int kcsan_udelay_interrupt;
> +
> /*
>  * Globally enable and disable KCSAN.
>  */
> diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
> index 11c791b886f3c..7bdb515e3662f 100644
> --- a/kernel/kcsan/report.c
> +++ b/kernel/kcsan/report.c
> @@ -1,5 +1,7 @@
> // SPDX-License-Identifier: GPL-2.0
>=20
> +#include <linux/debug_locks.h>
> +#include <linux/delay.h>
> #include <linux/jiffies.h>
> #include <linux/kernel.h>
> #include <linux/lockdep.h>
> @@ -31,7 +33,26 @@ static struct {
> 	int			cpu_id;
> 	unsigned long		stack_entries[NUM_STACK_ENTRIES];
> 	int			num_stack_entries;
> -} other_info =3D { .ptr =3D NULL };
> +
> +	/*
> +	 * Optionally pass @current. Typically we do not need to pass =
@current
> +	 * via @other_info since just @task_pid is sufficient. Passing =
@current
> +	 * has additional overhead.
> +	 *
> +	 * To safely pass @current, we must either use get_task_struct/
> +	 * put_task_struct, or stall the thread that populated =
@other_info.
> +	 *
> +	 * We cannot rely on get_task_struct/put_task_struct in case
> +	 * release_report() races with a task being released, and would =
have to
> +	 * free it in release_report(). This may result in deadlock if =
we want
> +	 * to use KCSAN on the allocators.
> +	 *
> +	 * Since we also want to reliably print held locks for
> +	 * CONFIG_KCSAN_VERBOSE, the current implementation stalls the =
thread
> +	 * that populated @other_info until it has been consumed.
> +	 */
> +	struct task_struct	*task;
> +} other_info;
>=20
> /*
>  * Information about reported races; used to rate limit reporting.
> @@ -245,6 +266,16 @@ static int sym_strcmp(void *addr1, void *addr2)
> 	return strncmp(buf1, buf2, sizeof(buf1));
> }
>=20
> +static void print_verbose_info(struct task_struct *task)
> +{
> +	if (!task)
> +		return;
> +
> +	pr_err("\n");
> +	debug_show_held_locks(task);
> +	print_irqtrace_events(task);
> +}
> +
> /*
>  * Returns true if a report was generated, false otherwise.
>  */
> @@ -319,6 +350,9 @@ static bool print_report(const volatile void *ptr, =
size_t size, int access_type,
> 				  other_info.num_stack_entries - =
other_skipnr,
> 				  0);
>=20
> +		if (IS_ENABLED(CONFIG_KCSAN_VERBOSE))
> +		    print_verbose_info(other_info.task);
> +
> 		pr_err("\n");
> 		pr_err("%s to 0x%px of %zu bytes by %s on cpu %i:\n",
> 		       get_access_type(access_type), ptr, size,
> @@ -340,6 +374,9 @@ static bool print_report(const volatile void *ptr, =
size_t size, int access_type,
> 	stack_trace_print(stack_entries + skipnr, num_stack_entries - =
skipnr,
> 			  0);
>=20
> +	if (IS_ENABLED(CONFIG_KCSAN_VERBOSE))
> +		print_verbose_info(current);
> +
> 	/* Print report footer. */
> 	pr_err("\n");
> 	pr_err("Reported by Kernel Concurrency Sanitizer on:\n");
> @@ -357,6 +394,67 @@ static void release_report(unsigned long *flags, =
enum kcsan_report_type type)
> 	spin_unlock_irqrestore(&report_lock, *flags);
> }
>=20
> +/*
> + * Sets @other_info.task and awaits consumption of @other_info.
> + *
> + * Precondition: report_lock is held.
> + * Postcondition: report_lock is held.
> + */
> +static void
> +set_other_info_task_blocking(unsigned long *flags, const volatile =
void *ptr)
> +{
> +	/*
> +	 * We may be instrumenting a code-path where current->state is =
already
> +	 * something other than TASK_RUNNING.
> +	 */
> +	const bool is_running =3D current->state =3D=3D TASK_RUNNING;
> +	/*
> +	 * To avoid deadlock in case we are in an interrupt here and =
this is a
> +	 * race with a task on the same CPU (KCSAN_INTERRUPT_WATCHER), =
provide a
> +	 * timeout to ensure this works in all contexts.
> +	 *
> +	 * Await approximately the worst case delay of the reporting =
thread (if
> +	 * we are not interrupted).
> +	 */
> +	int timeout =3D max(kcsan_udelay_task, kcsan_udelay_interrupt);
> +
> +	other_info.task =3D current;
> +	do {
> +		if (is_running) {
> +			/*
> +			 * Let lockdep know the real task is sleeping, =
to print
> +			 * the held locks (recall we turned lockdep off, =
so
> +			 * locking/unlocking @report_lock won't be =
recorded).
> +			 */
> +			set_current_state(TASK_UNINTERRUPTIBLE);
> +		}
> +		spin_unlock_irqrestore(&report_lock, *flags);
> +		/*
> +		 * We cannot call schedule() since we also cannot =
reliably
> +		 * determine if sleeping here is permitted -- see =
in_atomic().
> +		 */
> +
> +		udelay(1);
> +		spin_lock_irqsave(&report_lock, *flags);
> +		if (timeout-- < 0) {
> +			/*
> +			 * Abort. Reset other_info.task to NULL, since =
it
> +			 * appears the other thread is still going to =
consume
> +			 * it. It will result in no verbose info printed =
for
> +			 * this task.
> +			 */
> +			other_info.task =3D NULL;
> +			break;
> +		}
> +		/*
> +		 * If @ptr nor @current matches, then our information =
has been
> +		 * consumed and we may continue. If not, retry.
> +		 */
> +	} while (other_info.ptr =3D=3D ptr && other_info.task =3D=3D =
current);
> +	if (is_running)
> +		set_current_state(TASK_RUNNING);
> +}
> +
> /*
>  * Depending on the report type either sets other_info and returns =
false, or
>  * acquires the matching other_info and returns true. If other_info is =
not
> @@ -388,6 +486,9 @@ static bool prepare_report(unsigned long *flags, =
const volatile void *ptr,
> 		other_info.cpu_id		=3D cpu_id;
> 		other_info.num_stack_entries	=3D =
stack_trace_save(other_info.stack_entries, NUM_STACK_ENTRIES, 1);
>=20
> +		if (IS_ENABLED(CONFIG_KCSAN_VERBOSE))
> +			set_other_info_task_blocking(flags, ptr);
> +
> 		spin_unlock_irqrestore(&report_lock, *flags);
>=20
> 		/*
> diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
> index 081ed2e1bf7b1..0f1447ff8f558 100644
> --- a/lib/Kconfig.kcsan
> +++ b/lib/Kconfig.kcsan
> @@ -20,6 +20,19 @@ menuconfig KCSAN
>=20
> if KCSAN
>=20
> +config KCSAN_VERBOSE
> +	bool "Show verbose reports with more information about system =
state"
> +	depends on PROVE_LOCKING
> +	help
> +	  If enabled, reports show more information about the system =
state that
> +	  may help better analyze and debug races. This includes held =
locks and
> +	  IRQ trace events.
> +
> +	  While this option should generally be benign, we call into =
more
> +	  external functions on report generation; if a race report is
> +	  generated from any one of them, system stability may suffer =
due to
> +	  deadlocks or recursion.  If in doubt, say N.
> +
> config KCSAN_DEBUG
> 	bool "Debugging of KCSAN internals"
>=20
> --=20
> 2.25.0.265.gbab2e86ba0-goog
>=20

