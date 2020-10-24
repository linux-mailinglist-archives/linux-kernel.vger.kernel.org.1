Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39794297B86
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 10:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760127AbgJXIup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 04:50:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:35078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1760120AbgJXIuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 04:50:44 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37C542177B;
        Sat, 24 Oct 2020 08:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603529443;
        bh=ljVzpvEvHjrBo7BgLCaeSUhDmJcuqrGcgtk31UWUZdg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IBUmlIvxOuW3DA0obRC18N7HIIazYk1NtZnrV6QLDFgoH8tKlVfWS86Hcuu1nTW0d
         Eg2w3ojStZFXe4zplRxfKbjGSpFc2/tDEhRHcsPAjzC3DmLrRyoYCs9Aci6r2MP3yD
         pU+OOjnpKo1C1Epknvd5pL3CkLNg76gkX7kjmafA=
Date:   Sat, 24 Oct 2020 17:50:40 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, axelrasmussen@google.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] tracing/dynevent: Delegate parsing to create
 function
Message-Id: <20201024175040.3c7a69dcff5f110e713350be@kernel.org>
In-Reply-To: <af206cdc069b1de4670c0a27458eb98263eaf84e.1603484117.git.zanussi@kernel.org>
References: <cover.1603484117.git.zanussi@kernel.org>
        <af206cdc069b1de4670c0a27458eb98263eaf84e.1603484117.git.zanussi@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

Thanks for the update!

On Fri, 23 Oct 2020 15:33:52 -0500
Tom Zanussi <zanussi@kernel.org> wrote:

> From: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Delegate command parsing to each create function so that the
> command syntax can be customized.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> [ zanussi@kernel.org: added synthetic event modifications ]

Since you've customized the synth_event parser, could you update
the patch description? (Or split this into 2 patches)

> Signed-off-by: Tom Zanussi <zanussi@kernel.org>
> ---
>  kernel/trace/trace.c              |  23 +---
>  kernel/trace/trace.h              |   3 +-
>  kernel/trace/trace_dynevent.c     |  35 +++---
>  kernel/trace/trace_dynevent.h     |   4 +-
>  kernel/trace/trace_events_synth.c | 186 ++++++++++++++++--------------
>  kernel/trace/trace_kprobe.c       |  33 +++---
>  kernel/trace/trace_probe.c        |  17 +++
>  kernel/trace/trace_probe.h        |   1 +
>  kernel/trace/trace_uprobe.c       |  17 ++-
>  9 files changed, 174 insertions(+), 145 deletions(-)

[..]
> @@ -1223,26 +1176,43 @@ static int __create_synth_event(int argc, const char *name, const char **argv)
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
> +		field = parse_synth_field(argc, argv);
>  		if (IS_ERR(field)) {
> +			argv_free(argv);
>  			ret = PTR_ERR(field);
>  			goto err;
>  		}
> +
> +		argv_free(argv);
> +
>  		fields[n_fields++] = field;
>  		i += consumed - 1;

You may not need this line (and "consumed") anymore?

>  	}
>  
> -	if (i < argc && strcmp(argv[i], ";") != 0) {
> -		synth_err(SYNTH_ERR_INVALID_FIELD, errpos(argv[i]));
> +	if (n_fields == 0) {
> +		synth_err(SYNTH_ERR_CMD_INCOMPLETE, 0);
>  		ret = -EINVAL;
>  		goto err;
>  	}
> @@ -1261,6 +1231,8 @@ static int __create_synth_event(int argc, const char *name, const char **argv)
>   out:
>  	mutex_unlock(&event_mutex);
>  
> +	kfree(saved_fields);
> +
>  	return ret;
>   err:
>  	for (i = 0; i < n_fields; i++)
> @@ -1378,18 +1350,35 @@ int synth_event_delete(const char *event_name)
>  }
>  EXPORT_SYMBOL_GPL(synth_event_delete);
>  
> -static int create_or_delete_synth_event(int argc, char **argv)
> +static int create_or_delete_synth_event(const char *raw_command)
>  {
> -	const char *name = argv[0];
> -	int ret;
> +	char **argv, *name = NULL, *fields;
> +	int argc = 0, ret = 0;
> +
> +	last_cmd_set(raw_command);
> +
> +	argv = argv_split(GFP_KERNEL, raw_command, &argc);
> +	if (!argv)
> +		return -ENOMEM;

If you are sure the first argument is the name, you don't need
to use argv_split, but just strpbrk(raw_command, " \t"), something
like this.

	raw_command = skip_spaces(raw_command);
	p = strpbrk(raw_command, " \t");
	if (!p)
		return -EINVAL;

	name = kmemdup_nul(raw_command, p - raw_command, GFP_KERNEL);
	field = skip_spaces(p);

...

	ret = __create_synth_event(name, fields);
free:
	kfree(name);

(BTW, we should have find_spaces() instead of slow strpbrk().)


Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
