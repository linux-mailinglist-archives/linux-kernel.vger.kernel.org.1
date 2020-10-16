Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1C9928FC6E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 04:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404187AbgJPCev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 22:34:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:55476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404178AbgJPCeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 22:34:50 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 300C720878;
        Fri, 16 Oct 2020 02:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602815690;
        bh=wgurwTerQ1P/meEIJ41flc1QgAVRe5/Dfi5vOxe09rc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nkfJ6Q/Q3tcGvmzBTyfkTAEYV1zGi8EnSX6c1jl4ED6X9l/jjs9hOqp7LPZpgMkj+
         5I/IWmUkV24magig5hppYc+Tk/Dcc5dFJMi3SRROAoo3v79a7yLdHRU9OdfVN51+SP
         EE1TNfrt8zDEBestllDF3ocWXnbqwxRFh+HzIn2Q=
Date:   Fri, 16 Oct 2020 11:34:45 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [GIT PULL] tracing: Updates for 5.10
Message-Id: <20201016113445.4bd2a37c9b5e7f3a065b6f52@kernel.org>
In-Reply-To: <CAHk-=wjU86UhovK4XuwvCqTOfc+nvtpAuaN2PJBz15z=w=u0Xg@mail.gmail.com>
References: <20201015135345.6b29e8c0@gandalf.local.home>
        <CAHk-=wjU86UhovK4XuwvCqTOfc+nvtpAuaN2PJBz15z=w=u0Xg@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
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

Oops, that's my fault.
The commit 720dee53ad8d ("tracing/boot: Initialize per-instance event list
 in early boot") removes __init from __trace_early_add_events() but I
forgot to do same on __trace_early_add_new_event().
Would this work?

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 851ab37058dd..e705f06c68c6 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2498,7 +2498,7 @@ __trace_add_new_event(struct trace_event_call *call, struct trace_array *tr)
  * for enabling events at boot. We want to enable events before
  * the filesystem is initialized.
  */
-static __init int
+static int
 __trace_early_add_new_event(struct trace_event_call *call,
                            struct trace_array *tr)
 {


-- 
Masami Hiramatsu <mhiramat@kernel.org>
