Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDD33018F0
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 00:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbhAWXin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 18:38:43 -0500
Received: from foss.arm.com ([217.140.110.172]:34244 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726386AbhAWXim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 18:38:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD3841474;
        Sat, 23 Jan 2021 15:37:56 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A16A53F719;
        Sat, 23 Jan 2021 15:37:55 -0800 (PST)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Qais Yousef <qais.yousef@arm.com>
Subject: [PATCH 0/2] Fix BUG: Invalid wait context in hrtimer_interrupt()
Date:   Sat, 23 Jan 2021 23:37:39 +0000
Message-Id: <20210123233741.3614408-1-qais.yousef@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I hit a pr_warn() inside hrtimer_interrupt() which lead to a BUG: Invalid wait
context splat.

The problem wasn't reproducible but I think the cause is obvious, printk can't
be called from interrupt context.

AFAICU printk_deferred() is safe from NMI, so I assumed it is safe to be called
from hrtimer_interrupt() too. Adding a pr_warn_once() inside
hrtimer_interrupt() in a location where it is always hit produces the BUG
splat. Replacing it with pr_warn_deferred_once() generates the printk warning
without any splat.

I added a new pr_*_deferred_once() variants to avoid open coding; but the name
ended not much shorter and I'm not sure if the wrappers are a win overall.
Since I've already done it, I'm sticking to it in this post. But will be happy
to drop it and just open code the printk_deferred_once(KERN_WARN, ...) in
hrtimer_interrupt() instead.

Thanks

Qais Yousef (2):
  printk: Add new pr_*_deferred_once() variants
  hrtimer: Use pr_warn_deferred_once() in hrtimer_interrupt()

 include/linux/printk.h | 24 ++++++++++++++++++++++++
 kernel/time/hrtimer.c  |  3 ++-
 2 files changed, 26 insertions(+), 1 deletion(-)

-- 
2.25.1

