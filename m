Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 973C6272FF1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 19:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730146AbgIURBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 13:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729232AbgIUQjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 12:39:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760BFC0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 09:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=wqjgegzO+ftSkJE9wxZ13VljYsOaTKVsRiQ6s8/UsDE=; b=RzNhDIUjOse4Y9gkmMHX3iwp4B
        s+zEFCFZS4Z5FMcRDFTbxo2I9r+/ZNIaVpP2tN66WHePYdSMhDMkkBM9V+nVhF0v533u+nViuKXfU
        TH5S5BbDgDXE8Ll5BG2a4xzufqNZd1LDIRbiBufTiCAI+SAwxE6orsZf1ss90fNMdMS0vPDVyyBlW
        3tRMykIGHmhbB5K9+bsLtTFGwW0kCpW1BxxhecejtowwNE2efGLK7NiYk3SM7xI19yDm6IO3vX+gP
        fduwqpddzdWttUb7h/WV6UglK65Mv04Eol4NiNHNxac1OioyZlha9SXN+/5n+CipXBlfLLl+RS0ZI
        d9Ew11oQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kKOqD-000160-8w; Mon, 21 Sep 2020 16:39:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CA73D307A5A;
        Mon, 21 Sep 2020 18:38:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 9A2E7202075F1; Mon, 21 Sep 2020 18:38:59 +0200 (CEST)
Message-ID: <20200921163557.234036895@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 21 Sep 2020 18:35:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        qais.yousef@arm.com, swood@redhat.com, peterz@infradead.org,
        valentin.schneider@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com
Subject: [PATCH 0/9] sched: Migrate disable support
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's my take on migrate_disable(). It avoids growing a second means of
changing the affinity, documents how the things violates locking rules but
still mostly works.

It also avoids blocking completely, so no more futex band-aids required.

Also, no more atomics/locks on the fast path.

I also put in a comment that explains how the whole concept is fundamentally
flawed but a necessary evil to get PREEMPT_RT going -- for now.

Somewhat tested with PREEMPT_RT.

---
 include/linux/cpuhotplug.h    |    1 
 include/linux/preempt.h       |   60 +++
 include/linux/sched.h         |    4 
 include/linux/sched/hotplug.h |    2 
 include/linux/stop_machine.h  |    5 
 kernel/cpu.c                  |    9 
 kernel/sched/core.c           |  673 +++++++++++++++++++++++++++++++-----------
 kernel/sched/deadline.c       |    5 
 kernel/sched/sched.h          |   24 +
 kernel/stop_machine.c         |   23 +
 lib/dump_stack.c              |    2 
 lib/smp_processor_id.c        |    5 
 12 files changed, 635 insertions(+), 178 deletions(-)

