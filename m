Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F129A283916
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 17:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgJEPKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 11:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbgJEPJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 11:09:58 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD096C0613A7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 08:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=7uxcc1HQbsFxsgUBYV1O60g/85bhzF6mB+uRSWcz9tY=; b=AYTp+kc76rR6Lmv3HBoFX2QoDV
        tgcB3fVGSqmXnOjgxSOCOOsCWyCuuEDatbK32gmkGxys3mxLZIDNvOD3wP2R93Ey7gIeHXMgmcvhj
        dae7/m07g2ieSvryyzgAIYxnWGZYBdJZh0JLfNW62WGUqowiNtHhnwrwMeKu8G6NcttHRAhS04inT
        4lkjlNWXaWaVdRhQvYSmRY8TSdq0tZ9460N2u/CJr+4roPmTtqdszYYqrnCCaF/VrNUsiamRarrZE
        Mj4WcOlRGpoHm9Txoz69vHVm/g4ExjaC1Mwu+F3pjC3KGrscbkUBkiTn4aiL5Fnv1CPTXadYoWnYg
        /IBLJZJg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kPS7U-0008OX-RX; Mon, 05 Oct 2020 15:09:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CD8EB300B22;
        Mon,  5 Oct 2020 17:09:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B7FF329A897B1; Mon,  5 Oct 2020 17:09:42 +0200 (CEST)
Message-ID: <20201005145717.346020688@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 05 Oct 2020 16:57:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        qais.yousef@arm.com, swood@redhat.com, peterz@infradead.org,
        valentin.schneider@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com, tj@kernel.org
Subject: [PATCH -v2 00/17] sched: Migrate disable support
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Seconds version of migrate_disable(); it has a bunch of bugs fixed and has
grown rt/dl balancer changes to push away tasks that inhibit the migration of
migrate_disable() tasks.

I still don't like it much, and it very much hurts my brain, but it seems to have
stopped crashing in weird and wonderful ways.

Tested on PREEMPT_RT.

---
 fs/proc/array.c               |   4 +-
 include/linux/cpuhotplug.h    |   1 +
 include/linux/cpumask.h       |   6 +
 include/linux/preempt.h       |  64 ++++
 include/linux/sched.h         |   5 +
 include/linux/sched/hotplug.h |   2 +
 include/linux/stop_machine.h  |   5 +
 include/trace/events/sched.h  |  12 +
 kernel/cpu.c                  |   9 +-
 kernel/sched/core.c           | 764 ++++++++++++++++++++++++++++++++----------
 kernel/sched/cpudeadline.c    |   4 +-
 kernel/sched/cpupri.c         |   4 +-
 kernel/sched/deadline.c       |  43 ++-
 kernel/sched/rt.c             |  84 +++--
 kernel/sched/sched.h          |  59 +++-
 kernel/stop_machine.c         |  23 +-
 kernel/workqueue.c            |   4 +
 lib/cpumask.c                 |  18 +
 lib/dump_stack.c              |   2 +
 lib/smp_processor_id.c        |   5 +
 20 files changed, 895 insertions(+), 223 deletions(-)


