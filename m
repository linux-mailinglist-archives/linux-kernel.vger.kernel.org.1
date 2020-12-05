Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3372CF953
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 05:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbgLEEki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 23:40:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgLEEki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 23:40:38 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6234CC0613D1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 20:39:57 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id h7so4733943pjk.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 20:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dDsaAUqDcV3mkLWcdIvqwiC9jKLLEexcbhVFGjFuSCM=;
        b=TBa7hXSvL00GfYL1BJGGOgLClR65+euQ//6xwJHIXI2zw1mYaTHIAPTVhfxNJdYhxt
         PlzS4wUcik1uA7Hh0pcFMLmOAVRxmrBeZ0K5UET92VBOZI6q6gUckbmzRhxewIhoeBVW
         osPsrfLXkzLFHUMmJlEOon3+FImzaZ5dISCbSvD0D8V7Uk9T+6yGHg597Spg82bhb5X+
         FL8J9nXA9uX7bEt8OyXyUREfhtoyIDgR9nNqhYTReShQHgNWdPGkTiIP+9ONu0dR2nDV
         qjKcJcb6BcRplTOtzGEbYn/D6A/cvRj2uJWUgNsfV6k0PaXN7AXKYzsVpDM8gw9BZNfj
         iyvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dDsaAUqDcV3mkLWcdIvqwiC9jKLLEexcbhVFGjFuSCM=;
        b=XA6Bn5HJAR2Zwu9YOQe4w28E0q7CImAq/IMO/uv6s1x3VNtL8aCa8teNzhy4Finoxw
         THDiHTusym1jyCeU+sOvNQ1lVi296tHI/MrOdJAUzvUSygw7fnhnC53Nwk2EqBsqKYh9
         0pkQ3K2cVOuVbR45z1le29f34ClWA6q074Sm70c3QYpJrYVmB6BCzP9zgAatAQQwC0tV
         F68eMQNFodbqjG03U9cPhih7DiauGJvxbQwGvTgOna2uM9iea88z2EFHVCYpA3la7k35
         rZ8gUwSEk46UyePMFz6YCN1ht8wkFi1G2g/A6W5P/5v04XXIDRXV54fQ0FuEQHtNblwX
         Z1Ng==
X-Gm-Message-State: AOAM5308P1ZkfuLQRlGhExbmMj7MRaCdJgNbifW/Gj+62zWBrYGN8IrL
        XFMgduIwiDtxXuM0MB/bYWo=
X-Google-Smtp-Source: ABdhPJwZIgLcHEgOOAwIBaNkKYU8hih+hV8/z2jf5A/E4T9mOkJ47zDlEduMIjMNywDBWBCyOdxD1Q==
X-Received: by 2002:a17:90a:1bc7:: with SMTP id r7mr3093003pjr.33.1607143196801;
        Fri, 04 Dec 2020 20:39:56 -0800 (PST)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id s30sm5462196pgl.39.2020.12.04.20.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 20:39:55 -0800 (PST)
Date:   Sat, 5 Dec 2020 13:39:53 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: consoles: was: [PATCH next v2 3/3] printk: remove logbuf_lock,
 add syslog_lock
Message-ID: <X8sPGfe2kWkAqsl1@jagdpanzerIV.localdomain>
References: <20201201205341.3871-1-john.ogness@linutronix.de>
 <20201201205341.3871-4-john.ogness@linutronix.de>
 <X8phf/jITFd7nV38@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X8phf/jITFd7nV38@alley>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/12/04 17:19), Petr Mladek wrote:
[..]
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -2432,7 +2490,6 @@ void console_unlock(void)
> >  		size_t len;
> >  
> >  		printk_safe_enter_irqsave(flags);
> 
> Why do we actually need to use the printk_safe context here?
> There is not longer a risk of deadlock caused by logbuf_lock.
> All other recursions should be prevented by console_trylock()
> in printk().

All semaphore functions, including down_trylock(), acquire
semaphore spin_lock; and then some call into the scheduler
(or other kernel core functions) under semaphore's spin_lock.
For instance

	up()
	 raw_spin_lock_irqsave(&sem->lock)
	   __up()
	     wake_up_process()
	       try_to_wake_up()

	-ss
