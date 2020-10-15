Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9617D28E96E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 02:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732039AbgJOAQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 20:16:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:55632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730634AbgJOAQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 20:16:33 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66C29221FF;
        Thu, 15 Oct 2020 00:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602720992;
        bh=HGiBqzUWkqntE8fU1EZdxLl6YCsWiuRv5UJhNz7ST3o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BYrdwsZ7Xn/Zjavtp7qY8rDaXCu0OdTR5JxgivkC46n51JWXwgCAWDGyKJa422rQ2
         IYXhK0a8aitH+YzRPprcFKtG4a0VLCDG0NxV683KBPxa6bpMR6FuBBr+R+StKXo25m
         LARg18c0ZK1KNqTbaWZ8pn0FispCDUgVFhr6EEQU=
Date:   Thu, 15 Oct 2020 09:16:29 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Tom Zanussi <zanussi@kernel.org>, axelrasmussen@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/7] selftests/ftrace: Add test case for synthetic
 event syntax errors
Message-Id: <20201015091629.924b20723493d072ce14505c@kernel.org>
In-Reply-To: <20201014133215.21d066e4@gandalf.local.home>
References: <cover.1602598160.git.zanussi@kernel.org>
        <af611928ce79f86eaf0af8654f1d7802d5cc21ff.1602598160.git.zanussi@kernel.org>
        <20201014110636.139df7be275d40a23b523b84@kernel.org>
        <20201014133215.21d066e4@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Wed, 14 Oct 2020 13:32:15 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 14 Oct 2020 11:06:36 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Hi Tom,
> > 
> > On Tue, 13 Oct 2020 09:17:58 -0500
> > Tom Zanussi <zanussi@kernel.org> wrote:
> > 
> > > Add a selftest that verifies that the syntax error messages and caret
> > > positions are correct for most of the possible synthetic event syntax
> > > error cases.
> > > 
> > > Signed-off-by: Tom Zanussi <zanussi@kernel.org>
> > > ---
> > >  .../trigger-synthetic_event_syntax_errors.tc  | 19 +++++++++++++++++++
> > >  1 file changed, 19 insertions(+)
> > >  create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic_event_syntax_errors.tc
> > > 
> > > diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic_event_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic_event_syntax_errors.tc
> > > new file mode 100644
> > > index 000000000000..ada594fe16cb
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic_event_syntax_errors.tc
> > > @@ -0,0 +1,19 @@
> > > +#!/bin/sh
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# description: event trigger - test synthetic_events syntax parser errors
> > > +# requires: synthetic_events error_log  
> > 
> > This also requires dynamic strings support. So, its "requires" line should be
> > 
> > # requires: synthetic_events error_log "char name[]' >> synthetic_events":README
> > 
> > > +
> > > +check_error() { # command-with-error-pos-by-^
> > > +    ftrace_errlog_check 'synthetic_events' "$1" 'synthetic_events'
> > > +}
> > > +  
> > 
> > BTW, some errors looks a bit odd.
> > 
> > > +check_error 'myevent ^chr arg'			# INVALID_TYPE
> > > +check_error 'myevent ^char str[];; int v'	# INVALID_TYPE  
> > 
> > I think there is a wrong "void" argument between ";", instead of invalid type.
> > 
> > > +check_error 'myevent char ^str]; int v'		# INVALID_NAME
> > > +check_error 'myevent char ^str;[]'		# INVALID_NAME  
> > 
> > This is also not an invalid name but '[]' is an invalid type. 
> > 
> > > +check_error 'myevent ^char str[; int v'		# INVALID_TYPE
> > > +check_error '^mye;vent char str[]'		# BAD_NAME
> > > +check_error 'myevent char str[]; ^int'		# INVALID_FIELD  
> > 
> > Isn't it an incomplete command?
> > 
> > > +check_error '^myevent'				# INCOMPLETE_CMD
> > > +
> > > +exit 0  
> > 
> 
> Hi Masami,
> 
> I finished testing this series along with other patches (some from you),
> and I'm ready to push this to next, and hopefully soon to Linus. You have a
> "tested-by" for the entire series. Are you OK with this patch too? Can we
> push this forward and fix up any issues you have later?

I think this is OK to push at least for the upstream kernel (unless backporting).
The above issues can be fixed in another series :)

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
