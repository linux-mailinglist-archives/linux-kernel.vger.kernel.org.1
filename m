Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2166A2F880B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 23:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbhAOV67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 16:58:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:38004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726367AbhAOV67 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 16:58:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 37C22239FC;
        Fri, 15 Jan 2021 21:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610747898;
        bh=+6Vjjut+EQfcgIj8kOGhKBiQrdCG6BzSk78pb6dNlS0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=IePHwf1EUmOFCcr9j2pITG4NKalVEzWutmAih/KgmvNVL6BKFlJFhrIrCJBz426BH
         R9EbqUPIcBCdCOhFw2d0Jf6/h+79WoJTA8BKoe8ca8EFfesEwxvy/cJ0BeYqQGZJD0
         pPMX0+JagfTlePwecFbKjvkCOAwR0IjjsHF/hpWccCtdUEQR+G06mh9PtAYQcbUOdV
         VR06W2rfkqca0XNN47LsE046Or5MOuNM5LQxX12j3ZlMe5pbVonIo0XwRkoUY9VlJa
         z1g8jILFiG7SiLYdnWDLffUgb2ADhpQrTtzwmjljUcPqMyEpsfkQs8HL5Dx5yrYa9o
         RWc9gMj8PNlDQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 05CBA352162B; Fri, 15 Jan 2021 13:58:18 -0800 (PST)
Date:   Fri, 15 Jan 2021 13:58:17 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     dvyukov@google.com, glider@google.com, andreyknvl@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kcsan: Add missing license and copyright headers
Message-ID: <20210115215817.GN2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210115170953.3035153-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115170953.3035153-1-elver@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 06:09:53PM +0100, Marco Elver wrote:
> Adds missing license and/or copyright headers for KCSAN source files.
> 
> Signed-off-by: Marco Elver <elver@google.com>

This one seemed straightforward and I heard no objections to the previous
two-patch series, so I queued them for the v5.13 merge window, thank you!

If any of them need adjustment, please send me the updated patch and
tell me which one it replaces.  Something about -rcu being in heavy
experimental mode at the moment.  ;-)

							Thanx, Paul

