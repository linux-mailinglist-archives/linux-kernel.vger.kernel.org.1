Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E97C25A93A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 12:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgIBKQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 06:16:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:33886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbgIBKQq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 06:16:46 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C22C52078B;
        Wed,  2 Sep 2020 10:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599041805;
        bh=EhtEUf6VrbLDSVNq2Lbp3zU+GZQxmG87FZJnuOOkZ8I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qZGXIK4ttco2BWFw+JfijRtDK3MlqMq/QaU08Rlq86j25BsEfpjpqNCQiZbgr6r2R
         jFT1DT4VAzQMixIacAh3XaZBsz4fA7mn3yH3XBqs8i+NXFQMv67PJJhqVQnNkRo7tM
         pUzqoIy2gr83CCoDMO41CfdQP9jYb5zVlU8jq/vQ=
Date:   Wed, 2 Sep 2020 19:16:37 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     peterz@infradead.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com,
        pbonzini@redhat.com, mathieu.desnoyers@efficios.com,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH v7 08/18] static_call: Avoid kprobes on inline
 static_call()s
Message-Id: <20200902191637.72307d7ec6d493a6c0678346@kernel.org>
In-Reply-To: <20200902094820.GA1362448@hirez.programming.kicks-ass.net>
References: <20200818135735.948368560@infradead.org>
        <20200818135804.744920586@infradead.org>
        <20200902103508.2872d92709fc8de7c6bffe08@kernel.org>
        <20200902094820.GA1362448@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Sep 2020 11:48:20 +0200
peterz@infradead.org wrote:

> On Wed, Sep 02, 2020 at 10:35:08AM +0900, Masami Hiramatsu wrote:
> > On Tue, 18 Aug 2020 15:57:43 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > Similar to how we disallow kprobes on any other dynamic text
> > > (ftrace/jump_label) also disallow kprobes on inline static_call()s.
> > 
> > Looks good to me. 
> > 
> > Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> > 
> > BTW, here we already have 5 subsystems which reserves texts
> > (ftrace, alternatives, jump_label, static_call and kprobes.)
> > 
> > Except for the kprobes and ftrace, we can generalize the reserved-text
> > code because those are section-based static address-areas (or lists).
> 
> Doesn't ftrace also have a section where it lists all the mcount
> locations?

Is the data format in the section same as others?

> 
> On top of that ftrace probably registers its trampolines.

Good point. I think trampolines are filtered by kernel_text() check.

> 
> Do we support adding kprobes to BPF-JIT'ed code or should we blacklist
> them too?

No, we should blacklist it, because JIT'ed code will be used in
kprobes context. In that case, I think it is better to provide
partially execute non-JIT code and interrupt the interpreter. 

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
