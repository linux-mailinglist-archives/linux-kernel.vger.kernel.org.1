Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50E1829884F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 09:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1771745AbgJZI3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 04:29:40 -0400
Received: from casper.infradead.org ([90.155.50.34]:33830 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1771738AbgJZI3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 04:29:40 -0400
X-Greylist: delayed 1110 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Oct 2020 04:29:40 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UsL8E9iVmc/lWtGbrYDIulGBi0tVH0FebsF/SBaFmTY=; b=j2qonDVpg4fqmF4j6JkHRuPokA
        t1PaGw7qhx0Y1Rw3gWxuJ4ZMR8UkUdml5lF0FeddsG91CoiHOGrGTlMNNsm01vYibkEouYd+Vya3J
        ejG4ekbtyZKbHmF2MrpmXZc1yHc6XALWfuWG7nZ7Bl0ut+MRfqMhr5+y9T0MthyUrLk6HQVVCQJT5
        WufGOv2K9vdr7Gpp6IE+LyunM/Z0vUezlUzl9us2fFEJoq0XQE9A3RH23CQphsyHQVKUlgNSn69rv
        rBYLLNXugcM1TwEnXbx+SrzR8KiBBayc8caU9dSkIx5/NntjijrFpwzZ0uSgJekV6Ygs7VFRZHy3L
        kZvyjbuw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kWxrX-0005A7-94; Mon, 26 Oct 2020 08:28:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7DD68301179;
        Mon, 26 Oct 2020 09:28:14 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5D2BA20325EC8; Mon, 26 Oct 2020 09:28:14 +0100 (CET)
Date:   Mon, 26 Oct 2020 09:28:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joel Fernandes <joel@joelfernandes.org>
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
        Aaron Lu <aaron.lu@linux.alibaba.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
Subject: Re: [PATCH v8 -tip 06/26] sched: Add core wide task selection and
 scheduling.
Message-ID: <20201026082814.GD2628@hirez.programming.kicks-ass.net>
References: <20201020014336.2076526-1-joel@joelfernandes.org>
 <20201020014336.2076526-7-joel@joelfernandes.org>
 <20201023135129.GS2611@hirez.programming.kicks-ass.net>
 <20201023135400.GA2651@hirez.programming.kicks-ass.net>
 <20201023175724.GA3563800@google.com>
 <20201023192654.GH2974@worktop.programming.kicks-ass.net>
 <20201023213118.GD3563800@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201023213118.GD3563800@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 05:31:18PM -0400, Joel Fernandes wrote:
> BTW, as further optimization in the future, isn't it better for the
> schedule() loop on 1 HT to select for all HT *even if* need_sync == false to
> begin with?  i.e. no cookied tasks are runnable.
> 
> That way the pick loop in schedule() running on other HTs can directly pick
> what was pre-selected for it via:
>         if (rq->core->core_pick_seq == rq->core->core_task_seq &&
>             rq->core->core_pick_seq != rq->core_sched_seq &&
>             rq->core_pick)
> .. which I think is more efficient. Its just a thought and may not be worth doing.

I'm not sure that works. Imagine a sibling doing a wakeup (or sleep)
just after you done your core wide pick. Then it will have to repick and
you end up with having to do 2*nr_smt picks instead of 2 picks.


