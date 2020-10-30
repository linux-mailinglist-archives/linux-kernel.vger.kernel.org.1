Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2CA29FE76
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 08:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgJ3HbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 03:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgJ3HbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 03:31:02 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A6CC0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 00:31:02 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id g7so5659007ilr.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 00:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VcgKIcIjc8QS9zXXE+6ZVBu7oRx/ZUqPRqd/fYIBaIo=;
        b=OD+N+A7YwZDCB60kVffWKcbXO8kZanPoRTN6TMzfr1ZttR5kugqX+JwYh9fdiryhNu
         UoOofhVrRiRQe+csRW6+EZt8DiCKYnsBtJUYrizcQ2BX41uX0uWR6jyYALemvyP26yxu
         KgYD0d6XIM0/i9YZfDX/ajXuzWoU2+zhx9CPJj5NpUfNt21k2aATOLzyfWdifBLjqTPp
         Jb0KfCSe14wIqTnAc5SzROurym5GRm6aT2V6Cper/Nw5ej3+gttZfYKtDS7AdYKQCYwb
         PBoThdqyfZqr6G5ePVdyojvBdVGP34P19GIO4NusEOmAoC4IpXiOsLEWSTq4LsOsPh37
         sSCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VcgKIcIjc8QS9zXXE+6ZVBu7oRx/ZUqPRqd/fYIBaIo=;
        b=FYmG4XtEwPJ765AxKBTq2oMmJLXnbKvKsz/dh6eBMT0Y8Af5/SlcaTDCD7Tn7mjmTK
         isDK0KwQwCtxoVTc7ag5fO5TKr7u3EBpm3rM4ggtYMg6pu5C9GJOQw+E9L+uq6rzrHrq
         RLLFai5G5xfGjSE41nk7HOnTjNNJ5p8N8q69QDmuAoH0oEgyFx7h7UcWuvZ+LFmT/vAm
         gg0OiY3v4c73usHc8f5Yi4jDwUf1aByQDbxcZ16QzknJ6+Zl+yuUKjFY+QM/6PwZlyBH
         5xK2wC8MzcpsEgsyUFwSs4AAfOINpU4+Z8eOxmecWGHZN5om8R5kALYPMNQgF88mIV7T
         6kRw==
X-Gm-Message-State: AOAM533SjqRDTDq/ZM/WS/l3wcwxxh8iaRP3ISmSr6sZVqkt2KUejDpN
        NQGvYyEWDI+7XlqFiX0qttsWOA5pgsBZsp9c1TjVAiJD3fLFHw==
X-Google-Smtp-Source: ABdhPJzZ2x5670S6TzoeWcc1ccHyLnuBiP+QqEwFmQiR9HgO3fzElUSxu9vRknGwFwvxpWW3g2hbP6ngQHkGSRPSnSY=
X-Received: by 2002:a92:d5d0:: with SMTP id d16mr966201ilq.223.1604043061789;
 Fri, 30 Oct 2020 00:31:01 -0700 (PDT)
MIME-Version: 1.0
References: <20201030070442.457739-1-amistry@google.com> <20201030180403.1.I9c36fd7a0e4d52e300c1004a0f6f2fc705e2b065@changeid>
 <20201030072118.GB1495407@kroah.com>
