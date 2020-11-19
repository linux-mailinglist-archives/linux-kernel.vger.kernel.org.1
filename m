Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94FCC2B9418
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 15:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbgKSOIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 09:08:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:44266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbgKSOIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 09:08:02 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70A032220B;
        Thu, 19 Nov 2020 14:08:00 +0000 (UTC)
Date:   Thu, 19 Nov 2020 09:07:58 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH 1/3 v7] ftrace: Have the callbacks receive a struct
 ftrace_regs instead of pt_regs
Message-ID: <20201119090758.02e0bafa@gandalf.local.home>
In-Reply-To: <X7ZRiPw136nZE3JL@alley>
References: <20201113171811.288150055@goodmis.org>
        <20201113171939.162178036@goodmis.org>
        <X7ZRiPw136nZE3JL@alley>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Nov 2020 12:05:44 +0100
Petr Mladek <pmladek@suse.com> wrote:

> >  void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
> > -			   struct ftrace_ops *ops, struct pt_regs *regs)
> > +			   struct ftrace_ops *ops, struct ftrace_regs *fregs)
> >  {
> >  	int bit;
> >  	bool lr_saver = false;
> >  	struct kprobe *p;
> >  	struct kprobe_ctlblk *kcb;
> > +	struct pt_regs *regs;
> >  
> >  	bit = ftrace_test_recursion_trylock(ip, parent_ip);
> >  	if (bit < 0)
> >  		return;
> >  
> > +	regs = ftrace_get_regs(fregs);  
> 
> Should we check for NULL here?
> Same in all callers?

If regs is NULL that's a major bug.

It's no different than what we have today. If you set FL_SAVE_REGS, then
the regs parameter will have regs. If you don't, it will be NULL. We don't
check regs for NULL today, so we shouldn't need to check regs for NULL with
this.

One of my bootup tests checks if this works. I work hard to make sure that
regs is set for everything that wants it, otherwise bad things happen.

In other words, the functionality in this regard hasn't changed with this
patch.

-- Steve


> 
> >  	preempt_disable_notrace();
> >  	p = get_kprobe((kprobe_opcode_t *)ip);
> >  	if (!p) {  
> 
> Otherwise, the patch is pretty strightforard and looks good to me.

