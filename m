Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48C87276C47
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 10:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbgIXIpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 04:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbgIXIpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 04:45:45 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3036C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 01:45:44 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id z19so1466678pfn.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 01:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qcEFUagRFegtRA+c7Q/RWfZQtrVtJdKhlhnvr1c1Zzg=;
        b=tcXIn8tK5lvFVCLf9TZ113Haf08OtFPxoyDDXrkV37Us2tXKaGt+H+BDt8B03DjT+t
         Tnp+rqMxvAAgik9JI11a2Jh/r7kVtYQ/Ee7fI5tRrqNqks5aqFdnasKGLdtS13i1GN6n
         IzahVoDO7Qd+5KuxmQ3KWsW0fOJR+3qK+CdAIfE7wMiLCtdsKUhWZ2IBP/xGwR5RisUN
         4V7h9aNOQCxrU1e1dQEpH/UzEKfouCsdVli23c09Dp5LYga6U8W+58r9drKPkHcfl7uw
         QOM+0iV20wJG/xCyZO4uFMFHH8tJCH19c+aS7x+YeHvQhvz3kJtnFV7yz7tlSHuOV55D
         Ewjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qcEFUagRFegtRA+c7Q/RWfZQtrVtJdKhlhnvr1c1Zzg=;
        b=KqAulGx3IjAxsh8BK7BIcJrugE1iL6hhEQ96+3l/yik7jWWJV7lz7fbNiEfbjiLdyg
         hTdbn8p3m7/jeiRZTN/VBfrWcvmhpzq116iUZavomKmOMJPLs0q47eI1UsNbdjyxe2JY
         HGY9XWGrT2VgxsJVuQG2CFD8NByJZpmYneV1R/nRkWLcEK3/kKwfhHRCHfzuMcXpvqtL
         rEyQTNHg7PgEYIsPwRxWbibVkq//51eOVFQD75/oRfLWoBg3tSqUMv9TC/mSarxNAu0s
         cpJyik950okzlPLKJVY/Xg3wSRnY4HwSnl0z0Z+3+z1EwKuoovi6NrjiA4ZMQ1Dfgx3s
         jkqA==
X-Gm-Message-State: AOAM531RS3GhYH8VUwp819EeNK69iN0kyZ6zUsj70iA8Kd8vxQhT0Q0N
        cP4lUVOaOSN3pOGuU5DK75A=
X-Google-Smtp-Source: ABdhPJwHIj2BhAHbMC1354hH6cMTwV+pRu84kxWYlo+kvN49AGuZQOFnUUBFE4A8iirLvW6Az3EKfg==
X-Received: by 2002:a63:3856:: with SMTP id h22mr3055946pgn.451.1600937144394;
        Thu, 24 Sep 2020 01:45:44 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id o67sm2208680pgo.8.2020.09.24.01.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 01:45:43 -0700 (PDT)
Date:   Thu, 24 Sep 2020 17:45:41 +0900
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
Subject: Re: [PATCH printk 4/5] printk: remove logbuf_lock, add syslog_lock
Message-ID: <20200924084541.GA541@jagdpanzerIV.localdomain>
References: <20200922153816.5883-1-john.ogness@linutronix.de>
 <20200922153816.5883-5-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922153816.5883-5-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/09/22 17:44), John Ogness wrote:
[..]
>  void printk_safe_flush_on_panic(void)
>  {
> -	/*
> -	 * Make sure that we could access the main ring buffer.
> -	 * Do not risk a double release when more CPUs are up.
> -	 */
> -	if (raw_spin_is_locked(&logbuf_lock)) {
> -		if (num_online_cpus() > 1)
> -			return;
> -
> -		debug_locks_off();
> -		raw_spin_lock_init(&logbuf_lock);

If we panic() with syslog_lock locked then we need to zap syslog_lock
and disable debug_locks for kmsg_dump() to succeed. Otherwise panic()
may deadlock:

	syslog_lock_irq()
	-> NMI
		panic()
		...
			printk_safe_flush_on_panic();
			kmsg_dump(KMSG_DUMP_PANIC);	// syslog_lock_irqsave(flags)
		...

Did I miss the point where we make sure that kmsg_dump() will not
deadlock?

	-ss
