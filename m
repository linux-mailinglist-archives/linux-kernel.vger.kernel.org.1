Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFA9287D3E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 22:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbgJHUdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 16:33:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:49590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbgJHUdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 16:33:43 -0400
Received: from tzanussi-mobl (c-73-209-127-30.hsd1.il.comcast.net [73.209.127.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA21721D43;
        Thu,  8 Oct 2020 20:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602189223;
        bh=Wa6+SwmoUyDZWGsqat8x+/bUGRdpJ/vaeMrsIpQd+qc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=W7nmOE5qmQ6BUwgCKLNVpo5GHa9Tqmz9mlBcvfeP6+955vReHDngk43dFXq1OEllS
         XOLUfvj1NeuDPQPCRnlX2Ezi1/6MAoy3jnhcCdkHnur3iPkqiqlYJotwlKVqka35X8
         5TKGvfqP5kb/0gwuZ1Kp6mrJGrnoB8HXs132yM2I=
Message-ID: <dce75e64b996c9d676376440a9acf087395eec99.camel@kernel.org>
Subject: Re: [PATCH v4 4/7] tracing: Add support for dynamic strings to
 synthetic events
From:   Tom Zanussi <zanussi@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     rostedt@goodmis.org, axelrasmussen@google.com,
        linux-kernel@vger.kernel.org
Date:   Thu, 08 Oct 2020 15:33:41 -0500
In-Reply-To: <20201008182207.7526e70da842a01e373dd8cd@kernel.org>
References: <cover.1601848695.git.zanussi@kernel.org>
         <3ed35b6d0e390f5b94cb4a9ba1cc18f5982ab277.1601848695.git.zanussi@kernel.org>
         <20201008182207.7526e70da842a01e373dd8cd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On Thu, 2020-10-08 at 18:22 +0900, Masami Hiramatsu wrote:
> Hi Tom,
> 
> On Sun,  4 Oct 2020 17:14:06 -0500
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
> > [ <rostedt@goodmis.org>: added __set_synth_event_print_fmt()
> > changes:
> > 
> >   I added the following to make it work with trace-cmd. Dynamic
> > strings
> >   must have __get_str() for events in the print_fmt otherwise it
> > can't be
> >   parsed correctly. ]
> 
> I confirmed this works, but have some questions;
> - It seems no error message when we failed to define with wrong
> syntax

Yes, I need to add an error message for this (as well as others in this
file).

> 
> /sys/kernel/debug/tracing # echo 'myevent char name []' >>
> synthetic_events 
> sh: write error: Invalid argument
> /sys/kernel/debug/tracing # cat error_log 
> /sys/kernel/debug/tracing #
> 
> - what we write and what we see in synthetic_events are different
> 
> /sys/kernel/debug/tracing # echo 'myevent char name[]' >>
> synthetic_events 
> /sys/kernel/debug/tracing # cat synthetic_events 
> myevent	__data_loc char[] name
> 
> - And it is not able to re-define with that syntax
> 
> /sys/kernel/debug/tracing # echo > synthetic_events 
> /sys/kernel/debug/tracing # echo 'myevent __data_loc char[] name' >>
> synthetic_events 
> sh: write error: Invalid argument
> /sys/kernel/debug/tracing # 
> 

Yes, only the format needs to have the __data_loc, but the event
description shouldn't.

> - It seems to accept wrong name for variables
> 
> /sys/kernel/debug/tracing # echo 'myevent char name]' >>
> synthetic_events 
> /sys/kernel/debug/tracing # echo 'myevent2 char name;[]' >>
> synthetic_events 
> /sys/kernel/debug/tracing # cat synthetic_events 
> myevent	char name]
> myevent2	__data_loc char[] name;
> 

Yes, I think all these other errors boil down to allowing illegal
names.  Applying your is_good_name() function for probe events to these
fields should get rid of them.

> Some of those issues are not introduced from this series. I think
> we'd better fix those before introducing this series so that
> we can backport it to stable kernels.
> 

I should have patches addressing all of these shortly, tomorrow at the
latest.

Thanks,

Tom

> Thank you,
> 
> 

