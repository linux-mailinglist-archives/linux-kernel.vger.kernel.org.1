Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A48E529F443
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 19:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbgJ2Stj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 14:49:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:38404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbgJ2Stj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 14:49:39 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20B6D20825;
        Thu, 29 Oct 2020 18:49:38 +0000 (UTC)
Date:   Thu, 29 Oct 2020 14:49:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Qiujun Huang <hqjagain@gmail.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v4] tracing: Fix out of bounds write in get_trace_buf
Message-ID: <20201029144935.09c4ce8b@gandalf.local.home>
In-Reply-To: <20201029161905.4269-1-hqjagain@gmail.com>
References: <20201029161905.4269-1-hqjagain@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Oct 2020 00:19:05 +0800
Qiujun Huang <hqjagain@gmail.com> wrote:

> The subscript should be nesting - 1, as nesting had self-added.
> 
> Fixes: 3d9622c12c887 ("tracing: Add barrier to trace_printk() buffer nesting modification")

Thanks, I'll still use the updated change log.

-- Steve

> Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
> ---
> v4:
> Find the right patch which cause the problem.
> v3:
> Modify the way of array reference instead.
> v2:
> Fix a typo in the title.
> ---
>  kernel/trace/trace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 528971714fc6..daa96215e294 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -3132,7 +3132,7 @@ static char *get_trace_buf(void)
>  
>  	/* Interrupts must see nesting incremented before we use the buffer */
>  	barrier();
> -	return &buffer->buffer[buffer->nesting][0];
> +	return &buffer->buffer[buffer->nesting - 1][0];
>  }
>  
>  static void put_trace_buf(void)

