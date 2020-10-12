Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6954128BC1A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 17:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390066AbgJLPhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 11:37:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:42782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389121AbgJLPhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 11:37:52 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A340F20575;
        Mon, 12 Oct 2020 15:37:50 +0000 (UTC)
Date:   Mon, 12 Oct 2020 11:37:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Rob Clark <robdclark@chromium.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ilias Stamatis <stamatis.iliass@gmail.com>,
        Liang Chen <cl@rock-chips.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: Re: [PATCH] kthread: Add kthread_work tracepoints
Message-ID: <20201012113748.1182eb1c@gandalf.local.home>
In-Reply-To: <CAJs_Fx69jUs5jJdX6ZpP4Z4K_iFdkUAAiium6xAuBiM00Gd4SA@mail.gmail.com>
References: <20201010180323.126634-1-robdclark@gmail.com>
        <20201012095955.0741313b@gandalf.local.home>
        <CAJs_Fx69jUs5jJdX6ZpP4Z4K_iFdkUAAiium6xAuBiM00Gd4SA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Oct 2020 08:14:50 -0700
Rob Clark <robdclark@chromium.org> wrote:

> > DEFINE_EVENT(sched_kthread_work_execute_template, sched_kthread_work_execute_start,
> >         TP_PROTO(struct kthread_work *work),
> >         TP_ARGS(work));
> >
> > DEFINE_EVENT(sched_kthread_work_execute_template, sched_kthread_work_execute_end,
> >         TP_PROTO(struct kthread_work *work),
> >         TP_ARGS(work));
> >
> > As events are cheap, classes are expensive (size wise), and a TRACE_EVENT()
> > is really just a CLASS and EVENT for a single instance.  
> 
> I think we cannot quite do this, because we should not rely on being

Ah I missed seeing that one used work->func and the other passed in the
function.

> able to dereference work after it finishes.  Although I suppose I
> could just define it to explicitly pass the fxn ptr to both
> tracepoints..

But yes, I would rather see that. It could save up to 5K in text and data.

-- Steve
