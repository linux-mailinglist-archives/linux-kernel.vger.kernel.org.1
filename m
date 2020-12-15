Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90CDF2DA8D8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 09:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbgLOIAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 03:00:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgLOIAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 03:00:08 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28260C06179C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 23:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vlmMgAa2QEYiSS7lGJm7ACi0lKBxrujPFHmQpD6je1M=; b=bot1FTLv7CI6g/SdHWmN4+UEiU
        4lA4xmxntvsiGdFRqt+lbUB6lK19Go/UrZCG61eNIzVrK88yr9K4sq8jOVhHs2p8Qvq1ZEpo/pQRp
        NwgLCrBsD7zPm83HQyDIYRIQwjFaBVeKc78bjPiYwmxkh9i4WKefR7awvhtOrGOu39WfyzHdO7dJW
        UUjZHsngiBhs3VIlu/caxkbdHn9XdJUtVB6pjjC5snihpIGJPcWIo86X4phMHenSUTSBn37T66Ta3
        L2tfqcg2fcSqMHszcHK7klkh18YbjjpUd1hw/74nEs9NNBqsfWcZEHuvNRkabIZfaf+UF9CXQbjUd
        2hqNJ2cQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kp5Eo-0006sr-21; Tue, 15 Dec 2020 07:59:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 93C18302753;
        Tue, 15 Dec 2020 08:59:11 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 77BEE20D21018; Tue, 15 Dec 2020 08:59:11 +0100 (CET)
Date:   Tue, 15 Dec 2020 08:59:11 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc:     mgorman@techsingularity.net, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, valentin.schneider@arm.com,
        qais.yousef@arm.com, dietmar.eggemann@arm.com, rostedt@goodmis.org,
        bsegall@google.com, tim.c.chen@linux.intel.com, benbjiang@gmail.com
Subject: Re: [RFC][PATCH 1/5] sched/fair: Fix select_idle_cpu()s cost
 accounting
Message-ID: <20201215075911.GA3040@hirez.programming.kicks-ass.net>
References: <20201214164822.402812729@infradead.org>
 <20201214170017.877557652@infradead.org>
 <c4e31235-e1fb-52ac-99a8-ae943ee0de54@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4e31235-e1fb-52ac-99a8-ae943ee0de54@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 11:36:35AM +0800, Li, Aubrey wrote:
> On 2020/12/15 0:48, Peter Zijlstra wrote:
> > We compute the average cost of the total scan, but then use it as a
> > per-cpu scan cost when computing the scan proportion. Fix this by
> > properly computing a per-cpu scan cost.
> > 
> > This also fixes a bug where we would terminate early (!--nr, case) and
> > not account that cost at all.
> 
> I'm a bit worried this may introduce a regression under heavy load.
> The overhead of adding another cpu_clock() and calculation becomes 
> significant when sis_scan is throttled by nr.

The thing is, the code as it exists today makes no sense what so ever.
It's plain broken batshit.

We calculate the total scanning time (irrespective of how many CPUs we
touched), and then use that calculate the number of cpus to scan. That's
just daft.

After this patch we calculate the avg cost of scanning 1 cpu and use
that to calculate how many cpus to scan. Which is coherent and sane.

Maybe it can be improved, but that's a completely different thing.
