Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70C94296CDB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 12:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S462388AbgJWK0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 06:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S462193AbgJWKZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 06:25:14 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9899AC0613D2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 03:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=vUJMYzKjoiu+2eZIhnJKfp3/PqFT+oYykzDIiYMipmc=; b=ZMi22j+zSNhyZGStX9wcayN2EN
        4wUyydRClc+f8oSPD47+rNHILXrXUqLhJVXQPiIoG6my4xWV3W5wpLTnnRmpgbc8oY6oi1s8LWCEY
        3R05XUNtQus4vdLKhM1Vl4usepJZVuZYXMekwaNcwVnJaxY0aKjBL8RqdgyFVAARO3I1FM4J0reA1
        uSg6uDz0A9Aqz+J5VuhtMxZ13ETxiyG2RhUaA/Gulnoo2Dtj1ezN4Hadr1bvNaYI5MhPvlQxeLvoj
        45iYdxconXBAkqovAzyGwGNzm5kEv6cBah/375EcuZYEGAZtXYyq54th8ZckoRJbTaqfeXeeJh0BP
        vDxciHOQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVuFn-0003Ac-Nv; Fri, 23 Oct 2020 10:24:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6416A305C10;
        Fri, 23 Oct 2020 12:24:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 31C9829DDA657; Fri, 23 Oct 2020 12:24:56 +0200 (CEST)
Message-ID: <20201023101158.088940906@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 23 Oct 2020 12:11:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        qais.yousef@arm.com, swood@redhat.com, peterz@infradead.org,
        valentin.schneider@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com, tj@kernel.org,
        ouwen210@hotmail.com
Subject: [PATCH v4 00/19] sched: Migrate disable support
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The fourth version of migrate_disable() for PREEMPT_RT.

Two changes since last time:

 - fixes !SMP builds (bigeasy)
 - TLA+ validation of migrate_disable() vs sched_setaffinity() (valsch)

Esp. that latter resulted in significant changes to patch #10. Huge thanks to
Valentin.

---
 fs/proc/array.c               |    4 
 include/linux/cpuhotplug.h    |    1 
 include/linux/cpumask.h       |    6 
 include/linux/preempt.h       |   69 +++
 include/linux/sched.h         |    5 
 include/linux/sched/hotplug.h |    2 
 include/linux/stop_machine.h  |    5 
 include/trace/events/sched.h  |   12 
 kernel/cpu.c                  |    9 
 kernel/sched/core.c           |  925 +++++++++++++++++++++++++++++++++---------
 kernel/sched/cpudeadline.c    |    4 
 kernel/sched/cpupri.c         |    4 
 kernel/sched/deadline.c       |   47 +-
 kernel/sched/rt.c             |   81 ++-
 kernel/sched/sched.h          |   59 ++
 kernel/stop_machine.c         |   23 -
 kernel/workqueue.c            |    4 
 lib/cpumask.c                 |   18 
 lib/dump_stack.c              |    2 
 lib/smp_processor_id.c        |    5 
 20 files changed, 1056 insertions(+), 229 deletions(-)

