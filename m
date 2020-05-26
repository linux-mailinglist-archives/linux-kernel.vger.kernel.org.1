Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB321C9F61
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 01:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgEGX5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 19:57:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:54408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbgEGX5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 19:57:17 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7315920720;
        Thu,  7 May 2020 23:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588895836;
        bh=2o+y8fxLqhtXg3APfBgUNDvTw0QO66MYP7OHCoVyRF4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tvJM2f15l0kGd0TcPZ5vvEL9T0JafTX9h9hN27JKxQS0JWHerHbeDey3Mbw8YF0WA
         sMGk9CHL7k6wiBe60ImJu1FPC/jngFFZiLfNHeIppfP0mK2SOLuawse2sjah5xl0ko
         Pc0Fbkn52l14GZ3LdCA4Ouv+DsGC3gWSQlnAqXug=
Date:   Fri, 8 May 2020 08:57:12 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Julia Lawall <Julia.Lawall@inria.fr>,
        kernel-janitors@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org,
        Nic Volanschi <eugene.volanschi@inria.fr>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] tracing/probe: reverse arguments to list_add
Message-Id: <20200508085712.dcb44a32d1fb50c0a7e3e2a9@kernel.org>
In-Reply-To: <20200507165053.291ba5ea@gandalf.local.home>
References: <1588879808-24488-1-git-send-email-Julia.Lawall@inria.fr>
        <20200507165053.291ba5ea@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 May 2020 16:50:53 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu,  7 May 2020 21:30:08 +0200
> Julia Lawall <Julia.Lawall@inria.fr> wrote:
> 
> > Elsewhere in the file, the function trace_kprobe_has_same_kprobe uses
> > a trace_probe_event.probes object as the second argument of
> > list_for_each_entry, ie as a list head, while the list_for_each_entry
> > iterates over the list fields of the trace_probe structures, making
> > them the list elements.  So, exchange the arguments on the list_add
> > call to put the list head in the second argument.
> > 
> > Since both list_head structures were just initialized, this problem
> > did not cause any loss of information.
> > 

Oops, good catch!

> > Fixes: 60d53e2c3b75 ("tracing/probe: Split trace_event related data from trace_probe")
> > Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 
> Masami,
> 
> Can you give a Reviewed-by to this?

Yes, thanks Julia!

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,
> 
> -- Steve
> 
> > 
> > ---
> >  kernel/trace/trace_probe.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> > index ab8b6436d53f..b8a928e925c7 100644
> > --- a/kernel/trace/trace_probe.c
> > +++ b/kernel/trace/trace_probe.c
> > @@ -1006,7 +1006,7 @@ int trace_probe_init(struct trace_probe *tp, const char *event,
> >  	INIT_LIST_HEAD(&tp->event->class.fields);
> >  	INIT_LIST_HEAD(&tp->event->probes);
> >  	INIT_LIST_HEAD(&tp->list);
> > -	list_add(&tp->event->probes, &tp->list);
> > +	list_add(&tp->list, &tp->event->probes);
> >  
> >  	call = trace_probe_event_call(tp);
> >  	call->class = &tp->event->class;
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
