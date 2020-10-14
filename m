Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C363428E2DD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 17:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731052AbgJNPLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 11:11:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:38344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728339AbgJNPLH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 11:11:07 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81CCB21582;
        Wed, 14 Oct 2020 15:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602688267;
        bh=ptsX5IEHb097J/nb2tQjVNZYDaKY/GBTGnz0VmNNNeY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pf7NFDwd+vEb6o8Z/4HrTIQxyegCMbl6IP64+JcL+/KPo2uSMguNNpyaM/79C/h3f
         DNwtXDfHL1sYVmtC5+Rtpd8p1GPWvzD6xbpRo1OEMIuNt4orPEYYCB3czKJQXHjbvs
         C8iDO7M2zRLQ3A9TGh//1sfZVhy2k/q1xz0bbozQ=
Date:   Thu, 15 Oct 2020 00:11:04 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC PATCH 1/1] tracepoints: tree-wide: Replace %p with %px
Message-Id: <20201015001104.593651d4e07bc3d4597e0771@kernel.org>
In-Reply-To: <20201014093813.74490c26@gandalf.local.home>
References: <160266594977.74973.9883936722540767319.stgit@devnote2>
        <160266595921.74973.16021029265750003477.stgit@devnote2>
        <20201014093813.74490c26@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Oct 2020 09:38:13 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 14 Oct 2020 17:59:19 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > To help debugging kernel, use %px to show real addresses on
> > tracefs/trace file.
> > 
> > Since ftrace human-readable format uses vsprintf(), all %p are
> > translated to hash values instead of pointer address.
> > 
> > However, when debugging the kernel, raw address value gives a
> > hint when comparing with the memory mapping in the kernel.
> > (Those are sometimes used with crash log, which is not hashed too)
> > 
> > Moreover, this is not improving the security because the tracefs
> > can be used only by root user and the raw address values are readable
> > from tracefs/percpu/cpu*/trace_pipe_raw file.
> > 
> > Note that this has been done by the following script.
> > 
> >  #!/bin/sh
> >  tmp=`mktemp`
> >  for h in include/trace/events/*.h ; do
> >    sed -e 's/\(%p\)\([^a-zA-Z]\)/\1x\2/g' $h > $tmp
> >    cp $tmp $h
> >  done
> >  rm $tmp
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Hi Masami,
> 
> I think a better approach is to inject on the output side a conversion of
> "%p" to "%px" before printing. That is, in the trace_raw_output_##call()
> function, instead of calling trace_seq_printf(s, print), we call a new
> function trace_event_printf(s, print), that will take the fmt parameter,
> and copies it to something that does your 's/\(%p\)\([^a-zA-Z]\)/\1x\2/g'
> inline before passing it off to trace_seq_printf().

Hmm, would you mean we always run such conversion on printing the trace
buffer for each entry? It could be much overhead because we need allocate
memory (%p->%px increase 1 byte) and format conversion (with copying it).
Maybe we can avoid repeating it using a kind of cache, but it also consumes
memory. And as I pointed, the security reason is meaningless because there
are raw addresses in raw data which user can read...
Could you tell me what is your point? Making the code change as small as
possible?

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
