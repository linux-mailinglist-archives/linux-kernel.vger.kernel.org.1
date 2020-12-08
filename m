Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38E3D2D34A1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 22:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbgLHUw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 15:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727193AbgLHUw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 15:52:27 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3645DC0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 12:51:41 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id u4so1929590plr.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 12:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IDh1X7OB7wW8jbY8KXws0mweSxrU0MD7uaeCBRTpxI4=;
        b=BuT/VqEtkyxPV+Bb5g5ZS76YF4g46mfxn22JjYtqxYsYpZIXcEHaWhHkmAUTOC82dD
         o5ZhFxiZFBwLdR15mLm5sTKV7SOrIt5e3E5et/a7SOmzSELTcgDQIDM3GaiNoR6lCNIg
         taOzVyA+1S6l8GlBh1NuxgNy+El2nUSpz+rYn9yiUBd5Td9CLiGZbdE4iUhyRzZ6YVN9
         +uhFmx6stxm4DyTJrj94Vrk27rHtkgMmBv30zKL1mFXQeoxeGQRveDxj1XpP00sQo4Oe
         1CBLgQ2Kd19sYpqSJxtfeb1lNJtz/rwHaoscoiW4wIERtUvtBO+YR2/aBlw+ImuQDEOC
         h8Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IDh1X7OB7wW8jbY8KXws0mweSxrU0MD7uaeCBRTpxI4=;
        b=jeph9hi5ZBRlsuS1mNzY5FqH2tZcH3qc7P/X97eI1zSjh0FNOWD6WLdFaXpYLN0RSc
         HfLfMmHXgb+qBbsIf2v/lp59TTgGsvSNMba7hOnUlhjgOJSgF1b79OorUZWaDi+FfFYZ
         L2LH1EG7DTFiDtWSZxtnKYcqWlF9zvIxTNowTIz2a3g3LFlYDvlIN7z+pDlSexnFq9c+
         yLND6TkvyiMX6+wJX/eM44aF362RdgusFhSy04T4rqN8lbfHeLBmnTBWM8rb+UzwSwRj
         8VEPot/IkDWshrZAMQka9h8q/k5UZSYeMd5Aubv5iX5yH0UZSK4Hzj6bMLxGj0L+DNQ6
         C1KQ==
X-Gm-Message-State: AOAM530tZHClr86H+fgW70VvRT4VreKfS36AAXhkcLFXoCcOuomiLW8/
        jkYzoAdG7W+CDK/eQ6UK4o8=
X-Google-Smtp-Source: ABdhPJwYfGUca0k7wAXMk4KHtDu1qAKlqwa/YKCCkTjvnk0A7b7tq7c0sV7T/nj4ZX8+QId9aZFS/g==
X-Received: by 2002:a17:902:aa8b:b029:da:ef22:8675 with SMTP id d11-20020a170902aa8bb02900daef228675mr1319869plr.15.1607460700672;
        Tue, 08 Dec 2020 12:51:40 -0800 (PST)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id x10sm26156pff.214.2020.12.08.12.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 12:51:39 -0800 (PST)
Date:   Wed, 9 Dec 2020 05:51:37 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: consoles: was: [PATCH next v2 3/3] printk: remove logbuf_lock,
 add syslog_lock
Message-ID: <X8/nWUD1bKeQQ74Z@jagdpanzerIV.localdomain>
References: <20201201205341.3871-1-john.ogness@linutronix.de>
 <20201201205341.3871-4-john.ogness@linutronix.de>
 <X8phf/jITFd7nV38@alley>
 <X8sPGfe2kWkAqsl1@jagdpanzerIV.localdomain>
 <X836yrIxyIp5y+Qq@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X836yrIxyIp5y+Qq@alley>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/12/07 10:50), Petr Mladek wrote:
[..]
> > and then some call into the scheduler
> > (or other kernel core functions) under semaphore's spin_lock.
> > For instance
> > 
> > 	up()
> > 	 raw_spin_lock_irqsave(&sem->lock)
> > 	   __up()
> > 	     wake_up_process()
> > 	       try_to_wake_up()
> 
> This problem is partly solved by printk_deferred(). In each
> case, printk_safe() does not help here.

printk_deferred() has never been used in all the critical code paths.
So I think printk_safe does help here; it takes care of all the
remaining cases, that are not "partly solved by printk_deferred()".

> I still do _not_ see a reason to keep printk_safe()!

Not sure I'm following, sorry. To put it simply - we better keep
printk_safe until "new recursion prevention" >= printk_safe().
In this patch set "new recursion prevention" < printk_safe().

	-ss
