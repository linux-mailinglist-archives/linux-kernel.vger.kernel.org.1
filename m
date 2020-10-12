Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC8328BC18
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 17:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390029AbgJLPhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 11:37:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:42460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389121AbgJLPhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 11:37:22 -0400
Received: from tzanussi-mobl (c-73-209-127-30.hsd1.il.comcast.net [73.209.127.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AD6420575;
        Mon, 12 Oct 2020 15:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602517041;
        bh=UDFXDkJshI9WAzh09i45Ygqd33LHOwbKvPeaq9Kg3zc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=iZIzFOBIQ2g6VoIejkNSZN7V2YtZ+gspaiPktmn6VwijFUupqzHIJp+Wp4EstDCrs
         GEjUgcnwfAPX9GWZA+WlD2aZ3LWzYSqd2W4yKBhZxYgDNeXN06ePgT21h0/Hc8gwg7
         6pkzNpixu5G9PyhiQqr/WvvyTI6Vgo9+fxdc++6g=
Message-ID: <1a3863252345703b469821f128ecbac6bc55e1c0.camel@kernel.org>
Subject: Re: [PATCH 1/5] tracing: Don't show dynamic string internals in
 synthetic event description
From:   Tom Zanussi <zanussi@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     rostedt@goodmis.org, axelrasmussen@google.com,
        linux-kernel@vger.kernel.org
Date:   Mon, 12 Oct 2020 10:37:19 -0500
In-Reply-To: <20201011000344.4056fd1b0e8a7e48f2677ac0@kernel.org>
References: <cover.1602255803.git.zanussi@kernel.org>
         <b3b7baf7813298a5ede4ff02e2e837b91c05a724.1602255803.git.zanussi@kernel.org>
         <20201011000344.4056fd1b0e8a7e48f2677ac0@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On Sun, 2020-10-11 at 00:03 +0900, Masami Hiramatsu wrote:
> Hi Tom,
> 
> On Fri,  9 Oct 2020 10:17:07 -0500
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > For synthetic event dynamic fields, the type contains "__data_loc",
> > which is basically an internal part of the type which is only meant
> > to
> > be displayed in the format, not in the event description itself,
> > which
> > is confusing to users since they can't use __data_loc on the
> > command-line to define an event field, which printing it would lead
> > them to believe.
> > 
> > So filter it out from the description, while leaving it in the
> > type.
> > 
> 
> OK, I confirmed this removes __data_loc from synth_events interface.
> However, I also found another issue.
> 
>   /sys/kernel/debug/tracing # echo "myevent char str[]; int v" >>
> synthetic_events  
>   /sys/kernel/debug/tracing # cat synthetic_events 
>   myevent	char[]; str; int v
> 
> It seems that the type "char[]" includes ";" as a type, this results
> 

Yeah, this isn't a result of this patchset - it's a different bug which
I'll submit a new fix for.  Basically in the array case it doesn't
effectively strip off trailing characters when creating the array type.

Thanks,

Tom

> 
>   /sys/kernel/debug/tracing # cat events/synthetic/myevent/format 
>   name: myevent
>   ID: 1220
>   format:
> 	field:unsigned short common_type;	offset:0;	size:2;	signe
> d:0;
> 	field:unsigned char common_flags;	offset:2;	size:1;	signe
> d:0;
> 	field:unsigned char common_preempt_count;	offset:3;	size:
> 1;	signed:0;
> 	field:int common_pid;	offset:4;	size:4;	signed:1;
> 
> 	field:__data_loc char[]; str;	offset:8;	size:8;	signe
> d:1;
> 	field:int v;	offset:16;	size:4;	signed:1;
> 
>   print fmt: "str=%.*s, v=%d", __get_str(str), REC->v
> 
> 
> As you can see, the field type has ";" in format file too. This will
> prevent
> parsing event information correctly.
> I also try to remove ";" as below, it seems to work correctly.
> 
>   /sys/kernel/debug/tracing # echo "myevent char[] str; int v" >>
> synthetic_events 
>   /sys/kernel/debug/tracing # cat events/synthetic/myevent/format 
>   name: myevent
>   ID: 1221
>   format:
> 	field:unsigned short common_type;	offset:0;	size:2;	signe
> d:0;
> 	field:unsigned char common_flags;	offset:2;	size:1;	signe
> d:0;
> 	field:unsigned char common_preempt_count;	offset:3;	size:
> 1;	signed:0;
> 	field:int common_pid;	offset:4;	size:4;	signed:1;
> 
> 	field:__data_loc char[] str;	offset:8;	size:8;	signe
> d:1;
> 	field:int v;	offset:16;	size:4;	signed:1;
> 
>   print fmt: "str=%.*s, v=%d", __get_str(str), REC->v
> 
> 
> Thank you,
> 
> > Reported-by: Masami Hiramatsu <mhiramat@kernel.org>
> > Signed-off-by: Tom Zanussi <zanussi@kernel.org>
> > ---
> >  kernel/trace/trace_events_synth.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/trace/trace_events_synth.c
> > b/kernel/trace/trace_events_synth.c
> > index 3b2dcc42b8ee..b19e2f4159ab 100644
> > --- a/kernel/trace/trace_events_synth.c
> > +++ b/kernel/trace/trace_events_synth.c
> > @@ -1867,14 +1867,22 @@ static int __synth_event_show(struct
> > seq_file *m, struct synth_event *event)
> >  {
> >  	struct synth_field *field;
> >  	unsigned int i;
> > +	char *type, *t;
> >  
> >  	seq_printf(m, "%s\t", event->name);
> >  
> >  	for (i = 0; i < event->n_fields; i++) {
> >  		field = event->fields[i];
> >  
> > +		type = field->type;
> > +		t = strstr(type, "__data_loc");
> > +		if (t) { /* __data_loc belongs in format but not event
> > desc */
> > +			t += sizeof("__data_loc");
> > +			type = t;
> > +		}
> > +
> >  		/* parameter values */
> > -		seq_printf(m, "%s %s%s", field->type, field->name,
> > +		seq_printf(m, "%s %s%s", type, field->name,
> >  			   i == event->n_fields - 1 ? "" : "; ");
> >  	}
> >  
> > -- 
> > 2.17.1
> > 
> 
> 

