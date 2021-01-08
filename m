Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1BB72EF85D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 20:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbhAHTq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 14:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728759AbhAHTq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 14:46:59 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B35C061380
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 11:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oOtQDu7w1ab6cweuFIDLs0jH0PgEz7DuChoBHnBqhjY=; b=ezABTJEo25pEyy8exv16P+jYeK
        0xmgd65tq60rvsCkakyn2p3IaNG59Pb538U82McIBLZcyv1Kc9HHzM7cZqC7WP0jO/VxmbcgZgjXo
        ti/DTFIGGnvAVX1s6xnwnhCoiVKfXQ8U3HPu2gIOnfhQc5OYOnrwakzq6EoBTf/3cFW62soScWLnF
        /wPK56qVnW6SaOifD1t3ZREPk9vS2jIaxBbsICZoaCPELzVEr6Yz0gI/XTDBSLKfWKEF3P7Nk3IWE
        cEITXV6zeZdKYGet+qazKExGu4qt280U1e5ell3trROosKqnaYQ/Bf6FknWQswydbNNMlaa5BVLlC
        DeUVgw3w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kxxhn-0007O1-K1; Fri, 08 Jan 2021 19:45:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 10E8D3003D8;
        Fri,  8 Jan 2021 20:45:45 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F2E0220167A86; Fri,  8 Jan 2021 20:45:44 +0100 (CET)
Date:   Fri, 8 Jan 2021 20:45:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Jiang Biao <benbjiang@gmail.com>
Subject: Re: [RFC][PATCH 1/5] sched/fair: Fix select_idle_cpu()s cost
 accounting
Message-ID: <X/i2aIKmeyi5SZ7g@hirez.programming.kicks-ass.net>
References: <20201214164822.402812729@infradead.org>
 <20201214170017.877557652@infradead.org>
 <c4e31235-e1fb-52ac-99a8-ae943ee0de54@linux.intel.com>
 <20201215075911.GA3040@hirez.programming.kicks-ass.net>
 <20210108102738.GB3592@techsingularity.net>
 <CAKfTPtD5R1S=rwp9C-jyMg8bAB-37FCe3qrqad9KEeyR7mOmkw@mail.gmail.com>
 <20210108144058.GD3592@techsingularity.net>
 <CAKfTPtCGCmCv0yXSUmYUh6=8uzd0n9xFPqC0cW4sm-FqDvjvCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtCGCmCv0yXSUmYUh6=8uzd0n9xFPqC0cW4sm-FqDvjvCQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 04:10:51PM +0100, Vincent Guittot wrote:
> Also, there is another problem (that I'm investigating)  which is that
> this_rq()->avg_idle is stalled when your cpu is busy. Which means that
> this avg_idle can just be a very old and meaningless value. I think
> that we should decay it periodically to reflect there is less and less

https://lkml.kernel.org/r/20180530143105.977759909@infradead.org

:-)
