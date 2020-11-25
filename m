Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81BD72C3B42
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 09:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgKYImG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 03:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbgKYImG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 03:42:06 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EABC0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 00:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2mQNkYTzaDXbGszrlrz+vB6AFeJAIaY5IHubbH0fmzY=; b=MDMUc6dlFfI4lqfN5gY0Bfdra3
        JUU3gYqKBvwyf8fLPbKBLQOg6dKRQiOB90Xezx7I43oTEXM4r/rqk/kXPGj6+WyfshIuxo9hw44I+
        nHqmIxnl36d/S9FDbOYaJuXbeTHsYe6OCD6/LGi141dMDnAWt83yRZzlqYmJKTnXwMSG4f52h+gtA
        OjqQOQyZMhugI4ZpCcHfKtnkvdkInXAZEt0NHMj6bCLoOjBWvpFPvvMt4mtufxBW6vPYaMkqmDgIW
        pDuA9T2qClamWQ/JaImIbVyv4qMPyCkqHEEJ/s7PrPekDjWHUL6BC9iPASUN0EKjos2Jcd1ob2DgN
        LXvUboqw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khqMV-0006Lg-9H; Wed, 25 Nov 2020 08:41:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3710D30280E;
        Wed, 25 Nov 2020 09:41:12 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1939C20097204; Wed, 25 Nov 2020 09:41:12 +0100 (CET)
Date:   Wed, 25 Nov 2020 09:41:12 +0100
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
        chris.hyser@oracle.com, Ben Segall <bsegall@google.com>,
        Josh Don <joshdon@google.com>, Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
Subject: Re: [PATCH -tip 15/32] sched: Improve snapshotting of min_vruntime
 for CGroups
Message-ID: <20201125084112.GN2414@hirez.programming.kicks-ass.net>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
 <20201117232003.3580179-16-joel@joelfernandes.org>
 <20201124102741.GW3021@hirez.programming.kicks-ass.net>
 <20201124170744.GD1021337@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124170744.GD1021337@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 12:07:44PM -0500, Joel Fernandes wrote:

> Either way would be Ok with me, I would suggest retaining the history though
> so that the details in the changelog are preserved of the issues we faced,
> and in the future we can refer back to them.

Well, in part that's what we have mail archives for. My main concern is
that there's a lot of back and forth in the patches as presented and
that makes review really awkward.

I've done some of the patch munging proposed, I might do more if I find
the motivation.

But first I should probably go read all that API crud you did on top,
I've not read that before...
