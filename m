Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2C552765C8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 03:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgIXBVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 21:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgIXBVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 21:21:36 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F55C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 18:21:36 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id j7so714665plk.11
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 18:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=igPpRkqz2XyzMzkU8JuUgO7QxgO9fdrNQoEexwdzcUg=;
        b=EBjVIhB6OfDRJIAiUCR71d+gb2psevpXoene0AJ0nRFcULfdopK8KrdPe/F9FJmCgb
         8zi0VOXHlCWVdfWSjra+UEk282IjLmLZUPtV0WVzViQP05tIwRO1xcKCT/iUWraLYj2r
         71lzww5GhZmX+iC5NnNOmqvdXdr28L7lIeccP9wUD0gIIo1stLkoYrQ58mStb0diOMw+
         Yj5RcV1OgCYmmA3nesfaxrtuJtbjqDGmq+LzrODoJIPD2cGWkBDuGgRBL1TiMXJldP/o
         /OnQtbhuC8Ys6XxcrwPwPeH/KvHLnDAemjCcR6n/3ddOjGkdG5U4iGcskMsZmXNqEFK0
         QN6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=igPpRkqz2XyzMzkU8JuUgO7QxgO9fdrNQoEexwdzcUg=;
        b=n2mogvEdD3DKc98uRgV2vDpFdz69oa8Ob/7s2HhVjuaFZSVXnJ/Cnp9WOK2QYaPM2b
         RN8Oh/3v/GvOaUJvMmp7w47vdh9ugf0o9PY9r/QjXXQ2J0ujnP07EIS58sc6iM1RFsyx
         gpUTwXowN6PlaODZas7jqveMqDPH6lxtxP6N+DxymkSPqyza3gjaSoYdWBqk1DWa3xG5
         btPAHCxwhxC3o783NIZTUEbMd9M+W+40dsS0G3oAH6C+2k5cpJCWEfia0gXHA7hdTZIE
         5SDErlmZs1OD3ZgCxNuLqYPy/iqH8GPXj62a/TqgKypQ2eUPkbVSTntwGyTgAvyoeiEr
         csPQ==
X-Gm-Message-State: AOAM531d0TNxYQS4xVbbLqYZJYsxibKnw/SBlU2q5CbH96mbeMQg8P9E
        QEDqrx2RYBOVpCY8mXv4y5g=
X-Google-Smtp-Source: ABdhPJywyJR9mm2o+4PGbq261WDOkrGKnAyW2YEZZ/IUYEFFQLVDsIB/k2pYKCOn3b1vZeffmps+fg==
X-Received: by 2002:a17:902:6941:b029:d0:cbe1:e705 with SMTP id k1-20020a1709026941b02900d0cbe1e705mr2313216plt.19.1600910495483;
        Wed, 23 Sep 2020 18:21:35 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id 9sm906898pgx.76.2020.09.23.18.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 18:21:34 -0700 (PDT)
Date:   Thu, 24 Sep 2020 10:21:32 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk 3/5] printk: use buffer pool for sprint buffers
Message-ID: <20200924012132.GA577@jagdpanzerIV.localdomain>
References: <20200922153816.5883-1-john.ogness@linutronix.de>
 <20200922153816.5883-4-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922153816.5883-4-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/09/22 17:44), John Ogness wrote:
[..]
>  int vprintk_store(int facility, int level,
>  		  const struct dev_printk_info *dev_info,
>  		  const char *fmt, va_list args)
>  {
> -	static char textbuf[LOG_LINE_MAX];
> -	char *text = textbuf;
>  	size_t text_len;
>  	enum log_flags lflags = 0;
> +	unsigned long irqflags;
> +	int sprint_id;
> +	char *text;
> +	int ret;
> +
> +	text = get_sprint_buf(&sprint_id, &irqflags);
> +	if (WARN_ON_ONCE(!text))
> +		return 0;

So we failed to get the buffer. How likely that this recursive
WARN_ON_ONCE()->printk()->get_sprint_buf() will be able to get one?
I would rather expect that we will entirely lose WARN_ON_ONCE().

	-ss