> ---
>  Documentation/dev-tools/kcsan.rst | 3 +++
>  include/linux/kcsan-checks.h      | 6 ++++++
>  include/linux/kcsan.h             | 7 +++++++
>  kernel/kcsan/atomic.h             | 5 +++++
>  kernel/kcsan/core.c               | 5 +++++
>  kernel/kcsan/debugfs.c            | 5 +++++
>  kernel/kcsan/encoding.h           | 5 +++++
>  kernel/kcsan/kcsan.h              | 3 ++-
>  kernel/kcsan/report.c             | 5 +++++
>  kernel/kcsan/selftest.c           | 5 +++++
>  10 files changed, 48 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/dev-tools/kcsan.rst b/Documentation/dev-tools/kcsan.rst
> index be7a0b0e1f28..d85ce238ace7 100644
> --- a/Documentation/dev-tools/kcsan.rst
> +++ b/Documentation/dev-tools/kcsan.rst
> @@ -1,3 +1,6 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. Copyright (C) 2019, Google LLC.
> +
>  The Kernel Concurrency Sanitizer (KCSAN)
>  ========================================
>  
> diff --git a/include/linux/kcsan-checks.h b/include/linux/kcsan-checks.h
> index cf14840609ce..9fd0ad80fef6 100644
> --- a/include/linux/kcsan-checks.h
> +++ b/include/linux/kcsan-checks.h
> @@ -1,4 +1,10 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * KCSAN access checks and modifiers. These can be used to explicitly check
> + * uninstrumented accesses, or change KCSAN checking behaviour of accesses.
> + *
> + * Copyright (C) 2019, Google LLC.
> + */
>  
>  #ifndef _LINUX_KCSAN_CHECKS_H
>  #define _LINUX_KCSAN_CHECKS_H
> diff --git a/include/linux/kcsan.h b/include/linux/kcsan.h
> index 53340d8789f9..fc266ecb2a4d 100644
> --- a/include/linux/kcsan.h
> +++ b/include/linux/kcsan.h
> @@ -1,4 +1,11 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * The Kernel Concurrency Sanitizer (KCSAN) infrastructure. Public interface and
> + * data structures to set up runtime. See kcsan-checks.h for explicit checks and
> + * modifiers. For more info please see Documentation/dev-tools/kcsan.rst.
> + *
> + * Copyright (C) 2019, Google LLC.
> + */
>  
>  #ifndef _LINUX_KCSAN_H
>  #define _LINUX_KCSAN_H
> diff --git a/kernel/kcsan/atomic.h b/kernel/kcsan/atomic.h
> index 75fe701f4127..530ae1bda8e7 100644
> --- a/kernel/kcsan/atomic.h
> +++ b/kernel/kcsan/atomic.h
> @@ -1,4 +1,9 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Rules for implicitly atomic memory accesses.
> + *
> + * Copyright (C) 2019, Google LLC.
> + */
>  
>  #ifndef _KERNEL_KCSAN_ATOMIC_H
>  #define _KERNEL_KCSAN_ATOMIC_H
> diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
> index 3bf98db9c702..8c3867640c21 100644
> --- a/kernel/kcsan/core.c
> +++ b/kernel/kcsan/core.c
> @@ -1,4 +1,9 @@
>  // SPDX-License-Identifier: GPL-2.0
> +/*
> + * KCSAN core runtime.
> + *
> + * Copyright (C) 2019, Google LLC.
> + */
>  
>  #define pr_fmt(fmt) "kcsan: " fmt
>  
> diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
> index 3c8093a371b1..c837ce6c52e6 100644
> --- a/kernel/kcsan/debugfs.c
> +++ b/kernel/kcsan/debugfs.c
> @@ -1,4 +1,9 @@
>  // SPDX-License-Identifier: GPL-2.0
> +/*
> + * KCSAN debugfs interface.
> + *
> + * Copyright (C) 2019, Google LLC.
> + */
>  
>  #define pr_fmt(fmt) "kcsan: " fmt
>  
> diff --git a/kernel/kcsan/encoding.h b/kernel/kcsan/encoding.h
> index 7ee405524904..170a2bb22f53 100644
> --- a/kernel/kcsan/encoding.h
> +++ b/kernel/kcsan/encoding.h
> @@ -1,4 +1,9 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * KCSAN watchpoint encoding.
> + *
> + * Copyright (C) 2019, Google LLC.
> + */
>  
>  #ifndef _KERNEL_KCSAN_ENCODING_H
>  #define _KERNEL_KCSAN_ENCODING_H
> diff --git a/kernel/kcsan/kcsan.h b/kernel/kcsan/kcsan.h
> index 8d4bf3431b3c..594a5dd4842a 100644
> --- a/kernel/kcsan/kcsan.h
> +++ b/kernel/kcsan/kcsan.h
> @@ -1,8 +1,9 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -
>  /*
>   * The Kernel Concurrency Sanitizer (KCSAN) infrastructure. For more info please
>   * see Documentation/dev-tools/kcsan.rst.
> + *
> + * Copyright (C) 2019, Google LLC.
>   */
>  
>  #ifndef _KERNEL_KCSAN_KCSAN_H
> diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
> index d3bf87e6007c..13dce3c664d6 100644
> --- a/kernel/kcsan/report.c
> +++ b/kernel/kcsan/report.c
> @@ -1,4 +1,9 @@
>  // SPDX-License-Identifier: GPL-2.0
> +/*
> + * KCSAN reporting.
> + *
> + * Copyright (C) 2019, Google LLC.
> + */
>  
>  #include <linux/debug_locks.h>
>  #include <linux/delay.h>
> diff --git a/kernel/kcsan/selftest.c b/kernel/kcsan/selftest.c
> index 9014a3a82cf9..7f29cb0f5e63 100644
> --- a/kernel/kcsan/selftest.c
> +++ b/kernel/kcsan/selftest.c
> @@ -1,4 +1,9 @@
>  // SPDX-License-Identifier: GPL-2.0
> +/*
> + * KCSAN short boot-time selftests.
> + *
> + * Copyright (C) 2019, Google LLC.
> + */
>  
>  #define pr_fmt(fmt) "kcsan: " fmt
>  
> -- 
> 2.30.0.284.gd98b1dd5eaa7-goog
> 
