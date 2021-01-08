Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 913542EEC59
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 05:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbhAHEUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 23:20:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:58558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726600AbhAHEUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 23:20:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 150732075A;
        Fri,  8 Jan 2021 04:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610079566;
        bh=C50ILe8XD3p5Fd6hL1LckWStWtHfeqxjGImfDKqrk38=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AGmwRYrC9Var80OejosN1vXduVijQ2kr6gyalXmGwgfxpSGE20vXQbuWZb15KGE/G
         JE+6NtMUiOIkxMMXypj3w2Sj7boNizR2zO8W9MSx7Bzi1Ga8dyycqh8figfugexW1L
         vQPbEm77S/G4qFea4lZE7VNWmpOdFONIl0svTBK4lDUqAa3gA18ogC7JQdn1Vx2YbQ
         DJZG/EQqyfws9yoyJkRt4uU2ydijwcy2aL8wYzPBMOH3ib0rUI4vwiSbW/qdisH38I
         c6s2SA0yZ6E/Q3Aw68iV3z2pFjsQnytuiFIFWnVW9WS46W60yqZPuyzUIoHO+TpjgP
         QFjrZwadYn6OA==
Date:   Fri, 8 Jan 2021 13:19:22 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/kprobes: Do the notrace functions check without
 kprobes on ftrace
Message-Id: <20210108131922.8db9746c27241dae4d4ea8b2@kernel.org>
In-Reply-To: <20210107091330.3782789c@gandalf.local.home>
References: <160990323982.16047.9136060149082849917.stgit@devnote2>
        <20210107091330.3782789c@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Jan 2021 09:13:30 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed,  6 Jan 2021 12:20:40 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Enable the notrace function check on the architecture which doesn't
> > support kprobes on ftrace. This notrace function check is not only
> > for the kprobes on ftrace but also sw-breakpoint based kprobes.
> > Thus there is no reason to limit this check for the arch which
> > supports kprobes on ftrace.
> > 
> > This also changes the dependency of Kconfig. Because kprobe event
> > uses the function tracer's address list for identifying notrace
> > function, if the CONFIG_FUNCTION_TRACER=n, it can not check whether
> > the target function is notrace or not.
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > ---
> 
> Fails to build with:
> 
> kernel/trace/trace_kprobe.c: In function ‘__within_notrace_func’:
> kernel/trace/trace_kprobe.c:453:10: error: implicit declaration of function ‘ftrace_location_range’; did you mean ‘ftrace_location’? [-Werror=implicit-function-declaration]
>   453 |  return !ftrace_location_range(addr, addr + size - 1);
>       |          ^~~~~~~~~~~~~~~~~~~~~
>       |          ftrace_location
> 

Oops, it depends on CONFIG_DYNAMIC_FTRACE=y instead of CONFIG_FUNCTION_TRACER.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
