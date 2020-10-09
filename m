Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE247289A34
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 23:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391279AbgJIVKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 17:10:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:33122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389007AbgJIVKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 17:10:09 -0400
Received: from tzanussi-mobl (c-73-209-127-30.hsd1.il.comcast.net [73.209.127.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53C61222C3;
        Fri,  9 Oct 2020 21:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602277808;
        bh=qDPUDxE4AbwHFOlY76iqPi7ikUmn1YPb8j23oUDqTdc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=GRfRvlym51mizFezFe3Bp3KNeS+e56K0U2rihex9KA3ZRtTIqUlBUzxVnwCsSAHxa
         3DCDsnLIWV4UbXHa2jkLAL42R9As25L5IEMTFie/DQ41l+bZ6ZuEQFetmuQxagls/V
         vKbOBDH0alTrg77urMNOdLVGYFzlY+ec58azvtf0=
Message-ID: <39fbddae7f82df6be1488e819589713974b68a68.camel@kernel.org>
Subject: Re: [PATCH 0/5] tracing: Synthetic event dynamic string fixes
From:   Tom Zanussi <zanussi@kernel.org>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 09 Oct 2020 16:10:06 -0500
In-Reply-To: <CAJHvVchmmJ4LF-wY=BJgJSaEo7w6AhgKzsF9Q5HCDN276uv=HA@mail.gmail.com>
References: <cover.1602255803.git.zanussi@kernel.org>
         <CAJHvVchmmJ4LF-wY=BJgJSaEo7w6AhgKzsF9Q5HCDN276uv=HA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Axel,

On Fri, 2020-10-09 at 13:35 -0700, Axel Rasmussen wrote:
> On Fri, Oct 9, 2020 at 8:17 AM Tom Zanussi <zanussi@kernel.org>
> wrote:
> > 
> > These patches provide fixes for the problems observed by Masami in
> > the
> > new synthetic event dynamic string patchset.
> > 
> > The first patch (tracing: Don't show dynamic string internals in
> > synthetic event description) removes the __data_loc from the event
> > description but leaves it in the format.
> > 
> > The patch (tracing: Add synthetic event error logging) addresses
> > the
> > lack of error messages when parse errors occur.
> > 
> > The remaining three patches address the other problems Masami noted
> > which result from allowing illegal characters in synthetic event
> > and
> > field names when defining an event.  The is_good_name() function is
> > used to check that's not possible for the probe events, but should
> > also be used for the synthetic events as well.
> > 
> > (tracing: Move is_good_name() from trace_probe.h to trace.h) makes
> > that function available to other trace subsystems by putting it in
> > trace.h.  (tracing: Check that the synthetic event and field names
> > are
> > legal) applies it to the synthetic events, and (selftests/ftrace:
> > Change synthetic event name for inter-event-combined test) changes
> > a
> > testcase that now fails because it uses an illegal name.
> > 
> > The following changes since commit
> > 848183553e431e6e9c2ea2f72421a7a1bbc6532e:
> > 
> >   tracing: Fix synthetic print fmt check for use of __get_str()
> > (2020-10-08 15:29:07 -0400)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-
> > trace.git ftrace/dynstring-fixes-v1
> 
> I applied this series, and then my mmap_lock tracepoints series, onto
> v5.9-rc8. I played with the edge cases Masami raised in the other
> thread, and I also tried constructing a synthetic event as we
> discussed on the thread about my series.
> 
> As far as I can see, this addresses the edge cases Masami pointed
> out,
> and it all seems to work as intended. It works fine with the kind of
> synthetic event I'm hoping to define for my particular use case.
> 
> So, for what it's worth:
> 
> Tested-By: Axel Rasmussen <axelrasmussen@google.com>
> 

Great, thanks for (re-)testing!

Tom

> > 
> > Tom Zanussi (5):
> >   tracing: Don't show dynamic string internals in synthetic event
> >     description
> >   tracing: Move is_good_name() from trace_probe.h to trace.h
> >   tracing: Check that the synthetic event and field names are legal
> >   tracing: Add synthetic event error logging
> >   selftests/ftrace: Change synthetic event name for inter-event-
> > combined
> >     test
> > 
> >  kernel/trace/trace.h                          |  13 ++
> >  kernel/trace/trace_events_synth.c             | 133
> > +++++++++++++++++-
> >  kernel/trace/trace_probe.h                    |  13 --
> >  .../trigger-inter-event-combined-hist.tc      |   8 +-
> >  4 files changed, 147 insertions(+), 20 deletions(-)
> > 
> > --
> > 2.17.1
> > 

