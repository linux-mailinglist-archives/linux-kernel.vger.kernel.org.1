Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2904328FC61
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 04:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393708AbgJPCVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 22:21:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:50886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732267AbgJPCVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 22:21:44 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E371A20878;
        Fri, 16 Oct 2020 02:21:42 +0000 (UTC)
Date:   Thu, 15 Oct 2020 22:21:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [GIT PULL] tracing: Updates for 5.10
Message-ID: <20201015222139.1b92a3be@gandalf.local.home>
In-Reply-To: <CAHk-=wjU86UhovK4XuwvCqTOfc+nvtpAuaN2PJBz15z=w=u0Xg@mail.gmail.com>
References: <20201015135345.6b29e8c0@gandalf.local.home>
        <CAHk-=wjU86UhovK4XuwvCqTOfc+nvtpAuaN2PJBz15z=w=u0Xg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Oct 2020 18:54:34 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, Oct 15, 2020 at 10:53 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > Updates for tracing and bootconfig:  
> 
> Hmm. I haven't verified that this came from you, but it seems likely..
> Once again my clang build shows something that I don't see in my
> allmodconfig gcc build:
> 
>    WARNING: modpost: vmlinux.o(.text+0x1e5b06): Section mismatch in
> reference from the function __trace_early_add_events() to the function
> .init.text:__trace_early_add_new_event()
>    The function __trace_early_add_events() references
>    the function __init __trace_early_add_new_event().
>    This is often because __trace_early_add_events lacks a __init
>    annotation or the annotation of __trace_early_add_new_event is wrong.
> 
> Hmm?
> 
>                Linus

I see the issue, and I wonder if it has to do with optimization, for gcc
not to warn.

The issue is that we have:

trace_array_create() that can be called at any time. And it has:

	if (trace_instance_dir) {
		ret = trace_array_create_dir(tr);
		if (ret)
			goto out_free_tr;
	} else
		__trace_early_add_events(tr);


Where trace_instance_dir gets set at boot up, and thus the else statement
will never get called after that.

The __trace_early_add_events() then calls __trace_early_add_new_events()
which is __init.

I don't know how gcc didn't trigger this and clang does.

I'll have to think about how to untangle this. Is there some kind of
annotation that makes it show that a path can only be called at boot up and
not later?

-- Steve
