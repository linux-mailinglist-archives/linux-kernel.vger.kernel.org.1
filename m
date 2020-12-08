Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97F6C2D3449
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 21:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730434AbgLHUfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 15:35:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730247AbgLHUfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 15:35:04 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677ACC0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 12:34:24 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id y10so6122034plr.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 12:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=t4kVyTen2phjdNZnXxG0GnvWjYDxrQja3gblOV7KzQo=;
        b=Q9W6m/mnga0qeFXrySm9GSeXhfPZXhU8xKd0jpLCI+6EA9HKgA5ijVLTaXD6Rxz18I
         QT/3/lzvy1roI1Wr0AekpjBBLuA+9bQgQOvzEhku/JmAhsbyyca5WaJgbpmD6YLwLzrk
         pJgINC2ZZUJez+kXaDZ/gENWWIppmQm6tM4MGst3PCgFjoxN/eWIjVDi9gj/fCrkTVCq
         yW5nfmrqxM2I9YFjW5VQR0FXuEVzbpb6Te1EQzAVdvqw5nPg07778hIU7IoiuRkPxOYV
         uc4xO7HG5/y8g/lPUtXbtr/2gt+yIVFUb3PXbwrwavbcArwo2aeQzoS5rnIPU4LgTBjJ
         g3yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t4kVyTen2phjdNZnXxG0GnvWjYDxrQja3gblOV7KzQo=;
        b=uRGRRV6pROUpbDZZNW1NlSo5/WAeQg00Xq4Yh3Bpjf/Sl2JAItZN/H/Db6gi7DBl5x
         1hmWZZIme2Mr4IK2GHvlu3IQQLTttgL5bWcjMno7XPRoKa6R916pFIONOHyOouVAy/vZ
         lhzdVA8Cn7O7fAYs7PGU3vM+LKLrbK69iYZZsClK2F5ItIIJUpzzoELwo+RjNBF7A9at
         47/pvae/RDzx8IzNFmp9GL7hZ6ZZ7OMZwO+i4jv54/3xphz7hqZctKoLWC8AaK0SSJDy
         1vWjOpkWwBzANUSXpe4Dbu3eJU0GTqH/0pTyODSuJthUis8rjRpz1l8ZJNm6ax8+ouQt
         CmfQ==
X-Gm-Message-State: AOAM533/QmLN/XrAgONWcLG4ld8iHt/3xDxY9htTrm8JVNX5RdKBRkzm
        Fmd6B6isuw9JbmSVhxwSJBk=
X-Google-Smtp-Source: ABdhPJyOXiuxaJwrQFSFiZK7PE6Ls0zhqxHpxnS3jXWcCBqltdHKknoBHsNycA90alC+kG6oFwzXqw==
X-Received: by 2002:a17:902:6506:b029:da:b472:7131 with SMTP id b6-20020a1709026506b02900dab4727131mr22684238plk.38.1607459663883;
        Tue, 08 Dec 2020 12:34:23 -0800 (PST)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id c132sm16279pfc.119.2020.12.08.12.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 12:34:22 -0800 (PST)
Date:   Wed, 9 Dec 2020 05:34:19 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next v2 2/3] printk: change @clear_seq to atomic64_t
Message-ID: <X8/jS9k/eMIL+Acw@jagdpanzerIV.localdomain>
References: <20201201205341.3871-1-john.ogness@linutronix.de>
 <20201201205341.3871-3-john.ogness@linutronix.de>
 <X8n9a2DWUFE/giyB@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X8n9a2DWUFE/giyB@alley>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/12/04 10:12), Petr Mladek wrote:
> On Tue 2020-12-01 21:59:40, John Ogness wrote:
> > Currently @clear_seq access is protected by @logbuf_lock. Once
> > @logbuf_lock is removed some other form of synchronization will be
> > required. Change the type of @clear_seq to atomic64_t to provide the
> > synchronization.
> > 
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index fc5e3a7d6d89..e9018c4e1b66 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -3412,7 +3418,7 @@ EXPORT_SYMBOL_GPL(kmsg_dump_get_buffer);
> >   */
> >  void kmsg_dump_rewind_nolock(struct kmsg_dumper *dumper)
> >  {
> > -	dumper->cur_seq = clear_seq;
> > +	dumper->cur_seq = atomic64_read(&clear_seq);
> 
> Sigh, atomic64_read() uses a spin lock in the generic implementation
> that is used on some architectures.

Oh... So on those archs prb is not lockless in fact, it actually
takes the spin_lock each time we read the descriptor state?

	desc_read()
	  atomic_long_read(state_var)
	    atomic64_read()
	      raw_spin_lock_irqsave(lock, flags)
	        << NMI panic >>

Am I missing something?

	-ss
