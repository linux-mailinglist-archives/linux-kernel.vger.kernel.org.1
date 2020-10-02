Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB900281E05
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 00:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725793AbgJBWGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 18:06:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:35032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgJBWGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 18:06:19 -0400
Received: from tzanussi-mobl (c-73-209-127-30.hsd1.il.comcast.net [73.209.127.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8039320719;
        Fri,  2 Oct 2020 22:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601676378;
        bh=UaUr8eLHoidIYhofDxXptew0GoEgIJN4UykhGNio/kY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=SqWjaKlhi5N0jQAlU50H61d3tlPrA++6gGxJL6i/Yi0G/iY1acHwbbp7He2X6AeCz
         ffW4A9tuMA2ux0kS9/cyxaXHUVFeOkrrn/xGvuU5SU95Z53vTcJq2nIKkfP/2kgJSg
         lj2Gh1+uJX5L71mEig/uAlOJEsb61MrkNV6eFFs8=
Message-ID: <61457f24d225ded7099a71cddeb4f735e18ccc28.camel@kernel.org>
Subject: Re: [PATCH v2 3/3] tracing: Add support for dynamic strings to
 synthetic events
From:   Tom Zanussi <zanussi@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     rostedt@goodmis.org, axelrasmussen@google.com,
        linux-kernel@vger.kernel.org
Date:   Fri, 02 Oct 2020 17:06:17 -0500
In-Reply-To: <20201002161703.3961a96e84314fe31157f308@kernel.org>
References: <cover.1601490263.git.zanussi@kernel.org>
         <86c164d6476fd1fa9595ec79634b15c25f59e5b0.1601490263.git.zanussi@kernel.org>
         <20201002161703.3961a96e84314fe31157f308@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On Fri, 2020-10-02 at 16:17 +0900, Masami Hiramatsu wrote:
> Hi Tom,
> 
> On Wed, 30 Sep 2020 13:40:52 -0500
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > Currently, sythetic events only support static string fields such
> > as:
> > 
> >   # echo 'test_latency u64 lat; char somename[32]' >
> > /sys/kernel/debug/tracing/synthetic_events
> > 
> > Which is fine, but wastes a lot of space in the event.
> > 
> > It also prevents the most commonly-defined strings in the existing
> > trace events e.g. those defined using __string(), from being passed
> > to
> > synthetic events via the trace() action.
> > 
> > With this change, synthetic events with dynamic fields can be
> > defined:
> > 
> >   # echo 'test_latency u64 lat; char somename[]' >
> > /sys/kernel/debug/tracing/synthetic_events
> 
> Could you add a testcase (and update existing one) of ftracetest
> for this new feature too?
> 

Yes, I'll add it in the next version.

> > 
> > And the trace() action can be used to generate events using either
> > dynamic or static strings:
> > 
> >   # echo 'hist:keys=name:lat=common_timestamp.usecs-
> > $ts0:onmatch(sys.event).test_latency($lat,name)' >
> > /sys/kernel/debug/tracing/events
> > 
> > The synthetic event dynamic strings are implemented in the same way
> > as
> > the existing __data_loc strings and appear as such in the format
> > file.
> > 
> > Signed-off-by: Tom Zanussi <zanussi@kernel.org>
> > ---
> >  Documentation/trace/events.rst      |  15 +-
> >  Documentation/trace/histogram.rst   |  18 +++
> >  kernel/trace/synth_event_gen_test.c |  18 ++-
> >  kernel/trace/trace_events_hist.c    |   9 ++
> >  kernel/trace/trace_events_synth.c   | 239
> > ++++++++++++++++++++++++----
> >  kernel/trace/trace_synth.h          |   4 +
> 
> And you might also need to update tracefs/README so that user
> can check whether the kernel supports dynamic string or not.
> 

Yeah, good to add regardless, will do.

Thanks,

Tom


