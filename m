Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C07F12E256D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 09:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgLXIWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 03:22:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:55342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbgLXIWc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 03:22:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7EF0E229CA;
        Thu, 24 Dec 2020 08:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608798111;
        bh=4dRh5dQ6U2WKiejoumD6EOTE1qJAxxffrUTkrxN/FVU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=a7Lzd/7qVa08eOkQCyJ+B86j+/ysxpUd+ZWAoO31L6Dr6HqCjl6apNaC4KxTsoqXQ
         VDAN0o3b2N3HkCAEteY69NmCpkTk3SsTsNybW7C2zYH+QLllThhRrNM/urbdIExY9e
         AQBRc6kTBQBL0MSOK5sdNeIizDbmPkutyUyhyu0s21L38Mc28KR0yORMZNc+fXzegc
         x63rM3EGX3EOChovXH5VxPIvaVVzdmpiqROd9iVlFALwgDlSmGXUk54Kgy4wYQCZln
         A6NLKDCiws4kbpEjvSvmEo9PEJ8an+9+vNF0ba2Y89oSHgEXSpMT2WYFfH3QCLqmIV
         0vtzNiiWqtzlA==
Date:   Thu, 24 Dec 2020 17:21:47 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, axelrasmussen@google.com,
        dan.carpenter@oracle.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/5] tracing: Rework synthetic event command parsing
Message-Id: <20201224172147.2952b2d20c9a974922a33f6f@kernel.org>
In-Reply-To: <48d21108d635e707ef135cac7fa0eaabc1cf5e9a.camel@kernel.org>
References: <cover.1608586464.git.zanussi@kernel.org>
        <cc39d3737ffa8b330c3d3754b062709dbc1c50f6.1608586464.git.zanussi@kernel.org>
        <20201222214259.464311df07a343de821db568@kernel.org>
        <48d21108d635e707ef135cac7fa0eaabc1cf5e9a.camel@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Dec 2020 17:17:27 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> Hi Masami,
> 
> On Tue, 2020-12-22 at 21:42 +0900, Masami Hiramatsu wrote:
> > Hi Tom,
> > 
> > On Mon, 21 Dec 2020 15:44:28 -0600
> > Tom Zanussi <zanussi@kernel.org> wrote:
> > 
> > 
> > > @@ -656,7 +651,6 @@ static struct synth_field
> > > *parse_synth_field(int argc, const char **argv,
> > >  
> > >  	size = synth_field_size(field->type);
> > >  	if (size < 0) {
> > > -		synth_err(SYNTH_ERR_INVALID_TYPE, errpos(field_type));
> > 
> > Why did you remove this error message?
> 
> It wasn't actually removed - it was just moved into the next patch, so
> is still there.  I'll move it back here to avoid confusion.
> 
> > 
> > [..]
> > > @@ -1228,26 +1189,47 @@ static int __create_synth_event(int argc,
> > > const char *name, const char **argv)
> > >  		goto out;
> > >  	}
> > >  
> > > -	for (i = 0; i < argc - 1; i++) {
> > > -		if (strcmp(argv[i], ";") == 0)
> > > -			continue;
> > > +	tmp_fields = saved_fields = kstrdup(raw_fields, GFP_KERNEL);
> > > +	if (!tmp_fields) {
> > > +		ret = -ENOMEM;
> > > +		goto out;
> > > +	}
> > > +
> > > +	while ((field_str = strsep(&tmp_fields, ";")) != NULL) {
> > >  		if (n_fields == SYNTH_FIELDS_MAX) {
> > >  			synth_err(SYNTH_ERR_TOO_MANY_FIELDS, 0);
> > >  			ret = -EINVAL;
> > >  			goto err;
> > >  		}
> > >  
> > > -		field = parse_synth_field(argc - i, &argv[i],
> > > &consumed);
> > > +		argv = argv_split(GFP_KERNEL, field_str, &argc);
> > > +		if (!argv) {
> > > +			ret = -ENOMEM;
> > > +			goto err;
> > > +		}
> > > +
> > > +		if (!argc)
> > > +			continue;
> > > +
> > > +		field = parse_synth_field(argc, argv, &consumed);
> > >  		if (IS_ERR(field)) {
> > > +			argv_free(argv);
> > >  			ret = PTR_ERR(field);
> > >  			goto err;
> > >  		}
> > > +
> > > +		argv_free(argv);
> > > +
> > > +		if (consumed < argc) {
> > > +			ret = -EINVAL;
> > > +			goto err;
> > > +		}
> > 
> > You can check the consumed < argc in parse_synth_field(), unless
> > you keep the backward compatibility - I think you can add an
> > inner loop for it, something like
> > 
> > while ((field_str = strsep(&tmp_fields, ";")) != NULL) {
> >     argv = argv_split(...);
> >     consumed = 0;
> >     while (argc > consumed) {
> >         // increment consumed in parse_synth_field()
> >         field = parse_synth_field(argc - consumed, argv + consumed,
> > &consumed);
> >         if (IS_ERR(field)) {...}
> > 
> >         fields[n_fields++] = field;
> >         if (n_fields == SYNTH_FIELDS_MAX) {...}
> >      }
> > 
> >     argv_free(argv);
> > }
> > 
> > what would you think?
> 
> Hmm, not sure this helps - there's only supposed to be one field per
> field_str and consumed returns either 2 or 3 depending on the field. 

I meant that this can be reused to support older syntax like
"myevent int foo unsigned long bar" without inserting semicolons. 

> consumed is only used to detect whether there were unused words and if
> so flag an error, rather than loop around to try to get another field.

If you drop the backward compatibility from *this* patch, we can just
check the "consumed < argc" in parse_synth_field() and remove "consumed"
from this function.

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
