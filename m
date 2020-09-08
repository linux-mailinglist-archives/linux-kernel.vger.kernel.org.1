Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4842610A1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 13:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbgIHLZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 07:25:01 -0400
Received: from foss.arm.com ([217.140.110.172]:52246 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729351AbgIHLRr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 07:17:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9F3031B;
        Tue,  8 Sep 2020 04:17:24 -0700 (PDT)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BFC033F66E;
        Tue,  8 Sep 2020 04:17:23 -0700 (PDT)
Subject: Re: [PATCH v2] sched/debug: Add new tracepoint to track cpu_capacity
To:     Qais Yousef <qais.yousef@arm.com>, peterz@infradead.org
Cc:     vincent.donnefort@arm.com, mingo@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        valentin.schneider@arm.com, Phil Auld <pauld@redhat.com>
References: <1598605249-72651-1-git-send-email-vincent.donnefort@arm.com>
 <20200828102724.wmng7p6je2pkc33n@e107158-lin.cambridge.arm.com>
 <1e806d48-fd54-fd86-5b3a-372d9876f360@arm.com>
 <20200828172658.dxygk7j672gho4ax@e107158-lin.cambridge.arm.com>
 <58f5d2e8-493b-7ce1-6abd-57705e5ab437@arm.com>
 <20200907104845.6rust2lf2o3d5gmq@e107158-lin.cambridge.arm.com>
 <20200907111320.GP2674@hirez.programming.kicks-ass.net>
 <20200907145155.fsmeygi4fiypikzk@e107158-lin.cambridge.arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <cbad58a5-758b-ded9-ed41-1be74e8663a6@arm.com>
Date:   Tue, 8 Sep 2020 13:17:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200907145155.fsmeygi4fiypikzk@e107158-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2020 16:51, Qais Yousef wrote:
> On 09/07/20 13:13, peterz@infradead.org wrote:
>> On Mon, Sep 07, 2020 at 11:48:45AM +0100, Qais Yousef wrote:
>>> IMHO the above is a hack. Out-of-tree modules should rely on public headers and
>>> exported functions only. What you propose means that people who want to use
>>> these tracepoints in meaningful way must have a prebuilt kernel handy. Which is
>>> maybe true for us who work in the embedded world. But users who run normal
>>> distro kernels (desktop/servers) will fail to build against
>>
>> But this isn't really aimed at regular users. We're aiming this at
>> developers (IIUC) so I dont really see this as a problem.

This is what I thought as well. All these helpers can be coded directly
in these tracepoint-2-traceevent (tp-2-te) converters. As long as they
are build from within kernel/sched/ there is no issue with the export
via kernel/sched/sched.h. Otherwise this little trick would be necessary.
But since it is a tool for developers I guess we can assume that they
can build it from within kernel/sched/.

I tested:

https://lkml.kernel.org/r/20200907091717.26116-1-dietmar.eggemann@arm.com

with our EAS integration which provides one of these tp-2-t2 converter
(sched_tp.c).

http://linux-arm.org/git?p=linux-power.git;a=shortlog;h=refs/heads/topic/tracepoints

[...]
