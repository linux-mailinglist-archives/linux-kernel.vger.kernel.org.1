Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC4D91BDB46
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 14:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbgD2MBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 08:01:44 -0400
Received: from foss.arm.com ([217.140.110.172]:37862 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbgD2MBn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 08:01:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09DC9106F;
        Wed, 29 Apr 2020 05:01:43 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC3693F73D;
        Wed, 29 Apr 2020 05:01:41 -0700 (PDT)
References: <20200428050242.17717-1-swood@redhat.com> <20200428050242.17717-4-swood@redhat.com> <jhjees7s29u.mognet@arm.com> <fa406883f0eace37fe7f658814e29f82a4f0addf.camel@redhat.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Scott Wood <swood@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [RFC PATCH 3/3] sched,rt: break out of load balancing if an RT task appears
In-reply-to: <fa406883f0eace37fe7f658814e29f82a4f0addf.camel@redhat.com>
Date:   Wed, 29 Apr 2020 13:01:39 +0100
Message-ID: <jhjr1w6pkkc.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 28/04/20 23:33, Scott Wood wrote:
>> > +
>> > +/* Is there a task of a high priority class? */
>> > +static inline bool rq_has_runnable_rt_task(struct rq *rq)
>> > +{
>> > +	return unlikely(rq->nr_running != rq->cfs.h_nr_running);
>>
>> Seeing as that can be RT, DL or stopper, that name is somewhat misleading.
>
> rq_has_runnable_rt_dl_task()?  Or is there some term that unambiguously
> encompasses both?
>

Naming is a pain as always; I'd shove it in fair.c as
"rq_has_higher_tasks()" or similar.

> -Scott
