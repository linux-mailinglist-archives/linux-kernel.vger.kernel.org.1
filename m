Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F06A228FCFF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 05:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394301AbgJPDyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 23:54:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:55152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393647AbgJPDyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 23:54:47 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6325F2074F;
        Fri, 16 Oct 2020 03:54:46 +0000 (UTC)
Date:   Thu, 15 Oct 2020 23:54:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [GIT PULL] tracing: Updates for 5.10
Message-ID: <20201015235444.6f222746@gandalf.local.home>
In-Reply-To: <20201016115323.13a75e51d5dc18573de4d33a@kernel.org>
References: <20201015135345.6b29e8c0@gandalf.local.home>
        <CAHk-=wjU86UhovK4XuwvCqTOfc+nvtpAuaN2PJBz15z=w=u0Xg@mail.gmail.com>
        <20201015222139.1b92a3be@gandalf.local.home>
        <20201016115323.13a75e51d5dc18573de4d33a@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Oct 2020 11:53:23 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> > 
> > I'll have to think about how to untangle this. Is there some kind of
> > annotation that makes it show that a path can only be called at boot up and
> > not later?  
> 
> What happen if we use Peter's static_call() and update it after boot up? 

I think that's a bit over engineering ;-)

> Or, we might need to break apart the trace_array_create() and restruct
> it as __init trace_array_early_create() and trace_array_create().

That will likely make the code a bit more complex and possibly add as much
code as we save from the __init sections.

I think the best solution is what you proposed, and removing the __init,
and possibly making that function inline as well.

Care to send an official patch?

Thanks!

-- Steve
