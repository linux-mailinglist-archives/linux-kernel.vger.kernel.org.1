Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC9303029C0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 19:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731363AbhAYSOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 13:14:47 -0500
Received: from foss.arm.com ([217.140.110.172]:54048 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731296AbhAYRyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 12:54:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A29DA1063;
        Mon, 25 Jan 2021 09:53:57 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6845F3F66E;
        Mon, 25 Jan 2021 09:53:55 -0800 (PST)
Subject: Re: [PATCH] sched/fair: Rate limit calls to update_blocked_averages()
 for NOHZ
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
References: <20210122154600.1722680-1-joel@joelfernandes.org>
 <CAKfTPtAnzhDKXayicDdymWpK1UswfkTaO8vL-WHxVaoj7DaCFw@mail.gmail.com>
 <YAsjOqmo7TEeXjoj@google.com> <2cd5683f-eea3-e661-7dd0-c617c836896f@arm.com>
 <CAKfTPtA7Fte3WWw1=-BaNX-fpfEeWicUOEgfzJsgCTcygzZTQA@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <8db5ebd3-4e5c-cd7e-e0cb-dc86c3cafb5c@arm.com>
Date:   Mon, 25 Jan 2021 18:53:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtA7Fte3WWw1=-BaNX-fpfEeWicUOEgfzJsgCTcygzZTQA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/01/2021 18:30, Vincent Guittot wrote:
> On Mon, 25 Jan 2021 at 11:45, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>
>> On 22/01/2021 20:10, Joel Fernandes wrote:
>>> Hi Vincent,
>>>
>>> Thanks for reply. Please see the replies below:
>>>
>>> On Fri, Jan 22, 2021 at 05:56:22PM +0100, Vincent Guittot wrote:
>>>> On Fri, 22 Jan 2021 at 16:46, Joel Fernandes (Google)
>>>> <joel@joelfernandes.org> wrote:

[...]

>> If I understood you correctly, you want to avoid these frequent calls
>> to update_blocked_averages() here to further avoid invoking sched_util
>> via update_blocked_averages() -> cpufreq_update_util() (since 'decayed'
>> is set) very often in your setup.
> 
> So It's not clear if the problem that joel wants to raise, is about:
> - the running time of  update_blocked_averages
> - the running time of the cpufreq_update_util which is called because
> utilization has decayed during the update of blocked load
> - the wake up latency because of newly_idle lb

Pretty much so.

IIRC his interest is driven by the fact that he saw much less activity
in newly_idle lb and therefore cpufreq_update_util on a system with the
same kernel and userspace but with less CPUs (i.e. also smaller
frequency domains) and less cgroups (with blocked load) and started
wondering why.

I assume that since he understands this environment now much better, he
should be able to come up with better test numbers to show if there is a
performance issue on his 2+6 DynamIQ system and if yes, where exactly in
this code path.
