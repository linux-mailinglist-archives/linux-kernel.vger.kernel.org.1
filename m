Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B47202A0035
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 09:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgJ3ImU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 04:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgJ3ImU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 04:42:20 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CA1C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 01:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mK1sKeQRc51Ss+CdNz/7onPx5BwriPwjLZ9pRTEesu0=; b=2V6UYgLBWG3/PqKfitYx5/qc/p
        PamQxEOIq1AGoq8oXkYPRWYUw2rezgQT83YfdLrwI9hUPi3EK3CX+q/4KF7QC6AzQpOjarjf7pQsK
        YkzmO5Aat2U8JdhJ95VjbydruuaRRrElnL3wWacOXce3ObJuoBJ89V6ANj51zMx6Cxhsjcbc5g81N
        JX90N/P3WN0fWwFIVo6hUQ+s+KiQXj2Ofb0V1l9BILwSMK7Cnm7pP5cL3rdZ3+2LNovFNX35U5+5E
        Ms08WVMInt0xh4J3+fQ8pPVo5sgbhYoT2kFA/NNFWDHXlwmgD6tygu2CrRFmLzsSXHGwi+/2LHBwZ
        iprh8QXQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYPyK-0007L0-S2; Fri, 30 Oct 2020 08:41:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 266C93012C3;
        Fri, 30 Oct 2020 09:41:13 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EDF4820DCC48D; Fri, 30 Oct 2020 09:41:12 +0100 (CET)
Date:   Fri, 30 Oct 2020 09:41:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Thomas Glexiner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com,
        Dario Faggioli <dfaggioli@suse.com>,
        Paul Turner <pjt@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Patrick Bellasi <derkling@google.com>,
        =?utf-8?B?YmVuYmppYW5nKOiSi+W9qik=?= <benbjiang@tencent.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Tim Chen <tim.c.chen@intel.com>
Subject: Re: [PATCH v8 -tip 08/26] sched/fair: Snapshot the min_vruntime of
 CPUs on force idle
Message-ID: <20201030084112.GX2628@hirez.programming.kicks-ass.net>
References: <20201020014336.2076526-1-joel@joelfernandes.org>
 <20201020014336.2076526-9-joel@joelfernandes.org>
 <20201026124724.GT2611@hirez.programming.kicks-ass.net>
 <20201029182429.GA1844482@google.com>
 <20201029185933.GG2611@hirez.programming.kicks-ass.net>
 <CAEXW_YRtrhhL4Gc8W8_-2CR1CCw6_hhtnwSdQ-dMLYCJ+fP+RA@mail.gmail.com>
 <CAEXW_YTnJWANAZNeR9b=5xUeHu1CAPq9vgYaH8WSHgApJZ21Rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YTnJWANAZNeR9b=5xUeHu1CAPq9vgYaH8WSHgApJZ21Rw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 10:42:29PM -0400, Joel Fernandes wrote:

> Forgot to ask, do you also need to do the task_vruntime_update() for
> the unconstrained pick?

Humm.. interesting case.

Yes, however... since in that case the picks aren't synchronized it's a
wee bit dodgy. I'll throw it on the pile together with SMT4.


Also, I'm still hoping you can make this form work:

  https://lkml.kernel.org/r/20201026093131.GF2628@hirez.programming.kicks-ass.net

(note that the put_prev_task() needs an additional rq argument)

That's both simpler code and faster.
