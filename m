Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE7E32D6231
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 17:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392364AbgLJQl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 11:41:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:49520 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392188AbgLJQBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 11:01:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607616057; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yQSYHdaxfuV+MPVDKcJa/1toI/9a11F7SCyTgdm0uzg=;
        b=DTQ7VWJnpvMsFq6BB4RkGzPMgyJyzV539B1Dn+ZJmIxPSTgCWzThsWuJFODBRc9DBCMjTO
        sg948f8RiYe8MIRXozN2ZayG53zIglSJQDGMvhRaYmjZ2onuDccBdxCiTAnegfIPCKHWQf
        CRrKkYJ3oKQ6yJU0Y5zgRejMe2dm+fU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AB662AF1A;
        Thu, 10 Dec 2020 16:00:57 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Laurence Oberman <loberman@redhat.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2 2/7] watchdog: Explicitly update timestamp when reporting softlockup
Date:   Thu, 10 Dec 2020 17:00:33 +0100
Message-Id: <20201210160038.31441-3-pmladek@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201210160038.31441-1-pmladek@suse.com>
References: <20201210160038.31441-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The softlockup situation might stay for a long time or even forever.
When it happens, the softlockup debug messages are printed in regular
intervals defined by get_softlockup_thresh().

There is a mystery. The repeated message is printed after the full interval
that is defined by get_softlockup_thresh(). But the timer callback is called
more often as defined by sample_period. The code looks like the soflockup
should get reported in every sample_period when it was once behind the thresh.

It works only by chance. The watchdog is touched when printing the stall
report, for example, in printk_stack_address().

Make the behavior clear and predictable by explicitly updating
the timestamp in watchdog_timer_fn() when the report gets printed.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/watchdog.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index c58244064de8..7776d53a015c 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -409,6 +409,9 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 			}
 		}
 
+		/* Start period for the next softlockup warning. */
+		update_touch_ts();
+
 		pr_emerg("BUG: soft lockup - CPU#%d stuck for %us! [%s:%d]\n",
 			smp_processor_id(), duration,
 			current->comm, task_pid_nr(current));
-- 
2.26.2

