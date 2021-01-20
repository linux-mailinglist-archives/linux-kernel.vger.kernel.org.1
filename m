Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3921F2FCF7B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 13:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729390AbhATLfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 06:35:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732561AbhATKTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 05:19:10 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D436CC061575
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 02:18:29 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id j26so15849269qtq.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 02:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oUIZNwEtHm27eol4r2tzHkSJ0b2FBL+4+O0E9ZJ0BHw=;
        b=inc4dl5k3CbMkIldGF2mT5prRr/x1uWdZxHS6qSOWHEmHGDWiu1OxQ1o5cROwk5JTD
         9VpN5l9wfZWDhh5r8xZmXUsKFtmu2LyQkXvIkCOIFqa5HdBsNC96E7vXIYkb+Ll9MBdH
         b736U90x9hojKeKTQlDQbeqMRA+5ha4NoE/w79ic9Sv8W/y+gwDONx+c0y39/McxSxpp
         wLMYxEWMbrztzQhhKRFwlhdgp8cJSlxQ8EeEz2GRhe1N+4/OoV5ZtSFrk7yNjpBGe9Fe
         fg3TrLgWhxxlyrcReH8o35Vx71LyUSN5I7eFWAPOVfSeAapd/yza75oeBBYSXWUO8mF2
         y+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oUIZNwEtHm27eol4r2tzHkSJ0b2FBL+4+O0E9ZJ0BHw=;
        b=E4wO4M2plerCVtJNYcPrfMadWKsS7MxPaM4oRNyjWJ8s1g9oT1yMxlxD/mAuW5UMH5
         eTNELh0sWW2BtE3yI9fdlO7ttdZxvvEL9KzNuA2TankYn2VEdwQAQ3Uf59Bg3h6aPKvq
         9K2lihJBrisRkJD2PWv/7U759z8jUsAWyZtMpPX65SgrxJwb9KGk+qKnXZCsMT500Vtk
         TrQ1WadNP+Fe51v7bDF6eK7CqPpPp9ssRkUdjBsVVN5i3r0XrIoIuehB2hEeAnAOyk9d
         DChGiPlsUVhqvy4M6Y23rvbPtbQ4vXPOdNZMcVVfMPDng9y9itK28S5LbbWpGF8kBmX+
         ZYEA==
X-Gm-Message-State: AOAM532Op/CKnolNWw4CrkGW8eqxSR/1R8utsM13WmZz38tcr6kKet3N
        qSWJFC9qL/APJEVnwx2ng4xfkUS/MnLAvmdjWmx/I2lK970=
X-Google-Smtp-Source: ABdhPJx6VuiwQrJtjQz5yecFQOC2OCoYxScSjRElF0e8+ltQtRDY4Dear8TQurdzmuiBcBCeQlLyBQ5tTla0vo66A1s=
X-Received: by 2002:ac8:4e1c:: with SMTP id c28mr8157891qtw.67.1611137908832;
 Wed, 20 Jan 2021 02:18:28 -0800 (PST)
MIME-Version: 1.0
References: <20210120101044.9106-1-penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20210120101044.9106-1-penguin-kernel@I-love.SAKURA.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 20 Jan 2021 11:18:17 +0100
Message-ID: <CACT4Y+YUQj_G1o3eWFVeL2jsvdayQ0HkYkeVRuSzxOT5Xiu9mw@mail.gmail.com>
Subject: Re: [PATCH v4 (resend)] lockdep: Allow tuning tracing capacity constants.
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 11:12 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Since syzkaller continues various test cases until the kernel crashes,
> syzkaller tends to examine more locking dependencies than normal systems.
> As a result, syzbot is reporting that the fuzz testing was terminated
> due to hitting upper limits lockdep can track [1] [2] [3].
>
> Peter Zijlstra does not want to allow tuning these limits via kernel
> config options, for such change discourages thinking. But analysis via
> /proc/lockdep* did not show any obvious culprit [4] [5]. It is possible
> that many hundreds of kn->active lock instances are to some degree
> contributing to these problems, but there is no means to verify whether
> these instances are created for protecting same callback functions.
> Unless Peter provides a way to make these instances per "which callback
> functions the lock instance will call (identified by something like MD5
> of string representations of callback functions which each lock instance
> will protect)" than plain "serial number", I don't think that we can
> verify the culprit.
>
> [1] https://syzkaller.appspot.com/bug?id=3d97ba93fb3566000c1c59691ea427370d33ea1b
> [2] https://syzkaller.appspot.com/bug?id=381cb436fe60dc03d7fd2a092b46d7f09542a72a
> [3] https://syzkaller.appspot.com/bug?id=a588183ac34c1437fc0785e8f220e88282e5a29f
> [4] https://lkml.kernel.org/r/4b8f7a57-fa20-47bd-48a0-ae35d860f233@i-love.sakura.ne.jp
> [5] https://lkml.kernel.org/r/1c351187-253b-2d49-acaf-4563c63ae7d2@i-love.sakura.ne.jp
>
> Reported-by: syzbot <syzbot+cd0ec5211ac07c18c049@syzkaller.appspotmail.com>
> Reported-by: syzbot <syzbot+91fd909b6e62ebe06131@syzkaller.appspotmail.com>
> Reported-by: syzbot <syzbot+62ebe501c1ce9a91f68c@syzkaller.appspotmail.com>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Acked-by: Dmitry Vyukov <dvyukov@google.com>

