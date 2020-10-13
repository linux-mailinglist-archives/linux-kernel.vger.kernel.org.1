Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFE728D54D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 22:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730166AbgJMUZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 16:25:55 -0400
Received: from foss.arm.com ([217.140.110.172]:36662 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbgJMUZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 16:25:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93C9930E;
        Tue, 13 Oct 2020 13:25:54 -0700 (PDT)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C6063F66B;
        Tue, 13 Oct 2020 13:25:53 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] sched/uclamp: add SCHED_FLAG_UTIL_CLAMP_RESET flag
 to reset uclamp
To:     Yun Hsiang <hsiang023167@gmail.com>, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, qais.yousef@arm.com,
        patrick.bellasi@matbug.net
References: <20201012163140.371688-1-hsiang023167@gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <ae86aa70-2787-fe35-7ea6-2d1c4f4d9301@arm.com>
Date:   Tue, 13 Oct 2020 22:25:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201012163140.371688-1-hsiang023167@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yun,

On 12/10/2020 18:31, Yun Hsiang wrote:
> If the user wants to stop controlling uclamp and let the task inherit
> the value from the group, we need a method to reset.
> 
> Add SCHED_FLAG_UTIL_CLAMP_RESET flag to allow the user to reset uclamp via
> sched_setattr syscall.

before we decide on how to implement the 'uclamp user_defined reset'
feature, could we come back to your use case in
https://lkml.kernel.org/r/20201002053812.GA176142@ubuntu ?

Lets just consider uclamp min for now. We have:

(1) system-wide:

# cat /proc/sys/kernel/sched_util_clamp_min

1024

(2) tg (hierarchy) with top-app's cpu.uclamp.min to ~200 (20% of 1024):

# cat /sys/fs/cgroup/cpu/top-app/cpu.uclamp.min
20

(3) and 2 cfs tasks A and B in top-app:

# cat /sys/fs/cgroup/cpu/top-app/tasks

pid_A
pid_B

Then you set A and B's uclamp min to 100. A and B are now user_defined.
A and B's effective uclamp min value is 100.

Since the task uclamp min values (3) are less than (1) and (2), their
uclamp min value is not affected by (1) or (2).

If A doesn't want to control itself anymore, it can set its uclamp min
to e.g. 300. Now A's effective uclamp min value is ~200, i.e. controlled
by (2), the one of B stays 100.

So the policy is:

(a) If the user_defined task wants to control it's uclamp, use task
    uclamp value less than the tg (hierarchy) (and the system-wide)
    value.

(b) If the user_defined task doesn't want to control it's uclamp
    anymore, use a uclamp value greater than or equal the tg (hierarchy)
    (and the system-wide) value.

So where exactly is the use case which would require a 'uclamp
user_defined reset' functionality?
