Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26C062809A4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 23:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733167AbgJAVuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 17:50:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:40844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727017AbgJAVuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 17:50:04 -0400
Received: from tzanussi-mobl (c-73-209-127-30.hsd1.il.comcast.net [73.209.127.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7ED03206A2;
        Thu,  1 Oct 2020 21:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601589003;
        bh=lCWPFgLryeT/feBp/nhMIdq7hCsz2t2xsDVMQeaK+rY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=SI85QdFhYNR/W7UERxGHQyB0u1/8eTrJgqy9aCyPprIegIaHCgWHMNNwctxsJSv8x
         /ukPm/M6POg65+PNX/6CeMkPu3/3o5Aru1Dj1lLAdobuGcxdV4SqdST+rgV1ozobkv
         SyBj8DlZcz1P9V7dUC3UNPxI7iTqfiSQRdTnOhek=
Message-ID: <ef7e77e6e1ab23dacb5bf43bf52f4131fcdec059.camel@kernel.org>
Subject: Re: [PATCH v2 2/3] tracing: Fix parse_synth_field() error handling
From:   Tom Zanussi <zanussi@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     rostedt@goodmis.org, axelrasmussen@google.com,
        linux-kernel@vger.kernel.org
Date:   Thu, 01 Oct 2020 16:50:02 -0500
In-Reply-To: <20201001142723.66b8f3d7d6f7df803044c567@kernel.org>
References: <cover.1601490263.git.zanussi@kernel.org>
         <15b1808e1466f378fcf206e61b57c802423f8319.1601490263.git.zanussi@kernel.org>
         <20201001142723.66b8f3d7d6f7df803044c567@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On Thu, 2020-10-01 at 14:27 +0900, Masami Hiramatsu wrote:
> Hi Tom,
> 
> On Wed, 30 Sep 2020 13:40:51 -0500
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > synth_field_size() returns either a positive size or an error (zero
> > or
> > a negative value). However, the existing code assumes the only
> > error
> > value is 0. It doesn't handle negative error codes, as it assigns
> > directly to field->size (a size_t; unsigned), thereby interpreting
> > the
> > error code as a valid size instead.
> > 
> > Do the test before assignment to field->size.
> 
> This looks good to me. And I guess it is a kind of bugfix which
> should be backported?
> (doesn't this need a Fixes tag?)

Yep, thanks for pointing that out.

> 
> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
> 

Thanks!

Tom

> Thank you,
> 
> > 
> > [ axelrasmussen@google.com: changelog addition, first paragraph
> > above ]
> > 
> > Signed-off-by: Tom Zanussi <zanussi@kernel.org>
> > ---
> >  kernel/trace/trace_events_synth.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_events_synth.c
> > b/kernel/trace/trace_events_synth.c
> > index a9cd7793f7ea..fa8a99828f41 100644
> > --- a/kernel/trace/trace_events_synth.c
> > +++ b/kernel/trace/trace_events_synth.c
> > @@ -465,6 +465,7 @@ static struct synth_field
> > *parse_synth_field(int argc, const char **argv,
> >  	struct synth_field *field;
> >  	const char *prefix = NULL, *field_type = argv[0], *field_name,
> > *array;
> >  	int len, ret = 0;
> > +	ssize_t size;
> >  
> >  	if (field_type[0] == ';')
> >  		field_type++;
> > @@ -520,11 +521,12 @@ static struct synth_field
> > *parse_synth_field(int argc, const char **argv,
> >  			field->type[len - 1] = '\0';
> >  	}
> >  
> > -	field->size = synth_field_size(field->type);
> > -	if (!field->size) {
> > +	size = synth_field_size(field->type);
> > +	if (size <= 0) {
> >  		ret = -EINVAL;
> >  		goto free;
> >  	}
> > +	field->size = size;
> >  
> >  	if (synth_field_is_string(field->type))
> >  		field->is_string = true;
> > -- 
> > 2.17.1
> > 
> 
> 

