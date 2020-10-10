Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8CA928A2FD
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 01:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390813AbgJJW7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:59:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:57024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732637AbgJJTyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 15:54:41 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 856FB2226B;
        Sat, 10 Oct 2020 14:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602341877;
        bh=VNY5ztPE9qgnXKnz65g5kcR0mvL4eM1olKVmn4BQVrs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VCCUmBGvWyjeuc0JgFSYrypaqoN2Pyk4rxird4vKzfv88NLH2CA/aM5YuhQLgMj3S
         G9aqh2JdaMMKgnUA9fVk6tEgvDDvp74uvCEaoXRCQj75AON9xMhJfaWt0Xn1uVBMAR
         jlMsjgYMmpIFeo+hP3SYGlHNcbfE63KY7KOfB2Do=
Date:   Sat, 10 Oct 2020 23:57:54 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, axelrasmussen@google.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] tracing: Add synthetic event error logging
Message-Id: <20201010235754.432db5b2e841cad9dfae1865@kernel.org>
In-Reply-To: <ad3aa73bb8d20ae83ae466ed0561997bd12e69fc.1602255803.git.zanussi@kernel.org>
References: <cover.1602255803.git.zanussi@kernel.org>
        <ad3aa73bb8d20ae83ae466ed0561997bd12e69fc.1602255803.git.zanussi@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  9 Oct 2020 10:17:10 -0500
Tom Zanussi <zanussi@kernel.org> wrote:

> Add support for synthetic event error logging, which entails adding a
> logging function for it, a way to save the synthetic event command,
> and a set of specific synthetic event parse error strings and
> handling.

Thanks for fixing this. But it seems that the INVALID_TYPE error
position is not correct.

/sys/kernel/debug/tracing # echo "myevent chr arg" >> synthetic_events 
sh: write error: Invalid argument
/sys/kernel/debug/tracing # cat error_log 
[ 1354.611660] synthetic_events: error: Invalid type
  Command: myevent chr arg 
                       ^

If the type is invalid, it should point "chr" instead of "arg".
If you add a syntax error testcase as same as kprobe_events, you can
check the error position too.

Thank you,

