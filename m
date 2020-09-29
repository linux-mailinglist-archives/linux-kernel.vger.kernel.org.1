Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04B6727DB78
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 00:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbgI2WJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 18:09:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:40670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727922AbgI2WJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 18:09:31 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 129842083B;
        Tue, 29 Sep 2020 22:09:28 +0000 (UTC)
Date:   Tue, 29 Sep 2020 18:09:27 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] tracing: Add support for dynamic strings to
 synthetic events
Message-ID: <20200929180927.17b6b78f@gandalf.local.home>
In-Reply-To: <CAJHvVch+VA4oHafZzf5HRAwW321hKJKsTYC8mr_89yGjnUx8aw@mail.gmail.com>
References: <cover.1601410890.git.zanussi@kernel.org>
        <a296c3ead3da5f55e29eda2f40d69847d745071b.1601410890.git.zanussi@kernel.org>
        <CAJHvVch+VA4oHafZzf5HRAwW321hKJKsTYC8mr_89yGjnUx8aw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Sep 2020 15:01:59 -0700
Axel Rasmussen <axelrasmussen@google.com> wrote:

> >                 event->fields[i]->offset = n_u64;
> >
> > -               if (event->fields[i]->is_string) {
> > +               if (event->fields[i]->is_string && !event->fields[i]->is_dynamic) {
> >                         offset += STR_VAR_LEN_MAX;
> >                         n_u64 += STR_VAR_LEN_MAX / sizeof(u64);
> >                 } else {
> > @@ -139,6 +139,9 @@ static int synth_field_string_size(char *type)
> >         if (len > 3)
> >                 return -EINVAL;
> >
> > +       if (len == 0)
> > +               return 0; /* variable-length string */
> > +
> >         strncpy(buf, start, len);
> >         buf[len] = '\0';
> >
> > @@ -290,10 +293,25 @@ static enum print_line_t print_synth_event(struct trace_iterator *iter,
> >
> >                 /* parameter values */
> >                 if (se->fields[i]->is_string) {
> > -                       trace_seq_printf(s, print_fmt, se->fields[i]->name,
> > -                                        (char *)&entry->fields[n_u64],
> > -                                        i == se->n_fields - 1 ? "" : " ");
> > -                       n_u64 += STR_VAR_LEN_MAX / sizeof(u64);
> > +                       if (se->fields[i]->is_dynamic) {
> > +                               u32 offset, data_offset;
> > +                               char *str_field;
> > +
> > +                               offset = (u32)entry->fields[n_u64];
> > +                               data_offset = offset & 0xffff;
> > +
> > +                               str_field = (char *)entry + data_offset;  
> 
> Is it better to re-use __get_str from include/trace/trace_events.h
> instead of writing this out directly?
> 
> > +
> > +                               trace_seq_printf(s, print_fmt, se->fields[i]->name,
> > +                                                str_field,
> > +                                                i == se->n_fields - 1 ? "" : " ");
> > +                               n_u64++;
> > +                       } else {
> > +                               trace_seq_printf(s, print_fmt, se->fields[i]->name,
> > +                                                (char *)&entry->fields[n_u64],
> > +                                                i == se->n_fields - 1 ? "" : " ");
> > +                               n_u64 += STR_VAR_LEN_MAX / sizeof(u64);
> > +                       }
> >                 } else {
> >                         struct trace_print_flags __flags[] = {
> >                             __def_gfpflag_names, {-1, NULL} };
> > @@ -325,16 +343,52 @@ static struct trace_event_functions synth_event_funcs = {
> >         .trace          = print_synth_event
> >  };
> >
> > +static unsigned int trace_string(struct synth_trace_event *entry,
> > +                                struct synth_event *event,
> > +                                char *str_val,
> > +                                bool is_dynamic,
> > +                                unsigned int data_size,
> > +                                unsigned int *n_u64)
> > +{
> > +       unsigned int len = 0;
> > +       char *str_field;
> > +
> > +       if (is_dynamic) {
> > +               u32 data_offset;
> > +
> > +               data_offset = offsetof(typeof(*entry), fields);
> > +               data_offset += event->n_u64 * sizeof(u64);
> > +               data_offset += data_size;
> > +
> > +               str_field = (char *)entry + data_offset;
> > +
> > +               len = strlen(str_val) + 1;
> > +               strscpy(str_field, str_val, len);
> > +
> > +               data_offset |= len << 16;
> > +               *(u32 *)&entry->fields[*n_u64] = data_offset;  
> 
> Similar thing here, is it possible to reuse __dynamic_array or __string?

Interesting idea.

I'd prefer to keep it broken out for this patch set, and then we could look
at incorporating this file to use the macros of <trace/trace_event.h>.

But I much rather have that be a separate patch that does that as an
enhancement than to include it in this file doing more work.

-- Steve


> 
> > +
> > +               (*n_u64)++;
> > +       } else {
> > +               str_field = (char *)&entry->fields[*n_u64];
> > +
> > +               strscpy(str_field, str_val, STR_VAR_LEN_MAX);
> > +               (*n_u64) += STR_VAR_LEN_MAX / sizeof(u64);
> > +       }
> > +
> > +       return len;
> > +}
> > +
> >  static n
