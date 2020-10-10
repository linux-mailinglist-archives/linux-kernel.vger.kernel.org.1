Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2710828A2A3
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 00:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731956AbgJJW7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:59:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:57024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731597AbgJJTyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 15:54:09 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBF5B222C8;
        Sat, 10 Oct 2020 14:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602340920;
        bh=l40I3V9XZsVpiqUpsyzie5lpeXH9YHQ/A9SSooKOE38=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FcDoGORY7C8dbkfPBEa5qwYvtlJ4uii9AQh0nCym4DrzydFDk9AxokWTYEIBK/TDM
         OPaHWrTB6ZDg+M+8GvT2xDmNMdS7Rp2yZL3Hoyi0spg5vzN2B+k3eIsAWNyx/Hb9/u
         n9iJCbo+qIUZYF9/WmpfeeZHhg7l+R4SiIlREB2E=
Date:   Sat, 10 Oct 2020 23:41:56 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, axelrasmussen@google.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] tracing: Check that the synthetic event and field
 names are legal
Message-Id: <20201010234156.61a8743510a05878ccfda0bf@kernel.org>
In-Reply-To: <82b1b533c54f83bb7cd466a32244533717c8f291.1602255803.git.zanussi@kernel.org>
References: <cover.1602255803.git.zanussi@kernel.org>
        <82b1b533c54f83bb7cd466a32244533717c8f291.1602255803.git.zanussi@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  9 Oct 2020 10:17:09 -0500
Tom Zanussi <zanussi@kernel.org> wrote:

> Call the is_good_name() function used by probe events to make sure
> synthetic event and field names don't contain illegal characters and
> cause unexpected parsing of synthetic event commands.
> 

I've tested it. This looks good to me.

/sys/kernel/debug/tracing # echo "myevent char str]" >> synthetic_events 
sh: write error: Invalid argument
/sys/kernel/debug/tracing # echo "myevent char str;[]" >> synthetic_events 
sh: write error: Invalid argument

It works correctly now :)

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

> Fixes: 4b147936fa50 (tracing: Add support for 'synthetic' events)
> Reported-by: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Tom Zanussi <zanussi@kernel.org>
> ---
>  kernel/trace/trace_events_synth.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
> index b19e2f4159ab..8c9d6e464da0 100644
> --- a/kernel/trace/trace_events_synth.c
> +++ b/kernel/trace/trace_events_synth.c
> @@ -572,6 +572,10 @@ static struct synth_field *parse_synth_field(int argc, const char **argv,
>  		ret = -ENOMEM;
>  		goto free;
>  	}
> +	if (!is_good_name(field->name)) {
> +		ret = -EINVAL;
> +		goto free;
> +	}
>  
>  	if (field_type[0] == ';')
>  		field_type++;
> @@ -1112,6 +1116,11 @@ static int __create_synth_event(int argc, const char *name, const char **argv)
>  
>  	mutex_lock(&event_mutex);
>  
> +	if (!is_good_name(name)) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
>  	event = find_synth_event(name);
>  	if (event) {
>  		ret = -EEXIST;
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
