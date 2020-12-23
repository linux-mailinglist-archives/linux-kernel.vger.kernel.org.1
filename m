Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07E4B2E22A9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 00:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbgLWXSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 18:18:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:35168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726611AbgLWXSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 18:18:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 05617223E0;
        Wed, 23 Dec 2020 23:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608765449;
        bh=A3WSiGWqc+kIrTK8z3wKHj/uIm8ph2fAerx7FVPkG3o=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=iH27+XaAE2Ku8KEaiAUIhgPQsmm0uu/s92aOFZovdjjmvfNvSxkPjVKmIH5cTs3G0
         RW7A+cbWNgZlNcGp6J3JaUo0bmx7+vxqECHM9unbGK4Yw8BRHTzNcUdP2yciJ0NmhE
         IB/JP5m4mLw1ZPVvSsjUhNoeN3gT7d4cvQgB6omS/OeY6X1WYItXfZ2KAsV7tVTKPE
         0Yn+aGDhIkaTg9n+ZrNiLoW3uSYLGUYt0b8qVIsdTyDgT9XOCbJ3PvEMtAEUQn7/LQ
         cDADy1HLRGbPECnsUnHKPpf/re25VYf7wD8BhjlMbPbx9x/v4fPGfzKDzyg/YXOERS
         Hj7YX70cjMvTA==
Message-ID: <48d21108d635e707ef135cac7fa0eaabc1cf5e9a.camel@kernel.org>
Subject: Re: [PATCH v5 2/5] tracing: Rework synthetic event command parsing
From:   Tom Zanussi <zanussi@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     rostedt@goodmis.org, axelrasmussen@google.com,
        dan.carpenter@oracle.com, linux-kernel@vger.kernel.org
Date:   Wed, 23 Dec 2020 17:17:27 -0600
In-Reply-To: <20201222214259.464311df07a343de821db568@kernel.org>
References: <cover.1608586464.git.zanussi@kernel.org>
         <cc39d3737ffa8b330c3d3754b062709dbc1c50f6.1608586464.git.zanussi@kernel.org>
         <20201222214259.464311df07a343de821db568@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On Tue, 2020-12-22 at 21:42 +0900, Masami Hiramatsu wrote:
> Hi Tom,
> 
> On Mon, 21 Dec 2020 15:44:28 -0600
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> 
> > @@ -656,7 +651,6 @@ static struct synth_field
> > *parse_synth_field(int argc, const char **argv,
> >  
> >  	size = synth_field_size(field->type);
> >  	if (size < 0) {
> > -		synth_err(SYNTH_ERR_INVALID_TYPE, errpos(field_type));
> 
> Why did you remove this error message?

It wasn't actually removed - it was just moved into the next patch, so
is still there.  I'll move it back here to avoid confusion.

> 
> [..]
> > @@ -1228,26 +1189,47 @@ static int __create_synth_event(int argc,
> > const char *name, const char **argv)
> >  		goto out;
> >  	}
> >  
> > -	for (i = 0; i < argc - 1; i++) {
> > -		if (strcmp(argv[i], ";") == 0)
> > -			continue;
> > +	tmp_fields = saved_fields = kstrdup(raw_fields, GFP_KERNEL);
> > +	if (!tmp_fields) {
> > +		ret = -ENOMEM;
> > +		goto out;
> > +	}
> > +
> > +	while ((field_str = strsep(&tmp_fields, ";")) != NULL) {
> >  		if (n_fields == SYNTH_FIELDS_MAX) {
> >  			synth_err(SYNTH_ERR_TOO_MANY_FIELDS, 0);
> >  			ret = -EINVAL;
> >  			goto err;
> >  		}
> >  
> > -		field = parse_synth_field(argc - i, &argv[i],
> > &consumed);
> > +		argv = argv_split(GFP_KERNEL, field_str, &argc);
> > +		if (!argv) {
> > +			ret = -ENOMEM;
> > +			goto err;
> > +		}
> > +
> > +		if (!argc)
> > +			continue;
> > +
> > +		field = parse_synth_field(argc, argv, &consumed);
> >  		if (IS_ERR(field)) {
> > +			argv_free(argv);
> >  			ret = PTR_ERR(field);
> >  			goto err;
> >  		}
> > +
> > +		argv_free(argv);
> > +
> > +		if (consumed < argc) {
> > +			ret = -EINVAL;
> > +			goto err;
> > +		}
> 
> You can check the consumed < argc in parse_synth_field(), unless
> you keep the backward compatibility - I think you can add an
> inner loop for it, something like
> 
> while ((field_str = strsep(&tmp_fields, ";")) != NULL) {
>     argv = argv_split(...);
>     consumed = 0;
>     while (argc > consumed) {
>         // increment consumed in parse_synth_field()
>         field = parse_synth_field(argc - consumed, argv + consumed,
> &consumed);
>         if (IS_ERR(field)) {...}
> 
>         fields[n_fields++] = field;
>         if (n_fields == SYNTH_FIELDS_MAX) {...}
>      }
> 
>     argv_free(argv);
> }
> 
> what would you think?

Hmm, not sure this helps - there's only supposed to be one field per
field_str and consumed returns either 2 or 3 depending on the field. 
consumed is only used to detect whether there were unused words and if
so flag an error, rather than loop around to try to get another field.

> 
> > +
> >  		fields[n_fields++] = field;
> > -		i += consumed - 1;
> >  	}
> >  
> > -	if (i < argc && strcmp(argv[i], ";") != 0) {
> > -		synth_err(SYNTH_ERR_INVALID_FIELD, errpos(argv[i]));
> > +	if (n_fields == 0) {
> > +		synth_err(SYNTH_ERR_CMD_INCOMPLETE, 0);
> >  		ret = -EINVAL;
> >  		goto err;
> >  	}
> > @@ -1266,6 +1248,8 @@ static int __create_synth_event(int argc,
> > const char *name, const char **argv)
> >   out:
> >  	mutex_unlock(&event_mutex);
> >  
> > +	kfree(saved_fields);
> > +
> >  	return ret;
> >   err:
> >  	for (i = 0; i < n_fields; i++)
> > @@ -1385,29 +1369,35 @@ EXPORT_SYMBOL_GPL(synth_event_delete);
> >  
> >  static int create_or_delete_synth_event(const char *raw_command)
> >  {
> > -	char **argv, *name = NULL;
> > -	int argc = 0, ret = 0;
> > +	char *name = NULL, *fields, *p;
> > +	int ret = 0;
> >  
> > -	argv = argv_split(GFP_KERNEL, raw_command, &argc);
> > -	if (!argv)
> > -		return -ENOMEM;
> > +	raw_command = skip_spaces(raw_command);
> > +	if (raw_command[0] == '\0')
> > +		return ret;
> >  
> > -	if (!argc)
> > -		goto free;
> > +	last_cmd_set(raw_command);
> >  
> > -	name = argv[0];
> > +	p = strpbrk(raw_command, " \t");
> > +	if (!p)
> > +		return -EINVAL;
> 
> Hmm, this may drop the ability to delete an event with "!name",
> it always requires some spaces after the name.
> 

Yes, good point, will fix that and also add a test case for just !name.

Thanks,

Tom

> Thank you,
> 
> 

