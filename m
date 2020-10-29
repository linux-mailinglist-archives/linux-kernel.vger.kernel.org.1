Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B24BA29EBC8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 13:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgJ2MYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 08:24:50 -0400
Received: from foss.arm.com ([217.140.110.172]:35088 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgJ2MYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 08:24:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 067BF13A1;
        Thu, 29 Oct 2020 05:24:49 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C89D3F719;
        Thu, 29 Oct 2020 05:24:47 -0700 (PDT)
References: <20201028174412.680-1-vincent.guittot@linaro.org> <BN8PR12MB2978D627EE0D6456DC2EEA6B9A140@BN8PR12MB2978.namprd12.prod.outlook.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Tao Zhou <ouwen210@hotmail.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org,
        morten.rasmussen@arm.com
Subject: Re: [PATCH v2] sched/fair: prefer prev cpu in asymmetric wakeup path
In-reply-to: <BN8PR12MB2978D627EE0D6456DC2EEA6B9A140@BN8PR12MB2978.namprd12.prod.outlook.com>
Date:   Thu, 29 Oct 2020 12:24:45 +0000
Message-ID: <jhjimatp6cy.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 29/10/20 12:17, Tao Zhou wrote:
> Hi Vincent,
>
> On Wed, Oct 28, 2020 at 06:44:12PM +0100, Vincent Guittot wrote:
>> @@ -6173,20 +6173,20 @@ static int
>>  select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
>>  {
>>      unsigned long best_cap = 0;
>> -	int cpu, best_cpu = -1;
>> +	int task_util, cpu, best_cpu = -1;
>>      struct cpumask *cpus;
>>
>> -	sync_entity_load_avg(&p->se);
>> -
>>      cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
>>      cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
>>
>> +	task_util = uclamp_task_util(p);
>
> The return type of uclamp_task_util() is *unsigned long*.
> But, task_util is *int*.
>
> @Valentin: I checked that the return type of uclamp_task_util()
> is changed from unsigned int to unsigned long by you
>

Indeed, IIRC I stated in that changelog that the canonical type for
utilization / capacity values is unsigned long.
