Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1922C2F5532
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 00:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbhAMX1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 18:27:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:50210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729416AbhAMXUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 18:20:33 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9353233EA;
        Wed, 13 Jan 2021 23:11:59 +0000 (UTC)
Date:   Wed, 13 Jan 2021 18:11:58 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/bootconfig: Add tracing_on support to helper
 scripts
Message-ID: <20210113181158.1b9df04c@gandalf.local.home>
In-Reply-To: <160749166410.3497930.14204335886811029800.stgit@devnote2>
References: <160749166410.3497930.14204335886811029800.stgit@devnote2>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Just noticed this patch. I'm adding it into my queue for the next merge
window, as it doesn't look too urgent.

-- Steve


On Wed,  9 Dec 2020 14:27:44 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Add ftrace.instance.INSTANCE.tracing_on support to ftrace2bconf.sh
> and bconf2ftrace.sh.
> 
> commit 8490db06f914 ("tracing/boot: Add per-instance tracing_on
> option support") added the per-instance tracing_on option,
> but forgot to update the helper scripts.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  tools/bootconfig/scripts/bconf2ftrace.sh |    1 +
>  tools/bootconfig/scripts/ftrace2bconf.sh |    4 ++++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/tools/bootconfig/scripts/bconf2ftrace.sh b/tools/bootconfig/scripts/bconf2ftrace.sh
> index 595e164dc352..feb30c2c7881 100755
> --- a/tools/bootconfig/scripts/bconf2ftrace.sh
> +++ b/tools/bootconfig/scripts/bconf2ftrace.sh
> @@ -152,6 +152,7 @@ setup_instance() { # [instance]
>  	set_array_of ${instance}.options ${instancedir}/trace_options
>  	set_value_of ${instance}.trace_clock ${instancedir}/trace_clock
>  	set_value_of ${instance}.cpumask ${instancedir}/tracing_cpumask
> +	set_value_of ${instance}.tracing_on ${instancedir}/tracing_on
>  	set_value_of ${instance}.tracer ${instancedir}/current_tracer
>  	set_array_of ${instance}.ftrace.filters \
>  		${instancedir}/set_ftrace_filter
> diff --git a/tools/bootconfig/scripts/ftrace2bconf.sh b/tools/bootconfig/scripts/ftrace2bconf.sh
> index 6c0d4b61e0c2..a0c3bcc6da4f 100755
> --- a/tools/bootconfig/scripts/ftrace2bconf.sh
> +++ b/tools/bootconfig/scripts/ftrace2bconf.sh
> @@ -221,6 +221,10 @@ instance_options() { # [instance-name]
>  	if [ `echo $val | sed -e s/f//g`x != x ]; then
>  		emit_kv $PREFIX.cpumask = $val
>  	fi
> +	val=`cat $INSTANCE/tracing_on`
> +	if [ `echo $val | sed -e s/f//g`x != x ]; then
> +		emit_kv $PREFIX.tracing_on = $val
> +	fi
>  
>  	val=
>  	for i in `cat $INSTANCE/set_event`; do

