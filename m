Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 960A528751E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 15:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730198AbgJHNPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 09:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgJHNPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 09:15:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B4AC061755;
        Thu,  8 Oct 2020 06:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JaQ+T90WKEsmTDN0IcV43yKJVPBOn1vkBHwJ2Y5Wb1o=; b=pKPbIDTDlUfvitahW5Nw+P5yuI
        nvNJGFIhol1qjRFQK/06ohMB6l7wf7S51vxszWhnedWVhYPN7FL//f7cBq4vU466aAZ255IHmjq3w
        2aVgTyjAFE+AzazuilSHJwHQitz8XKZw4z7Ob+ip93by2hHgQC98EqbBfzG9ANIeyoH0JXIjWcii4
        T9+Yn1NSF5jjrfcvibN/NwAMYbWSC0qSdJEjaSucImRoe20chjzmroyNP5or7ocgMcX6GSR8qeGAn
        EV24uMlgdzQIRoK4M8DHC3XAKbWY7rz9NAn3/ZtjDZcJ4ARwtBi+nc8/f5SVSx7GThoSU+niFBwWL
        rOBIzNcQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQVlR-0008UV-Cb; Thu, 08 Oct 2020 13:15:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3AA7B303A02;
        Thu,  8 Oct 2020 15:15:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2227F2B7801AD; Thu,  8 Oct 2020 15:15:20 +0200 (CEST)
Date:   Thu, 8 Oct 2020 15:15:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kajoljain <kjain@linux.ibm.com>
Cc:     acme@kernel.org, jolsa@redhat.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        daniel@iogearbox.net, brho@google.com, srikar@linux.vnet.ibm.com
Subject: Re: [PATCH] perf/core: Fix hung issue on perf stat command during
 cpu hotplug
Message-ID: <20201008131520.GY2628@hirez.programming.kicks-ass.net>
References: <20200827064732.20860-1-kjain@linux.ibm.com>
 <931cf8fd-79e9-3cbd-0943-63abea31ee8d@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <931cf8fd-79e9-3cbd-0943-63abea31ee8d@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 05:55:35PM +0530, kajoljain wrote:
> 
> 
> On 8/27/20 12:17 PM, Kajol Jain wrote:
> > Commit 2ed6edd33a21 ("perf: Add cond_resched() to task_function_call()")
> > added assignment of ret value as -EAGAIN in case function
> > call to 'smp_call_function_single' fails.
> > For non-zero ret value, it did
> > 'ret = !ret ? data.ret : -EAGAIN;', which always
> > assign -EAGAIN to ret and make second if condition useless.
> > 
> > In scenarios like when executing a perf stat with --per-thread option, and
> > if any of the monitoring cpu goes offline, the 'smp_call_function_single'
> > function could return -ENXIO, and with the above check,
> > task_function_call hung and increases CPU
> > usage (because of repeated 'smp_call_function_single()')
> > 
> > Recration scenario:
> > 	# perf stat -a --per-thread && (offline a CPU )
> > 
> > Patch here removes the tertiary condition added as part of that
> > commit and added a check for NULL and -EAGAIN.
> 
> Hi Peter,
>      Please let me know if you have any comment on this patch.

Yes, sorry. I've got it now. Thanks!

---
Subject: perf: Fix task_function_call() error handling
From: Kajol Jain <kjain@linux.ibm.com>
Date: Thu, 27 Aug 2020 12:17:32 +0530

From: Kajol Jain <kjain@linux.ibm.com>

The error handling introduced by commit:

  2ed6edd33a21 ("perf: Add cond_resched() to task_function_call()")

looses any return value from smp_call_function_single() that is not
{0, -EINVAL}. This is a problem because it will return -EXNIO when the
target CPU is offline. Worse, in that case it'll turn into an infinite
loop.

Fixes: 2ed6edd33a21 ("perf: Add cond_resched() to task_function_call()")
Reported-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Barret Rhoden <brho@google.com>
Tested-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Link: https://lkml.kernel.org/r/20200827064732.20860-1-kjain@linux.ibm.com
---
 kernel/events/core.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -99,7 +99,7 @@ static void remote_function(void *data)
  * retry due to any failures in smp_call_function_single(), such as if the
  * task_cpu() goes offline concurrently.
  *
- * returns @func return value or -ESRCH when the process isn't running
+ * returns @func return value or -ESRCH or -ENXIO when the process isn't running
  */
 static int
 task_function_call(struct task_struct *p, remote_function_f func, void *info)
@@ -115,7 +115,8 @@ task_function_call(struct task_struct *p
 	for (;;) {
 		ret = smp_call_function_single(task_cpu(p), remote_function,
 					       &data, 1);
-		ret = !ret ? data.ret : -EAGAIN;
+		if (!ret)
+			ret = data.ret;
 
 		if (ret != -EAGAIN)
 			break;
