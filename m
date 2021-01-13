Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 825F02F51A1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 19:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbhAMSCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 13:02:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727946AbhAMSCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 13:02:37 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2FEEC061575
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 10:01:57 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id c22so1951424pgg.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 10:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2yOASqLXCFmH8rHiDFY5aK5IF9dZ2OI5aQ21Vbh1eP8=;
        b=gHtUHzUPG5nr4qeM6RqXwHoa31eiMAo2G3XbBdMPhPetpWhM+8FxJcVQrQckAjJOts
         a+PuAK+iIngRm+Yp1MRDCVK0BKRkRO9ogHvQh8O/VHesI2z8n5+VeisZVKsjgEqjLV5k
         U3cHR0de4KgfDQBMl4Uj4g9/NyiGrIcwhViN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2yOASqLXCFmH8rHiDFY5aK5IF9dZ2OI5aQ21Vbh1eP8=;
        b=lEn/MnGR4EJOYjoIJoB7qgc8t2i53aEIigaZcL+gJLB3yzQ2LyhyPETki73qyjowdy
         n1mzFHrxRWNOEukSqoX9BN/D2sNUIMNAXV2A6QCrR1bw8XzYEP/7AEMVjFYSjVJRzBIV
         g6DiaThJZVCKBvShe0XLGo/Nxo2x7J20yqbPd2J+8RUWBdVh4s6qP7j2U66HBXVMztbQ
         zjG0UIUfJKPtP8p27mMPxC7vEsntQTrSE2Ha5lwuiBaWVmQQ0zwU06W67SBDGmMEnt/s
         ix0v/Aa0HCylg+yH8i13VH73rem/L9be4W1Zg91b544iD7lEu28b3XEnYAoUsglPw0OP
         sstw==
X-Gm-Message-State: AOAM531k2HY88eMK5JSmWNnwGAolKD+Nnyd5zR+UJL9O56DFemgm6s4X
        iuJ8gJ+TpyQjfDPUQzV3PUTmr+/XPaxXQg==
X-Google-Smtp-Source: ABdhPJy/l5JCoFPdFR12hWOnKrP/lLjwYszhjP/WNJBh99XAQ0ifkW1xWHqHas6EDvPBSGX8HpJRMQ==
X-Received: by 2002:a63:8f19:: with SMTP id n25mr3154262pgd.17.1610560917380;
        Wed, 13 Jan 2021 10:01:57 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c5sm3574184pjo.4.2021.01.13.10.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 10:01:56 -0800 (PST)
Date:   Wed, 13 Jan 2021 10:01:55 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Alexey Gladkov <gladkov.alexey@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Alexey Gladkov <legion@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH v2 1/8] Use atomic type for ucounts reference counting
Message-ID: <202101131001.BF1108F90@keescook>
References: <cover.1610299857.git.gladkov.alexey@gmail.com>
 <447547b12bba1894d3f1f79d6408dfc60b219b0c.1610299857.git.gladkov.alexey@gmail.com>
 <878s8wdcib.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878s8wdcib.fsf@x220.int.ebiederm.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 10:31:40AM -0600, Eric W. Biederman wrote:
> Alexey Gladkov <gladkov.alexey@gmail.com> writes:
> 
> We might want to use refcount_t instead of atomic_t.  Not a big deal
> either way.

Yes, please use refcount_t, and don't use _read() since that introduces
races.

-Kees

> 
> > Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
> > ---
> >  include/linux/user_namespace.h |  2 +-
> >  kernel/ucount.c                | 10 +++++-----
> >  2 files changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
> > index 64cf8ebdc4ec..84fefa9247c4 100644
> > --- a/include/linux/user_namespace.h
> > +++ b/include/linux/user_namespace.h
> > @@ -92,7 +92,7 @@ struct ucounts {
> >  	struct hlist_node node;
> >  	struct user_namespace *ns;
> >  	kuid_t uid;
> > -	int count;
> > +	atomic_t count;
> >  	atomic_t ucount[UCOUNT_COUNTS];
> >  };
> >  
> > diff --git a/kernel/ucount.c b/kernel/ucount.c
> > index 11b1596e2542..0f2c7c11df19 100644
> > --- a/kernel/ucount.c
> > +++ b/kernel/ucount.c
> > @@ -141,7 +141,8 @@ static struct ucounts *get_ucounts(struct user_namespace *ns, kuid_t uid)
> >  
> >  		new->ns = ns;
> >  		new->uid = uid;
> > -		new->count = 0;
> > +
> > +		atomic_set(&new->count, 0);
> >  
> >  		spin_lock_irq(&ucounts_lock);
> >  		ucounts = find_ucounts(ns, uid, hashent);
> > @@ -152,10 +153,10 @@ static struct ucounts *get_ucounts(struct user_namespace *ns, kuid_t uid)
> >  			ucounts = new;
> >  		}
> >  	}
> > -	if (ucounts->count == INT_MAX)
> > +	if (atomic_read(&ucounts->count) == INT_MAX)
> >  		ucounts = NULL;
> >  	else
> > -		ucounts->count += 1;
> > +		atomic_inc(&ucounts->count);
> >  	spin_unlock_irq(&ucounts_lock);
> >  	return ucounts;
> >  }
> > @@ -165,8 +166,7 @@ static void put_ucounts(struct ucounts *ucounts)
> >  	unsigned long flags;
> >  
> >  	spin_lock_irqsave(&ucounts_lock, flags);
> > -	ucounts->count -= 1;
> > -	if (!ucounts->count)
> > +	if (atomic_dec_and_test(&ucounts->count))
> >  		hlist_del_init(&ucounts->node);
> >  	else
> >  		ucounts = NULL;
> 
> 
> This can become:
> static void put_ucounts(struct ucounts *ucounts)
> {
> 	unsigned long flags;
> 
>         if (atomic_dec_and_lock_irqsave(&ucounts->count, &ucounts_lock, flags)) {
>         	hlist_del_init(&ucounts->node);
>                 spin_unlock_irqrestore(&ucounts_lock);
>                 kfree(ucounts);
>         }
> }
> 

-- 
Kees Cook