> 
> Signed-off-by: Tom Zanussi <zanussi@kernel.org>
> ---
>  kernel/trace/trace_events_synth.c | 114 +++++++++++++++++++++++++++++-
>  1 file changed, 112 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
> index 8c9d6e464da0..ce4cae5cfd47 100644
> --- a/kernel/trace/trace_events_synth.c
> +++ b/kernel/trace/trace_events_synth.c
> @@ -20,6 +20,53 @@
>  
>  #include "trace_synth.h"
>  
> +#undef ERRORS
> +#define ERRORS	\
> +	C(BAD_NAME,		"Illegal name"),		\
> +	C(CMD_INCOMPLETE,	"Incomplete command"),		\
> +	C(EVENT_EXISTS,		"Event already exists"),	\
> +	C(TOO_MANY_FIELDS,	"Too many fields"),		\
> +	C(INCOMPLETE_TYPE,	"Incomplete type"),		\
> +	C(INVALID_TYPE,		"Invalid type"),		\
> +	C(INVALID_FIELD,	"Invalid field"),		\
> +	C(CMD_TOO_LONG,		"Command too long"),
> +
> +#undef C
> +#define C(a, b)		SYNTH_ERR_##a
> +
> +enum { ERRORS };
> +
> +#undef C
> +#define C(a, b)		b
> +
> +static const char *err_text[] = { ERRORS };
> +
> +static char last_cmd[MAX_FILTER_STR_VAL];
> +
> +static int errpos(const char *str)
> +{
> +	return err_pos(last_cmd, str);
> +}
> +
> +static void last_cmd_set(char *str)
> +{
> +	if (!str)
> +		return;
> +
> +	strncat(last_cmd, str, MAX_FILTER_STR_VAL - 1);
> +}
> +
> +static void synth_err(u8 err_type, u8 err_pos)
> +{
> +	tracing_log_err(NULL, "synthetic_events", last_cmd, err_text,
> +			err_type, err_pos);
> +}
> +
> +static void synth_err_clear(void)
> +{
> +	last_cmd[0] = '\0';
> +}
> +
>  static int create_synth_event(int argc, const char **argv);
>  static int synth_event_show(struct seq_file *m, struct dyn_event *ev);
>  static int synth_event_release(struct dyn_event *ev);
> @@ -545,8 +592,10 @@ static struct synth_field *parse_synth_field(int argc, const char **argv,
>  		field_type++;
>  
>  	if (!strcmp(field_type, "unsigned")) {
> -		if (argc < 3)
> +		if (argc < 3) {
> +			synth_err(SYNTH_ERR_INCOMPLETE_TYPE, errpos(field_type));
>  			return ERR_PTR(-EINVAL);
> +		}
>  		prefix = "unsigned ";
>  		field_type = argv[1];
>  		field_name = argv[2];
> @@ -573,6 +622,7 @@ static struct synth_field *parse_synth_field(int argc, const char **argv,
>  		goto free;
>  	}
>  	if (!is_good_name(field->name)) {
> +		synth_err(SYNTH_ERR_BAD_NAME, errpos(field_name));
>  		ret = -EINVAL;
>  		goto free;
>  	}
> @@ -601,6 +651,7 @@ static struct synth_field *parse_synth_field(int argc, const char **argv,
>  
>  	size = synth_field_size(field->type);
>  	if (size < 0) {
> +		synth_err(SYNTH_ERR_INVALID_TYPE, errpos(field->name));
>  		ret = -EINVAL;
>  		goto free;
>  	} else if (size == 0) {
> @@ -621,6 +672,7 @@ static struct synth_field *parse_synth_field(int argc, const char **argv,
>  			field->is_dynamic = true;
>  			size = sizeof(u64);
>  		} else {
> +			synth_err(SYNTH_ERR_INVALID_TYPE, errpos(field->name));
>  			ret = -EINVAL;
>  			goto free;
>  		}
> @@ -1098,12 +1150,64 @@ int synth_event_gen_cmd_array_start(struct dynevent_cmd *cmd, const char *name,
>  }
>  EXPORT_SYMBOL_GPL(synth_event_gen_cmd_array_start);
>  
> +static int cmdstr_append(char *buf, const char *str, int *remaining)
> +{
> +	int len = strlen(str);
> +
> +	if (len + 1 >= *remaining) {
> +		synth_err(SYNTH_ERR_CMD_TOO_LONG, 0);
> +		return -EINVAL;
> +	}
> +
> +	strcat(buf, str);
> +	strcat(buf, " ");
> +	*remaining -= len + 1;
> +
> +	return 0;
> +}
> +
> +static int save_cmdstr(int argc, const char *name, const char **argv)
> +{
> +	int i, ret, remaining = MAX_DYNEVENT_CMD_LEN;
> +	char *buf;
> +
> +	synth_err_clear();
> +
> +	buf = kzalloc(MAX_DYNEVENT_CMD_LEN, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	ret = cmdstr_append(buf, name, &remaining);
> +	if (ret) {
> +		kfree(buf);
> +		return ret;
> +	}
> +
> +	for (i = 0; i < argc; i++) {
> +		ret = cmdstr_append(buf, argv[i], &remaining);
> +		if (ret) {
> +			kfree(buf);
> +			return ret;
> +		}
> +	}
> +
> +	last_cmd_set(buf);
> +
> +	kfree(buf);
> +
> +	return ret;
> +}
> +
>  static int __create_synth_event(int argc, const char *name, const char **argv)
>  {
>  	struct synth_field *field, *fields[SYNTH_FIELDS_MAX];
>  	struct synth_event *event = NULL;
>  	int i, consumed = 0, n_fields = 0, ret = 0;
>  
> +	ret = save_cmdstr(argc, name, argv);
> +	if (ret)
> +		return ret;
> +
>  	/*
>  	 * Argument syntax:
>  	 *  - Add synthetic event: <event_name> field[;field] ...
> @@ -1111,18 +1215,22 @@ static int __create_synth_event(int argc, const char *name, const char **argv)
>  	 *      where 'field' = type field_name
>  	 */
>  
> -	if (name[0] == '\0' || argc < 1)
> +	if (name[0] == '\0' || argc < 1) {
> +		synth_err(SYNTH_ERR_CMD_INCOMPLETE, 0);
>  		return -EINVAL;
> +	}
>  
>  	mutex_lock(&event_mutex);
>  
>  	if (!is_good_name(name)) {
> +		synth_err(SYNTH_ERR_BAD_NAME, errpos(name));
>  		ret = -EINVAL;
>  		goto out;
>  	}
>  
>  	event = find_synth_event(name);
>  	if (event) {
> +		synth_err(SYNTH_ERR_EVENT_EXISTS, errpos(name));
>  		ret = -EEXIST;
>  		goto out;
>  	}
> @@ -1131,6 +1239,7 @@ static int __create_synth_event(int argc, const char *name, const char **argv)
>  		if (strcmp(argv[i], ";") == 0)
>  			continue;
>  		if (n_fields == SYNTH_FIELDS_MAX) {
> +			synth_err(SYNTH_ERR_TOO_MANY_FIELDS, 0);
>  			ret = -EINVAL;
>  			goto err;
>  		}
> @@ -1145,6 +1254,7 @@ static int __create_synth_event(int argc, const char *name, const char **argv)
>  	}
>  
>  	if (i < argc && strcmp(argv[i], ";") != 0) {
> +		synth_err(SYNTH_ERR_INVALID_FIELD, errpos(argv[i]));
>  		ret = -EINVAL;
>  		goto err;
>  	}
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
