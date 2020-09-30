Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86A9727E571
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 11:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbgI3JnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 05:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbgI3JnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 05:43:20 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCC6C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 02:43:20 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id j19so615220pjl.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 02:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=61ICL5zGRKO1MItWicMgfip9KgfsfXP7VLKSUqqkDX0=;
        b=mL1EEWFVw8ebVC4bZf1PgbnvWrqasu+uXouOLBDrj8IVNXTTdgavypRRgqhrslFxND
         +3F5sUfJLS7I/dk+uSwSXCQ/1sN5vb/ZqyhzAMsAa2IBnVL+mRH2+LPngrTKixnNoqhv
         XkhYm8YsapWe5Sa/eY43xlr3+bqGJR9kYlS+wjFor05lRtWMia1R7MgJdg0ddtxvFmmo
         odArMhL8+r5lCusFBDMn99KSnjHiLlX/bLtE3vE1kft6Vfx4TgUN8pl+8VOUqq50O+oi
         E8CS+6E0ffpi0MMfA+oNXGFgvagJkWrqBQlQ+dCkvCTEBv3vRW99goxDyegOrqf6ApYp
         i23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=61ICL5zGRKO1MItWicMgfip9KgfsfXP7VLKSUqqkDX0=;
        b=qRHbsUkTthE0ZfWbZYSqH4ZQ01p1ln53gjCRzbtHXzFH5BUhCKavQJUrsg4VQmqotc
         r5/2TW+y1d7HwFj08glMiJ0BJ22NIQq8YgMgB+YuYLBznseD++qF8AYHBroSYhmRH8tM
         xAPvQuaI/3U6yQc/AsSE1s5w72XcW/7AWj/Z8C0ROO4dfK5fCeOHjZ6MpdXZjJ0Xl5GD
         0mE/5Fz6F9Su+ntFy+KxhLUO8wJjai7j+KJoZ+F4tXp7FSlZcmXGpDL26MjUqXXgcMGw
         TCaErr9Bl2V7VLuv5F7hXOXn/on66F/5udewjWIdGTZ0meZ6/B7fU6CijAPKviA4wrQa
         abrQ==
X-Gm-Message-State: AOAM530lxt8JIRFfqJXa9wK2qTgMlouBRTwGJS2jfO4CDNHQSdJvFHC6
        SFZ1kPHndLvOE69tImB0Kt8=
X-Google-Smtp-Source: ABdhPJxSTThKSRvV6EhogUATCfiWXxKrZIYhF84v2z4J7Uv6mV90oz9eh/SYtEOpAMhZX/ZHYwwtsQ==
X-Received: by 2002:a17:902:c151:b029:d2:42a6:2fb with SMTP id 17-20020a170902c151b02900d242a602fbmr1734221plj.10.1601458999592;
        Wed, 30 Sep 2020 02:43:19 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id l79sm1832160pfd.210.2020.09.30.02.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 02:43:18 -0700 (PDT)
Date:   Wed, 30 Sep 2020 18:43:16 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next v2 1/2] printk: avoid and/or handle record truncation
Message-ID: <20200930094316.GB987@jagdpanzerIV.localdomain>
References: <20200930090134.8723-1-john.ogness@linutronix.de>
 <20200930090134.8723-2-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930090134.8723-2-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/09/30 11:07), John Ogness wrote:
[..]
> @@ -1389,6 +1391,9 @@ bool prb_reserve_in_last(struct prb_reserved_entry *e, struct printk_ringbuffer
>  		if (!data_check_size(&rb->text_data_ring, r->text_buf_size))
>  			goto fail;
>  
> +		if (r->text_buf_size > max_size)
> +			goto fail;
> +
>  		r->text_buf = data_alloc(rb, &rb->text_data_ring, r->text_buf_size,
>  					 &d->text_blk_lpos, id);
>  	} else {
> @@ -1410,6 +1415,9 @@ bool prb_reserve_in_last(struct prb_reserved_entry *e, struct printk_ringbuffer
>  		if (!data_check_size(&rb->text_data_ring, r->text_buf_size))
>  			goto fail;
>  
> +		if (r->text_buf_size > max_size)
> +			goto fail;
> +
>  		r->text_buf = data_realloc(rb, &rb->text_data_ring, r->text_buf_size,
>  					   &d->text_blk_lpos, id);
>  	}
[..]

>  bool prb_reserve_in_last(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
> -			 struct printk_record *r, u32 caller_id);
> +			 struct printk_record *r, u32 caller_id, unsigned int max_size);

Isn't `max_size' always LOG_LINE_MAX?

	-ss
