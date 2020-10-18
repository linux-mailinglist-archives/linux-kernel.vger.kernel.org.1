Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F2D291800
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 17:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgJRPNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 11:13:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:43066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgJRPNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 11:13:50 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B2D4208B8;
        Sun, 18 Oct 2020 15:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603034029;
        bh=BSFYCgPQ9AmjyxF/qscSU+n8q8yrhsEMJAA+56Cy0W0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WQVcdcTXqKe7Fh3JK07XbEit3mXLIV3DTIcL3XGLUG+8BBgIOO2p2sL4skALYvFAW
         wh/7d6VvgAInnXt+fyK/sQcczV/r1Stq7PVQ3ACxj6pBbmy5v/4MujJfo6Zyd65m5+
         Xp+5K/83sL88RGtQlXsf5qbQo6lkZv08NJJI7ngo=
Date:   Mon, 19 Oct 2020 00:13:46 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, axelrasmussen@google.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] tracing: More synthetic event error fixes
Message-Id: <20201019001346.9d53c0c942e368ab01f667bb@kernel.org>
In-Reply-To: <cover.1602883818.git.zanussi@kernel.org>
References: <cover.1602883818.git.zanussi@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

On Fri, 16 Oct 2020 16:48:21 -0500
Tom Zanussi <zanussi@kernel.org> wrote:

> Hi,
> 
> This patchset addresses the synthetic event error anomalies reported
> by Masami in the last patchset [1].
> 
> It turns out that most of the problems boil down to clunky separator
> parsing; adding a couple new abilities to trace_run_command() and then
> adapting the existing users seemed to me the best way to fix these
> things, and also gets rid of some code.

Thanks for your work! But I think the interface design is a bit add-hoc.
I sent a comment mail on [1/4]. Let's discuss on the thread.

> Also, to make things easier for error display, I changed these to
> preserve the original command string and pass it through the callback
> instead of rebuilding it for error display.

trace_*probe reconstruct the input from argv, are there any reason
synthetic event can not do the same thing?
(this means the command on error message can be a bit different,
 see __trace_probe_log_err() in kernel/trace/trace_probe.c)

> 
> I added some new error strings and removed unused ones as well, and
> added a bunch of new test cases to the synthetic parser error test
> case.

Good.

> 
> I didn't see any problems running the entire ftrace testsuite or the
> test modules that also use the things that were touched here.

Thanks,

> 
> Thanks,
> 
> Tom
> 
> [1] https://lore.kernel.org/lkml/20201014110636.139df7be275d40a23b523b84@kernel.org/
> 
> The following changes since commit 6107742d15832011cd0396d821f3225b52551f1f:
> 
>   tracing: support "bool" type in synthetic trace events (2020-10-15 12:01:14 -0400)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace/synth-fixes-v1
> 
> Tom Zanussi (4):
>   tracing: Make trace_*_run_command() more flexible
>   tracing: Use new trace_run_command() options
>   tracing: Update synth command errors
>   selftests/ftrace: Update synthetic event syntax errors
> 
>  kernel/trace/trace.c                          | 41 ++++++++--
>  kernel/trace/trace.h                          | 12 ++-
>  kernel/trace/trace_dynevent.c                 |  4 +-
>  kernel/trace/trace_events_synth.c             | 79 ++++---------------
>  kernel/trace/trace_kprobe.c                   |  5 +-
>  kernel/trace/trace_uprobe.c                   |  5 +-
>  .../trigger-synthetic_event_syntax_errors.tc  | 17 ++--
>  7 files changed, 78 insertions(+), 85 deletions(-)
> 
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
