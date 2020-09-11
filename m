Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1D52660F7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 16:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgIKOJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 10:09:59 -0400
Received: from foss.arm.com ([217.140.110.172]:34454 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbgIKN20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 09:28:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57467106F;
        Fri, 11 Sep 2020 06:27:34 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E8DB3F68F;
        Fri, 11 Sep 2020 06:27:33 -0700 (PDT)
References: <20200911081745.214686199@infradead.org> <20200911082536.470013100@infradead.org> <jhjsgbo5wzl.mognet@arm.com> <20200911122547.GI1362448@hirez.programming.kicks-ass.net>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     peterz@infradead.org
Cc:     mingo@kernel.org, vincent.guittot@linaro.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bristot@redhat.com, swood@redhat.com
Subject: Re: [PATCH 1/2] sched: Fix balance_callback()
In-reply-to: <20200911122547.GI1362448@hirez.programming.kicks-ass.net>
Date:   Fri, 11 Sep 2020 14:27:30 +0100
Message-ID: <jhjpn6s5tq5.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/09/20 13:25, peterz@infradead.org wrote:
> On Fri, Sep 11, 2020 at 01:17:02PM +0100, Valentin Schneider wrote:
>> So that can be say __schedule() tail racing with some setprio; what's the
>> worst that can (currently) happen here? Something like say two consecutive
>> enqueuing of push_rt_tasks() to the callback list?
>
> Yeah, but that isn't in fact the case I worry most about.
>
> What can happen (and what I've spotted once before) is that someone
> attempts to enqueue a balance_callback from a rq->lock region that
> doesn't handle the calls.
>
> Currently that 'works', that is, it will get ran _eventually_. But
> ideally we'd want that to not work and issue a WARN. We want the
> callbacks to be timely.
>
> So basically all of these machinations we in order to add the WARN :-)

Makes sense, thanks!
