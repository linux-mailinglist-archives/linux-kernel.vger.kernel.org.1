Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B43128A309
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 01:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732112AbgJJW7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:59:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:57032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731620AbgJJTyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 15:54:11 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5926720776;
        Sat, 10 Oct 2020 15:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602342228;
        bh=xGydme+UTV4NKZi6UvEPEeCFfn0iIC8Oj9EpAiXdy5Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EezBVq+qYtujYEV7awQcPBPp7Se6Ebzh9AuAq56e5AOD3lzLp6VlNBENcOjxOl6PD
         UUouMBBQqZ3ZAUi52rzSHqc5/DyvlNQuxwkezscH1M+7RweUdByJjjr3XZZrx8qDHm
         sz26hp80dilYI+0HsuV5v5TkCBaACy1B7N//qluA=
Date:   Sun, 11 Oct 2020 00:03:44 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, axelrasmussen@google.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] tracing: Don't show dynamic string internals in
 synthetic event description
Message-Id: <20201011000344.4056fd1b0e8a7e48f2677ac0@kernel.org>
In-Reply-To: <b3b7baf7813298a5ede4ff02e2e837b91c05a724.1602255803.git.zanussi@kernel.org>
References: <cover.1602255803.git.zanussi@kernel.org>
        <b3b7baf7813298a5ede4ff02e2e837b91c05a724.1602255803.git.zanussi@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

On Fri,  9 Oct 2020 10:17:07 -0500
Tom Zanussi <zanussi@kernel.org> wrote:

> For synthetic event dynamic fields, the type contains "__data_loc",
> which is basically an internal part of the type which is only meant to
> be displayed in the format, not in the event description itself, which
> is confusing to users since they can't use __data_loc on the
> command-line to define an event field, which printing it would lead
> them to believe.
> 
> So filter it out from the description, while leaving it in the type.
> 

OK, I confirmed this removes __data_loc from synth_events interface.
However, I also found another issue.

  /sys/kernel/debug/tracing # echo "myevent char str[]; int v" >> synthetic_events  
  /sys/kernel/debug/tracing # cat synthetic_events 
  myevent	char[]; str; int v

It seems that the type "char[]" includes ";" as a type, this results


  /sys/kernel/debug/tracing # cat events/synthetic/myevent/format 
  name: myevent
  ID: 1220
  format:
	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
	field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
	field:int common_pid;	offset:4;	size:4;	signed:1;

	field:__data_loc char[]; str;	offset:8;	size:8;	signed:1;
	field:int v;	offset:16;	size:4;	signed:1;

  print fmt: "str=%.*s, v=%d", __get_str(str), REC->v


As you can see, the field type has ";" in format file too. This will prevent
parsing event information correctly.
I also try to remove ";" as below, it seems to work correctly.

  /sys/kernel/debug/tracing # echo "myevent char[] str; int v" >> synthetic_events 
  /sys/kernel/debug/tracing # cat events/synthetic/myevent/format 
  name: myevent
  ID: 1221
  format:
	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
	field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
	field:int common_pid;	offset:4;	size:4;	signed:1;

	field:__data_loc char[] str;	offset:8;	size:8;	signed:1;
	field:int v;	offset:16;	size:4;	signed:1;

  print fmt: "str=%.*s, v=%d", __get_str(str), REC->v


Thank you,

> Reported-by: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Tom Zanussi <zanussi@kernel.org>
> ---
>  kernel/trace/trace_events_synth.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
> index 3b2dcc42b8ee..b19e2f4159ab 100644
> --- a/kernel/trace/trace_events_synth.c
> +++ b/kernel/trace/trace_events_synth.c
> @@ -1867,14 +1867,22 @@ static int __synth_event_show(struct seq_file *m, struct synth_event *event)
>  {
>  	struct synth_field *field;
>  	unsigned int i;
> +	char *type, *t;
>  
>  	seq_printf(m, "%s\t", event->name);
>  
>  	for (i = 0; i < event->n_fields; i++) {
>  		field = event->fields[i];
>  
> +		type = field->type;
> +		t = strstr(type, "__data_loc");
> +		if (t) { /* __data_loc belongs in format but not event desc */
> +			t += sizeof("__data_loc");
> +			type = t;
> +		}
> +
>  		/* parameter values */
> -		seq_printf(m, "%s %s%s", field->type, field->name,
> +		seq_printf(m, "%s %s%s", type, field->name,
>  			   i == event->n_fields - 1 ? "" : "; ");
>  	}
>  
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