Thanks for your persistence!
I still support this. And assessment of lockdep stats on overflow
seems to confirm it's just a very large lock graph triggered by
syzkaller.


> ---
>  kernel/locking/lockdep.c           |  2 +-
>  kernel/locking/lockdep_internals.h |  8 +++---
>  lib/Kconfig.debug                  | 40 ++++++++++++++++++++++++++++++
>  3 files changed, 45 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index c1418b47f625..c0553872668a 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -1391,7 +1391,7 @@ static int add_lock_to_list(struct lock_class *this,
>  /*
>   * For good efficiency of modular, we use power of 2
>   */
> -#define MAX_CIRCULAR_QUEUE_SIZE                4096UL
> +#define MAX_CIRCULAR_QUEUE_SIZE                (1UL << CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS)
>  #define CQ_MASK                                (MAX_CIRCULAR_QUEUE_SIZE-1)
>
>  /*
> diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
> index de49f9e1c11b..ecb8662e7a4e 100644
> --- a/kernel/locking/lockdep_internals.h
> +++ b/kernel/locking/lockdep_internals.h
> @@ -99,16 +99,16 @@ static const unsigned long LOCKF_USED_IN_IRQ_READ =
>  #define MAX_STACK_TRACE_ENTRIES        262144UL
>  #define STACK_TRACE_HASH_SIZE  8192
>  #else
> -#define MAX_LOCKDEP_ENTRIES    32768UL
> +#define MAX_LOCKDEP_ENTRIES    (1UL << CONFIG_LOCKDEP_BITS)
>
> -#define MAX_LOCKDEP_CHAINS_BITS        16
> +#define MAX_LOCKDEP_CHAINS_BITS        CONFIG_LOCKDEP_CHAINS_BITS
>
>  /*
>   * Stack-trace: tightly packed array of stack backtrace
>   * addresses. Protected by the hash_lock.
>   */
> -#define MAX_STACK_TRACE_ENTRIES        524288UL
> -#define STACK_TRACE_HASH_SIZE  16384
> +#define MAX_STACK_TRACE_ENTRIES        (1UL << CONFIG_LOCKDEP_STACK_TRACE_BITS)
> +#define STACK_TRACE_HASH_SIZE  (1 << CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS)
>  #endif
>
>  /*
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 7937265ef879..4cb84b499636 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1332,6 +1332,46 @@ config LOCKDEP
>  config LOCKDEP_SMALL
>         bool
>
> +config LOCKDEP_BITS
> +       int "Bitsize for MAX_LOCKDEP_ENTRIES"
> +       depends on LOCKDEP && !LOCKDEP_SMALL
> +       range 10 30
> +       default 15
> +       help
> +         Try increasing this value if you hit "BUG: MAX_LOCKDEP_ENTRIES too low!" message.
> +
> +config LOCKDEP_CHAINS_BITS
> +       int "Bitsize for MAX_LOCKDEP_CHAINS"
> +       depends on LOCKDEP && !LOCKDEP_SMALL
> +       range 10 30
> +       default 16
> +       help
> +         Try increasing this value if you hit "BUG: MAX_LOCKDEP_CHAINS too low!" message.
> +
> +config LOCKDEP_STACK_TRACE_BITS
> +       int "Bitsize for MAX_STACK_TRACE_ENTRIES"
> +       depends on LOCKDEP && !LOCKDEP_SMALL
> +       range 10 30
> +       default 19
> +       help
> +         Try increasing this value if you hit "BUG: MAX_STACK_TRACE_ENTRIES too low!" message.
> +
> +config LOCKDEP_STACK_TRACE_HASH_BITS
> +       int "Bitsize for STACK_TRACE_HASH_SIZE"
> +       depends on LOCKDEP && !LOCKDEP_SMALL
> +       range 10 30
> +       default 14
> +       help
> +         Try increasing this value if you need large MAX_STACK_TRACE_ENTRIES.
> +
> +config LOCKDEP_CIRCULAR_QUEUE_BITS
> +       int "Bitsize for elements in circular_queue struct"
> +       depends on LOCKDEP
> +       range 10 30
> +       default 12
> +       help
> +         Try increasing this value if you hit "lockdep bfs error:-1" warning due to __cq_enqueue() failure.
> +
>  config DEBUG_LOCKDEP
>         bool "Lock dependency engine debugging"
>         depends on DEBUG_KERNEL && LOCKDEP
> --
> 2.18.4
>
