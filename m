Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73F1F300EAA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 22:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbhAVVOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 16:14:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:53058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730526AbhAVVNq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 16:13:46 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8E8E23A7A;
        Fri, 22 Jan 2021 21:12:56 +0000 (UTC)
Date:   Fri, 22 Jan 2021 16:12:55 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     axelrasmussen@google.com, mhiramat@kernel.org,
        dan.carpenter@oracle.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/6] tracing: Add a backward-compatibility check for
 synthetic event creation
Message-ID: <20210122161255.58a7e704@gandalf.local.home>
In-Reply-To: <c4e79b84ae0bee606fd89c8578ffbcb4ceb3010a.1611243025.git.zanussi@kernel.org>
References: <cover.1611243025.git.zanussi@kernel.org>
        <c4e79b84ae0bee606fd89c8578ffbcb4ceb3010a.1611243025.git.zanussi@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jan 2021 11:01:07 -0600
Tom Zanussi <zanussi@kernel.org> wrote:
> --- a/kernel/trace/trace_events_synth.c
> +++ b/kernel/trace/trace_events_synth.c
> @@ -580,11 +580,18 @@ static void free_synth_field(struct synth_field *field)
>  	kfree(field);
>  }
>  
> -static struct synth_field *parse_synth_field(int argc, char **argv)
> +static int check_field_version(const char *prefix, const char *field_type,
> +			       const char *field_name)
> +{

This needs a comment:

	/*
	 * For backward compatibility, the old format did not require
	 * semicolons, and not to break user space, that old format must
	 * still work. If a new feature is added, then the format that uses
	 * the new feature will be required to have semicolons, as nothing
	 * that uses the old format would be using the new, yet to be
	 * created, feature. When a new feature is added, this will detect
	 * it, and return a number greater than 1, and require the format
	 * to use semicolons.
	 */

Or something to that effect.

> +	return 1;
> +}
> +
> +static struct synth_field *parse_synth_field(int argc, char **argv,
> +					     int *consumed, int *field_version)
>  {
>  	const char *prefix = NULL, *field_type = argv[0], *field_name, *array;
> -	int len, consumed, ret = -ENOMEM;
>  	struct synth_field *field;
> +	int len, ret = -ENOMEM;
>  	struct seq_buf s;
>  	ssize_t size;
>  
> @@ -596,15 +603,10 @@ static struct synth_field *parse_synth_field(int argc, char **argv)
>  		prefix = "unsigned ";
>  		field_type = argv[1];
>  		field_name = argv[2];
> -		consumed = 3;
> +		*consumed += 3;
>  	} else {
>  		field_name = argv[1];
> -		consumed = 2;
> -	}
> -
> -	if (consumed < argc) {
> -		synth_err(SYNTH_ERR_INVALID_FIELD, errpos(field_type));
> -		return ERR_PTR(-EINVAL);
> +		*consumed += 2;
>  	}
>  
>  	if (!field_name) {
> @@ -612,6 +614,8 @@ static struct synth_field *parse_synth_field(int argc, char **argv)
>  		return ERR_PTR(-EINVAL);
>  	}
>  
> +	*field_version = check_field_version(prefix, field_type, field_name);
> +
>  	field = kzalloc(sizeof(*field), GFP_KERNEL);
>  	if (!field)
>  		return ERR_PTR(-ENOMEM);
> @@ -1167,6 +1171,7 @@ static int __create_synth_event(const char *name, const char *raw_fields)
>  {
>  	char **argv, *field_str, *tmp_fields, *saved_fields = NULL;
>  	struct synth_field *field, *fields[SYNTH_FIELDS_MAX];
> +	int consumed, cmd_version = 1, n_fields_this_loop;
>  	int i, argc, n_fields = 0, ret = 0;
>  	struct synth_event *event = NULL;
>  
> @@ -1214,21 +1219,46 @@ static int __create_synth_event(const char *name, const char *raw_fields)
>  		if (!argc)
>  			continue;
>  
> -		field = parse_synth_field(argc, argv);
> -		if (IS_ERR(field)) {
> -			argv_free(argv);
> -			ret = PTR_ERR(field);
> -			goto err;
> -		}
> +		n_fields_this_loop = 0;
> +		consumed = 0;
> +		while (argc > consumed) {
> +			int field_version;
> +
> +			field = parse_synth_field(argc - consumed,
> +						  argv + consumed, &consumed,
> +						  &field_version);
> +			if (IS_ERR(field)) {
> +				argv_free(argv);
> +				ret = PTR_ERR(field);
> +				goto err;
> +			}
>  
> -		argv_free(argv);
> +			if (field_version > cmd_version)
> +				cmd_version = field_version;
> +

There needs to be some comments here to explain what the versioning means.

-- Steve


> +			if (cmd_version > 1 && n_fields_this_loop >= 1) {
> +				synth_err(SYNTH_ERR_INVALID_CMD, errpos(field_str));
> +				ret = -EINVAL;
> +				goto err;
> +			}
> +
> +			fields[n_fields++] = field;
> +			if (n_fields == SYNTH_FIELDS_MAX) {
> +				synth_err(SYNTH_ERR_TOO_MANY_FIELDS, 0);
> +				ret = -EINVAL;
> +				goto err;
> +			}
> +
> +			n_fields_this_loop++;
> +		}
>  
> -		fields[n_fields++] = field;
> -		if (n_fields == SYNTH_FIELDS_MAX) {
> -			synth_err(SYNTH_ERR_TOO_MANY_FIELDS, 0);
> +		if (consumed < argc) {
> +			synth_err(SYNTH_ERR_INVALID_CMD, 0);
>  			ret = -EINVAL;
>  			goto err;
>  		}
> +
> +		argv_free(argv);
>  	}
>  
>  	if (n_fields == 0) {

