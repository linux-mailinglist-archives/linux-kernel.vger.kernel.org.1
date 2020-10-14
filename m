Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34F9428E171
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 15:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731302AbgJNNiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 09:38:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:56676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727302AbgJNNiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 09:38:16 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 041E42173E;
        Wed, 14 Oct 2020 13:38:15 +0000 (UTC)
Date:   Wed, 14 Oct 2020 09:38:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC PATCH 1/1] tracepoints: tree-wide: Replace %p with %px
Message-ID: <20201014093813.74490c26@gandalf.local.home>
In-Reply-To: <160266595921.74973.16021029265750003477.stgit@devnote2>
References: <160266594977.74973.9883936722540767319.stgit@devnote2>
        <160266595921.74973.16021029265750003477.stgit@devnote2>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Oct 2020 17:59:19 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> To help debugging kernel, use %px to show real addresses on
> tracefs/trace file.
> 
> Since ftrace human-readable format uses vsprintf(), all %p are
> translated to hash values instead of pointer address.
> 
> However, when debugging the kernel, raw address value gives a
> hint when comparing with the memory mapping in the kernel.
> (Those are sometimes used with crash log, which is not hashed too)
> 
> Moreover, this is not improving the security because the tracefs
> can be used only by root user and the raw address values are readable
> from tracefs/percpu/cpu*/trace_pipe_raw file.
> 
> Note that this has been done by the following script.
> 
>  #!/bin/sh
>  tmp=`mktemp`
>  for h in include/trace/events/*.h ; do
>    sed -e 's/\(%p\)\([^a-zA-Z]\)/\1x\2/g' $h > $tmp
>    cp $tmp $h
>  done
>  rm $tmp
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>

Hi Masami,

I think a better approach is to inject on the output side a conversion of
"%p" to "%px" before printing. That is, in the trace_raw_output_##call()
function, instead of calling trace_seq_printf(s, print), we call a new
function trace_event_printf(s, print), that will take the fmt parameter,
and copies it to something that does your 's/\(%p\)\([^a-zA-Z]\)/\1x\2/g'
inline before passing it off to trace_seq_printf().

-- Steve
