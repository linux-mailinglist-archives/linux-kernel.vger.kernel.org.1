Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 161BD2D3453
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 21:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731488AbgLHUgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 15:36:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgLHUgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 15:36:23 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CC4C06179C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 12:35:43 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id p6so7581326plr.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 12:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g0rRBmreHzUF5Wz84oY1Ijp3vDw215QBnXCFr+jcEsM=;
        b=N4V92l7nE5nAvps8UBNcfHY2QUljmCVVPctgALxoV47Iehcx1gcJw7AhfVbw4Z/Kfn
         2ZpsjNDhY4pBI/SHQhM/c9orrrJx4DDBhtx1EJR6O3oCxCkqHnBreZxpa0RolxmnMHvQ
         51v0l8/xnBW8H76l6+UEzz3Z+hC7Ous4ISTs+jxzEM+buSC5BwAK1nM8V5S0auFxfQJo
         Te7UawIC4y9sgbW5khgOaryKtZV6Bzx/qEuj8PkIb+6tfgZJ5Fzu6CaFFc22j+1nece/
         e8Icby5/Zk/RzVsES4/4mcpxouhX8P8+oY/J7YPQ/rESwxfm4Len0NQxAszCJgIhCjzT
         jQvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g0rRBmreHzUF5Wz84oY1Ijp3vDw215QBnXCFr+jcEsM=;
        b=YuzormK/uoa3z8uDlfwOj8xjeFMqDGwIijVxZmm3HJR7Zf/BtxwaSLN2NGTqTIlLN0
         0IAVqW/0Rbjrk5LyLhJAD6zZQqMapfXlMaLWEHymjWewMTFn/XWft4d6Yopuv//jiFVR
         rxrw16OYDK3xPZwK8C9T4UNS2ZuUEEOPfYCXnByiR5MfJ5j26r6qE/9LiXib/4yoMLam
         Ad1tkoBSaQmHcI4oNYWiZoMNR4yuKKzvckvEtQ1nqjRnmzc9y2GX7WiF7HRJo9gxXf3k
         ms55/01oE9t2s/RlC6JJH+l1BXI0szGRNZ8UE62Q6oaT2yKUQL4kwVZAxbtClRLyqrvx
         gk4w==
X-Gm-Message-State: AOAM5305CbTI3qzaJU+C5qjnWRQE5nF24ICYiJEUTkKtNt3m7zMF6cc3
        lOfUE0dyf/6sTCkrH0V0+J0=
X-Google-Smtp-Source: ABdhPJzcyMMXm3AgehMNohdGeo2TCCACxKHFAkdKRWiot5qX90Md8s7EZTf8TLAw27IlJ8TdJFtugA==
X-Received: by 2002:a17:902:82c7:b029:da:cb88:38f8 with SMTP id u7-20020a17090282c7b02900dacb8838f8mr22870339plz.49.1607459742612;
        Tue, 08 Dec 2020 12:35:42 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:a6ae:11ff:fe11:4b46])
        by smtp.gmail.com with ESMTPSA id y2sm33426pfe.10.2020.12.08.12.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 12:35:41 -0800 (PST)
Date:   Wed, 9 Dec 2020 05:35:39 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next v3 3/3] printk: remove logbuf_lock protection for
 ringbuffer
Message-ID: <20201208203539.GB1667627@google.com>
References: <20201207222020.2923-1-john.ogness@linutronix.de>
 <20201207222020.2923-4-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207222020.2923-4-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/12/07 23:26), John Ogness wrote:
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index e1f068677a74..f3c0fcc3163f 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1068,7 +1068,6 @@ void __init setup_log_buf(int early)
>  	struct printk_record r;
>  	size_t new_descs_size;
>  	size_t new_infos_size;
> -	unsigned long flags;
>  	char *new_log_buf;
>  	unsigned int free;
>  	u64 seq;
> @@ -1126,8 +1125,6 @@ void __init setup_log_buf(int early)
>  		 new_descs, ilog2(new_descs_count),
>  		 new_infos);
>  
> -	logbuf_lock_irqsave(flags);
> -
>  	log_buf_len = new_log_buf_len;
>  	log_buf = new_log_buf;
>  	new_log_buf_len = 0;
> @@ -1143,8 +1140,6 @@ void __init setup_log_buf(int early)
>  	 */
>  	prb = &printk_rb_dynamic;
>  
> -	logbuf_unlock_irqrestore(flags);

logbuf_lock_irqsave() does two things - it locks the logbuf lock and
enables the printk_safe gating. While we can drop the former, the
latter one must stay until we have a complete replacement.

Looking more:

> ---
>	logbuf_lock_irqsave(flags);
>
>	log_buf_len = new_log_buf_len;
>	log_buf = new_log_buf;
>	new_log_buf_len = 0;
>
>	free = __LOG_BUF_LEN;
>	prb_for_each_record(0, &printk_rb_static, seq, &r)
>		free -= add_to_rb(&printk_rb_dynamic, &r);
>
>	/*
>	 * This is early enough that everything is still running on the
>	 * boot CPU and interrupts are disabled. So no new messages will
>	 * appear during the transition to the dynamic buffer.
>	 */
>	prb = &printk_rb_dynamic;
>
>	logbuf_unlock_irqrestore(flags);
---

I'd say that I'd prefer to keep logbuf initialisation under printk_safe(),
per-CPU buffer can be already initialised at this point. Strictly speaking
we can have new message during transition to the dynamic buffer - there are
functions there that can pr_err/warn while we prb_for_each_record/add_to_rb.

>	-ss
