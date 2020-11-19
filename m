Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8ACC2B9754
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 17:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbgKSQE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 11:04:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:38582 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727151AbgKSQE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 11:04:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605801864; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/3TE/0VHRs9SOe8v/y8uvMKxuFo2wQveqxMzaIV2RCk=;
        b=LOCs+VrTcR9sCo8N0NzF33sCSgaAc3jNsAZtuiF9d/apTlGH1s2jMudPEiBiZVv3Wwn9k8
        5pOgNRD2UTG599iJGUbfk3dGAP9zsI2ue3MW39gJaBo5onOP9lzcNxACH1fUDjSNkfnMIg
        VYXfnRpfNQbYHjpU4U9sdsdBdhJwlIA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6F31AAE1C;
        Thu, 19 Nov 2020 16:04:24 +0000 (UTC)
Date:   Thu, 19 Nov 2020 17:04:23 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH 1/3 v7] ftrace: Have the callbacks receive a struct
 ftrace_regs instead of pt_regs
Message-ID: <X7aXh3wivkz4tEMm@alley>
References: <20201113171811.288150055@goodmis.org>
 <20201113171939.162178036@goodmis.org>
 <X7ZRiPw136nZE3JL@alley>
 <20201119090758.02e0bafa@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119090758.02e0bafa@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-11-19 09:07:58, Steven Rostedt wrote:
> On Thu, 19 Nov 2020 12:05:44 +0100
> Petr Mladek <pmladek@suse.com> wrote:
> 
> > >  void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
> > > -			   struct ftrace_ops *ops, struct pt_regs *regs)
> > > +			   struct ftrace_ops *ops, struct ftrace_regs *fregs)
> > >  {
> > >  	int bit;
> > >  	bool lr_saver = false;
> > >  	struct kprobe *p;
> > >  	struct kprobe_ctlblk *kcb;
> > > +	struct pt_regs *regs;
> > >  
> > >  	bit = ftrace_test_recursion_trylock(ip, parent_ip);
> > >  	if (bit < 0)
> > >  		return;
> > >  
> > > +	regs = ftrace_get_regs(fregs);  
> > 
> > Should we check for NULL here?
> > Same in all callers?
> 
> If regs is NULL that's a major bug.
> 
> It's no different than what we have today. If you set FL_SAVE_REGS, then
> the regs parameter will have regs. If you don't, it will be NULL. We don't
> check regs for NULL today, so we shouldn't need to check regs for NULL with
> this.
> 
> One of my bootup tests checks if this works. I work hard to make sure that
> regs is set for everything that wants it, otherwise bad things happen.
> 
> In other words, the functionality in this regard hasn't changed with this
> patch.

Thanks for explanation. Feel free to use:

Acked-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
