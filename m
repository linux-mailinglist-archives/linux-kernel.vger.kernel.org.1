Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 909412701FD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 18:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgIRQUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 12:20:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:60580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbgIRQUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 12:20:11 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 510C420795;
        Fri, 18 Sep 2020 16:20:10 +0000 (UTC)
Date:   Fri, 18 Sep 2020 12:20:08 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     mingo@redhat.com, peterz@infradead.org, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org
Subject: Re: [PATCH] ftrace: Free the trampoline when ftrace_startup() fails
Message-ID: <20200918122008.7b21f77e@gandalf.local.home>
In-Reply-To: <alpine.LSU.2.21.2008311455440.16475@pobox.suse.cz>
References: <20200831122631.28057-1-mbenes@suse.cz>
        <alpine.LSU.2.21.2008311455440.16475@pobox.suse.cz>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Aug 2020 14:56:57 +0200 (CEST)
Miroslav Benes <mbenes@suse.cz> wrote:

> I used Masami's address which did not work. Sorry about that. Should be ok 
> now.

Thanks Miroslav,

I've queued this up to be tested and pushed as urgent.

-- Steve

> 
> On Mon, 31 Aug 2020, Miroslav Benes wrote:
> 
> > Commit fc0ea795f53c ("ftrace: Add symbols for ftrace trampolines")
> > missed to remove ops from new ftrace_ops_trampoline_list in
> > ftrace_startup() if ftrace_hash_ipmodify_enable() fails there. It may
> > lead to BUG if such ops come from a module which may be removed.
> > 
> > Moreover, the trampoline itself is not freed in this case.
> > 
> > Fix it by calling ftrace_trampoline_free() during the rollback.
> > 
> > Fixes: fc0ea795f53c ("ftrace: Add symbols for ftrace trampolines")
> > Signed-off-by: Miroslav Benes <mbenes@suse.cz>
> > ---
> >
