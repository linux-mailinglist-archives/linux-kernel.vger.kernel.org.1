Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC0E428FD13
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 06:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgJPEFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 00:05:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:59078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726498AbgJPEFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 00:05:50 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A0632076E;
        Fri, 16 Oct 2020 04:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602821150;
        bh=vsrcDgb66ZZHroPzoaTCBR+9WG8G0fK5ozU28secHx0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T8tnutUhi2yjg6rfrO0cFXVUYv4ruo168k2OL0XXlWhD3/0RG79YNCvlRtrxL37y4
         UzyrQmXVJpU0IgKt9Qk3Ehw3GVLFenFKrjbM9FToz52SRCujeDMV9JInlqI0t16pQu
         73YcxtvWGjlT9evFO2MjKURwR4pKHhllVidIhtf8=
Date:   Fri, 16 Oct 2020 13:05:45 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [GIT PULL] tracing: Updates for 5.10
Message-Id: <20201016130545.caea7a3312ca2ee32990af61@kernel.org>
In-Reply-To: <20201015235444.6f222746@gandalf.local.home>
References: <20201015135345.6b29e8c0@gandalf.local.home>
        <CAHk-=wjU86UhovK4XuwvCqTOfc+nvtpAuaN2PJBz15z=w=u0Xg@mail.gmail.com>
        <20201015222139.1b92a3be@gandalf.local.home>
        <20201016115323.13a75e51d5dc18573de4d33a@kernel.org>
        <20201015235444.6f222746@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Oct 2020 23:54:44 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 16 Oct 2020 11:53:23 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > > 
> > > I'll have to think about how to untangle this. Is there some kind of
> > > annotation that makes it show that a path can only be called at boot up and
> > > not later?  
> > 
> > What happen if we use Peter's static_call() and update it after boot up? 
> 
> I think that's a bit over engineering ;-)
> 
> > Or, we might need to break apart the trace_array_create() and restruct
> > it as __init trace_array_early_create() and trace_array_create().
> 
> That will likely make the code a bit more complex and possibly add as much
> code as we save from the __init sections.
> 
> I think the best solution is what you proposed, and removing the __init,
> and possibly making that function inline as well.
> 
> Care to send an official patch?

Sure, I'll send it.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
