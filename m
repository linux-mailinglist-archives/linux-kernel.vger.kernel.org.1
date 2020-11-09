Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAC432AC164
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 17:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730546AbgKIQvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 11:51:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:56010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730130AbgKIQvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 11:51:54 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 122502074F;
        Mon,  9 Nov 2020 16:51:52 +0000 (UTC)
Date:   Mon, 9 Nov 2020 11:51:51 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 03/11 v3] ftrace: Optimize testing what context current
 is in
Message-ID: <20201109115151.1d841d97@oasis.local.home>
In-Reply-To: <20201109121708.GK2594@hirez.programming.kicks-ass.net>
References: <20201106023235.367190737@goodmis.org>
        <20201106023546.558881845@goodmis.org>
        <20201109121708.GK2594@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Nov 2020 13:17:08 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> This patch is misleading, it doesn't optimize it nearly as much as is
> possible and actually fixes the softirq case, which isn't at all
> mentioned.

This is actually an old patch I had for some time (it's been in the
ring buffer code for a while). I honestly didn't even realize that it
fixed softirq, which is why it isn't mentioned ;-)

I only said "optimize" I didn't say "optimal", thus it can be improved
more. When I first wrote this, I saw non noise improvements with it, so
it does indeed optimize it.

> 
> Let me go do that other patch.

I'll keep this patch, and replace the code when your version is
available.

Thanks!

-- Steve
