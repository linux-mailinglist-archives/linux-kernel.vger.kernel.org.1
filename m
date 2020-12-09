Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF0372D46E9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 17:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731711AbgLIQhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 11:37:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:56192 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729012AbgLIQhz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 11:37:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607531828; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZVwPeZe+K1uTe80npboLjwJwLum31MbCHyq8Bs1n6Us=;
        b=jfB75bKYTmF3ZlJNb7d+m0GZ+aC6yuqOStmEeVBxJECpJnAmliYMMiJgN7Oq9aISHb/s5P
        GrZwMbJK9kns2omwSJni7LhySsNeY+gY6Rm/LZ8OKrNUo1FEdTZJ4bK5rz/qlsOhsrV9Rp
        nOGKS9ORwey6AM1agzd8F1bpBlsA1Sg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 20CD4AC9A;
        Wed,  9 Dec 2020 16:37:08 +0000 (UTC)
Date:   Wed, 9 Dec 2020 17:37:07 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH 0/3] clear_warn_once: add timed interval resetting
Message-ID: <X9D9MwJzUCuwQPNb@alley>
References: <20201126063029.2030-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126063029.2030-1-paul.gortmaker@windriver.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-11-26 01:30:26, Paul Gortmaker wrote:
> The existing clear_warn_once functionality is currently a manually
> issued state reset via the file /sys/kernel/debug/clear_warn_once when
> debugfs is mounted.  The idea being that a developer would be running
> some tests, like LTP or similar, and want to check reproducibility
> without having to reboot.
> 
> But you currently can't make use of clear_warn_once unless you've got
> debugfs enabled and mounted - which may not be desired by some people
> in some deployment situations.
> 
> The functionality added here allows for periodic resets in addition to
> the one-shot reset it already had.  Then we allow for a boot-time setting
> of the periodic resets so it can be used even when debugfs isn't mounted.
> 
> By having a periodic reset, we also open the door for having the various
> "once" functions act as long period ratelimited messages, where a sysadmin
> can pick an hour or a day reset if they are facing an issue and are
> wondering "did this just happen once, or am I only being informed once?"

OK, I though more about it and I NACK this patchset.

My reason:

1. The primary purpose was to provide a way to reset warn_once() without
   debugfs. From this POV, the solution is rather complicated: timers
   and another kernel parameter.

2. I am not aware of any convincing argument why debugfs could not be
   mounted on the debugged system.

3. Debugfs provides many more debugging facilities. It is designed for
   this purpose. It does not look like a good strategy to provide
   alternative interfaces just to avoid it.

4. There were mentioned several other use cases for this feature,
   like RT systems. But it was not clear that it was really needed
   or that people would really use it.

5. Some code might even rely on that it is called only once, see commit
   dfbf2897d00499f94cd ("bug: set warn variable before calling
   WARN()") or the recent
   https://lore.kernel.org/r/20201029142406.3c46855a@gandalf.local.home

   It should better stay as debugging feature that should be used with
   care.


6. It creates system wide ratelimited printk().

   We have printk_ratelimited() for this. And it is quite problematic.
   It is supposed to prevent flood of printk() messages. But it does
   not work well because the limits depend on more factors, like:
   system size, conditions, console speed.

   Yes, the proposed feature is supposed to solve another problem
   (lack of messages). But it is a global action that would
    re-enable >1000 messages that were limited to be printed
    only once because they could be too frequent. As a result:

	+ it might cause flood of printk() messages

	+ it is hard to define a good system wide time limit;
	  it was even unclear what should be the lower limit.

	+ it will restart the messages at some "random" point,
	  so that the relation of the reported events would
	  be unclear.

  From the API point of view:

	+ printk_ratelimited() is used when we want to see that a
	  problem is still there. It is per-message setting.

	+ printk_once() is used when even printk_ratelimited() would
	  be too much. It is per-message setting.

	+ The new printk_repeated_once() is a strange mix of this two
	  with the global setting. It does not fit much.


Best Regards,
Petr

PS: I did not answer your last mail because it looked like an endless
    fight over words or point of views. I decided to make a summary
    of my view instead. These are reason why I nacked it.

    I know that there might be different views but so far no arguments
    changed mine. And I do not know how to explain it better.
