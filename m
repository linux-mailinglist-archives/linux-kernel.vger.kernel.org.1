Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04333286C1A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 02:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbgJHAid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 20:38:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:35354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbgJHAid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 20:38:33 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B294207EA;
        Thu,  8 Oct 2020 00:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602117512;
        bh=H/qocNI2hftGBcrST8buDAfvQgAF6ShTxtWAxGgNncM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jHxQwEDANdug0DL6sGGJBg8CbfKw00x/cb5egt/rVMGv3O1I4Z7W4DBuzZNTDa9W8
         ovqg6NwayPiryPE6DAGq4aq8NMzR26Mya/yp0lg6DcM6uYzFNq1Ao75TrCfpaPSpd+
         hpkmpn4h4/6vXM8SoEyzs8fD1EAeB3JG3HVFKNik=
Date:   Thu, 8 Oct 2020 09:38:28 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, axelrasmussen@google.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/7] tracing: Add README information for
 synthetic_events file
Message-Id: <20201008093828.d9ac6e49299e0e4f79c349eb@kernel.org>
In-Reply-To: <3c7f178cf95aaeebc01eda7d95600dd937233eb7.1601848695.git.zanussi@kernel.org>
References: <cover.1601848695.git.zanussi@kernel.org>
        <3c7f178cf95aaeebc01eda7d95600dd937233eb7.1601848695.git.zanussi@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

On Sun,  4 Oct 2020 17:14:07 -0500
Tom Zanussi <zanussi@kernel.org> wrote:

> Add an entry with a basic description of events/synthetic_events along
> with a simple example.
> 
> Signed-off-by: Tom Zanussi <zanussi@kernel.org>

This looks good to me.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

> ---
>  kernel/trace/trace.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 3f2533adae72..73fd0e0c0f39 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -5249,7 +5249,12 @@ static const char readme_msg[] =
>  	"\t        trace(<synthetic_event>,param list)  - generate synthetic event\n"
>  	"\t        save(field,...)                      - save current event fields\n"
>  #ifdef CONFIG_TRACER_SNAPSHOT
> -	"\t        snapshot()                           - snapshot the trace buffer\n"
> +	"\t        snapshot()                           - snapshot the trace buffer\n\n"
> +#endif
> +#ifdef CONFIG_SYNTH_EVENTS
> +	"  events/synthetic_events\t- Create/append/remove/show synthetic events\n"
> +	"\t  Write into this file to define/undefine new synthetic events.\n"
> +	"\t     example: echo 'myevent u64 lat; char name[]' >> synthetic_events\n"
>  #endif
>  #endif
>  ;
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
