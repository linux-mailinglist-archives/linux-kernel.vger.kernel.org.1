Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2D1D2CF311
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 18:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730959AbgLDRW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 12:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728185AbgLDRWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 12:22:55 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DE8C061A4F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 09:22:09 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id y16so7479095ljk.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 09:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YqdH3CZ1CYT0Ogl/PUsSSdFVg1WWYApotKTo8YlG6b0=;
        b=Sxu8wf67/pJvgj3t3oP/0ns4PrctpytfByuyjDHZN3gvKaKow52qg5edlev/dbxbgo
         m+PNoC9PtT16ZrmmieoWcUGwcvCQMwde8+eNUothuf0dnfT4r4cicgxdqQjWuxJIsFUj
         /M5dpWN8CrJ2nWMPFq71sY1W6InnRdv4jGuXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YqdH3CZ1CYT0Ogl/PUsSSdFVg1WWYApotKTo8YlG6b0=;
        b=pAjCgVweoanlTHEvHj/IxEB8LdKfK9BGdG4eMmRz4VQVtYjcdQX69P9vtHNw5bJrme
         qlyel7QZeW9Rz1X7cGRibaGRgkQSKimRxBHpZ1KRoIAKccpH1Qt9gfC0+cVILSeoCiIf
         SjTUnPHSkDrg+Dlt3R7TM99YvkODb84gb6fUjvifuWcXMYB3N/Fx1nspy7XVwVf+7mkP
         ByDTXHJlKd6Ez9e9JekmQT1oPaC7szdO7hitKPYIweeXc37lZ3gWg6bYO7U4bg80E6ef
         QoOlhMr2VUIiuc60S3x5lopqD9nqGF1jG15+m7Ad4ycZbhJmBIEwqshoAFQcSsvt+p7q
         hf9A==
X-Gm-Message-State: AOAM531yhxcG/Br/Xkj4XayfGkyY5Lwbe+bXNqGvSDolvsWehSZ4e9G3
        DMU93kohqkjTCkUjKs55ezt7Ll+rwYCASw==
X-Google-Smtp-Source: ABdhPJzZRaFcpQ5RE97q97Y6KSFs9bVxKCrhsxJiqHCWvHyGls/uSVpgGDk4WhAcE+hdHKHKSuBRTA==
X-Received: by 2002:a2e:8e98:: with SMTP id z24mr3862955ljk.150.1607102527747;
        Fri, 04 Dec 2020 09:22:07 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id l7sm1869403lfk.302.2020.12.04.09.22.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Dec 2020 09:22:05 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id u9so3150001lfm.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 09:22:05 -0800 (PST)
X-Received: by 2002:a19:7f55:: with SMTP id a82mr3514413lfd.603.1607102525086;
 Fri, 04 Dec 2020 09:22:05 -0800 (PST)
MIME-Version: 1.0
References: <87tut2bqik.fsf@x220.int.ebiederm.org> <87ft4mbqen.fsf@x220.int.ebiederm.org>
 <AM6PR03MB5170412C2B0318C40CED55E5E4F10@AM6PR03MB5170.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB5170412C2B0318C40CED55E5E4F10@AM6PR03MB5170.eurprd03.prod.outlook.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 4 Dec 2020 09:21:49 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi6inOF5yvQRwUFbqMt0zFJ8S8GhqE2M0judU7RiGru8Q@mail.gmail.com>
Message-ID: <CAHk-=wi6inOF5yvQRwUFbqMt0zFJ8S8GhqE2M0judU7RiGru8Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] exec: Transform exec_update_mutex into a rw_semaphore
To:     Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Jann Horn <jannh@google.com>,
        Vasiliy Kulikov <segoon@openwall.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        Christopher Yeoh <cyeoh@au1.ibm.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 4, 2020 at 8:08 AM Bernd Edlinger <bernd.edlinger@hotmail.de> wrote:
>
> >
> > -static void kcmp_unlock(struct mutex *m1, struct mutex *m2)
> > +static void kcmp_unlock(struct rw_semaphore *l1, struct rw_semaphore *l2)
> >  {
> > -     if (likely(m2 != m1))
> > -             mutex_unlock(m2);
> > -     mutex_unlock(m1);
> > +     if (likely(l2 != l1))
>
> is this still necessary ?
>
> > +             up_read(l2);
> > +     up_read(l1);
> >  }
> >
> > -static int kcmp_lock(struct mutex *m1, struct mutex *m2)
> > +static int kcmp_lock(struct rw_semaphore *l1, struct rw_semaphore *l2)
> >  {
> >       int err;
> >
> > -     if (m2 > m1)
> > -             swap(m1, m2);
> > +     if (l2 > l1)
> > +             swap(l1, l2);
>
> and this is probably also no longer necessary?

These are still necessary, because even a recursive read lock can
still block on a writer trying to come in between the two read locks
due to fairness guarantees.

So taking the same read lock twice is still a source of possible deadlocks.

For the same reason, read locks still have ABBA deadlock and need to
be taken in order.

So switching from a mutex to a rwlock doesn't really change the
locking rules in this respect.

In fact, I'm not convinced this change even fixes the deadlock that
syzbot reported, for the same reason: it just requires a write lock in
between two read locks to deadlock.

               Linus
