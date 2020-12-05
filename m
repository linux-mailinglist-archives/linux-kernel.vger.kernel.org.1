Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D02DD2CF94E
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 05:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgLEE0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 23:26:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgLEE0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 23:26:04 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47864C0613D1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 20:25:24 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id l23so4354984pjg.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 20:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3aoJifxdJCMf1Dssr2/wG661csEI+TPCc82Ba7razE4=;
        b=jH5TqiP8ZvQKA6CXGnnLDpGZEIlUVXcewGIfctv2W3L1h5f7MKtPwcI07EDD+HNzXl
         iaW+bGdA37VyQudWwteqx/+MYJwMUEl4y5iQCpIsarbY/h7S2aAyN+wfhgglWPJqfw8w
         cZvDg1nDaGhArnmnP5Ct0CcRSn/iDAg0cevUvFGAa2H8wbcE2Cpbkl2LvZGFAO8KA6dE
         Vxkycw3UMghcTeUFzr7NWDoyglIPwFS4q3T3gOfZZ6ySjhbfaqXTt+neR/Kc3qSWW3MM
         YntBACkd5yhKpd9ILMj8ORiZZjW6iihjhOFBh7FMIdqzE6ag+ANSTtxilPudgz588c7q
         0q3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3aoJifxdJCMf1Dssr2/wG661csEI+TPCc82Ba7razE4=;
        b=BcD5OiX2X6qkqy+tN68VGQ+hNGRWUS/metWck86R00xO5QtJrwEl/KdP6AZ2sgKu4U
         YrW3BUrwdEnN89Hv/7D5xS+zE1CNXyukblXEEthJ5UlNLJ4CS8A8IKpZ2d1ti4tKKMMN
         8IBLvTQAouWpwp7yT7kvr5YhkndIsUoUaxemOCEioDncIAijDeBfsIxzP6Z5UnQiM3uc
         NrmaZtAnCcsLnPOEtn7FFasNNRVUf3AkaA11SeTx9EkDMUVEcQe16+ihJDSUh58oTBmL
         man5kS0soG/G9hDsO5W9dJibXA9OdUYPYcqf28P+/ZABWExI1rSnxJby4P26WpDNjRxs
         1ehQ==
X-Gm-Message-State: AOAM5332LUD/bZAOsY/ve8khdI+sXFW+Ye6E0fjPNYB24f/IdItvaX3i
        9UhZHIwAnxfoCOXN5wRgewM=
X-Google-Smtp-Source: ABdhPJx6xv6Jpjlldg6bV3JqkokktOPwrw8yXmjfcnnwlHD0qD+U+C10RLOe7OOYcicWEOxvve8xzw==
X-Received: by 2002:a17:90b:358a:: with SMTP id mm10mr7071611pjb.125.1607142323602;
        Fri, 04 Dec 2020 20:25:23 -0800 (PST)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id q23sm6548993pfg.18.2020.12.04.20.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 20:25:22 -0800 (PST)
Date:   Sat, 5 Dec 2020 13:25:19 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: recursion handling: Re: [PATCH next v2 3/3] printk: remove
 logbuf_lock, add syslog_lock
Message-ID: <X8sLr4snLX9DB3I8@jagdpanzerIV.localdomain>
References: <20201201205341.3871-1-john.ogness@linutronix.de>
 <20201201205341.3871-4-john.ogness@linutronix.de>
 <X8pfX/qPBuY360k/@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X8pfX/qPBuY360k/@alley>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/12/04 17:10), Petr Mladek wrote:
[..]
> char *get_printk_counter_by_ctx()
> {
> 	int ctx = 0;
> 
> 	if (in_nmi)
> 		ctx = 1;
> 
> 	if (!printk_percpu_data_ready())
> 		return &printk_count_early[ctx];
> 
> 	return this_cpu_ptr(printk_count[ctx]);
> }
>
> > +
> > +	return count;
> > +}
> > +
> > +static bool printk_enter(unsigned long *flags)
> > +{
> > +	char *count;
> > +
> > +	local_irq_save(*flags);
> > +	count = get_printk_count();
> > +	/* Only 1 level of recursion allowed. */
> 
> We should allow at least some level of recursion. Otherwise, we would
> not see warnings printed from vsprintf code.

One level of recursion seems reasonable on one hand, but on the other
hand I also wonder if we can get useful info from recursion levels 2
and higher. Would be great to maybe list possible scenarios. vsprintf()
still call re-enter printk() -- WARN_ONCE()-s in the code -- external
format specifiers handlers also can. Would we need to let two levels of
recursion printk->vsprintf->printk->???->printk or one is just enough?

It also would make sense to add the lost messages counter to per-CPU
recursion counter struct, to count the number of times we bailout
of printk due to recursion limit. So that we'll at least have
"%d recursive printk messages lost" hints.


Overall...
I wonder where does the "limit printk recursion" come from? printk_safe
doesn't impose any strict limits (print_context is limited, but still)
and we've been running it for years now; have we ever seen any reports
of printk recursion overflows?

> > +	if (*count > 1) {
> > +		local_irq_restore(*flags);
> > +		return false;
> > +	}
> > +	(*count)++;
> > +
> > +	return true;
> > +}
> 
> This should be unified with printk_context, printk_nmi_enter(),
> printk_nmi_exit(). It does not make sense to have two separate
> printk context counters.

Agreed.

> Or is there any plan to remove printk_safe and printk_context?

That's a good point. This patch set and printk_safe answer the
same question in different ways, as far as I understand it. The
question is "Why do we want to track printk recursion"? This patch
set merely wants to, correct me if I'm wrong, avoid the very deep
vprintk_store() recursion stacks (which is a subset of printk()
recursion superset):

	vprintk_store()
	{
		if (!printk_enter())
			return;

		vsprintf/prb
		print_exit();
	}

And that's pretty much it, at least for the time being.

printk_safe()'s answer is - we don't want to re-enter parts of
the kernel that sit in the core, behind the scenes, and that are
not ready to be re-entered. Things like

	printk()
	 down_console_sem()
	  down()
	   raw_spin_lock_irqsave(&sem->lock)
	    printk()
	     down_console_sem()
	      down()
	       raw_spin_lock_irqsave(&sem->lock)

	-ss
