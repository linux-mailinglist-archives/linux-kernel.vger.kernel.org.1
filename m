Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7581FB24E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 15:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbgFPNje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 09:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbgFPNjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 09:39:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F4AC061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 06:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NX4/RAif7Qv0NRDyEqVkKAgLJrAgF0MHnstuThWnuPY=; b=PaYdmCv5e2DLub+pdwJuwWlhXs
        l5usGFGbtrNW3QP4yazJjyBd6Xmf/AEkTxw/f851ece9hv8JoW7/6WWM/LNR39uDv7gvW1Lth8GKi
        r11P/57AsXTc7aeGYH2AzdPK2jzvERd5CVoMimq3T0pRvC3Rkmy2rU9ldb2C8MSSYeQdEYslL5Iab
        QAxKcCeOj8gVUw5ykaumJRMe6iTbxwEah2nuSUVJxVn3uxtpXfB4eK3SiEPU4VUgt2MZtwRTjDknl
        /WXSVLXoAYsWm/9jjC3trjbV9PVXTQ5SIIDEN03fBVt9K+RR3LyY8QeHUfJyOGgK7nNZI5WdMar/V
        o0riZMHQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jlBnl-0000Zb-Vh; Tue, 16 Jun 2020 13:38:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E332D30018A;
        Tue, 16 Jun 2020 15:38:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9D74C20244311; Tue, 16 Jun 2020 15:38:55 +0200 (CEST)
Date:   Tue, 16 Jun 2020 15:38:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peng Wang <rocking@linux.alibaba.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] sched/fair: Optimize dequeue_task_fair()
Message-ID: <20200616133855.GX2531@hirez.programming.kicks-ass.net>
References: <6f2f195aea48bc50187dfb064aa530ba132be01b.1592230286.git.rocking@linux.alibaba.com>
 <701eef9a40de93dcf5fe7063fd607bca5db38e05.1592287263.git.rocking@linux.alibaba.com>
 <CAKfTPtDUXmDB8w+03c2dqrjKDJyp7wrgdwj0oADg8N--9jmRJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtDUXmDB8w+03c2dqrjKDJyp7wrgdwj0oADg8N--9jmRJw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 02:31:15PM +0200, Vincent Guittot wrote:
> On Tue, 16 Jun 2020 at 08:05, Peng Wang <rocking@linux.alibaba.com> wrote:
> >
> > While looking at enqueue_task_fair and dequeue_task_fair, it occurred
> > to me that dequeue_task_fair can also be optimized as Vincent described
> > in commit 7d148be69e3a ("sched/fair: Optimize enqueue_task_fair()").
> >
> > When encountering throttled cfs_rq, dequeue_throttle label can ensure
> > se not to be NULL, and rq->nr_running remains unchanged, so we can also
> > skip the early balance check.
> >
> > Signed-off-by: Peng Wang <rocking@linux.alibaba.com>
> 
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

Thanks!
