Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0C53006BD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 16:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbhAVPJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 10:09:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:40556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729070AbhAVPCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 10:02:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8405623ABA;
        Fri, 22 Jan 2021 15:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611327734;
        bh=ytzMBlkdUUvKuZjby1OfxMsyN3uTMqyGAf4Tx3EsXMw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Cxn/UfyTZSBdxJ5NSf27EGBMJrR3fjpYaIxVDhtzPneYa+ovB4Fu5cCxdaBwq+Igz
         KS/Qg6ieGPx/3iSUfYpBAlkFZG7X9qwTMLH7FdAFPrVzzx5HFRTJZs2yiHa0rkphkh
         iFXo6dGYof2lUHfqxMCDR0UKSsEXZIfycal3g2iXsO4uShnDVcGafPtMJULzdYB7KT
         zO/0ZG9qVfgVk7vIUTBNCIjSoUm8xEB4n8dUSlBDfc+U8SDNRieckSjSu4OJ3BytNo
         nYsr14/tWshCatkMi9coOmZXVCnIBwDTTn/Fi1M+4vczprzsIAVHJmciI/kPJ7zE6d
         u84Ydz3Pchx/w==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 504373522649; Fri, 22 Jan 2021 07:02:14 -0800 (PST)
Date:   Fri, 22 Jan 2021 07:02:14 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>
Subject: Re: [RFC PATCH 0/7] preempt: Tune preemption flavour on boot v4
Message-ID: <20210122150214.GD2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210118141223.123667-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118141223.123667-1-frederic@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 03:12:15PM +0100, Frederic Weisbecker wrote:
> Hi,
> 
> Here is a new version of the feature that can select the preempt flavour
> on boot time. Note that it doesn't entirely mimic the actual real
> config-based preemption flavours, because at least preempt-RCU
> implementation is there in any case.
> 
> Also there is still some work to do against subsystems that may play
> their own games with CONFIG_PREEMPT.
> 
> In this version:
> 
> * Restore the initial simple __static_call_return0() implementation.
> 
> * Uninline __static_call_return0 on all flavours since its address is
> always needed on DEFINE_STATIC_CALL()
> 
> * Introduce DEFINE_STATIC_CALL_RET0()
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
> 	preempt/dynamic-v4
> 
> HEAD: b5f3b1da9df4197d0b0ffe0f55f0f6a8c838d75f

I gave these a quick test and got the following:

Warning: Kernel ABI header at 'tools/include/linux/static_call_types.h' differs from latest version at 'include/linux/static_call_types.h'.

Other than that, looks good.

							Thanx, Paul

> Thanks,
> 	Frederic
> ---
> 
> Peter Zijlstra (Intel) (4):
>       preempt/dynamic: Provide cond_resched() and might_resched() static calls
>       preempt/dynamic: Provide preempt_schedule[_notrace]() static calls
>       preempt/dynamic: Provide irqentry_exit_cond_resched() static call
>       preempt/dynamic: Support dynamic preempt with preempt= boot option
> 
> Peter Zijlstra (2):
>       static_call/x86: Add __static_call_return0()
>       static_call: Pull some static_call declarations to the type headers
> 
> Frederic Weisbecker (1):
>       static_call: Provide DEFINE_STATIC_CALL_RET0()
> 
> Michal Hocko (1):
>       preempt: Introduce CONFIG_PREEMPT_DYNAMIC
> 
> 
>  Documentation/admin-guide/kernel-parameters.txt |  7 ++
>  arch/Kconfig                                    |  9 +++
>  arch/x86/Kconfig                                |  1 +
>  arch/x86/include/asm/preempt.h                  | 34 ++++++---
>  arch/x86/kernel/static_call.c                   | 17 ++++-
>  include/linux/entry-common.h                    |  4 ++
>  include/linux/kernel.h                          | 23 ++++--
>  include/linux/sched.h                           | 27 ++++++-
>  include/linux/static_call.h                     | 43 ++++--------
>  include/linux/static_call_types.h               | 29 ++++++++
>  kernel/Kconfig.preempt                          | 19 +++++
>  kernel/entry/common.c                           | 10 ++-
>  kernel/sched/core.c                             | 93 ++++++++++++++++++++++++-
>  kernel/static_call.c                            |  5 ++
>  14 files changed, 271 insertions(+), 50 deletions(-)
