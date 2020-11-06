Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC7A2A9EB1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 21:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbgKFUru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 15:47:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:37574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728386AbgKFUrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 15:47:49 -0500
Received: from tzanussi-mobl (c-73-209-127-30.hsd1.il.comcast.net [73.209.127.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBC9420853;
        Fri,  6 Nov 2020 20:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604695668;
        bh=F3fRRjAcC7K3WpyCM6VrbEayCum3dPNFG94uN3PghMY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=stVedLLWTsI7ZMQNsjvotYSAUXNLkRkE6DiWEc5XvObK7ldp4xhRdKBfx/SAMOele
         YrLGhvvMdiK7oXEsxd7DOlkjNRWBuImwMqRWuK421oSmYl2qvkWwV7oSdAKqpqqDeq
         KNSRZa54FAoNDBs3WuOoL3rmp1XmCr3sKGlgJKcM=
Message-ID: <96720ed0aac00653f9359679665d0ed4b2cc346d.camel@kernel.org>
Subject: Re: [PATCH] docs: trace: fix event state structure name
From:   Tom Zanussi <zanussi@kernel.org>
To:     Artem Bityutskiy <dedekind1@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org
Date:   Fri, 06 Nov 2020 14:47:46 -0600
In-Reply-To: <20201104122113.322452-1-dedekind1@gmail.com>
References: <20201104122113.322452-1-dedekind1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Artem,

On Wed, 2020-11-04 at 14:21 +0200, Artem Bityutskiy wrote:
> From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> 
> The documentation refers to a non-existent 'struct synth_trace_state'
> structure. The correct name is 'struct synth_event_trace_state'.
> 
> In other words, this patch is a mechanical substitution:
> s/synth_trace_state/synth_event_trace_state/g
> 
> Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

Thanks for fixing this!

Reviewed-by: Tom Zanussi <zanussi@kernel.org>


> ---
>  Documentation/trace/events.rst | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/trace/events.rst
> b/Documentation/trace/events.rst
> index f792b1959a33..bdba7b0e19ef 100644
> --- a/Documentation/trace/events.rst
> +++ b/Documentation/trace/events.rst
> @@ -787,13 +787,13 @@ To trace a synthetic using the piecewise method
> described above, the
>  synth_event_trace_start() function is used to 'open' the synthetic
>  event trace::
>  
> -       struct synth_trace_state trace_state;
> +       struct synth_event_trace_state trace_state;
>  
>         ret = synth_event_trace_start(schedtest_event_file,
> &trace_state);
>  
>  It's passed the trace_event_file representing the synthetic event
>  using the same methods as described above, along with a pointer to a
> -struct synth_trace_state object, which will be zeroed before use and
> +struct synth_event_trace_state object, which will be zeroed before
> use and
>  used to maintain state between this and following calls.
>  
>  Once the event has been opened, which means space for it has been
> @@ -805,7 +805,7 @@ lookup per field.
>  
>  To assign the values one after the other without lookups,
>  synth_event_add_next_val() should be used.  Each call is passed the
> -same synth_trace_state object used in the synth_event_trace_start(),
> +same synth_event_trace_state object used in the
> synth_event_trace_start(),
>  along with the value to set the next field in the event.  After each
>  field is set, the 'cursor' points to the next field, which will be
> set
>  by the subsequent call, continuing until all the fields have been
> set
> @@ -834,7 +834,7 @@ this method would be (without error-handling
> code)::
>         ret = synth_event_add_next_val(395, &trace_state);
>  
>  To assign the values in any order, synth_event_add_val() should be
> -used.  Each call is passed the same synth_trace_state object used in
> +used.  Each call is passed the same synth_event_trace_state object
> used in
>  the synth_event_trace_start(), along with the field name of the
> field
>  to set and the value to set it to.  The same sequence of calls as in
>  the above examples using this method would be (without error-
> handling
> @@ -856,7 +856,7 @@ can be used but not both at the same time.
>  
>  Finally, the event won't be actually traced until it's 'closed',
>  which is done using synth_event_trace_end(), which takes only the
> -struct synth_trace_state object used in the previous calls::
> +struct synth_event_trace_state object used in the previous calls::
>  
>         ret = synth_event_trace_end(&trace_state);
>  

