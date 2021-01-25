Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 446083027C8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 17:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730606AbhAYQ0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 11:26:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:46912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730711AbhAYQZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 11:25:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 09DA3221E3;
        Mon, 25 Jan 2021 16:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611591904;
        bh=llvoHSgfL3XbhsAbsTymXEXhCLnj5iJ+UioJ9v+HXkw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=mS8Q57X2z/ECGY0lE32ctQVT4gMiBmJdi4S8LoRfgd0rYnABwzwUV6ScQ+678ItRk
         z2oZdORJ5KTZcNcsXxO9maF+QqOJgxcQRCwX+5JXe7nFHQEPGVxKns6S2VUyGMHfbA
         EUqoFjauvdPb3jSfymr7vuRf4XxlEJz3uPVIbdBQ6z/YkSukqCDir5BQND0xmFdz0Y
         tiIimnG0Pi3gMhatLFc8JLacO5rOCbdCQ2dwEd1AYpYKlIXJf+BR62/kyNKUDQ1CBT
         K9fb6h0FuvsrKbqWAODIfIpmcQp4bYCakndsAyzCdiy5DI1IUB8E/cNccHTtOnxohX
         qE5PnIJC96mAQ==
Message-ID: <76b2feaa5198dffb7646a8c4020136f44c3cd9b6.camel@kernel.org>
Subject: Re: [PATCH v6 4/6] tracing: Add a backward-compatibility check for
 synthetic event creation
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     axelrasmussen@google.com, mhiramat@kernel.org,
        dan.carpenter@oracle.com, linux-kernel@vger.kernel.org
Date:   Mon, 25 Jan 2021 10:25:02 -0600
In-Reply-To: <20210122161255.58a7e704@gandalf.local.home>
References: <cover.1611243025.git.zanussi@kernel.org>
         <c4e79b84ae0bee606fd89c8578ffbcb4ceb3010a.1611243025.git.zanussi@kernel.org>
         <20210122161255.58a7e704@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Fri, 2021-01-22 at 16:12 -0500, Steven Rostedt wrote:
> On Thu, 21 Jan 2021 11:01:07 -0600
> Tom Zanussi <zanussi@kernel.org> wrote:
> > --- a/kernel/trace/trace_events_synth.c
> > +++ b/kernel/trace/trace_events_synth.c
> > @@ -580,11 +580,18 @@ static void free_synth_field(struct
> > synth_field *field)
> >  	kfree(field);
> >  }
> >  
> > -static struct synth_field *parse_synth_field(int argc, char
> > **argv)
> > +static int check_field_version(const char *prefix, const char
> > *field_type,
> > +			       const char *field_name)
> > +{
> 
> This needs a comment:
> 
> 	/*
> 	 * For backward compatibility, the old format did not require
> 	 * semicolons, and not to break user space, that old format
> must
> 	 * still work. If a new feature is added, then the format that
> uses
> 	 * the new feature will be required to have semicolons, as
> nothing
> 	 * that uses the old format would be using the new, yet to be
> 	 * created, feature. When a new feature is added, this will
> detect
> 	 * it, and return a number greater than 1, and require the
> format
> 	 * to use semicolons.
> 	 */
> 
> Or something to that effect.
> 

OK, will add better comments in the code about how this is meant to
work.

Thanks,

Tom

> > +	return 1;
> > +}
> > +
> > +static struct synth_field *parse_synth_field(int argc, char
> > **argv,
> > +					     int *consumed, int
> > *field_version)
> >  {
> >  	const char *prefix = NULL, *field_type = argv[0], *field_name,
> > *array;
> > -	int len, consumed, ret = -ENOMEM;
> >  	struct synth_field *field;
> > +	int len, ret = -ENOMEM;
> >  	struct seq_buf s;
> >  	ssize_t size;
> >  
> > @@ -596,15 +603,10 @@ static struct synth_field
> > *parse_synth_field(int argc, char **argv)
> >  		prefix = "unsigned ";
> >  		field_type = argv[1];
> >  		field_name = argv[2];
> > -		consumed = 3;
> > +		*consumed += 3;
> >  	} else {
> >  		field_name = argv[1];
> > -		consumed = 2;
> > -	}
> > -
> > -	if (consumed < argc) {
> > -		synth_err(SYNTH_ERR_INVALID_FIELD, errpos(field_type));
> > -		return ERR_PTR(-EINVAL);
> > +		*consumed += 2;
> >  	}
> >  
> >  	if (!field_name) {
> > @@ -612,6 +614,8 @@ static struct synth_field
> > *parse_synth_field(int argc, char **argv)
> >  		return ERR_PTR(-EINVAL);
> >  	}
> >  
> > +	*field_version = check_field_version(prefix, field_type,
> > field_name);
> > +
> >  	field = kzalloc(sizeof(*field), GFP_KERNEL);
> >  	if (!field)
> >  		return ERR_PTR(-ENOMEM);
> > @@ -1167,6 +1171,7 @@ static int __create_synth_event(const char
> > *name, const char *raw_fields)
> >  {
> >  	char **argv, *field_str, *tmp_fields, *saved_fields = NULL;
> >  	struct synth_field *field, *fields[SYNTH_FIELDS_MAX];
> > +	int consumed, cmd_version = 1, n_fields_this_loop;
> >  	int i, argc, n_fields = 0, ret = 0;
> >  	struct synth_event *event = NULL;
> >  
> > @@ -1214,21 +1219,46 @@ static int __create_synth_event(const char
> > *name, const char *raw_fields)
> >  		if (!argc)
> >  			continue;
> >  
> > -		field = parse_synth_field(argc, argv);
> > -		if (IS_ERR(field)) {
> > -			argv_free(argv);
> > -			ret = PTR_ERR(field);
> > -			goto err;
> > -		}
> > +		n_fields_this_loop = 0;
> > +		consumed = 0;
> > +		while (argc > consumed) {
> > +			int field_version;
> > +
> > +			field = parse_synth_field(argc - consumed,
> > +						  argv + consumed,
> > &consumed,
> > +						  &field_version);
> > +			if (IS_ERR(field)) {
> > +				argv_free(argv);
> > +				ret = PTR_ERR(field);
> > +				goto err;
> > +			}
> >  
> > -		argv_free(argv);
> > +			if (field_version > cmd_version)
> > +				cmd_version = field_version;
> > +
> 
> There needs to be some comments here to explain what the versioning
> means.
> 
> -- Steve
> 
> 
> > +			if (cmd_version > 1 && n_fields_this_loop >= 1)
> > {
> > +				synth_err(SYNTH_ERR_INVALID_CMD,
> > errpos(field_str));
> > +				ret = -EINVAL;
> > +				goto err;
> > +			}
> > +
> > +			fields[n_fields++] = field;
> > +			if (n_fields == SYNTH_FIELDS_MAX) {
> > +				synth_err(SYNTH_ERR_TOO_MANY_FIELDS,
> > 0);
> > +				ret = -EINVAL;
> > +				goto err;
> > +			}
> > +
> > +			n_fields_this_loop++;
> > +		}
> >  
> > -		fields[n_fields++] = field;
> > -		if (n_fields == SYNTH_FIELDS_MAX) {
> > -			synth_err(SYNTH_ERR_TOO_MANY_FIELDS, 0);
> > +		if (consumed < argc) {
> > +			synth_err(SYNTH_ERR_INVALID_CMD, 0);
> >  			ret = -EINVAL;
> >  			goto err;
> >  		}
> > +
> > +		argv_free(argv);
> >  	}
> >  
> >  	if (n_fields == 0) {
> 
> 

