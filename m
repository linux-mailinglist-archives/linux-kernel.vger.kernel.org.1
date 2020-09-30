Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C76F27F179
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 20:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729819AbgI3Skm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 14:40:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:50048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbgI3Skm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 14:40:42 -0400
Received: from tzanussi-mobl (c-98-220-232-140.hsd1.il.comcast.net [98.220.232.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30FE020708;
        Wed, 30 Sep 2020 18:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601491241;
        bh=Nw45fjTRE6xb20gbtpxGUyzJM+N++BLrf5o52RUDaZQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=a69fToStglxxjDs+cTAw2R0aCprljyGox26FvJX2OqeppzWp0pg9RnqhOmbvIa3sU
         EGYj4xXw0qE6/6ZtyOB9YAB/pRjTBHDJV3G6stb8TBGALl6z+Ydx3GyBFnQRHdM2B2
         8EXuV1mWXNHOUYSRwUJKT+HRvNVTc8IzxaAyyQdY=
Message-ID: <832ee35903df56214b864e8042f24c7358a99668.camel@kernel.org>
Subject: Re: [PATCH 2/3] tracing: Fix parse_synth_field() error handling
From:   Tom Zanussi <zanussi@kernel.org>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 30 Sep 2020 13:40:39 -0500
In-Reply-To: <CAJHvVcgBxBa_CHhRYGiwKEK=0RVzBFrNc3Z9YP+3M_N1PLXFTQ@mail.gmail.com>
References: <cover.1601410890.git.zanussi@kernel.org>
         <834e9060c2e7e3272e25d8bfc6e7566639c18aa9.1601410890.git.zanussi@kernel.org>
         <CAJHvVcgBxBa_CHhRYGiwKEK=0RVzBFrNc3Z9YP+3M_N1PLXFTQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Axel,

On Tue, 2020-09-29 at 14:56 -0700, Axel Rasmussen wrote:
> On Tue, Sep 29, 2020 at 1:33 PM Tom Zanussi <zanussi@kernel.org>
> wrote:
> > 
> > synth_field_size() returns either the size or an error.  However,
> > the
> > code assigns the return val to ssize_t which is unsigned, and then
> > tests whether it's less than 0, which it isn't so discards the
> > error.
> 
> I think the patch is correct, but the commit message is not.
> field->size is a size_t (unsigned), not an ssize_t (signed). I think
> this should say instead something like:
> 
> synth_field_size() returns either a positive size or an error (zero
> or
> a negative value). However, the existing code assumes the only error
> value is 0. It doesn't handle negative error codes, as it assigns
> directly to field->size (a size_t; unsigned), thereby interpreting
> the
> error code as a valid size instead.
> 

Yes, that's better - I used the above text in v2.

> > 
> > Do the test before assignment to field->size.
> > 
> > Signed-off-by: Tom Zanussi <zanussi@kernel.org>
> > ---
> >  kernel/trace/trace_events_synth.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_events_synth.c
> > b/kernel/trace/trace_events_synth.c
> > index a9cd7793f7ea..6e7282c7b530 100644
> > --- a/kernel/trace/trace_events_synth.c
> > +++ b/kernel/trace/trace_events_synth.c
> > @@ -465,6 +465,7 @@ static struct synth_field
> > *parse_synth_field(int argc, const char **argv,
> >         struct synth_field *field;
> >         const char *prefix = NULL, *field_type = argv[0],
> > *field_name, *array;
> >         int len, ret = 0;
> > +       int size;
> 
> Why not make this an ssize_t

Yep, makes sense.  Changed in v2, thanks!

Tom

> 
> > 
> >         if (field_type[0] == ';')
> >                 field_type++;
> > @@ -520,11 +521,12 @@ static struct synth_field
> > *parse_synth_field(int argc, const char **argv,
> >                         field->type[len - 1] = '\0';
> >         }
> > 
> > -       field->size = synth_field_size(field->type);
> > -       if (!field->size) {
> > +       size = synth_field_size(field->type);
> > +       if (size < 0) {
> >                 ret = -EINVAL;
> >                 goto free;
> >         }
> > +       field->size = size;
> > 
> >         if (synth_field_is_string(field->type))
> >                 field->is_string = true;
> > --
> > 2.17.1
> > 

