Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23FA528FC80
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 04:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393927AbgJPCxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 22:53:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:41016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393703AbgJPCx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 22:53:29 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEA5820878;
        Fri, 16 Oct 2020 02:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602816808;
        bh=IhSQx53hkVBmzkENXzPWlb+dAsaKLcdkiKSiRey596Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1LG+EHVjsqLKxDYcoFXj5wJB/Pr9XQTRfBaZN8Dy3bdAFxOJwJn0mxNMPUv2ZQfM+
         u6T7ZL9WbZGkm+VUPqzHgElWvuuDtaWACL2TwI9X9P/rcMcZWNMVz4DrbmmCWlvV2t
         6KEevFmkZNK1as8mBtpg/9y+K2vveYG0ZKDLtePw=
Date:   Fri, 16 Oct 2020 11:53:23 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [GIT PULL] tracing: Updates for 5.10
Message-Id: <20201016115323.13a75e51d5dc18573de4d33a@kernel.org>
In-Reply-To: <20201015222139.1b92a3be@gandalf.local.home>
References: <20201015135345.6b29e8c0@gandalf.local.home>
        <CAHk-=wjU86UhovK4XuwvCqTOfc+nvtpAuaN2PJBz15z=w=u0Xg@mail.gmail.com>
        <20201015222139.1b92a3be@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Oct 2020 22:21:39 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 15 Oct 2020 18:54:34 -0700
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > On Thu, Oct 15, 2020 at 10:53 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > > Updates for tracing and bootconfig:  
> > 
> > Hmm. I haven't verified that this came from you, but it seems likely..
> > Once again my clang build shows something that I don't see in my
> > allmodconfig gcc build:
> > 
> >    WARNING: modpost: vmlinux.o(.text+0x1e5b06): Section mismatch in
> > reference from the function __trace_early_add_events() to the function
> > .init.text:__trace_early_add_new_event()
> >    The function __trace_early_add_events() references
> >    the function __init __trace_early_add_new_event().
> >    This is often because __trace_early_add_events lacks a __init
> >    annotation or the annotation of __trace_early_add_new_event is wrong.
> > 
> > Hmm?
> > 
> >                Linus
> 
> I see the issue, and I wonder if it has to do with optimization, for gcc
> not to warn.

I also couldn't reproduce it even with CONFIG_DEBUG_SECTION_MISMATCH=y.
It seems that the __trace_early_add_new_event() is inlined in 
__trace_early_add_events(). 

$ eu-readelf -w kernel/trace/trace_events.o
...
 [ 1af20]    subprogram           abbrev: 53
             name                 (strp) "__trace_early_add_new_event"
             decl_file            (data1) trace_events.c (1)
             decl_line            (data2) 2502
             decl_column          (data1) 1
             prototyped           (flag_present) yes
             type                 (ref4) [    cc]
             inline               (data1) inlined (1)
$ gcc -v
...
gcc version 9.3.0 (Ubuntu 9.3.0-17ubuntu1~20.04) 

> 
> The issue is that we have:
> 
> trace_array_create() that can be called at any time. And it has:
> 
> 	if (trace_instance_dir) {
> 		ret = trace_array_create_dir(tr);
> 		if (ret)
> 			goto out_free_tr;
> 	} else
> 		__trace_early_add_events(tr);
> 
> 
> Where trace_instance_dir gets set at boot up, and thus the else statement
> will never get called after that.
> 
> The __trace_early_add_events() then calls __trace_early_add_new_events()
> which is __init.
> 
> I don't know how gcc didn't trigger this and clang does.

> 
> I'll have to think about how to untangle this. Is there some kind of
> annotation that makes it show that a path can only be called at boot up and
> not later?

What happen if we use Peter's static_call() and update it after boot up? 
Or, we might need to break apart the trace_array_create() and restruct
it as __init trace_array_early_create() and trace_array_create().

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
