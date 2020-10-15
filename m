Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A365728F18D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 13:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730246AbgJOLzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 07:55:17 -0400
Received: from foss.arm.com ([217.140.110.172]:35160 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730041AbgJOLyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 07:54:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23ADC31B;
        Thu, 15 Oct 2020 04:53:47 -0700 (PDT)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 243343F66B;
        Thu, 15 Oct 2020 04:53:45 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] sched/uclamp: add SCHED_FLAG_UTIL_CLAMP_RESET flag
 to reset uclamp
To:     Patrick Bellasi <patrick.bellasi@matbug.net>
Cc:     Yun Hsiang <hsiang023167@gmail.com>, peterz@infradead.org,
        linux-kernel@vger.kernel.org, qais.yousef@arm.com
References: <20201012163140.371688-1-hsiang023167@gmail.com>
 <ae86aa70-2787-fe35-7ea6-2d1c4f4d9301@arm.com>
 <87zh4ohnf9.derkling@matbug.net>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <e935245c-1403-3a3f-9849-f4adca2f6020@arm.com>
Date:   Thu, 15 Oct 2020 13:53:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87zh4ohnf9.derkling@matbug.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/2020 16:50, Patrick Bellasi wrote:
> 
> On Tue, Oct 13, 2020 at 22:25:48 +0200, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote...

[...]

>> On 12/10/2020 18:31, Yun Hsiang wrote:

[...]

> Not sure what's the specific use-case Yun is after, but I have at least
> one in my mind.
> 
> Let say a task does not need boost at all, independently from
> the cgroup it's configured to run into. We can go on and set its task
> specific value to util_min=0.
> 
> In this case, when the task is running alone on a CPU, it will get
> always the minimum OPP, independently from its utilization.
> 
> Now, after a while (e.g. some special event happens) we want to relax
> this constraint and allow the task to run:
>   1. at whatever OPP is required by its utilization
>   2. with any additional boost possibly enforced by its cgroup
> 
> Right now we have only quite cumbersome or hack solution:
>   a) go check the current cgroup util_min value and set for the task
>   something higher than that

IMHO, it's not only the current taskgroup. You would have to check the
whole hierarchy (including system-wide).

>   b) set task::util_min=1024 thus asking for the maximum possible boost
> 
> Solution a) is more code for userspace and it's also racy. Solution b)
> is misleading since the task does not really want to run at 1024.
> It's also potentially over-killing in case the task should be moved to
> the root group, which is normally unbounded and thus the task will get
> executed always at the max OPP without any specific reason why.
> 
> A simple _UCLAMP_RESET flag will allow user-space to easily switch a
> tasks to the default behavior (follow utilization or recommended
> boosts) which is what a task usually gets when it does not opt-in to
> uclamp.

OK, so restricting (eclipsing) 'user_defined' task uclamp values to
taskgroup (hierarchy) values by setting the task value > the taskgroup
(hierarchy) value is cumbersome.

A task uclamp reset function will force this 'user_defined' task
automatically under taskgroup (hierarchy) control by turning it into a
'!user_defined' task again.

... and this will facilitate easier uclamp userspace controller.
