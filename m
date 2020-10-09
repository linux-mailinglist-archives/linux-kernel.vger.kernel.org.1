Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34F86288692
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 12:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387502AbgJIKKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 06:10:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:38404 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726357AbgJIKKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 06:10:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1602238245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/ov0pV+JB4ZGZv2uDLjVS7nh4hz9wFdZu6KBCZbZ2Jg=;
        b=qMn8RpNtwWsMeKWX/VdFIczmkvptBUr1BbaGSBAnGBRKE7yRnxNsJwighOhNUaIh7rbrb9
        cdDudAZRtDhwUOa1slw4l82M8qNamPdcMYekFOT0H7oWdZ81zPcpFaF7D27weM0xqiIioN
        8MFan10Wx23dhbKQuwL2t0td5yzqoIo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 981D1B048;
        Fri,  9 Oct 2020 10:10:45 +0000 (UTC)
Date:   Fri, 9 Oct 2020 12:10:44 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbecker@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>
Subject: Re: [RFC PATCH] kernel: allow to configure PREEMPT_NONE,
 PREEMPT_VOLUNTARY on kernel command line
Message-ID: <20201009101044.GH4967@dhcp22.suse.cz>
References: <20201007120401.11200-1-mhocko@kernel.org>
 <20201009091218.GF4967@dhcp22.suse.cz>
 <20201009094245.GG2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009094245.GG2628@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 09-10-20 11:42:45, Peter Zijlstra wrote:
> On Fri, Oct 09, 2020 at 11:12:18AM +0200, Michal Hocko wrote:
> > Is there any additional feedback? Should I split up the patch and repost
> > for inclusion?
> 
> Maybe remove PREEMPT_NONE after that?  Since that's then equivalent to
> building with VOLUNTARY and booting with preempt=none.

So do you mean that I should post an additional patch which does this on
top? With a justification that there is one option less to chose from?

diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index bf82259cff96..103a5f9e4bcf 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -2,20 +2,7 @@
 
 choice
 	prompt "Preemption Model"
-	default PREEMPT_NONE
-
-config PREEMPT_NONE
-	bool "No Forced Preemption (Server)"
-	help
-	  This is the traditional Linux preemption model, geared towards
-	  throughput. It will still provide good latencies most of the
-	  time, but there are no guarantees and occasional longer delays
-	  are possible.
-
-	  Select this option if you are building a kernel for a server or
-	  scientific/computation system, or if you want to maximize the
-	  raw processing power of the kernel, irrespective of scheduling
-	  latencies.
+	default PREEMPT_VOLUNTARY
 
 config PREEMPT_VOLUNTARY
 	bool "Voluntary Kernel Preemption (Desktop)"

-- 
Michal Hocko
SUSE Labs
