Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7494C223DA2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 16:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgGQOF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 10:05:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:54002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbgGQOF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:05:58 -0400
Received: from lenoir.home (lfbn-ncy-1-317-216.w83-196.abo.wanadoo.fr [83.196.152.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21EE12067D;
        Fri, 17 Jul 2020 14:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594994757;
        bh=9EQT3hOMbnuZ/8hseTErt+8ql3auDUgbS6ChJ0lzLu0=;
        h=From:To:Cc:Subject:Date:From;
        b=QAx7A6MvKEOlBOdft6TV3hf8TxrZZf33CmFOHdqI+Hi+Q1fzwVKuChTniUe/f6nOZ
         /JeLh/9HzVy5TwU/5tl6sGV64l1z4sIc9g/Hm2NEH6LZLhzMnzq30eRu0/MSyLHHuK
         0KNSeIzlwhCxxm6peOzunsdQCRL9NXDogUvNTbss=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH 00/11] timer: Reduce timers softirq v3
Date:   Fri, 17 Jul 2020 16:05:39 +0200
Message-Id: <20200717140551.29076-1-frederic@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set piggybacks the 3 patches that have been posted seperately
along the reviews.

Changes since v2:

1) Add "timer: Fix wheel index calculation on last level"
   This one targets timers/urgent

2) Add "timer: Preserve higher bits of expiration on index calculation"
       "timer: Move trigger_dyntick_cpu() to enqueue_timer()"

3) Rebase the series against the whole

4) Fix comments in "timer: Move trigger_dyntick_cpu() to enqueue_timer()"
   as per Anna Maria's suggestion

5) Fix comments in "timer: Add comments about calc_index() ceiling work"
   as per Thomas' suggestion

Please pull the timers/softirq-v3 branch that can be found at:

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	timers/softirq-v3

HEAD: f176eb2a146b422f78d81ec63273487c33b3011d

Thanks,
	Frederic
---

Frederic Weisbecker (11):
      timer: Fix wheel index calculation on last level
      timer: Preserve higher bits of expiration on index calculation
      timer: Move trigger_dyntick_cpu() to enqueue_timer()
      timer: Add comments about calc_index() ceiling work
      timer: Optimize _next_timer_interrupt() level iteration
      timers: Always keep track of next expiry
      timer: Reuse next expiry cache after nohz exit
      timer: Expand clk forward logic beyond nohz
      timer: Spare timer softirq until next expiry
      timer: Remove must_forward_clk
      timer: Lower base clock forwarding threshold

Anna-Maria Behnsen (1):
      timers: Use only bucket expiry for base->next_expiry value


 kernel/time/timer.c | 236 ++++++++++++++++++++--------------------------------
 1 file changed, 92 insertions(+), 144 deletions(-)
