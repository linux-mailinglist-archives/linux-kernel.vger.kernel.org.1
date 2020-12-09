Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 247542D411B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 12:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730787AbgLIL3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 06:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730497AbgLIL3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 06:29:35 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA750C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 03:28:55 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id y8so770312plp.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 03:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rGk4yN6GMLzTcflJyDvU9agoEbLFqvaw6HVCUpm/9cw=;
        b=AuECYvUl8DM9+eYl3j+ur8bzPFZSo4y4YB1Zr0gAYSYvnJCksw63VR5gF66hguBjdz
         m0AxMdwJiijBt5W0uXK5iv9kdczWIfbr8J5qxvyJr9Cn6FFEoGUHTBr9QuAbpWUfm4B0
         U14Gr1bHm0hnMHL5tqouqmProflkQy4CPdMODf6tOxLsbvoVPHtWmdMBZpXbHirBWthx
         lcHV2IbzgUAgV3WCufO6ayKMwsx6kiyo4nlB768pnl1NSx1O2ZPpsM96yicWBM1hsgdM
         7/4G0Eavnt+C5mZjz6pSdJZN6KOjmizMFYXwOoxu7Ig//XsSwXi+ajdSOm92wmeIIocw
         c+mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rGk4yN6GMLzTcflJyDvU9agoEbLFqvaw6HVCUpm/9cw=;
        b=PHzXnhHCKpVTTW4mAHEyxpywakKfcchg4Nfgpjmse+OuVdkNKMR9uQZ9kkLTLc+wDu
         cOuo4AY3tHhK26ArVi9ZCyr+ULNFDNr87v4K1ID6dBFlvnhddnxGpjkhNhJ9r2UfvfKz
         YyGw88OhP9710+Glg4fh/c/Pd5sxLL7rBFNmf+f9f7VLpei18sLPGPG/1KUGky8smG3K
         lmuo9wVsBsVHZwJQFjlG5oDv9zNlJNT+GLfJaMaMdeqgiLdt7blPPyOe/LWX/X1pEjSW
         p+SzBA0hMQ88dn24SSxhEi1V/F1hsp56BGly48X4p00PPgsCXOdEmYMoobRp17irraFa
         8Gvg==
X-Gm-Message-State: AOAM5326AsVcywAB51fxmWZW4o2W6X9mpeYPThCQYyc1tY5HX4E+4WgR
        8Ryog8p1UPHKipe5JnNhroc=
X-Google-Smtp-Source: ABdhPJwqT0e15JhCOCAS6fFtrF8qsKSEbdWFvvctuLFlcKK00muv5UOqPUHQtDCi1ypa81oZgKbsjA==
X-Received: by 2002:a17:90a:2a83:: with SMTP id j3mr1839386pjd.84.1607513335167;
        Wed, 09 Dec 2020 03:28:55 -0800 (PST)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id 19sm2136106pfn.133.2020.12.09.03.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 03:28:54 -0800 (PST)
Date:   Wed, 9 Dec 2020 20:28:52 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next v2 2/3] printk: change @clear_seq to atomic64_t
Message-ID: <X9C09N5r4sGdel+h@jagdpanzerIV.localdomain>
References: <20201201205341.3871-1-john.ogness@linutronix.de>
 <20201201205341.3871-3-john.ogness@linutronix.de>
 <X8n9a2DWUFE/giyB@alley>
 <X8/jS9k/eMIL+Acw@jagdpanzerIV.localdomain>
 <875z5c9bhn.fsf@jogness.linutronix.de>
 <20201209081623.GI2414@hirez.programming.kicks-ass.net>
 <20201209092204.GD1667627@google.com>
 <X9Cq9SMaCy3lGhXJ@jagdpanzerIV.localdomain>
 <20201209110042.GW3021@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209110042.GW3021@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/12/09 12:00), Peter Zijlstra wrote:
> > So another potential re-entry path is
> > 
> > 	atomic_foo()
> > 	 spin_lock_irqsave(ATOMIC_HASH(v), flags)
> > 	  printk()
> > 	   prb()
> > 	    atomic_foo()
> > 	     spin_lock_irqsave(ATOMIC_HASH(v), flags)
> > 
> > which can deadlock, in theory, if both atomics HASH to the same
> > key (same spin_lock).
> 
> Yep, but see the 'mostly' in the 'they mostly work'. Given the
> limitiations of these architectures there's really only so much you can
> do.

Right, agreed.

Nevertheless TIL that lockless printk buffer is not always lockless.
Perhaps, people that work with those archs need to also know this.
I haven't checked all the archs, but if, somehow, (IF) some of them
can panic the system with the atomic hash entries locked, then on
those archs new printk may not be able to flush-on-panic. Because
while printk iterates logbuf it may HASH to the atomic hash table
entry, that will never be unlocked. So there are some changes in
atomic/printk department on those archs.

	-ss
