Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 995F3302A06
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 19:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbhAYSV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 13:21:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41708 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726642AbhAYSVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 13:21:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611598775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H4TSNt/4SXvDlED+RMxB+tDfc6cFdU946xMQ2FUbIlY=;
        b=iK98xf6duQc1xWgK0KME3N5qlJXYoEMkFvpoRnDgJh5fbImK+tpEDhdbfVLxHxoqqdP+3K
        MCjhxrmLTT99XJqFmsg/GNcJVRnf/9r7dwrYkwoZ2DhmVSxajo5QqbCA76GrgWpDE6wmqH
        +zzJC98IYFE/mArUESEl7yqqmRj2MF0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-MDt6SEWsP-SXDCCjfd8nlQ-1; Mon, 25 Jan 2021 13:19:31 -0500
X-MC-Unique: MDt6SEWsP-SXDCCjfd8nlQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CAE13190D341;
        Mon, 25 Jan 2021 18:19:29 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.128])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6493E19C47;
        Mon, 25 Jan 2021 18:19:28 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 25 Jan 2021 19:19:29 +0100 (CET)
Date:   Mon, 25 Jan 2021 19:19:27 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Jianlin Lv <Jianlin.Lv@arm.com>
Cc:     rostedt@goodmis.org, mingo@redhat.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tracing: precise log info for kretprobe addr err
Message-ID: <20210125181926.GA10248@redhat.com>
References: <20210125160108.2147511-1-Jianlin.Lv@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210125160108.2147511-1-Jianlin.Lv@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/26, Jianlin Lv wrote:
>
> When trying to create kretprobe with the wrong function symbol in tracefs;
> The error is triggered in the register_trace_kprobe() and recorded as
> FAIL_REG_PROBE issue,
>
> Example:
>   $ cd /sys/kernel/debug/tracing
>   $ echo 'r:myprobe ERROR_SYMBOL_XXX ret=%x0' >> kprobe_events
>     bash: echo: write error: Invalid argument
>   $ cat error_log
>     [142797.347877] trace_kprobe: error: Failed to register probe event
>     Command: r:myprobe ERROR_SYMBOL_XXX ret=%x0
>                        ^
>
> This error can be detected in the parameter parsing stage, the effect of
> applying this patch is as follows:
>
>   $ echo 'r:myprobe ERROR_SYMBOL_XXX ret=%x0' >> kprobe_events
>     bash: echo: write error: Invalid argument
>   $ cat error_log
>     [415.89]trace_kprobe: error: Retprobe address must be an function entry
>     Command: r:myprobe ERROR_SYMBOL_XXX ret=%x0

IOW, the "offset != 0" check removed by this patch is obviously wrong, right?

Agreed, but...

> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -830,7 +830,7 @@ static int trace_kprobe_create(int argc, const char *argv[])
>  			flags |= TPARG_FL_RETURN;
>  		if (kprobe_on_func_entry(NULL, symbol, offset))
>  			flags |= TPARG_FL_FENTRY;
> -		if (offset && is_return && !(flags & TPARG_FL_FENTRY)) {
> +		if (!strchr(symbol, ':') && is_return && !(flags & TPARG_FL_FENTRY)) {

but why did you add the strchr(':') check instead?

I was really puzzled until I found the this email from Masami:
https://lore.kernel.org/lkml/20210120131406.5a992c1e434681750a0cd5d4@kernel.org/

So I leave this to you and Masami, but perhaps you can document this check at
least in the changelog?

Oleg.

