Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3990B28F0B7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 13:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731284AbgJOLK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 07:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730659AbgJOLKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 07:10:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE239C0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 04:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=TtmRHLIX95xbXx5qC43nj9eDzT89CPl5wEDLzlxaBF0=; b=ODerkIWwMJlGbMxRyprvWhDllV
        SkpcOT6glS9NQYM8TKi/NGG+1ZTiyJiTx0w2zwtXqx3Wc1LN6+Eq8TdGXt7h2zlg0nIAPVzKTQQJb
        F6d7GjEzov6+XQ89iqYSdTQ7mxkZAFl7JyA+gTOECv1jxzQqM9fFTVHO1qbz2hVPIrf6ahfoiYjRF
        gYlWSDONuO/3HVJAMVRbgif4WfOk0+x8uYci3yY7ll5MjPE2Y53cGWNw7Rf3NFwwDb0T7oozmRnDF
        cuQHyEz1s1W4sBuFLZyeC74b2II7W1C3wyPFkccOvkHJ7bULoQBVn8fWi9ifADQKapTAvKvRRhj1Z
        SSXbx60g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kT18c-0002O9-00; Thu, 15 Oct 2020 11:09:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8606B30015A;
        Thu, 15 Oct 2020 13:09:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 63DDB235F4443; Thu, 15 Oct 2020 13:09:36 +0200 (CEST)
Message-ID: <20201015110532.738127234@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 15 Oct 2020 13:05:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        qais.yousef@arm.com, swood@redhat.com, peterz@infradead.org,
        valentin.schneider@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com, tj@kernel.org,
        ouwen210@hotmail.com
Subject: [PATCH v3 00/19] sched: Migrate disable support
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Third version of migrate_disable()... hopefully getting to the point where we're all happy with it.

---
 fs/proc/array.c               |    4 
 include/linux/cpuhotplug.h    |    1 
 include/linux/cpumask.h       |    6 
 include/linux/preempt.h       |   64 +++
 include/linux/sched.h         |    5 
 include/linux/sched/hotplug.h |    2 
 include/linux/stop_machine.h  |    5 
 include/trace/events/sched.h  |   12 
 kernel/cpu.c                  |    9 
 kernel/sched/core.c           |  852 +++++++++++++++++++++++++++++++++---------
 kernel/sched/cpudeadline.c    |    4 
 kernel/sched/cpupri.c         |    4 
 kernel/sched/deadline.c       |   47 +-
 kernel/sched/rt.c             |   81 +++
 kernel/sched/sched.h          |   59 ++
 kernel/stop_machine.c         |   23 -
 kernel/workqueue.c            |    4 
 lib/cpumask.c                 |   18 
 lib/dump_stack.c              |    2 
 lib/smp_processor_id.c        |    5 
 20 files changed, 985 insertions(+), 222 deletions(-)


