Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6A4629296A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 16:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbgJSOfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 10:35:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:60928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728311AbgJSOfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 10:35:36 -0400
Received: from tzanussi-mobl (c-73-209-127-30.hsd1.il.comcast.net [73.209.127.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D20A222C3;
        Mon, 19 Oct 2020 14:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603118134;
        bh=R960V/vdgMPSisx95jGlTaJm+Qm74c102WG7QRYeAAY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=dSkIrcWbeyqbqzE29BGSZD0gjr2vzQlDpnuV3Q9CnI3Gjzb4RlzOOEwA/bAC5GA+2
         +bxoC2rvleThy54eHjI7Bw7QR2Llv8iKCPOT0RKATStb2w/3a2zPaHdjzYD/WVxVt6
         YtkSqX364udJ3ec7FXhTrLNwHRPRlCgtsTj/9ht8=
Message-ID: <dcdae58c4bac15e012067866afac19bca13ba7cf.camel@kernel.org>
Subject: Re: [PATCH 1/4] tracing: Make trace_*_run_command() more flexible
From:   Tom Zanussi <zanussi@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     rostedt@goodmis.org, axelrasmussen@google.com,
        linux-kernel@vger.kernel.org
Date:   Mon, 19 Oct 2020 09:35:32 -0500
In-Reply-To: <20201019001504.70dc3ec608277ed22060d2f7@kernel.org>
References: <cover.1602883818.git.zanussi@kernel.org>
         <e29c3ae1fc46892ec792d6f6f910f75d0e12584c.1602883818.git.zanussi@kernel.org>
         <20201018232011.38e5da51f5cd8e73e6f529ee@kernel.org>
         <20201019001504.70dc3ec608277ed22060d2f7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On Mon, 2020-10-19 at 00:15 +0900, Masami Hiramatsu wrote:
> Hi Tom,
> 
> On Sun, 18 Oct 2020 23:20:11 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Hi Tom,
> > 
> > On Fri, 16 Oct 2020 16:48:22 -0500
> > Tom Zanussi <zanussi@kernel.org> wrote:
> > 
> > > trace_run_command() and therefore functions that use it, such as
> > > trace_parse_run_command(), uses argv_split() to split the command
> > > into
> > > an array of args then passed to the callback to handle.
> > > 
> > > This works fine for most commands but some commands would like to
> > > allow the user to use and additional separator to visually group
> > > items
> > > in the command.  One example would be synthetic event commands,
> > > which
> > > use semicolons to group fields:
> > > 
> > >   echo 'event_name int a; char b[]; u64 lat' >> synthetic_events
> > > 
> > > What gets passed as an args array to the command for a command
> > > like
> > > this include tokens that have semicolons included with the token,
> > > which the callback then needs to strip out, since argv_split()
> > > only
> > > looks at whitespace as a separator.
> > > 
> > > It would be nicer to just have trace_run_command() strip out the
> > > semicolons at its level rather than passing that task onto the
> > > callback. To accomplish that, this change adds an
> > > 'additional_sep'
> > > arg to a new __trace_run_command() function that allows a caller
> > > to
> > > pass an additional separator char that if non-zero simply
> > > replaces
> > > that character with whitespace before splitting the command into
> > > args.
> > > The original trace_run_command() remains as-is in this regard,
> > > simply
> > > calling __trace_run_command() with 0 for the separator, while
> > > making a
> > > new trace_run_command_add_sep() version that can be used to pass
> > > in a
> > > separator.
> > 
> > No, I don't like to tweak trace_run_command() that way, I'm OK to
> > delegate the argv_split() totally to the callback function (pass
> > the raw command string to the callback), OR __create_synth_event()
> > concatinate the fields argv and parse it by itself (I think the
> > latter is better and simpler).
> > 
> > The ";" separator is not an additinal separator but that is higher
> > level separator for synthetic event. Suppose that you get the
> > following input;
> >  "myevent int c ; char b"
> >  "myevent int;c;char;b;"
> > These should not be same for the synthetic events. The fields must
> > be
> > splitted by ';' at first, and then each field should be parsed.
> > 
> > So, I recommend you not to pass the additional separator to the
> > generic function, but (since it is only for synthetic event) to
> > reconstruct the raw command from argv, and parse it again with
> > ";" inside synthetic event parser. Then each fields parser can
> > check that is a wrong input or not.
> > 
> > It will be something like
> > 
> > __create_synth_event(argc, argv)
> > {
> > 	<event-name parsing>
> > 	argc--; argv++;
> > 
> > 	raw_fields = concat_argv(argc, argv);// you can assume argv is
> > generated by argv_split().
> > 	vfields = split_fields(raw_fields, &nfields);// similar to
> > argv_split()
> > 	for (i = 0; i < nfields; i++)
> > 		parse_synth_field(vfields[i]);
> > }
> > 
> > Then, you don't need to change the generic functions, and also
> > you will get the correct parser routines.
> 
> If you think the split->concat->split process is redundant, I think
> we
> can remove trace_run_command() and just pass a raw command string to
> each
> event command parser as I said above.
> 
> In this way, each event create function can parse the command by
> themselves.
> So you can parse the command as you like.
> 
> Here is the patch which modifies trace-{k,u}probe and trace-dynevent
> side, but not changing synthetic event side yet. Will this help you?
> 

Yeah, it was probably a mistake to try to shoehorn synthetic events
into the unmodified trace_run_command() in the first place.

This should work for me - I'll build on it.  Thanks for supplying it!

Tom


> From 5aed03a8df0926d92f6585b3932fdc96324cb82d Mon Sep 17 00:00:00
> 2001
> From: Masami Hiramatsu <mhiramat@kernel.org>
> Date: Sat, 17 Oct 2020 23:11:29 +0900
> Subject: [PATCH] tracing/dynevent: Delegate parsing to create
> function
> 
> Delegate command parsing to each create function so that the
> command syntax can be customized.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  kernel/trace/trace.c          | 23 ++---------------------
>  kernel/trace/trace.h          |  3 +--
>  kernel/trace/trace_dynevent.c | 35 ++++++++++++++++++++++-----------
> --
>  kernel/trace/trace_dynevent.h |  4 ++--
>  kernel/trace/trace_kprobe.c   | 33 ++++++++++++++++++---------------
>  kernel/trace/trace_probe.c    | 17 +++++++++++++++++
>  kernel/trace/trace_probe.h    |  1 +
>  kernel/trace/trace_uprobe.c   | 17 +++++++++++------
>  8 files changed, 74 insertions(+), 59 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 63c97012ed39..277d97220971 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -9367,30 +9367,11 @@ void ftrace_dump(enum ftrace_dump_mode
> oops_dump_mode)
>  }
>  EXPORT_SYMBOL_GPL(ftrace_dump);
>  
> -int trace_run_command(const char *buf, int (*createfn)(int, char
> **))
> -{
> -	char **argv;
> -	int argc, ret;
> -
> -	argc = 0;
> -	ret = 0;
> -	argv = argv_split(GFP_KERNEL, buf, &argc);
> -	if (!argv)
> -		return -ENOMEM;
> -
> -	if (argc)
> -		ret = createfn(argc, argv);
> -
> -	argv_free(argv);
> -
> -	return ret;
> -}
> -
>  #define WRITE_BUFSIZE  4096
>  
>  ssize_t trace_parse_run_command(struct file *file, const char __user
> *buffer,
>  				size_t count, loff_t *ppos,
> -				int (*createfn)(int, char **))
> +				int (*createfn)(const char *))
>  {
>  	char *kbuf, *buf, *tmp;
>  	int ret = 0;
> @@ -9438,7 +9419,7 @@ ssize_t trace_parse_run_command(struct file
> *file, const char __user *buffer,
>  			if (tmp)
>  				*tmp = '\0';
>  
> -			ret = trace_run_command(buf, createfn);
> +			ret = createfn(buf);
>  			if (ret)
>  				goto out;
>  			buf += size;
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 34e0c4d5a6e7..02d7c487a30b 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -1982,10 +1982,9 @@ extern int tracing_set_cpumask(struct
> trace_array *tr,
>  
>  #define MAX_EVENT_NAME_LEN	64
>  
> -extern int trace_run_command(const char *buf, int (*createfn)(int,
> char**));
>  extern ssize_t trace_parse_run_command(struct file *file,
>  		const char __user *buffer, size_t count, loff_t *ppos,
> -		int (*createfn)(int, char**));
> +		int (*createfn)(const char *));
>  
>  extern unsigned int err_pos(char *cmd, const char *str);
>  extern void tracing_log_err(struct trace_array *tr,
> diff --git a/kernel/trace/trace_dynevent.c
> b/kernel/trace/trace_dynevent.c
> index 5fa49cfd2bb6..af83bc5447fe 100644
> --- a/kernel/trace/trace_dynevent.c
> +++ b/kernel/trace/trace_dynevent.c
> @@ -31,23 +31,31 @@ int dyn_event_register(struct
> dyn_event_operations *ops)
>  	return 0;
>  }
>  
> -int dyn_event_release(int argc, char **argv, struct
> dyn_event_operations *type)
> +int dyn_event_release(const char *raw_command, struct
> dyn_event_operations *type)
>  {
>  	struct dyn_event *pos, *n;
>  	char *system = NULL, *event, *p;
> -	int ret = -ENOENT;
> +	int argc, ret = -ENOENT;
> +	char **argv;
> +
> +	argv = argv_split(GFP_KERNEL, raw_command, &argc);
> +	if (!argv)
> +		return -ENOMEM;
>  
>  	if (argv[0][0] == '-') {
> -		if (argv[0][1] != ':')
> -			return -EINVAL;
> +		if (argv[0][1] != ':') {
> +			ret = -EINVAL;
> +			goto out;
> +		}
>  		event = &argv[0][2];
>  	} else {
>  		event = strchr(argv[0], ':');
> -		if (!event)
> -			return -EINVAL;
> +		if (!event) {
> +			ret = -EINVAL;
> +			goto out;
> +		}
>  		event++;
>  	}
> -	argc--; argv++;
>  
>  	p = strchr(event, '/');
>  	if (p) {
> @@ -63,7 +71,7 @@ int dyn_event_release(int argc, char **argv, struct
> dyn_event_operations *type)
>  		if (type && type != pos->ops)
>  			continue;
>  		if (!pos->ops->match(system, event,
> -				argc, (const char **)argv, pos))
> +				argc - 1, (const char **)argv + 1,
> pos))
>  			continue;
>  
>  		ret = pos->ops->free(pos);
> @@ -71,21 +79,22 @@ int dyn_event_release(int argc, char **argv,
> struct dyn_event_operations *type)
>  			break;
>  	}
>  	mutex_unlock(&event_mutex);
> -
> +out:
> +	argv_free(argv);
>  	return ret;
>  }
>  
> -static int create_dyn_event(int argc, char **argv)
> +static int create_dyn_event(const char *raw_command)
>  {
>  	struct dyn_event_operations *ops;
>  	int ret = -ENODEV;
>  
> -	if (argv[0][0] == '-' || argv[0][0] == '!')
> -		return dyn_event_release(argc, argv, NULL);
> +	if (raw_command[0] == '-' || raw_command[0] == '!')
> +		return dyn_event_release(raw_command, NULL);
>  
>  	mutex_lock(&dyn_event_ops_mutex);
>  	list_for_each_entry(ops, &dyn_event_ops_list, list) {
> -		ret = ops->create(argc, (const char **)argv);
> +		ret = ops->create(raw_command);
>  		if (!ret || ret != -ECANCELED)
>  			break;
>  	}
> diff --git a/kernel/trace/trace_dynevent.h
> b/kernel/trace/trace_dynevent.h
> index d6857a254ede..4f4e03df4cbb 100644
> --- a/kernel/trace/trace_dynevent.h
> +++ b/kernel/trace/trace_dynevent.h
> @@ -39,7 +39,7 @@ struct dyn_event;
>   */
>  struct dyn_event_operations {
>  	struct list_head	list;
> -	int (*create)(int argc, const char *argv[]);
> +	int (*create)(const char *raw_command);
>  	int (*show)(struct seq_file *m, struct dyn_event *ev);
>  	bool (*is_busy)(struct dyn_event *ev);
>  	int (*free)(struct dyn_event *ev);
> @@ -97,7 +97,7 @@ void *dyn_event_seq_start(struct seq_file *m,
> loff_t *pos);
>  void *dyn_event_seq_next(struct seq_file *m, void *v, loff_t *pos);
>  void dyn_event_seq_stop(struct seq_file *m, void *v);
>  int dyn_events_release_all(struct dyn_event_operations *type);
> -int dyn_event_release(int argc, char **argv, struct
> dyn_event_operations *type);
> +int dyn_event_release(const char *raw_command, struct
> dyn_event_operations *type);
>  
>  /*
>   * for_each_dyn_event	-	iterate over the dyn_event list
> diff --git a/kernel/trace/trace_kprobe.c
> b/kernel/trace/trace_kprobe.c
> index d04f380f6286..446273d7813d 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -34,7 +34,7 @@ static int __init set_kprobe_boot_events(char *str)
>  }
>  __setup("kprobe_event=", set_kprobe_boot_events);
>  
> -static int trace_kprobe_create(int argc, const char **argv);
> +static int trace_kprobe_create(const char *raw_command);
>  static int trace_kprobe_show(struct seq_file *m, struct dyn_event
> *ev);
>  static int trace_kprobe_release(struct dyn_event *ev);
>  static bool trace_kprobe_is_busy(struct dyn_event *ev);
> @@ -710,7 +710,7 @@ static inline void sanitize_event_name(char
> *name)
>  			*name = '_';
>  }
>  
> -static int trace_kprobe_create(int argc, const char *argv[])
> +static int __trace_kprobe_create(int argc, const char *argv[])
>  {
>  	/*
>  	 * Argument syntax:
> @@ -909,20 +909,25 @@ static int trace_kprobe_create(int argc, const
> char *argv[])
>  	goto out;
>  }
>  
> -static int create_or_delete_trace_kprobe(int argc, char **argv)
> +static int trace_kprobe_create(const char *raw_command)
> +{
> +	return trace_probe_create(raw_command, __trace_kprobe_create);
> +}
> +
> +static int create_or_delete_trace_kprobe(const char *raw_command)
>  {
>  	int ret;
>  
> -	if (argv[0][0] == '-')
> -		return dyn_event_release(argc, argv,
> &trace_kprobe_ops);
> +	if (raw_command[0] == '-')
> +		return dyn_event_release(raw_command,
> &trace_kprobe_ops);
>  
> -	ret = trace_kprobe_create(argc, (const char **)argv);
> +	ret = trace_kprobe_create(raw_command);
>  	return ret == -ECANCELED ? -EINVAL : ret;
>  }
>  
>  static int trace_kprobe_run_command(struct dynevent_cmd *cmd)
>  {
> -	return trace_run_command(cmd->seq.buffer,
> create_or_delete_trace_kprobe);
> +	return create_or_delete_trace_kprobe(cmd->seq.buffer);
>  }
>  
>  /**
> @@ -1083,7 +1088,7 @@ int kprobe_event_delete(const char *name)
>  
>  	snprintf(buf, MAX_EVENT_NAME_LEN, "-:%s", name);
>  
> -	return trace_run_command(buf, create_or_delete_trace_kprobe);
> +	return create_or_delete_trace_kprobe(buf);
>  }
>  EXPORT_SYMBOL_GPL(kprobe_event_delete);
>  
> @@ -1886,7 +1891,7 @@ static __init void
> setup_boot_kprobe_events(void)
>  		if (p)
>  			*p++ = '\0';
>  
> -		ret = trace_run_command(cmd,
> create_or_delete_trace_kprobe);
> +		ret = create_or_delete_trace_kprobe(cmd);
>  		if (ret)
>  			pr_warn("Failed to add event(%d): %s\n", ret,
> cmd);
>  		else
> @@ -1984,8 +1989,7 @@ static __init int
> kprobe_trace_self_tests_init(void)
>  
>  	pr_info("Testing kprobe tracing: ");
>  
> -	ret = trace_run_command("p:testprobe
> kprobe_trace_selftest_target $stack $stack0 +0($stack)",
> -				create_or_delete_trace_kprobe);
> +	ret = create_or_delete_trace_kprobe("p:testprobe
> kprobe_trace_selftest_target $stack $stack0 +0($stack)");
>  	if (WARN_ON_ONCE(ret)) {
>  		pr_warn("error on probing function entry.\n");
>  		warn++;
> @@ -2006,8 +2010,7 @@ static __init int
> kprobe_trace_self_tests_init(void)
>  		}
>  	}
>  
> -	ret = trace_run_command("r:testprobe2
> kprobe_trace_selftest_target $retval",
> -				create_or_delete_trace_kprobe);
> +	ret = create_or_delete_trace_kprobe("r:testprobe2
> kprobe_trace_selftest_target $retval");
>  	if (WARN_ON_ONCE(ret)) {
>  		pr_warn("error on probing function return.\n");
>  		warn++;
> @@ -2080,13 +2083,13 @@ static __init int
> kprobe_trace_self_tests_init(void)
>  				trace_probe_event_call(&tk->tp), file);
>  	}
>  
> -	ret = trace_run_command("-:testprobe",
> create_or_delete_trace_kprobe);
> +	ret = create_or_delete_trace_kprobe("-:testprobe");
>  	if (WARN_ON_ONCE(ret)) {
>  		pr_warn("error on deleting a probe.\n");
>  		warn++;
>  	}
>  
> -	ret = trace_run_command("-:testprobe2",
> create_or_delete_trace_kprobe);
> +	ret = create_or_delete_trace_kprobe("-:testprobe2");
>  	if (WARN_ON_ONCE(ret)) {
>  		pr_warn("error on deleting a probe.\n");
>  		warn++;
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index d2867ccc6aca..abc66d1cbf82 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -1134,3 +1134,20 @@ bool trace_probe_match_command_args(struct
> trace_probe *tp,
>  	}
>  	return true;
>  }
> +
> +int trace_probe_create(const char *raw_command, int (*createfn)(int,
> const char **))
> +{
> +	int argc, ret;
> +	char **argv;
> +
> +	argv = argv_split(GFP_KERNEL, raw_command, &argc);
> +	if (!argv)
> +		return -ENOMEM;
> +
> +	if (argc)
> +		ret = createfn(argc, (const char **)argv);
> +
> +	argv_free(argv);
> +
> +	return ret;
> +}
> diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> index 2f703a20c724..7ce4027089ee 100644
> --- a/kernel/trace/trace_probe.h
> +++ b/kernel/trace/trace_probe.h
> @@ -341,6 +341,7 @@ struct event_file_link
> *trace_probe_get_file_link(struct trace_probe *tp,
>  int trace_probe_compare_arg_type(struct trace_probe *a, struct
> trace_probe *b);
>  bool trace_probe_match_command_args(struct trace_probe *tp,
>  				    int argc, const char **argv);
> +int trace_probe_create(const char *raw_command, int (*createfn)(int,
> const char **));
>  
>  #define trace_probe_for_each_link(pos, tp)	\
>  	list_for_each_entry(pos, &(tp)->event->files, list)
> diff --git a/kernel/trace/trace_uprobe.c
> b/kernel/trace/trace_uprobe.c
> index 3cf7128e1ad3..e6b56a65f80f 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -34,7 +34,7 @@ struct uprobe_trace_entry_head {
>  #define DATAOF_TRACE_ENTRY(entry, is_return)		\
>  	((void*)(entry) + SIZEOF_TRACE_ENTRY(is_return))
>  
> -static int trace_uprobe_create(int argc, const char **argv);
> +static int trace_uprobe_create(const char *raw_command);
>  static int trace_uprobe_show(struct seq_file *m, struct dyn_event
> *ev);
>  static int trace_uprobe_release(struct dyn_event *ev);
>  static bool trace_uprobe_is_busy(struct dyn_event *ev);
> @@ -530,7 +530,7 @@ static int register_trace_uprobe(struct
> trace_uprobe *tu)
>   * Argument syntax:
>   *  - Add uprobe: p|r[:[GRP/]EVENT] PATH:OFFSET[%return][(REF)]
> [FETCHARGS]
>   */
> -static int trace_uprobe_create(int argc, const char **argv)
> +static int __trace_uprobe_create(int argc, const char **argv)
>  {
>  	struct trace_uprobe *tu;
>  	const char *event = NULL, *group = UPROBE_EVENT_SYSTEM;
> @@ -716,14 +716,19 @@ static int trace_uprobe_create(int argc, const
> char **argv)
>  	return ret;
>  }
>  
> -static int create_or_delete_trace_uprobe(int argc, char **argv)
> +int trace_uprobe_create(const char *raw_command)
> +{
> +	return trace_probe_create(raw_command, __trace_uprobe_create);
> +}
> +
> +static int create_or_delete_trace_uprobe(const char *raw_command)
>  {
>  	int ret;
>  
> -	if (argv[0][0] == '-')
> -		return dyn_event_release(argc, argv,
> &trace_uprobe_ops);
> +	if (raw_command[0] == '-')
> +		return dyn_event_release(raw_command,
> &trace_uprobe_ops);
>  
> -	ret = trace_uprobe_create(argc, (const char **)argv);
> +	ret = trace_uprobe_create(raw_command);
>  	return ret == -ECANCELED ? -EINVAL : ret;
>  }
>  
> -- 
> 2.25.1
> 
> 
> 

