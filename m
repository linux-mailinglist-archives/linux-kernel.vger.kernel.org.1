Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 038572A9EA2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 21:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbgKFUjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 15:39:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:35454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727129AbgKFUjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 15:39:05 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F286120719;
        Fri,  6 Nov 2020 20:39:03 +0000 (UTC)
Date:   Fri, 6 Nov 2020 15:39:01 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Artem Bityutskiy <dedekind1@gmail.com>
Cc:     Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs: trace: fix event state structure name
Message-ID: <20201106153901.1e578557@gandalf.local.home>
In-Reply-To: <20201104122113.322452-1-dedekind1@gmail.com>
References: <20201104122113.322452-1-dedekind1@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  4 Nov 2020 14:21:13 +0200
Artem Bityutskiy <dedekind1@gmail.com> wrote:

> From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> 
> The documentation refers to a non-existent 'struct synth_trace_state'
> structure. The correct name is 'struct synth_event_trace_state'.
> 
> In other words, this patch is a mechanical substitution:
> s/synth_trace_state/synth_event_trace_state/g
> 

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> ---
>  Documentation/trace/events.rst | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/trace/events.rst b/Documentation/trace/events.rst
> index f792b1959a33..bdba7b0e19ef 100644
> --- a/Documentation/trace/events.rst
> +++ b/Documentation/trace/events.rst
> @@ -787,13 +787,13 @@ To trace a synthetic using the piecewise method described above, the
>  synth_event_trace_start() function is used to 'open' the synthetic
>  event trace::
>  
> -       struct synth_trace_state trace_state;
> +       struct synth_event_trace_state trace_state;
>  
>         ret = synth_event_trace_start(schedtest_event_file, &trace_state);
>  
>  It's passed the trace_event_file representing the synthetic event
>  using the same methods as described above, along with a pointer to a
> -struct synth_trace_state object, which will be zeroed before use and
> +struct synth_event_trace_state object, which will be zeroed before use and
>  used to maintain state between this and following calls.
>  
>  Once the event has been opened, which means space for it has been
> @@ -805,7 +805,7 @@ lookup per field.
>  
>  To assign the values one after the other without lookups,
>  synth_event_add_next_val() should be used.  Each call is passed the
> -same synth_trace_state object used in the synth_event_trace_start(),
> +same synth_event_trace_state object used in the synth_event_trace_start(),
>  along with the value to set the next field in the event.  After each
>  field is set, the 'cursor' points to the next field, which will be set
>  by the subsequent call, continuing until all the fields have been set
> @@ -834,7 +834,7 @@ this method would be (without error-handling code)::
>         ret = synth_event_add_next_val(395, &trace_state);
>  
>  To assign the values in any order, synth_event_add_val() should be
> -used.  Each call is passed the same synth_trace_state object used in
> +used.  Each call is passed the same synth_event_trace_state object used in
>  the synth_event_trace_start(), along with the field name of the field
>  to set and the value to set it to.  The same sequence of calls as in
>  the above examples using this method would be (without error-handling
> @@ -856,7 +856,7 @@ can be used but not both at the same time.
>  
>  Finally, the event won't be actually traced until it's 'closed',
>  which is done using synth_event_trace_end(), which takes only the
> -struct synth_trace_state object used in the previous calls::
> +struct synth_event_trace_state object used in the previous calls::
>  
>         ret = synth_event_trace_end(&trace_state);
>  

