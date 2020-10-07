Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1E82286AEC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 00:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbgJGWcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 18:32:52 -0400
Received: from foss.arm.com ([217.140.110.172]:51306 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728275AbgJGWcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 18:32:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DEB081042;
        Wed,  7 Oct 2020 15:32:51 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D569F3F66B;
        Wed,  7 Oct 2020 15:32:49 -0700 (PDT)
References: <20201005145717.346020688@infradead.org> <20201005150922.458081448@infradead.org> <jhjpn5tn8mz.mognet@arm.com> <20201007210850.GQ2628@hirez.programming.kicks-ass.net>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vincent.donnefort@arm.com,
        tj@kernel.org
Subject: Re: [PATCH -v2 15/17] sched: Fix migrate_disable() vs rt/dl balancing
In-reply-to: <20201007210850.GQ2628@hirez.programming.kicks-ass.net>
Date:   Wed, 07 Oct 2020 23:32:44 +0100
Message-ID: <jhjo8ldmzub.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 07/10/20 22:08, Peter Zijlstra wrote:
> On Wed, Oct 07, 2020 at 08:22:44PM +0100, Valentin Schneider wrote:
>> +		struct task_struct *curr = class->peek_next_task(rq);
>
> If you look at the core-sched patches they have something very similar
> :-)

Shiny, there's the fair thing I chickened out of doing all prechewed!

I was trying very hard to forget about that series, seems like I did partly
succeed in that :)
