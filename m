Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F285A28715B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 11:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgJHJWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 05:22:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:36134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbgJHJWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 05:22:11 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF24C215A4;
        Thu,  8 Oct 2020 09:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602148930;
        bh=HAnhUEWENLt6sb8vx2xIBB+O8WbtTzkBmOOMxnDhndo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UNkk57M444hLGVhQLvxnDAJ/TGuLbcr1wPT5nksrjt/z6dReETLzSLN3D0sUmpic+
         XQqDyJ0PGIORInFM4SloRVOPSXqtsMP39aE9mQkzcc2slM7sDrAkljDfjjPu/4cG4g
         6HcHWKzl4JL01TDoJGNT+WUdVhK4GE1XD8mcrbNA=
Date:   Thu, 8 Oct 2020 18:22:07 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, axelrasmussen@google.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/7] tracing: Add support for dynamic strings to
 synthetic events
Message-Id: <20201008182207.7526e70da842a01e373dd8cd@kernel.org>
In-Reply-To: <3ed35b6d0e390f5b94cb4a9ba1cc18f5982ab277.1601848695.git.zanussi@kernel.org>
References: <cover.1601848695.git.zanussi@kernel.org>
        <3ed35b6d0e390f5b94cb4a9ba1cc18f5982ab277.1601848695.git.zanussi@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

On Sun,  4 Oct 2020 17:14:06 -0500
Tom Zanussi <zanussi@kernel.org> wrote:

> Currently, sythetic events only support static string fields such as:
> 
>   # echo 'test_latency u64 lat; char somename[32]' > /sys/kernel/debug/tracing/synthetic_events
> 
> Which is fine, but wastes a lot of space in the event.
> 
> It also prevents the most commonly-defined strings in the existing
> trace events e.g. those defined using __string(), from being passed to
> synthetic events via the trace() action.
> 
> With this change, synthetic events with dynamic fields can be defined:
> 
>   # echo 'test_latency u64 lat; char somename[]' > /sys/kernel/debug/tracing/synthetic_events
> 
> And the trace() action can be used to generate events using either
> dynamic or static strings:
> 
>   # echo 'hist:keys=name:lat=common_timestamp.usecs-$ts0:onmatch(sys.event).test_latency($lat,name)' > /sys/kernel/debug/tracing/events
> 
> The synthetic event dynamic strings are implemented in the same way as
> the existing __data_loc strings and appear as such in the format file.
> 
> [ <rostedt@goodmis.org>: added __set_synth_event_print_fmt() changes:
> 
>   I added the following to make it work with trace-cmd. Dynamic strings
>   must have __get_str() for events in the print_fmt otherwise it can't be
>   parsed correctly. ]

I confirmed this works, but have some questions;
- It seems no error message when we failed to define with wrong syntax

/sys/kernel/debug/tracing # echo 'myevent char name []' >> synthetic_events 
sh: write error: Invalid argument
/sys/kernel/debug/tracing # cat error_log 
/sys/kernel/debug/tracing #

- what we write and what we see in synthetic_events are different

/sys/kernel/debug/tracing # echo 'myevent char name[]' >> synthetic_events 
/sys/kernel/debug/tracing # cat synthetic_events 
myevent	__data_loc char[] name

- And it is not able to re-define with that syntax

/sys/kernel/debug/tracing # echo > synthetic_events 
/sys/kernel/debug/tracing # echo 'myevent __data_loc char[] name' >> synthetic_events 
sh: write error: Invalid argument
/sys/kernel/debug/tracing # 

- It seems to accept wrong name for variables

/sys/kernel/debug/tracing # echo 'myevent char name]' >> synthetic_events 
/sys/kernel/debug/tracing # echo 'myevent2 char name;[]' >> synthetic_events 
/sys/kernel/debug/tracing # cat synthetic_events 
myevent	char name]
myevent2	__data_loc char[] name;

Some of those issues are not introduced from this series. I think
we'd better fix those before introducing this series so that
we can backport it to stable kernels.

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