In-Reply-To: <20201030072118.GB1495407@kroah.com>
From:   "Anand K. Mistry" <amistry@google.com>
Date:   Fri, 30 Oct 2020 18:30:49 +1100
Message-ID: <CAATStaMAyE+mbdjjRauYNKrj85h78_=tPpWC3PRzKHYPq8mh=w@mail.gmail.com>
Subject: Re: [PATCH 1/1] debugfs: Add a helper to export atomic64_t values
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Oct 2020 at 18:20, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Oct 30, 2020 at 06:04:42PM +1100, Anand K Mistry wrote:
> > This mirrors support for exporting atomic_t values.
> >
> > Signed-off-by: Anand K Mistry <amistry@google.com>
> >
> > ---
> >
> >  fs/debugfs/file.c       | 37 +++++++++++++++++++++++++++++++++++++
> >  include/linux/debugfs.h |  6 ++++++
> >  2 files changed, 43 insertions(+)
> >
> > diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
> > index a768a09430c3..798bd3bdedec 100644
> > --- a/fs/debugfs/file.c
> > +++ b/fs/debugfs/file.c
> > @@ -770,6 +770,43 @@ void debugfs_create_atomic_t(const char *name, umode_t mode,
> >  }
> >  EXPORT_SYMBOL_GPL(debugfs_create_atomic_t);
> >
> > +static int debugfs_atomic64_t_set(void *data, u64 val)
> > +{
> > +     atomic64_set((atomic64_t *)data, val);
> > +     return 0;
> > +}
> > +static int debugfs_atomic64_t_get(void *data, u64 *val)
> > +{
> > +     *val = atomic64_read((atomic64_t *)data);
> > +     return 0;
> > +}
> > +DEFINE_DEBUGFS_ATTRIBUTE(fops_atomic64_t, debugfs_atomic64_t_get,
> > +                     debugfs_atomic64_t_set, "%lld\n");
> > +DEFINE_DEBUGFS_ATTRIBUTE(fops_atomic64_t_ro, debugfs_atomic64_t_get, NULL,
> > +                     "%lld\n");
> > +DEFINE_DEBUGFS_ATTRIBUTE(fops_atomic64_t_wo, NULL, debugfs_atomic64_t_set,
> > +                     "%lld\n");
> > +
> > +/**
> > + * debugfs_create_atomic64_t - create a debugfs file that is used to read and
> > + * write an atomic64_t value
> > + * @name: a pointer to a string containing the name of the file to create.
> > + * @mode: the permission that the file should have
> > + * @parent: a pointer to the parent dentry for this file.  This should be a
> > + *          directory dentry if set.  If this parameter is %NULL, then the
> > + *          file will be created in the root of the debugfs filesystem.
> > + * @value: a pointer to the variable that the file should read to and write
> > + *         from.
> > + */
> > +void debugfs_create_atomic64_t(const char *name, umode_t mode,
> > +                            struct dentry *parent, atomic64_t *value)
> > +{
> > +     debugfs_create_mode_unsafe(name, mode, parent, value,
> > +                                &fops_atomic64_t, &fops_atomic64_t_ro,
> > +                                &fops_atomic64_t_wo);
> > +}
> > +EXPORT_SYMBOL_GPL(debugfs_create_atomic64_t);
> > +
> >  ssize_t debugfs_read_file_bool(struct file *file, char __user *user_buf,
> >                              size_t count, loff_t *ppos)
> >  {
> > diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
> > index 851dd1f9a8a5..0fac84c53eab 100644
> > --- a/include/linux/debugfs.h
> > +++ b/include/linux/debugfs.h
> > @@ -126,6 +126,8 @@ void debugfs_create_size_t(const char *name, umode_t mode,
> >                          struct dentry *parent, size_t *value);
> >  void debugfs_create_atomic_t(const char *name, umode_t mode,
> >                            struct dentry *parent, atomic_t *value);
> > +void debugfs_create_atomic64_t(const char *name, umode_t mode,
> > +                                  struct dentry *parent, atomic64_t *value);
> >  struct dentry *debugfs_create_bool(const char *name, umode_t mode,
> >                                 struct dentry *parent, bool *value);
> >
> > @@ -291,6 +293,10 @@ static inline void debugfs_create_atomic_t(const char *name, umode_t mode,
> >                                          atomic_t *value)
> >  { }
> >
> > +static inline void debugfs_create_atomic64_t(const char *name, umode_t mode,
> > +                                          struct dentry *parent, atomic64_t *value)
> > +{ }
> > +
> >  static inline struct dentry *debugfs_create_bool(const char *name, umode_t mode,
> >                                                struct dentry *parent,
> >                                                bool *value)
>
> Looks good, but where is the user of this code?  I can't add new apis
> without a user.

Fair enough. Right now, the user is just some local
debugging/performance measuring which will never be upstreamed.
Happy to let this drop.

>
> And are you _SURE_ you want to be using an atomic64_t in the first
> place?  We are starting to reduce the "raw" usage of atomic variables as
> almost no one needs them, they should be using something else instead,
> or just a u64 as atomics are not needed for simple statistics.

I understand, and would generally never use atomics in real code. I
used an atomic since I wanted accuracy
(for some of the benchmarks I want to run) but can't use anything that
blocks (spinlock/mutex) since
the code is somewhere inside the scheduler.

>
> thanks,
>
> greg k-h

-- 
Anand K. Mistry
Software Engineer
Google Australia
