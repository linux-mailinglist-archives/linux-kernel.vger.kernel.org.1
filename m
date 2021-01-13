Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5359E2F50D7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 18:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbhAMRQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 12:16:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:52560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728065AbhAMRQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 12:16:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 32FBF233FD;
        Wed, 13 Jan 2021 17:16:05 +0000 (UTC)
Date:   Wed, 13 Jan 2021 17:16:02 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v2 1/4] kasan, arm64: Add KASAN light mode
Message-ID: <20210113171602.GD27045@gaia>
References: <20210107172908.42686-1-vincenzo.frascino@arm.com>
 <20210107172908.42686-2-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107172908.42686-2-vincenzo.frascino@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 05:29:05PM +0000, Vincenzo Frascino wrote:
> Architectures supported by KASAN HW can provide a light mode of
> execution. On an MTE enabled arm64 hw for example this can be identified
> with the asynch mode of execution. If an async exception occurs, the
> arm64 core updates a register which is asynchronously detected the next
> time in which the kernel is accessed.

What do you mean by "the kernel is accessed"? Also, there is no
"exception" as such, only a bit in a register updated asynchronously. So
the last sentence could be something like:

  In this mode, if a tag check fault occurs, the TFSR_EL1 register is
  updated asynchronously. The kernel checks the corresponding bits
  periodically.

(or you can be more precise on when the kernel checks for such faults)

> KASAN requires a specific mode of execution to make use of this hw feature.
> 
> Add KASAN HW light execution mode.

Shall we call it "fast"? ;)

> --- /dev/null
> +++ b/include/linux/kasan_def.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_KASAN_DEF_H
> +#define _LINUX_KASAN_DEF_H
> +
> +enum kasan_arg_mode {
> +	KASAN_ARG_MODE_DEFAULT,
> +	KASAN_ARG_MODE_OFF,
> +	KASAN_ARG_MODE_LIGHT,
> +	KASAN_ARG_MODE_PROD,
> +	KASAN_ARG_MODE_FULL,
> +};
> +
> +enum kasan_arg_stacktrace {
> +	KASAN_ARG_STACKTRACE_DEFAULT,
> +	KASAN_ARG_STACKTRACE_OFF,
> +	KASAN_ARG_STACKTRACE_ON,
> +};
> +
> +enum kasan_arg_fault {
> +	KASAN_ARG_FAULT_DEFAULT,
> +	KASAN_ARG_FAULT_REPORT,
> +	KASAN_ARG_FAULT_PANIC,
> +};
> +
> +#endif /* _LINUX_KASAN_DEF_H */

I thought we agreed not to expose the KASAN internal but come up with
another abstraction. Maybe this was after you posted these patches.

-- 
Catalin
