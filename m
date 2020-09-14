Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 865DA268457
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 08:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgINGDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 02:03:34 -0400
Received: from mail.jv-coder.de ([5.9.79.73]:46504 "EHLO mail.jv-coder.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726030AbgINGDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 02:03:33 -0400
Received: from [10.61.40.7] (unknown [37.156.92.209])
        by mail.jv-coder.de (Postfix) with ESMTPSA id 2F5369F7F6;
        Mon, 14 Sep 2020 06:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
        t=1600063409; bh=PTS1Gsr7Nh89LZ5e6XV6TSxihUbw/uQD/CL+Tyjz01w=;
        h=Subject:To:From:Message-ID:Date:MIME-Version;
        b=CrAaTU16cfRkBIvL6Cn4YUvmfoO3BeKbgDyThduFmvRIJuokfWCociD4H7nGpo/O3
         TKc8JDQhZpkyGndU34kituUfoBeXIF+tEEuOKKDiIQehbDlM+QA1P8EZmXUOBmAhyK
         NOtt3VpSJcmRYxF/i3GYCEvY8Eu7JLmkDkBSA9Kc=
Subject: Re: [BUG RT] dump-capture kernel not executed for panic in interrupt
 context
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     peterz@infradead.org, Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Huang Ying <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org,
        Joerg Vehlow <joerg.vehlow@aox-tech.de>
References: <20200528084614.0c949e8d@gandalf.local.home>
 <cbbf7926-148e-7acb-dc03-3f055d73364b@jv-coder.de>
 <20200727163655.8c94c8e245637b62311f5053@linux-foundation.org>
 <c6b095af-fc92-420f-303f-d2efd9f28873@jv-coder.de>
 <20200821110848.6c3183d1@oasis.local.home>
 <20200821134753.9547695c9b782275be3c95b5@linux-foundation.org>
 <20200821170334.73b52fdd@oasis.local.home>
 <95d7a489-a295-1c11-ac62-83e941ed3a87@jv-coder.de>
 <20200907114618.GR2674@hirez.programming.kicks-ass.net>
 <5c3a502f-2255-5aae-3599-5220aa4b8328@jv-coder.de>
 <20200907162338.GN1362448@hirez.programming.kicks-ass.net>
 <5600c9f8-2c9d-7776-161a-5f5c1be62c10@jv-coder.de>
 <51f3b288-260b-a800-6a47-51d93f892c3d@jv-coder.de>
 <87sgbo3p5w.fsf@x220.int.ebiederm.org>
From:   Joerg Vehlow <lkml@jv-coder.de>
Message-ID: <22bad750-ef5d-82a5-527c-5213346dd280@jv-coder.de>
Date:   Mon, 14 Sep 2020 08:03:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <87sgbo3p5w.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=1.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,HELO_MISC_IP,NICE_REPLY_A,RDNS_NONE
        autolearn=no autolearn_force=no version=3.4.4
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on mail.jv-coder.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,
> What is this patch supposed to be doing?
>
> What bug is it fixing?
This information is part in the first message of this mail thread.
The patch was intendedfor the active discussion in this thread,
not for a broad review.
A short summary: In the rt kernel, a panic in an interrupt context does
not start the dump-capture kernel, because there is a mutex_trylock in
__crash_kexe. If this is called in interrupt context, it always fails.
In the non-rt kernel calling mutex_trylock is not allowed according to
the comment of the function, but it still works.

> A BUG_ON that triggers inside of BUG_ONs seems not just suspect but
> outright impossible to make use of.
I am not entirely sure what would happen here. But even if it gets in
some kind ofendless loop, I guess this is ok, because it allows finding
the problem. A piece of code in the function, that ensures the precondition
is a lot better than relying on only a comment.
If this was in mtex_trylock, the bug described above wouldn't have sneaked
in 12 years ago...
> I get the feeling skimming this that it is time to sort out and simplify
> the locking here, rather than make it more complex, and more likely to
> fail.
I would very much like that, but sadly it looks like it is not possible.
Either it wouldrequire blocking locks, that may fail, or not locking at
all, that may also fail.Using a different kind of lock (like spinlock)
is also not possible, becausespinlock_trylock again uses mutex_trylock
in the rt kernel.
>
> I get the feeling that over the years somehow the assumption that the
> rest of the kernel is broken and that we need to get out of the broken
> kernel as fast and as simply as possible has been lost.
Yes I also have the feeling, that the mutexes need fixing, but I wouldn't
to post any patch for that. At the moment, given the interface of the mutex,
this is clearly a bug in kexec, even if it works in the non-rt kernel.

Jörg
