Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB448298C8C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 13:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1774613AbgJZMAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 08:00:37 -0400
Received: from casper.infradead.org ([90.155.50.34]:38410 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1769221AbgJZMAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 08:00:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=u20lWUbRrbd3iYR1FUzEq+iuwdVgwCFfuhJCV3CaHs4=; b=XcPe+CfBjxe2ido98eQLKGmr14
        TFZPSUhBEo0tsRr55rjM5ePFo8VJsu3VGcLhE+9f25OacBF67rq9cT8dtuUrgdWtHBE8xSw6Bcbfh
        yg4Yhkoe5OezvY6jmQOh/paX5v6PbuKiZTeoeqOtL6fH8iIFmzO743EHjg7B90YCDDthmbgpdO5QT
        BsX9E19dS8iotkA//7O54dBw8rkNcMl5WkpMKQjCOiCCVd9wqWpdzdR4d78dt/PHubflxxK13gTPu
        MNV1qy8BGTqOGBY925aSetvKA2PPVNuNVfFhP0/MViJyEj+qLII2v9yNXMYnEt2SRFA9FsyFK9+7E
        2pFqTpRg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kX19u-0001O8-A8; Mon, 26 Oct 2020 11:59:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BA2EA305815;
        Mon, 26 Oct 2020 12:59:27 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 997F3214ECD42; Mon, 26 Oct 2020 12:59:27 +0100 (CET)
Date:   Mon, 26 Oct 2020 12:59:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        torvalds@linux-foundation.org, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        pjt@google.com, rostedt@goodmis.org, derkling@google.com,
        benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>, jsbarnes@google.com,
        chris.hyser@oracle.com,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
Subject: Re: [PATCH v8 -tip 03/26] sched: Core-wide rq->lock
Message-ID: <20201026115927.GH2628@hirez.programming.kicks-ass.net>
References: <20201020014336.2076526-1-joel@joelfernandes.org>
 <20201020014336.2076526-4-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020014336.2076526-4-joel@joelfernandes.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 09:43:13PM -0400, Joel Fernandes (Google) wrote:
> +	if (!core_rq) {
> +		for_each_cpu(i, smt_mask) {
> +			rq = cpu_rq(i);
> +			if (rq->core && rq->core == rq)
> +				core_rq = rq;
> +			init_sched_core_irq_work(rq);

That function doesn't exist quite yet.

> +		}
