Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79B9D29901B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 15:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1782308AbgJZOye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 10:54:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:39686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1782104AbgJZOyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 10:54:33 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D822022281;
        Mon, 26 Oct 2020 14:54:30 +0000 (UTC)
Date:   Mon, 26 Oct 2020 10:54:28 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michel Lespinasse <walken@google.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Jann Horn <jannh@google.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        David Rientjes <rientjes@google.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Subject: Re: [PATCH v4 1/1] mmap_lock: add tracepoints around lock
 acquisition
Message-ID: <20201026105428.3205d2b0@gandalf.local.home>
In-Reply-To: <a98b7807-9ed9-feda-f182-0031e6512328@suse.cz>
References: <20201020184746.300555-1-axelrasmussen@google.com>
        <20201020184746.300555-2-axelrasmussen@google.com>
        <fa6b9d13-0ef5-4d5d-bda3-657300028e23@suse.cz>
        <CAJHvVcjzZgsvdzciR5v_wkgf3M7aD_vNGv3TXrf5Z5K6SLprSA@mail.gmail.com>
        <a98b7807-9ed9-feda-f182-0031e6512328@suse.cz>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Oct 2020 19:56:49 +0200
Vlastimil Babka <vbabka@suse.cz> wrote:

> > I'm somewhat sure this code can be called in interrupt context, so I
> > don't think we can use locks to prevent this situation. I think it
> > works like this: say we acquire the lock, an interrupt happens, and
> > then we try to acquire again on the same CPU; we can't sleep, so we're
> > stuck.  
> 
> Yes, we could perhaps trylock() and if it fails, give up on the memcg path.
> 
> > I think we can't kmalloc here (instead of a percpu buffer) either,
> > since I would guess that kmalloc may also acquire mmap_lock itself?  
> 
> the overhead is not worth it anyway, for a tracepoint
> 
> > Is adding local_irq_save()/local_irq_restore() in addition to
> > get_cpu()/put_cpu() sufficient?  
> 
> If you do that, then I guess you don't need get_cpu()/put_cpu() anymore. But 
> it's more costly.
> 
> But sounds like we are solving something that the tracing subystem has to solve 
> as well to store the trace event data, so maybe Steven has some better idea?

How big of a buffer to you need? The way that ftrace handles reserving
buffer for events (which coincidentally, I just talked about today at Open
Source Summit Europe!), is that I simply use local_add_return() and have a
buffer index. And the stack trace code does this as well.

For using a temporary buffer, you would allocate (at enabling of the
tracepoint, which is why we have a "reg" and "unreg" form of the
TRACE_EVENT macro called TRACE_EVENT_FN (for "function)). Have this
temporary buffer per cpu and handle all the contexts that it would be
called in. For ftrace, we usually make it 4 (normal, softirq, irq and NM
context). Ftrace will use local_add_return, but as I'm guessing, the
interrupt context will be done with its buffer after writing the event, you
don't need to worry about the counter being atomic.

You simply need to do:

DEFINE_PER_CPU(char *, my_buffer);
static int my_buf_idx;

At initialization:

	for_each_possible_cpu(cpu) {
		per_cpu(my_buffer, cpu) = kmalloc(MY_BUFF_SIZE *context_needed, GFP_KERNEL);
		if (!per_cpu(my_buffer, cpu))
			goto out_fail;
		per_cpu(my_buf_idx, cpu) = 0;
	}


Then for the event:

	preempt_disable();
	idx = this_cpu_add(my_buf_idx, MY_BUFF_SIZE);
	current_buffer = this_cpu_ptr(my_buffer);
	buf = current_buffer[idx - MY_BUFF-SIZE];

	copy_my_data_to_buffer(buf);
	trace_my_trace_point(buf);

	this_cpu_sub(my_buf_idx, MY_BUFF_SIZE);
	preempt_enable();



Now if an interrupt were to come in, it would do the same thing, but will
use the buffer after the MY_BUFF_SIZE, and you don't need to worry about
one corrupting another. Once the index has been incremented, a interrupt
will use the portion of the buffer after the "allocate" part. And even if
it happened right at the this_cpu_add(), the interrupt would put it back
before returning back to the context that it interrupted.

Is this what you need to deal with?

-- Steve
