Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBD7029F41A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 19:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725807AbgJ2Saa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 14:30:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:34678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725648AbgJ2Saa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 14:30:30 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F09DA20732;
        Thu, 29 Oct 2020 18:30:28 +0000 (UTC)
Date:   Thu, 29 Oct 2020 14:30:26 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Qiujun Huang <hqjagain@gmail.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v3] tracing: Fix out of bounds write in get_trace_buf
Message-ID: <20201029143026.420e25ec@gandalf.local.home>
In-Reply-To: <20201029155714.3935-1-hqjagain@gmail.com>
References: <20201029155714.3935-1-hqjagain@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Oct 2020 23:57:14 +0800
Qiujun Huang <hqjagain@gmail.com> wrote:

> The subscript should be nesting - 1, as nesting had self-added.

Thanks Qiujun! I'll add this to my urgent queue, and mark it for stable.

I'll update the change log to state:

"The nesting count of trace_printk allows for 4 levels of nesting. The
nesting counter starts at zero and is incremented before being used to
retrieve the current context's buffer. But the index to the buffer uses the
nesting counter after it was incremented, and not its original number,
which in needs to do."

-- Steve

> 
> Fixes: e2ace001176dc ("tracing: Choose static tp_printk buffer by explicit nesting count")
> Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
> ---
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

