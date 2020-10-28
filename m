Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06F6929D640
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731007AbgJ1WNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:13:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:56464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730829AbgJ1WMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:12:23 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC763247C5;
        Wed, 28 Oct 2020 15:29:18 +0000 (UTC)
Date:   Wed, 28 Oct 2020 11:29:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [RFC][PATCH 1/2 v2] ftrace/x86: Allow for arguments to be
 passed in to REGS by default
Message-ID: <20201028112916.50bcbc69@oasis.local.home>
In-Reply-To: <20201028102502.28095c95@oasis.local.home>
References: <20201028131542.963014814@goodmis.org>
        <20201028131909.738751907@goodmis.org>
        <20201028102502.28095c95@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

Talking with Peter and Thomas on IRC, where they really don't like
passing a partial pt_regs around, got me thinking of redoing the REGS
parameter of ftrace. Kprobes is the only user that requires the full
registers being saved, and that's only because some kprobe user might
want them.

On Wed, 28 Oct 2020 10:25:02 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:
>
>  typedef void (*ftrace_func_t)(unsigned long ip, unsigned long parent_ip,
>  			      struct ftrace_ops *op, struct pt_regs *regs);
>  


Most registers of pt_regs at a start of a function is rather useless.
What if we got rid of FL_SAVE_REGS all together and had a "ftrace_regs"
structure passed in that would have only access to all the argument
registers, the stack pointer and the instruction pointer?

Then kprobes could just create its own pt_regs, fill in all the data
from ftrace_regs and then fill the rest with zeros or possibly whatever
the values currently are (does it really matter what those registers
are?), including flags.

Not only would this simplify the code, it would probably allow moving
more of the kprobe code from the arch specific to the generic code, and
remove a lot of duplication.

This would also help speed up the processing of live kernel patching.

And best of all, it would give everything access to the arguments of a
function and a stack pointer with out (ab)using pt_regs.

Do you think this would be feasible?

-- Steve
