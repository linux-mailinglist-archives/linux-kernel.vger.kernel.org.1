Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C51C2C6935
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 17:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731381AbgK0QN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 11:13:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:39666 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726889AbgK0QNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 11:13:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606493633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zNyePPr8eaM8q6N1hI8z6fuqCl9mrbj+/oSQS+LcGdc=;
        b=qxot8es63erorEWepO3xkbh/OnZQsbV5DAmD478L74PIdOK5TOvWXbwgE27UHuuu1YTiFt
        H+YZqvkVTWnZQTFR4dH1OdqCFzhgH3adySpeBkklnUAr+AzBm2QnUq19Mc5rsZmd2556ld
        kaMBZRwNX8C9Zjls+1LinOQxg7Tsa84=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B387FAC2D;
        Fri, 27 Nov 2020 16:13:53 +0000 (UTC)
Date:   Fri, 27 Nov 2020 17:13:52 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH 0/3] clear_warn_once: add timed interval resetting
Message-ID: <X8ElwBh9tw+OLHF+@alley>
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

What is the primary problem that you wanted to solve, please?

Do you have an example what particular printk_once() you were
interested into?

I guess that the main problem is that
/sys/kernel/debug/clear_warn_once is available only when debugfs is
mounted. And the periodic reset is just one possible solution
that looks like a nice to have. Do I get it correctly, please?

I am not completely against the idea. But I have some concerns.

1. It allows to convert printk_once() into printk_ratelimited()
   with some special semantic and interface. It opens possibilities
   for creativity. It might be good and it also might create
   problems that are hard to foresight now.

   printk_ratelimited() is problematic, definitely, see below.


2. printk_ratelimited() is typically used when a message might get
   printed too often. It prevents overloading consoles, log daemons.
   Also it helps to see other messages that might get lost otherwise.

   I have seen many discussions about what is the right ratelimit
   for a particular message. I have to admit that it was mainly
   related to console speed. The messages were lost with slow
   consoles. People want to see more on fast consoles.

   The periodic warn once should not have this problem because the
   period would typically be long. And it would produce only
   one message on each location.

   The problem is that it is a global setting. It would reset
   all printk_once() callers. And I see two problems here:

       + Periodic reset might cause printing related problems
	 in the wrong order. Messages from victims first. Messages
	 about the root of the problem later (from next cycle).
	 It might create confusion.

       + People have problems to set the right ratelimit for
	 a particular message. It would be even bigger problem
	 to set the right ratelimit for the entire system.


I do not know. Maybe I am just too paranoid today. Anyway, there
are other possibilities:

+ Move clear_warn_once from debugfs to a location that is always
  available. For example, into /proc

+ Allow to change printk_once() to printk_n_times() globally. I mean
  that it would print the same message only N-times instead on once.
  It will print only first few occurrences, so it will not have
  the problem with ordering.

Any other opinion?

Best Regards,
Petr
