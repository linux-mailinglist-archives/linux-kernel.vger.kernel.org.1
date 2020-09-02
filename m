Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53BAE25A2E1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 04:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgIBCHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 22:07:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:60268 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbgIBCHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 22:07:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3B72FAD36;
        Wed,  2 Sep 2020 02:07:16 +0000 (UTC)
Date:   Tue, 1 Sep 2020 18:51:28 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Question on task_blocks_on_rt_mutex()
Message-ID: <20200902015128.wsulcxhbo7dutcjz@linux-p48b>
References: <20200831224911.GA13114@paulmck-ThinkPad-P72>
 <20200831232130.GA28456@paulmck-ThinkPad-P72>
 <20200901174938.GA8158@paulmck-ThinkPad-P72>
 <20200901235821.GA8516@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200901235821.GA8516@paulmck-ThinkPad-P72>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Sep 2020, Paul E. McKenney wrote:

>And it appears that a default-niced CPU-bound SCHED_OTHER process is
>not preempted by a newly awakened MAX_NICE SCHED_OTHER process.  OK,
>OK, I never waited for more than 10 minutes, but on my 2.2GHz that is
>close enough to a hang for most people.
>
>Which means that the patch below prevents the hangs.  And maybe does
>other things as well, firing rcutorture up on it to check.
>
>But is this indefinite delay expected behavior?
>
>This reproduces for me on current mainline as follows:
>
>tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --torture lock --duration 3 --configs LOCK05
>
>This hangs within a minute of boot on my setup.  Here "hangs" is defined
>as stopping the per-15-second console output of:
>	Writes:  Total: 569906696 Max/Min: 81495031/63736508   Fail: 0

Ok this doesn't seem to be related to lockless wake_qs then. fyi there have
been missed wakeups in the past where wake_q_add() fails the cmpxchg because
the task is already pending a wakeup leading to the actual wakeup ocurring
before its corresponding wake_up_q(). This is why we have wake_q_add_safe().
But for rtmutexes, because there is no lock stealing only top-waiter is awoken
as well as try_to_take_rt_mutex() is done under the lock->wait_lock I was not
seeing an actual race here.

Thanks,
Davidlohr
