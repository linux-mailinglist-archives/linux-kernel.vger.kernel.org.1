Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D075D2B4061
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 11:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgKPKAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 05:00:22 -0500
Received: from foss.arm.com ([217.140.110.172]:36976 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbgKPKAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 05:00:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4657A31B;
        Mon, 16 Nov 2020 02:00:21 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6156E3F718;
        Mon, 16 Nov 2020 02:00:20 -0800 (PST)
References: <a1fd0d9c6c8cd90a74879b61467ae48d@natalenko.name>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org
Subject: Re: WARNING at kernel/sched/core.c:2013 migration_cpu_stop+0x2e3/0x330
Message-ID: <jhj3619y63v.mognet@arm.com>
In-reply-to: <a1fd0d9c6c8cd90a74879b61467ae48d@natalenko.name>
Date:   Mon, 16 Nov 2020 10:00:14 +0000
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 15/11/20 22:32, Oleksandr Natalenko wrote:
> Hi.
>
> I'm running v5.10-rc3-rt7 for some time, and I came across this splat in 
> dmesg:
>
> ```
> [118769.951010] ------------[ cut here ]------------
> [118769.951013] WARNING: CPU: 19 PID: 146 at kernel/sched/core.c:2013 

Err, I didn't pick up on this back then, but isn't that check bogus? If the
task is enqueued elsewhere, it's valid for it not to be affined
'here'. Also that is_migration_disabled() check within is_cpu_allowed()
makes me think this isn't the best thing to call on a remote task.

---
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1218f3ce1713..47d5b677585f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2010,7 +2010,7 @@ static int migration_cpu_stop(void *data)
 		 * valid again. Nothing to do.
 		 */
 		if (!pending) {
-			WARN_ON_ONCE(!is_cpu_allowed(p, cpu_of(rq)));
+			WARN_ON_ONCE(!cpumask_test_cpu(task_cpu(p), p->cpus_ptr));
 			goto out;
 		}
 
