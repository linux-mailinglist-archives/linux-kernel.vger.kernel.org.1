Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55CA228F42D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 15:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388170AbgJON7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 09:59:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:53328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387904AbgJON7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 09:59:43 -0400
Received: from tzanussi-mobl (c-73-209-127-30.hsd1.il.comcast.net [73.209.127.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 235972222B;
        Thu, 15 Oct 2020 13:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602770382;
        bh=8haq88aRZfHa91NkLFfD9u6mDM75ZHqJEOPYsntrSQY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=2iq9s9GTaPhzIudb9GcF5p3xmUcmVbSjUGU2xk67+oQhOpriRYSmFg15PlnrUQWLu
         v4/AdBckpjsdnVdBjNpQ7fFy036C+0jy4Koc6dduIrxbZTHd6NVlkypXBRy4cdAkHB
         KxZojKlNi94M3QLikxj6Hvbf5gV8J08tZIcxWe68=
Message-ID: <6cfecc21b67c5aa7e91dfa58b5e59f8545e6524f.camel@kernel.org>
Subject: Re: [PATCH v3 7/7] selftests/ftrace: Add test case for synthetic
 event syntax errors
From:   Tom Zanussi <zanussi@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     rostedt@goodmis.org, axelrasmussen@google.com,
        linux-kernel@vger.kernel.org
Date:   Thu, 15 Oct 2020 08:59:40 -0500
In-Reply-To: <20201014110636.139df7be275d40a23b523b84@kernel.org>
References: <cover.1602598160.git.zanussi@kernel.org>
         <af611928ce79f86eaf0af8654f1d7802d5cc21ff.1602598160.git.zanussi@kernel.org>
         <20201014110636.139df7be275d40a23b523b84@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On Wed, 2020-10-14 at 11:06 +0900, Masami Hiramatsu wrote:
> Hi Tom,
> 
> On Tue, 13 Oct 2020 09:17:58 -0500
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > Add a selftest that verifies that the syntax error messages and
> > caret
> > positions are correct for most of the possible synthetic event
> > syntax
> > error cases.
> > 
> > Signed-off-by: Tom Zanussi <zanussi@kernel.org>
> > ---
> >  .../trigger-synthetic_event_syntax_errors.tc  | 19
> > +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >  create mode 100644
> > tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-
> > synthetic_event_syntax_errors.tc
> > 
> > diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-
> > event/trigger-synthetic_event_syntax_errors.tc
> > b/tools/testing/selftests/ftrace/test.d/trigger/inter-
> > event/trigger-synthetic_event_syntax_errors.tc
> > new file mode 100644
> > index 000000000000..ada594fe16cb
> > --- /dev/null
> > +++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-
> > event/trigger-synthetic_event_syntax_errors.tc
> > @@ -0,0 +1,19 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL-2.0
> > +# description: event trigger - test synthetic_events syntax parser
> > errors
> > +# requires: synthetic_events error_log
> 
> This also requires dynamic strings support. So, its "requires" line
> should be
> 
> # requires: synthetic_events error_log "char name[]' >>
> synthetic_events":README
> 

Yes, thanks for reminding me. ;-)

> > +
> > +check_error() { # command-with-error-pos-by-^
> > +    ftrace_errlog_check 'synthetic_events' "$1" 'synthetic_events'
> > +}
> > +
> 
> BTW, some errors looks a bit odd.
> 
> > +check_error 'myevent ^chr arg'			# INVALID_TYPE
> > +check_error 'myevent ^char str[];; int v'	# INVALID_TYPE
> 
> I think there is a wrong "void" argument between ";", instead of
> invalid type.

Yes, you're right.  I think the solution overall is to just treat
semicolons as whitespace.

> 
> > +check_error 'myevent char ^str]; int v'		# INVALID_NAME
> > +check_error 'myevent char ^str;[]'		# INVALID_NAME
> 
> This is also not an invalid name but '[]' is an invalid type. 
> 
> > +check_error 'myevent ^char str[; int v'		# INVALID_TYPE
> > +check_error '^mye;vent char str[]'		# BAD_NAME
> > +check_error 'myevent char str[]; ^int'		# INVALID_FIELD
> 
> Isn't it an incomplete command?

Yes, but also an invalid field.  I'll try to refine these errors a bit
and make these more consistent.

Tom

> 
> > +check_error '^myevent'				#
> > INCOMPLETE_CMD
> > +
> > +exit 0
> 
> Thank you,
> 
> > -- 
> > 2.17.1
> > 
> 
> 

