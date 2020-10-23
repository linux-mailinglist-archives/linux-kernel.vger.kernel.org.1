Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8261D2971F0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 17:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S465571AbgJWPHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 11:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S465564AbgJWPHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 11:07:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9367C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 08:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3j1wdMU3iWUzcnIirPeVJ1o9wQMVAaCuFP8KGikRUI0=; b=ieVavwerONVKNmvQX5oI6DkDTM
        xYe7zBeHmxdM+6wrbRurYQvNGQWZo/kpijA2qehJEvfz/d4lvgZ1KDgMl0BA2+JB02ikmH9YWTvdG
        F9Euv40tJJLBnNumSVN8AYIT1vV/MKP2tS9VYiUdZpuOZr/VfhY3cg7nBnMTahqviuJa1S3ePwM4W
        wa8L31fLNzlgxiBuJWGrJLeNPVyx9Dzymz0bvpQEMEJNAUQmMOkJMdaurwW/ASsF7ObaAxwldiCRS
        JyuGUXxhUd4r6SjRkHgKHAda9oX98Z6r6akBbgVCPRpX01+yIjGARQu+xj5zUEgFct/0BupmHumo/
        SQxtRAuQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVydV-0003m3-Jh; Fri, 23 Oct 2020 15:05:45 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5CA9B98104F; Fri, 23 Oct 2020 17:05:44 +0200 (CEST)
Date:   Fri, 23 Oct 2020 17:05:44 +0200
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
        Aaron Lu <aaron.lu@linux.alibaba.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
Subject: Re: [PATCH v8 -tip 06/26] sched: Add core wide task selection and
 scheduling.
Message-ID: <20201023150544.GG2974@worktop.programming.kicks-ass.net>
References: <20201020014336.2076526-1-joel@joelfernandes.org>
 <20201020014336.2076526-7-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020014336.2076526-7-joel@joelfernandes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 09:43:16PM -0400, Joel Fernandes (Google) wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> Instead of only selecting a local task, select a task for all SMT
> siblings for every reschedule on the core (irrespective which logical
> CPU does the reschedule).

This:

> 
> During a CPU hotplug event, schedule would be called with the hotplugged
> CPU not in the cpumask. So use for_each_cpu(_wrap)_or to include the
> current cpu in the task pick loop.
> 
> There are multiple loops in pick_next_task that iterate over CPUs in
> smt_mask. During a hotplug event, sibling could be removed from the
> smt_mask while pick_next_task is running. So we cannot trust the mask
> across the different loops. This can confuse the logic. Add a retry logic
> if smt_mask changes between the loops.

isn't entirely accurate anymore, is it?
