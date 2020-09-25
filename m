Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F05B278308
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 10:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbgIYIoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 04:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbgIYIoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 04:44:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6221C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 01:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lN4amxJoHFI8xR2Zb1qzV2zkUpXMr501fx9eI+w1y4Y=; b=hXgH7DjRwjwGdvXhpvjPUme2Lr
        +ta38BXfJrKvMnCVVHzMj6886PAxqc1HqsQafKpD/LbcXc4o50htMD1HkDTS9M8+HaZLNqVfY92NQ
        4x6UC2S2j5BPK9ewns26DN/W7hypexuzXRX3uIHYBXxvoE1wmH0K1FyG2yT7Fac+ZJDvp7a8/tZtj
        HBuRbZgO+uL02n+WleXHxoPLWerfn0mCVaFBNSZ4/L31zDUbF2BAdWIIf/97cotHKU7KB2fGt3OV6
        4E7GnkXi3DWPrA+WhpBiA90FfkHpsYJE2lwAoWi0qbCj/p8qLUN91R6UT8HkMEWc1N4nOlF9085j1
        x/8RtVOQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kLjKQ-0000IC-F8; Fri, 25 Sep 2020 08:43:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4EB75301A27;
        Fri, 25 Sep 2020 10:43:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1507720240A54; Fri, 25 Sep 2020 10:43:39 +0200 (CEST)
Date:   Fri, 25 Sep 2020 10:43:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vincent.donnefort@arm.com
Subject: Re: [PATCH 8/9] sched: Fix migrate_disable() vs
 set_cpus_allowed_ptr()
Message-ID: <20200925084339.GU2628@hirez.programming.kicks-ass.net>
References: <20200921163557.234036895@infradead.org>
 <20200921163845.830487105@infradead.org>
 <jhj3637lzdm.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhj3637lzdm.mognet@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 08:59:33PM +0100, Valentin Schneider wrote:

> > +	if (task_running(rq, p) || p->state == TASK_WAKING) {
> > +
> > +		task_rq_unlock(rq, p, rf);
> > +		stop_one_cpu(cpu_of(rq), migration_cpu_stop, &arg);
> > +
> 
> Shouldn't we check for is_migrate_disabled(p) before doing any of that?
> migration_cpu_stop() does check for it, is there something that prevents us
> from acting on it earlier than that?

Since migrate_disable() / ->migration_disabled is only touched from the
current task, you can only reliably read it from the same CPU.

Hence I only look at it when the stop task has pinned the task, because
at that point I know it's stable.

Doing it earlier gives races, races give me head-aches. This is a slow
path, I don't care about performance.
