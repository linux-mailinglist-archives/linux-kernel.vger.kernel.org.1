Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 679C72E0A1F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 13:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgLVMno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 07:43:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:34262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbgLVMno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 07:43:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D902F2312E;
        Tue, 22 Dec 2020 12:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608640983;
        bh=T99t2LQMV+DJflQNBVMt8iDeZR9CErI0osB/univ9cA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OJ0akUAA1OXDemhKkxzIpH/T8JUV3hjuyJCFQ03RRXqYlIAa3zDAUCsomlKTDhc+e
         0v2zablLgTUtMooXXoe0hlvGantO8yhDOjzFmdncOVcIyLwtvi3Z9LizGLlUUrfu/G
         1JtqHs0Cdwh0iZ6vq9LsZck11wCs7RdK6CVL8dPFDi6+sMkTSIwc1Mr+i5Vy8deqEM
         8fLUHgdF2JU6aUA5/uLxR/K24I4Zp6IROo+TOFEA9wsuteE5DAN+UGUXdy2mDH2JWv
         QQnx6A3EibwRqo5T8NwzKPnxTGxsle+7lr0WjeLs788iPI8uNQBUatqQgY4eSGvEED
         y5bkOkjXVbCcQ==
Date:   Tue, 22 Dec 2020 21:42:59 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, axelrasmussen@google.com, mhiramat@kernel.org,
        dan.carpenter@oracle.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/5] tracing: Rework synthetic event command parsing
Message-Id: <20201222214259.464311df07a343de821db568@kernel.org>
In-Reply-To: <cc39d3737ffa8b330c3d3754b062709dbc1c50f6.1608586464.git.zanussi@kernel.org>
References: <cover.1608586464.git.zanussi@kernel.org>
        <cc39d3737ffa8b330c3d3754b062709dbc1c50f6.1608586464.git.zanussi@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

On Mon, 21 Dec 2020 15:44:28 -0600
Tom Zanussi <zanussi@kernel.org> wrote:


> @@ -656,7 +651,6 @@ static struct synth_field *parse_synth_field(int argc, const char **argv,
>  
>  	size = synth_field_size(field->type);
>  	if (size < 0) {
> -		synth_err(SYNTH_ERR_INVALID_TYPE, errpos(field_type));

Why did you remove this error message?

[..]
> @@ -1228,26 +1189,47 @@ static int __create_synth_event(int argc, const char *name, const char **argv)
>  		goto out;
>  	}
>  
> -	for (i = 0; i < argc - 1; i++) {
> -		if (strcmp(argv[i], ";") == 0)
> -			continue;
> +	tmp_fields = saved_fields = kstrdup(raw_fields, GFP_KERNEL);
> +	if (!tmp_fields) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	while ((field_str = strsep(&tmp_fields, ";")) != NULL) {
>  		if (n_fields == SYNTH_FIELDS_MAX) {
>  			synth_err(SYNTH_ERR_TOO_MANY_FIELDS, 0);
>  			ret = -EINVAL;
>  			goto err;
>  		}
>  
> -		field = parse_synth_field(argc - i, &argv[i], &consumed);
> +		argv = argv_split(GFP_KERNEL, field_str, &argc);
> +		if (!argv) {
> +			ret = -ENOMEM;
> +			goto err;
> +		}
> +
> +		if (!argc)
> +			continue;
> +
> +		field = parse_synth_field(argc, argv, &consumed);
>  		if (IS_ERR(field)) {
> +			argv_free(argv);
>  			ret = PTR_ERR(field);
>  			goto err;
>  		}
> +
> +		argv_free(argv);
> +
> +		if (consumed < argc) {
> +			ret = -EINVAL;
> +			goto err;
> +		}

You can check the consumed < argc in parse_synth_field(), unless
you keep the backward compatibility - I think you can add an
inner loop for it, something like

while ((field_str = strsep(&tmp_fields, ";")) != NULL) {
    argv = argv_split(...);
    consumed = 0;
    while (argc > consumed) {
        // increment consumed in parse_synth_field()
        field = parse_synth_field(argc - consumed, argv + consumed, &consumed);
        if (IS_ERR(field)) {...}

        fields[n_fields++] = field;
        if (n_fields == SYNTH_FIELDS_MAX) {...}
     }

    argv_free(argv);
}

what would you think?

> +
>  		fields[n_fields++] = field;
> -		i += consumed - 1;
>  	}
>  
> -	if (i < argc && strcmp(argv[i], ";") != 0) {
> -		synth_err(SYNTH_ERR_INVALID_FIELD, errpos(argv[i]));
> +	if (n_fields == 0) {
> +		synth_err(SYNTH_ERR_CMD_INCOMPLETE, 0);
>  		ret = -EINVAL;
>  		goto err;
>  	}
> @@ -1266,6 +1248,8 @@ static int __create_synth_event(int argc, const char *name, const char **argv)
>   out:
>  	mutex_unlock(&event_mutex);
>  
> +	kfree(saved_fields);
> +
>  	return ret;
>   err:
>  	for (i = 0; i < n_fields; i++)
> @@ -1385,29 +1369,35 @@ EXPORT_SYMBOL_GPL(synth_event_delete);
>  
>  static int create_or_delete_synth_event(const char *raw_command)
>  {
> -	char **argv, *name = NULL;
> -	int argc = 0, ret = 0;
> +	char *name = NULL, *fields, *p;
> +	int ret = 0;
>  
> -	argv = argv_split(GFP_KERNEL, raw_command, &argc);
> -	if (!argv)
> -		return -ENOMEM;
> +	raw_command = skip_spaces(raw_command);
> +	if (raw_command[0] == '\0')
> +		return ret;
>  
> -	if (!argc)
> -		goto free;
> +	last_cmd_set(raw_command);
>  
> -	name = argv[0];
> +	p = strpbrk(raw_command, " \t");
> +	if (!p)
> +		return -EINVAL;

Hmm, this may drop the ability to delete an event with "!name",
it always requires some spaces after the name.

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
