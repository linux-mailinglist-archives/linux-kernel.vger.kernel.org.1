Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F327C3027B5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 17:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730535AbhAYQWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 11:22:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:44936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730418AbhAYQUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 11:20:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B0BAF22AAA;
        Mon, 25 Jan 2021 16:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611591604;
        bh=IFCd/a40LfbI9sYQ3IA+ME16kG0Vr1F0TTsO2JGtIXw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=FTyQ4S7Qd6y1i4PafI8lY3OvEXMx2s+6jQuFHIxy2ljj8HlBEqj7WymJBb+LW/JBm
         nQx1eDbYXsZ3BWmRkAQ/ozWJLuFySgqe0pO+EOFvGMkfKxuw03l2aed4j6nnhPC24d
         ap/s/fgcdktqqKxExwxlAANgXUgM6ik0Wb53+Um+ZwUGnnS5Fe4Z4ioHyMowoXe9WJ
         97kGePJEQg/d/Ub7+ICCRbXsttJS8zC6Lf2f/WaKrWRsQrovIxYKZZpfiSkmuaTyiy
         8aniBeGf671F034iLFW1XME3g4Ub20j8NzPwqnLEBAc6dtsLxtBxtcwP4YQ8K4+Jui
         MlNqMKQ3OM0zA==
Message-ID: <b671a1ad7906be389190fd98df6112de87259f91.camel@kernel.org>
Subject: Re: [PATCH v6 3/6] tracing: Update synth command errors
From:   Tom Zanussi <zanussi@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     rostedt@goodmis.org, axelrasmussen@google.com,
        dan.carpenter@oracle.com, linux-kernel@vger.kernel.org
Date:   Mon, 25 Jan 2021 10:20:02 -0600
In-Reply-To: <20210122222311.7559b4e71d1dc3ce60fa3fcc@kernel.org>
References: <cover.1611243025.git.zanussi@kernel.org>
         <18090ccadf2c33b03e4eaad429867d7088782721.1611243025.git.zanussi@kernel.org>
         <20210122222311.7559b4e71d1dc3ce60fa3fcc@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-01-22 at 22:23 +0900, Masami Hiramatsu wrote:
