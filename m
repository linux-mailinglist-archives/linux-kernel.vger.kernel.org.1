Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5A1302D27
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 22:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732366AbhAYVBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 16:01:52 -0500
Received: from foss.arm.com ([217.140.110.172]:58644 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732117AbhAYTrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 14:47:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 03AF731B;
        Mon, 25 Jan 2021 11:46:06 -0800 (PST)
Received: from e107158-lin (unknown [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 000763F66E;
        Mon, 25 Jan 2021 11:46:04 -0800 (PST)
Date:   Mon, 25 Jan 2021 19:46:02 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] printk: Add new pr_*_deferred_once() variants
Message-ID: <20210125194602.4ayir2tmlllmrnk4@e107158-lin>
References: <20210123233741.3614408-1-qais.yousef@arm.com>
 <20210123233741.3614408-2-qais.yousef@arm.com>
 <YA6fTuFEaCjFQB3h@hirez.programming.kicks-ass.net>
 <87y2gh2shy.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y2gh2shy.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/25/21 12:04, John Ogness wrote:
> On 2021-01-25, Peter Zijlstra <peterz@infradead.org> wrote:
> > On Sat, Jan 23, 2021 at 11:37:40PM +0000, Qais Yousef wrote:
> >> To allow users in code where printk is not allowed.
> >> 
> >> Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> >> ---
> >>  include/linux/printk.h | 24 ++++++++++++++++++++++++
> >>  1 file changed, 24 insertions(+)
> >> 
> >> diff --git a/include/linux/printk.h b/include/linux/printk.h
> >> index fe7eb2351610..92c0978c7b44 100644
> >> --- a/include/linux/printk.h
> >> +++ b/include/linux/printk.h
> >> @@ -480,21 +480,45 @@ extern int kptr_restrict;
> >>  	printk_once(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
> >>  /* no pr_cont_once, don't do that... */
> >>  
> >> +#define pr_emerg_deferred_once(fmt, ...)				\
> >> +	printk_deferred_once(KERN_EMERG pr_fmt(fmt), ##__VA_ARGS__)
> >> +#define pr_alert_deferred_once(fmt, ...)				\
> >> +	printk_deferred_once(KERN_ALERT pr_fmt(fmt), ##__VA_ARGS__)
> >> +#define pr_crit_deferred_once(fmt, ...)					\
> >> +	printk_deferred_once(KERN_CRIT pr_fmt(fmt), ##__VA_ARGS__)
> >> +#define pr_err_deferred_once(fmt, ...)					\
> >> +	printk_deferred_once(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
> >> +#define pr_warn_deferred_once(fmt, ...)					\
> >> +	printk_deferred_once(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
> >> +#define pr_notice_deferred_once(fmt, ...)				\
> >> +	printk_deferred_once(KERN_NOTICE pr_fmt(fmt), ##__VA_ARGS__)
> >> +#define pr_info_deferred_once(fmt, ...)					\
> >> +	printk_deferred_once(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
> >> +/* no pr_cont_deferred_once, don't do that... */
> >
> > I absolutely detest this.. the whole _deferred thing is an
> > abomination.
> 
> And it will disappear at some point.
> 
> > We should be very close to printk not needing this anymore, printk
> > people?
> 
> It will disappear once console printing threads are introduced. We
> probably still have a few kernel releases until we see that. First we
> need to finish merging full lockless access, remove the safe buffers,
> and merge the atomic consoles.

Okay. As I said in the cover letter, I didn't think the addition of these new
macros looked like a win overall.

I will drop this patch and just open code the use of printk_deferred_once() in
hrtimer_interrupt(). Which should be easier to fix later when it should
disappear.

Thanks

--
Qais Yousef
