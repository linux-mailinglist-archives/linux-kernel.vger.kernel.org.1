Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFD328D763
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 02:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730451AbgJNAWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 20:22:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:50542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727122AbgJNAWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 20:22:22 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFFFF2078A;
        Wed, 14 Oct 2020 00:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602634941;
        bh=0tbo4sTM9I67446ppig/Fd68gVUt6XxhPPoM7W+hyfU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1d7UznJmCmyW5QG+oN+uj/rFK3t5CTpJ+zQvLrpTnHHcdbCpkBgxSPNzKVPc5yRos
         EWbiiujTRfP12nQ9gFnpZOJVjENDj3CrN/MXdKnpu8f4D55JVmdfshZOtxIgxh0VwC
         QrmmXUCKSeb+WjmCM8sSYr9S0NPJXWf91qI+kjeo=
Date:   Wed, 14 Oct 2020 09:22:18 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, axelrasmussen@google.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] tracing: Synthetic event dynamic string fixes
Message-Id: <20201014092218.71ecfbcbb56661f7f6a6b0e5@kernel.org>
In-Reply-To: <cover.1602598160.git.zanussi@kernel.org>
References: <cover.1602598160.git.zanussi@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

On Tue, 13 Oct 2020 09:17:51 -0500
Tom Zanussi <zanussi@kernel.org> wrote:

> This updates v2 to replace some of the v2 code with improved code from
> Steve (tracing: Add synthetic event error logging) and (tracing:
> Handle synthetic event array field type checking correctly) and remove
> the synth_error_clear() function and change last_cmd_set() to use
> strncpy.

Thank you for updating, I tested the series and confirmed all issues 
are fixed now :)

Tested-by: Masami Hiramatsu <mhiramat@kernel.org>

for this series.

/ # cd /sys/kernel/debug/tracing/
/sys/kernel/debug/tracing # echo 'myevent char foo]' >> synthetic_events 
sh: write error: Invalid argument
/sys/kernel/debug/tracing # cat error_log 
[   35.086780] synthetic_events: error: Illegal name
  Command: myevent char foo]
                        ^
/sys/kernel/debug/tracing # echo 'myevent char foo;[]' >> synthetic_events 
sh: write error: Invalid argument
/sys/kernel/debug/tracing # cat error_log 
[   35.086780] synthetic_events: error: Illegal name
  Command: myevent char foo]
                        ^
[   46.857674] synthetic_events: error: Illegal name
  Command: myevent char foo;[]
                        ^
/sys/kernel/debug/tracing # echo 'myevent char foo+[]' >> synthetic_events 
sh: write error: Invalid argument
/sys/kernel/debug/tracing # cat error_log 
[   35.086780] synthetic_events: error: Illegal name
  Command: myevent char foo]
                        ^
[   46.857674] synthetic_events: error: Illegal name
  Command: myevent char foo;[]
                        ^
[   57.220147] synthetic_events: error: Illegal name
  Command: myevent char foo+[]
                        ^
/sys/kernel/debug/tracing # echo 'myevent char foo[]' >> synthetic_events 
/sys/kernel/debug/tracing # cat synthetic_events 
myevent	char[] foo
/sys/kernel/debug/tracing # echo > synthetic_events 
/sys/kernel/debug/tracing # echo 'myevent char[] foo' >> synthetic_events 
/sys/kernel/debug/tracing # cat synthetic_events 
myevent	char[] foo
/sys/kernel/debug/tracing # cat events/synthetic/myevent/format 
name: myevent
ID: 1219
format:
	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
	field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
	field:int common_pid;	offset:4;	size:4;	signed:1;

	field:__data_loc char[] foo;	offset:8;	size:8;	signed:1;

print fmt: "foo=%.*s", __get_str(foo)


> 
> Thanks,
> 
> Tom
> 
> v2 text:
> 
> This updates v1 to fix a couple of additional things that Masami
> pointed out:
> 
>  - The error logging for the BAD_TYPE error was actually pointing to
>    the name - it now points to the type as it should.
> 
>  - Added a new test case that verifies most of the synthetic event
>    error messages and caret positions.
>  
>  - Added a new patch that correctly strips off trailing semicolons and
>    everything else from array types, which wasn't happening before,
>    even before the dynamic array patches.
> 
> Original v1 text:
> 
> These patches provide fixes for the problems observed by Masami in the
> new synthetic event dynamic string patchset.
> 
> The first patch (tracing: Don't show dynamic string internals in
> synthetic event description) removes the __data_loc from the event
> description but leaves it in the format.
> 
> The patch (tracing: Add synthetic event error logging) addresses the
> lack of error messages when parse errors occur.
> 
> The remaining three patches address the other problems Masami noted
> which result from allowing illegal characters in synthetic event and
> field names when defining an event.  The is_good_name() function is
> used to check that's not possible for the probe events, but should
> also be used for the synthetic events as well.
> 
> (tracing: Move is_good_name() from trace_probe.h to trace.h) makes
> that function available to other trace subsystems by putting it in
> trace.h.  (tracing: Check that the synthetic event and field names are
> legal) applies it to the synthetic events, and (selftests/ftrace:
> Change synthetic event name for inter-event-combined test) changes a
> testcase that now fails because it uses an illegal name.
> 
> The following changes since commit 848183553e431e6e9c2ea2f72421a7a1bbc6532e:
> 
>   tracing: Fix synthetic print fmt check for use of __get_str() (2020-10-08 15:29:07 -0400)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace/dynstring-fixes-v3
> 
> Tom Zanussi (7):
>   tracing: Don't show dynamic string internals in synthetic event
>     description
>   tracing: Move is_good_name() from trace_probe.h to trace.h
>   tracing: Check that the synthetic event and field names are legal
>   tracing: Add synthetic event error logging
>   selftests/ftrace: Change synthetic event name for inter-event-combined
>     test
>   tracing: Handle synthetic event array field type checking correctly
>   selftests/ftrace: Add test case for synthetic event syntax errors
> 
>  kernel/trace/trace.h                          |  13 ++
>  kernel/trace/trace_events_synth.c             | 123 +++++++++++++++++-
>  kernel/trace/trace_probe.h                    |  13 --
>  .../trigger-inter-event-combined-hist.tc      |   8 +-
>  .../trigger-synthetic_event_syntax_errors.tc  |  19 +++
>  5 files changed, 153 insertions(+), 23 deletions(-)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic_event_syntax_errors.tc
> 
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