> Hi Tom,
> 
> On Thu, 21 Jan 2021 11:01:06 -0600
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > Since array types are handled differently, errors referencing them
> > also need to be handled differently.  Add and use a new
> > INVALID_ARRAY_SPEC error.  Also add INVALID_CMD and INVALID_DYN_CMD
> > to
> > catch and display the correct form for badly-formed commands, which
> > can also be used in place of CMD_INCOMPLETE, which is removed, and
> > remove CMD_TOO_LONG, since it's no longer used.
> 
> OK, so this will add new errors for precise error logging.
> 
> > 
> > Signed-off-by: Tom Zanussi <zanussi@kernel.org>
> > ---
> >  kernel/trace/trace_events_synth.c | 72
> > +++++++++++++++++++++++++++----
> >  1 file changed, 63 insertions(+), 9 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_events_synth.c
> > b/kernel/trace/trace_events_synth.c
> > index a79c17b97add..dd141ee6b3fc 100644
> > --- a/kernel/trace/trace_events_synth.c
> > +++ b/kernel/trace/trace_events_synth.c
> > @@ -23,13 +23,14 @@
> >  #undef ERRORS
> >  #define ERRORS	\
> >  	C(BAD_NAME,		"Illegal name"),		\
> > -	C(CMD_INCOMPLETE,	"Incomplete command"),		\
> > +	C(INVALID_CMD,		"Command must be of the form:
> > <name> field[;field] ..."),\
> > +	C(INVALID_DYN_CMD,	"Command must be of the form: s or
> > -:[synthetic/]<name> field[;field] ..."),\
> >  	C(EVENT_EXISTS,		"Event already exists"),	\
> >  	C(TOO_MANY_FIELDS,	"Too many fields"),		\
> >  	C(INCOMPLETE_TYPE,	"Incomplete type"),		\
> >  	C(INVALID_TYPE,		"Invalid type"),		\
> > -	C(INVALID_FIELD,	"Invalid field"),		\
> > -	C(CMD_TOO_LONG,		"Command too long"),
> > +	C(INVALID_FIELD,        "Invalid field"),		\
> > +	C(INVALID_ARRAY_SPEC,	"Invalid array specification"),
> >  
> >  #undef C
> >  #define C(a, b)		SYNTH_ERR_##a
> > @@ -655,7 +656,10 @@ static struct synth_field
> > *parse_synth_field(int argc, char **argv)
> >  
> >  	size = synth_field_size(field->type);
> >  	if (size < 0) {
> > -		synth_err(SYNTH_ERR_INVALID_TYPE, errpos(field_type));
> > +		if (array)
> > +			synth_err(SYNTH_ERR_INVALID_ARRAY_SPEC,
> > errpos(field_name));
> > +		else
> > +			synth_err(SYNTH_ERR_INVALID_TYPE,
> > errpos(field_type));
> >  		ret = -EINVAL;
> >  		goto free;
> >  	} else if (size == 0) {
> > @@ -1176,7 +1180,7 @@ static int __create_synth_event(const char
> > *name, const char *raw_fields)
> >  	mutex_lock(&event_mutex);
> >  
> >  	if (name[0] == '\0') {
> > -		synth_err(SYNTH_ERR_CMD_INCOMPLETE, 0);
> > +		synth_err(SYNTH_ERR_INVALID_CMD, 0);
> >  		ret = -EINVAL;
> >  		goto out;
> >  	}
> > @@ -1228,7 +1232,7 @@ static int __create_synth_event(const char
> > *name, const char *raw_fields)
> >  	}
> >  
> >  	if (n_fields == 0) {
> > -		synth_err(SYNTH_ERR_CMD_INCOMPLETE, 0);
> > +		synth_err(SYNTH_ERR_INVALID_CMD, 0);
> >  		ret = -EINVAL;
> >  		goto err;
> >  	}
> > @@ -1366,6 +1370,40 @@ int synth_event_delete(const char
> > *event_name)
> >  }
> >  EXPORT_SYMBOL_GPL(synth_event_delete);
> >  
> > +static int check_command(const char *raw_command)
> > +{
> > +	char **argv = NULL, *cmd, *saved_cmd, *name_and_field;
> > +	int argc, ret = 0;
> > +
> > +	cmd = saved_cmd = kstrdup(raw_command, GFP_KERNEL);
> > +	if (!cmd)
> > +		return -ENOMEM;
> > +
> > +	name_and_field = strsep(&cmd, ";");
> > +	if (!name_and_field) {
> > +		ret = -EINVAL;
> > +		goto free;
> > +	}
> > +
> > +	if (name_and_field[0] == '!')
> > +		goto free;
> > +
> > +	argv = argv_split(GFP_KERNEL, name_and_field, &argc);
> > +	if (!argv) {
> > +		ret = -ENOMEM;
> > +		goto free;
> > +	}
> > +
> > +	if (argc < 3)
> > +		ret = -EINVAL;
> > +free:
> > +	kfree(saved_cmd);
> > +	if (argv)
> > +		argv_free(argv);
> > +
> > +	return ret;
> > +}
> 
> But I'm not sure why this (yet another parser) is needed. What you
> are expecting
> for this check_command()? Could you tell me some examples?
> 

This is just a common function to check we even have the possibility of
a valid command.  It will catch things right off the top like

  # echo 'myevent' >> synthetic_events

or

  # echo 'myevent int'  >> synthetic events

You're right, it's confusing to have it in this patch, since it really
belongs in the rework patch - I'll move it there.

Thanks,

Tom


> Thank you,
> 
> 
> 

