Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 423F128612E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 16:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbgJGOYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 10:24:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:33784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728053AbgJGOYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 10:24:45 -0400
Received: from tzanussi-mobl (c-73-209-127-30.hsd1.il.comcast.net [73.209.127.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCA452076C;
        Wed,  7 Oct 2020 14:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602080685;
        bh=BzMiLG3o9KTsXHIs8zkROqkug2J5mhgSNQCw3AUVpTw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=uPlCvJQm/kBON6qQQV0enCmY3ZMzNjmt9tdsbGbjV+lF8qIPH+nc/1cvy3cRqsCH3
         bjwpZHYn9+ZwuQL9FSEGUMN4KEuuhigAGI4JsYkOgpXz3wAp23n7ry9Hh3xY9Cazpt
         jW74W47Yp9TTfCvYKipfEVCr/fOCreBbtEn+iA2M=
Message-ID: <7de01ef110454f0fdcfc8422260c9e61424a255e.camel@kernel.org>
Subject: Re: [PATCH v4 7/7] tracing: Change synthetic event string format to
 limit printed length
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     axelrasmussen@google.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 07 Oct 2020 09:24:43 -0500
In-Reply-To: <20201005181751.1338afbc@gandalf.local.home>
References: <cover.1601848695.git.zanussi@kernel.org>
         <b6bdb34e70d970e8026daa3503db6b8e5cdad524.1601848695.git.zanussi@kernel.org>
         <20201005181751.1338afbc@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Mon, 2020-10-05 at 18:17 -0400, Steven Rostedt wrote:
> On Sun,  4 Oct 2020 17:14:09 -0500
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > From: Steven Rostedt <rostedt@goodmis.org>
> > 
> > Change the format for printing synthetic field strings to limit the
> > length of the string printed even if it's not correctly terminated.
> > 
> > Description from Steve:
> > 
> > I also added this for a bit of paranoid, and probably should be a
> > separate patch, just to make sure if the string isn't nul
> > terminated,
> > this will keep it from bleeding pass the end of the string.
> 
> Just FYI. In the future, for something like this, you should still
> have
> your own Signed-off-by, as you are sending it (and part of the commit
> path). You could also add:
> 
> [ Need signed-off-by from Steven ]
> 
> Which I would have also added as well.
> 

Yeah, will do that next time.  Thanks for the tip.

Tom

> Thanks!
> 
> -- Steve
> 
> 
> > ---
> >  kernel/trace/trace_events_synth.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/trace/trace_events_synth.c
> > b/kernel/trace/trace_events_synth.c
> > index 24bc6d61aa40..742ce5f62d6d 100644
> > --- a/kernel/trace/trace_events_synth.c
> > +++ b/kernel/trace/trace_events_synth.c
> > @@ -234,7 +234,7 @@ static const char *synth_field_fmt(char *type)
> >  	else if (strcmp(type, "gfp_t") == 0)
> >  		fmt = "%x";
> >  	else if (synth_field_is_string(type))
> > -		fmt = "%s";
> > +		fmt = "%.*s";
> >  
> >  	return fmt;
> >  }
> > @@ -303,11 +303,13 @@ static enum print_line_t
> > print_synth_event(struct trace_iterator *iter,
> >  				str_field = (char *)entry +
> > data_offset;
> >  
> >  				trace_seq_printf(s, print_fmt, se-
> > >fields[i]->name,
> > +						 STR_VAR_LEN_MAX,
> >  						 str_field,
> >  						 i == se->n_fields - 1
> > ? "" : " ");
> >  				n_u64++;
> >  			} else {
> >  				trace_seq_printf(s, print_fmt, se-
> > >fields[i]->name,
> > +						 STR_VAR_LEN_MAX,
> >  						 (char *)&entry-
> > >fields[n_u64],
> >  						 i == se->n_fields - 1
> > ? "" : " ");
> >  				n_u64 += STR_VAR_LEN_MAX / sizeof(u64);
> 
> 

