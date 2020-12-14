Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 378212D9A9B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 16:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406647AbgLNPMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 10:12:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbgLNPMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 10:12:15 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA19EC0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 07:11:34 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id m12so30954397lfo.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 07:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JlXKO/hJvTy3JBiw5f2Jp7oajlui81QeS0khsJbuVVg=;
        b=MgGdOEmxdzsGD00ohwZEiBgGkdtM5eQ9nDo2/kN1VBtxkMPKLJWuTSM7u2AmdfWux4
         VrttTkPdQp3Ot0nqQXXcBhYbDCpOPMSEtcQejIgpNpu0UrBi5kL0lzxbuTUO58QQY8RT
         S6qk8W/lBCLKyh8o88G90I3OG5EjwwczrapQ8oxr5zyvl9b1YgSKSzhhIIgbOj2Xw0+z
         dwMeUElFV9baQi5q2CyyNKmc4YmKOrzw+nyMta/gZflFf4LhOwiUYKg3NKe8BsZSVHdO
         /il3YQym77kp3XnxMJA8VE8MwHbx8hTuIP64M7KyUbQEi+v7a8IFIOuDIHHrVaTZm05q
         CzoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JlXKO/hJvTy3JBiw5f2Jp7oajlui81QeS0khsJbuVVg=;
        b=FBhe9YqHoWTB3K7kOEsif+VB64f30rlOVg8eh4Iib62e3SGElcdk3eTTlRJncIsaSM
         GTyHC36SC2lqoKpGYUb4LGodF+JLL6PNdtENsaP5VfdUxGW89CjnnkkrlBfO7UW5/V4k
         75rPEhXZXH9nqwM/DDHKtdTvNJsP0id6xbed7+MlDHthfHQA658NGIgq0+7LSaHqn2Fi
         xt1CpZbmfnLd0p5eCURsqHPJW6N0uxH0W6Snf+NxkQUKI8lrSp1aQ9cUc65GLlW6PryX
         CoU/ntttoNNB8Dcy8JUUfJz/9Ie1DOKq61A5f0WBooJP5RrDSs4Xeau/QBERKmm4CcUI
         aIig==
X-Gm-Message-State: AOAM530BYDbqJjL2E3mZbubjhjX1LVSTQh3S21CFySE5OFSVK6a2TEUf
        vWNeSyP3t4WuM5S10c/ERP4=
X-Google-Smtp-Source: ABdhPJz4inHxF7OKC/lCN3WcnxHWgHZde/D/wtNwJcugiGJdAnI3i8mPhcPlnIWRG+ZBincvt6EMAg==
X-Received: by 2002:a2e:574d:: with SMTP id r13mr11371829ljd.479.1607958691263;
        Mon, 14 Dec 2020 07:11:31 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id c198sm2109512lfg.265.2020.12.14.07.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 07:11:30 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Mon, 14 Dec 2020 16:11:28 +0100
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmalloc: Fix unlock order in s_stop()
Message-ID: <20201214151128.GA2094@pc638.lan>
References: <20201213180843.16938-1-longman@redhat.com>
 <20201213183936.GA20007@pc636>
 <20201213215134.GI2443@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201213215134.GI2443@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 13, 2020 at 09:51:34PM +0000, Matthew Wilcox wrote:
> On Sun, Dec 13, 2020 at 07:39:36PM +0100, Uladzislau Rezki wrote:
> > On Sun, Dec 13, 2020 at 01:08:43PM -0500, Waiman Long wrote:
> > > When multiple locks are acquired, they should be released in reverse
> > > order. For s_start() and s_stop() in mm/vmalloc.c, that is not the
> > > case.
> > > 
> > >   s_start: mutex_lock(&vmap_purge_lock); spin_lock(&vmap_area_lock);
> > >   s_stop : mutex_unlock(&vmap_purge_lock); spin_unlock(&vmap_area_lock);
> > > 
> > > This unlock sequence, though allowed, is not optimal. If a waiter is
> > > present, mutex_unlock() will need to go through the slowpath of waking
> > > up the waiter with preemption disabled. Fix that by releasing the
> > > spinlock first before the mutex.
> > > 
> > > Fixes: e36176be1c39 ("mm/vmalloc: rework vmap_area_lock")
> > > Signed-off-by: Waiman Long <longman@redhat.com>
> > > ---
> > >  mm/vmalloc.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > index 6ae491a8b210..75913f685c71 100644
> > > --- a/mm/vmalloc.c
> > > +++ b/mm/vmalloc.c
> > > @@ -3448,11 +3448,11 @@ static void *s_next(struct seq_file *m, void *p, loff_t *pos)
> > >  }
> > >  
> > >  static void s_stop(struct seq_file *m, void *p)
> > > -	__releases(&vmap_purge_lock)
> > >  	__releases(&vmap_area_lock)
> > > +	__releases(&vmap_purge_lock)
> > >  {
> > > -	mutex_unlock(&vmap_purge_lock);
> > >  	spin_unlock(&vmap_area_lock);
> > > +	mutex_unlock(&vmap_purge_lock);
> > >  }
> > >  
> > >  static void show_numa_info(struct seq_file *m, struct vm_struct *v)
> > BTW, if navigation over both list is an issue, for example when there
> > are multiple heavy readers of /proc/vmallocinfo, i think, it make sense
> > to implement RCU safe lists iteration and get rid of both locks.
> 
> If we need to iterate the list efficiently, i'd suggest getting rid of
> the list and using an xarray instead.  maybe a maple tree, once that code
> is better exercised.
>
Not really efficiently. We need just a full scan of it propagating the
information about mapped and un-purged areas to user space applications.

For example RCU-safe list is what we need, IMHO. From the other hand i
am not sure if xarray is RCU safe in a context of concurrent removing/adding
an element(xa_remove()/xa_insert()) and scanning like xa_for_each_XXX().

--
Vlad Rezki
