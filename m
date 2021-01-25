Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2843B30295F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 18:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731290AbhAYRyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 12:54:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:39940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731239AbhAYRxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 12:53:19 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BB2722D04;
        Mon, 25 Jan 2021 17:52:37 +0000 (UTC)
Date:   Mon, 25 Jan 2021 12:52:36 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH V2] x86/entry/64: De-Xen-ify our NMI code further
Message-ID: <20210125125236.14b295a5@gandalf.local.home>
In-Reply-To: <20210125123859.39b244ca@gandalf.local.home>
References: <CALCETrW1qP=vbHCSdgOLjjP+-i=io3o1w5bMdtH_UHSV3gvBXg@mail.gmail.com>
        <20210125074506.15064-1-jiangshanlai@gmail.com>
        <20210125123859.39b244ca@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jan 2021 12:38:59 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On triggering an NMI from user space, I see the switch to the thread stack
> is done, and "exc_nmi" is called.
> 
> The problem I see with this is that exc_nmi is called with the thread
> stack, if it were to take an exception, NMIs would be enabled allowing for
> a nested NMI to run. From what I can tell, I don't see anything stopping
> that NMI from executing over the currently running NMI. That is, this means
> that NMI handlers are now re-entrant.
> 
> Yes, the stack issue is not a problem here, but NMI handlers are not
> allowed to be re-entrant. For example, we have spin locks in NMI handlers
> that are considered fine if they are only used in NMI handlers. But because
> there's a possible way to make NMI handlers re-entrant then these spin
> locks can deadlock.
> 
> I'm guessing that we need to add some tricks to the user space path to
> set and clear the "NMI executing" variable, but the return may become a bit
> complex in clearing that without races.

I think this may work if we wrap the exc_nmi call with the following:

Overwrite the NMI HW stack frame on the NMI stack as if an NMI came in at
the return back to the user space path of the NMI handler. Set the stack
pointer to the NMI stack just after the first frame that was updated. Then
jump to asm_exc_nmi.

Then the code would act like it came in from kernel mode, and execute the
NMI nesting code normally. When it finishes, and does the iretq, it will
return to the NMI handler for the user space return with the kernel thread
stack, and then the special code for returning to user space can be called.

The exc_nmi C code will need to handle this case to update pt_regs to make
sure the registered NMI handlers still see the pt_regs from user space. But
I think something like this may be the easiest way to handle this without
dealing with more NMI stack nesting races.

I could try to write something up to implemented this.

-- Steve
