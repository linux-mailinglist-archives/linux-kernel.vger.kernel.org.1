Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAEE2A0566
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 13:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgJ3Max (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 08:30:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:51780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbgJ3Mao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 08:30:44 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8836320731;
        Fri, 30 Oct 2020 12:30:42 +0000 (UTC)
Date:   Fri, 30 Oct 2020 08:30:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, nstange@suse.de
Subject: Re: [PATCH 1/9] ftrace: Move the recursion testing into global
 headers
Message-ID: <20201030083039.0c6135ad@oasis.local.home>
In-Reply-To: <alpine.LSU.2.21.2010301008160.22360@pobox.suse.cz>
References: <20201028115244.995788961@goodmis.org>
        <20201028115612.460535535@goodmis.org>
        <alpine.LSU.2.21.2010301008160.22360@pobox.suse.cz>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Oct 2020 10:13:50 +0100 (CET)
Miroslav Benes <mbenes@suse.cz> wrote:

> how does this work in case of NMI? trace_get_context_bit() returns 0 (it 
> does not change later in the patch set). "start" in 
> trace_test_and_set_recursion() is 0 zero too as used later in the patch 
> set by ftrace_test_recursion_trylock(). So trace_test_and_set_recursion() 
> returns 0. That is perfectly sane, but then...
> 
> > +static __always_inline void trace_clear_recursion(int bit)
> > +{
> > +	unsigned int val = current->trace_recursion;
> > +
> > +	if (!bit)
> > +		return;  
> 
> ... the bit is not cleared here.

Yeah, I found that and fixed it yesterday, which discovered stack
overflow in perf:

  https://lore.kernel.org/r/20201030002722.766a22df@oasis.local.home

There's another bug that causes a false positive during interrupt
context transition. I have a fix for that too.

-- Steve
