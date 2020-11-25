Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEF92C428D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 16:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbgKYPBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 10:01:23 -0500
Received: from foss.arm.com ([217.140.110.172]:53060 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbgKYPBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 10:01:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46113106F;
        Wed, 25 Nov 2020 07:01:22 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0FA453F70D;
        Wed, 25 Nov 2020 07:01:20 -0800 (PST)
References: <20201123022433.17905-1-valentin.schneider@arm.com> <87be8915-21b0-5214-9742-ccc7515c298b@intel.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, James Morse <James.Morse@arm.com>
Subject: Re: [PATCH v2 0/3] x86/intel_rdt: task_work vs task_struct rmid/closid write race
In-reply-to: <87be8915-21b0-5214-9742-ccc7515c298b@intel.com>
Date:   Wed, 25 Nov 2020 15:01:16 +0000
Message-ID: <jhjpn41v5tv.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Reinette,

On 24/11/20 21:37, Reinette Chatre wrote:
> Hi Valentin,
>
> On 11/22/2020 6:24 PM, Valentin Schneider wrote:
>> This is a small cleanup + a fix for a race I stumbled upon while staring at
>> resctrl stuff.
>>
>> Briefly tested on a Xeon Gold 5120 (m2.xlarge.x86 on Equinix) by bouncing
>> a few tasks around control groups.
>>
>
> ...
>
> Thank you very much for taking this on. Unfortunately this race is one
> of a few issues with the way in which tasks moving to a new resource
> group is handled.
>
> Other issues are:
>
> 1.
> Until the queued work is run, the moved task runs with old (and even
> invalid in the case when its original resource group has been removed)
> closid and rmid.
>

For a userspace task, that queued work should be run as soon as possible
(& relevant). If said task is currently running, then task_work_add() will
lead to an IPI; the other cases (task moving itself or not currently
running) are covered by the return to userspace path.

Kernel threads however are a prickly matter because they quite explicitly
don't have this return to userspace - they only run their task_work
callbacks on exit. So we currently have to wait for those kthreads to go
through a context switch to update the relevant register, but I don't
see any other alternative that wouldn't involve interrupting every other
CPU (the kthread could move between us triggering some remote work and its
previous CPU receiving the IPI).

> 2.
> Work to update the PQR_ASSOC register is queued every time the user
> writes a task id to the "tasks" file, even if the task already belongs
> to the resource group and in addition to any other pending work for that
> task. This could result in multiple pending work items associated with a
> single task even if they are all identical and even though only a single
> update with most recent values is needed. This could result in
> significant system resource waste, especially on tasks sleeping for a
> long time.
>
> Fenghua solved these issues by replacing the callback with a synchronous
> update, similar to how tasks are currently moved when a resource group
> is deleted. We plan to submit this work next week.
>
> This new solution will make patch 1 and 2 of this series unnecessary. As
> I understand it patch 3 would still be a welcome addition but would
> require changes. As you prefer you could either submit patch 3 on its
> own for the code as it is now and we will rework the task related
> changes on top of that, or you could wait for the task related changes
> to land first?
>

Please do Cc me on those - I'll re-evaluate the need for patch 3 then.

Thanks!

>>
>> Valentin Schneider (3):
>>    x86/intel_rdt: Check monitor group vs control group membership earlier
>>    x86/intel_rdt: Plug task_work vs task_struct {rmid,closid} update race
>>    x86/intel_rdt: Apply READ_ONCE/WRITE_ONCE to task_struct .rmid &
>>      .closid
>>
>
> Thank you very much
>
> Reinette
