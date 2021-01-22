Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F318300416
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 14:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbhAVNYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 08:24:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:51680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727072AbhAVNXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 08:23:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 269F223444;
        Fri, 22 Jan 2021 13:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611321794;
        bh=oHJWJDj56FnbgLcjcBE6tq8KXnOhekXJpKyA88bUWe0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=s3BO2ExFl4S9NeUeU7ybCRtdtZOO6vW14S0smtZ9zgyYm2tTx+Q58K9z2LDxPk+xb
         FhteaWpackED717/v2qZzLD1KxXiB/Zi7FDY50Vobfgd8RCcTFc4AH7flV9HJErurY
         S3N50U6qfgOlyJOOJzgV6j3Bj+Kx8pHdHKLQJI85zDY5syokzP3CHNnug9ym/2vjzK
         WTKXMD6Ia9QTfR9CvNb1qqUEm68xnpXXNHa/z2MZvQnmYnuo8cP6a8vQWkhSL0l6Kt
         Xs48POE4jStwFGyo1rGRqgFAc4/G6kpb7m7dy0jERz4tsMLaaRzQNOUMci2isaBFZQ
         IOIRo3vosXeJA==
Date:   Fri, 22 Jan 2021 22:23:11 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, axelrasmussen@google.com, mhiramat@kernel.org,
        dan.carpenter@oracle.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/6] tracing: Update synth command errors
Message-Id: <20210122222311.7559b4e71d1dc3ce60fa3fcc@kernel.org>
In-Reply-To: <18090ccadf2c33b03e4eaad429867d7088782721.1611243025.git.zanussi@kernel.org>
References: <cover.1611243025.git.zanussi@kernel.org>
        <18090ccadf2c33b03e4eaad429867d7088782721.1611243025.git.zanussi@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

On Thu, 21 Jan 2021 11:01:06 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> Since array types are handled differently, errors referencing them
> also need to be handled differently.  Add and use a new
> INVALID_ARRAY_SPEC error.  Also add INVALID_CMD and INVALID_DYN_CMD to
> catch and display the correct form for badly-formed commands, which
> can also be used in place of CMD_INCOMPLETE, which is removed, and
> remove CMD_TOO_LONG, since it's no longer used.

OK, so this will add new errors for precise error logging.

> 
> Signed-off-by: Tom Zanussi <zanussi@kernel.org>
> ---
>  kernel/trace/trace_events_synth.c | 72 +++++++++++++++++++++++++++----
>  1 file changed, 63 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
> index a79c17b97add..dd141ee6b3fc 100644
> --- a/kernel/trace/trace_events_synth.c
> +++ b/kernel/trace/trace_events_synth.c
> @@ -23,13 +23,14 @@
>  #undef ERRORS
>  #define ERRORS	\
>  	C(BAD_NAME,		"Illegal name"),		\
> -	C(CMD_INCOMPLETE,	"Incomplete command"),		\
> +	C(INVALID_CMD,		"Command must be of the form: <name> field[;field] ..."),\
> +	C(INVALID_DYN_CMD,	"Command must be of the form: s or -:[synthetic/]<name> field[;field] ..."),\
>  	C(EVENT_EXISTS,		"Event already exists"),	\
>  	C(TOO_MANY_FIELDS,	"Too many fields"),		\
>  	C(INCOMPLETE_TYPE,	"Incomplete type"),		\
>  	C(INVALID_TYPE,		"Invalid type"),		\
> -	C(INVALID_FIELD,	"Invalid field"),		\
> -	C(CMD_TOO_LONG,		"Command too long"),
> +	C(INVALID_FIELD,        "Invalid field"),		\
> +	C(INVALID_ARRAY_SPEC,	"Invalid array specification"),
>  
>  #undef C
>  #define C(a, b)		SYNTH_ERR_##a
> @@ -655,7 +656,10 @@ static struct synth_field *parse_synth_field(int argc, char **argv)
>  
>  	size = synth_field_size(field->type);
>  	if (size < 0) {
> -		synth_err(SYNTH_ERR_INVALID_TYPE, errpos(field_type));
> +		if (array)
> +			synth_err(SYNTH_ERR_INVALID_ARRAY_SPEC, errpos(field_name));
> +		else
> +			synth_err(SYNTH_ERR_INVALID_TYPE, errpos(field_type));
>  		ret = -EINVAL;
>  		goto free;
>  	} else if (size == 0) {
> @@ -1176,7 +1180,7 @@ static int __create_synth_event(const char *name, const char *raw_fields)
>  	mutex_lock(&event_mutex);
>  
>  	if (name[0] == '\0') {
> -		synth_err(SYNTH_ERR_CMD_INCOMPLETE, 0);
> +		synth_err(SYNTH_ERR_INVALID_CMD, 0);
>  		ret = -EINVAL;
>  		goto out;
>  	}
> @@ -1228,7 +1232,7 @@ static int __create_synth_event(const char *name, const char *raw_fields)
>  	}
>  
>  	if (n_fields == 0) {
> -		synth_err(SYNTH_ERR_CMD_INCOMPLETE, 0);
> +		synth_err(SYNTH_ERR_INVALID_CMD, 0);
>  		ret = -EINVAL;
>  		goto err;
>  	}
> @@ -1366,6 +1370,40 @@ int synth_event_delete(const char *event_name)
>  }
>  EXPORT_SYMBOL_GPL(synth_event_delete);
>  
> +static int check_command(const char *raw_command)
> +{
> +	char **argv = NULL, *cmd, *saved_cmd, *name_and_field;
> +	int argc, ret = 0;
> +
> +	cmd = saved_cmd = kstrdup(raw_command, GFP_KERNEL);
> +	if (!cmd)
> +		return -ENOMEM;
> +
> +	name_and_field = strsep(&cmd, ";");
> +	if (!name_and_field) {
> +		ret = -EINVAL;
> +		goto free;
> +	}
> +
> +	if (name_and_field[0] == '!')
> +		goto free;
> +
> +	argv = argv_split(GFP_KERNEL, name_and_field, &argc);
> +	if (!argv) {
> +		ret = -ENOMEM;
> +		goto free;
> +	}
> +
> +	if (argc < 3)
> +		ret = -EINVAL;
> +free:
> +	kfree(saved_cmd);
> +	if (argv)
> +		argv_free(argv);
> +
> +	return ret;
> +}

But I'm not sure why this (yet another parser) is needed. What you are expecting
for this check_command()? Could you tell me some examples?

Thank you,



-- 
Masami Hiramatsu <mhiramat@kernel.org>
