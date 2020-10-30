Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D920329FF55
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 09:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbgJ3IEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 04:04:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:34696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725808AbgJ3IEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 04:04:06 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E018206DD;
        Fri, 30 Oct 2020 08:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604045045;
        bh=Sn3dA1VSNSN5lgi26Pj5nHNRUhr7ixjp5QdHMAE3z0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R6VW27tE3iq36TLQY+OPia0HlP8XY9AMUEUeebXLiOpnjQKeqSwGbToBxehyBZYQx
         aqJnaa2roCO+le/qMzJg7/ZKlhgabKxyR1R6Nze1ZhSSaUhFQMFf24x5PVjNhYh9bS
         bSOK0Bcd4cyUfIU4z4qmQn2S7EWYkcK0CNub504s=
Date:   Fri, 30 Oct 2020 09:04:53 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Anand K. Mistry" <amistry@google.com>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/1] debugfs: Add a helper to export atomic64_t values
Message-ID: <20201030080453.GB1612206@kroah.com>
References: <20201030070442.457739-1-amistry@google.com>
 <20201030180403.1.I9c36fd7a0e4d52e300c1004a0f6f2fc705e2b065@changeid>
 <20201030072118.GB1495407@kroah.com>
 <CAATStaMAyE+mbdjjRauYNKrj85h78_=tPpWC3PRzKHYPq8mh=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAATStaMAyE+mbdjjRauYNKrj85h78_=tPpWC3PRzKHYPq8mh=w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 06:30:49PM +1100, Anand K. Mistry wrote:
> On Fri, 30 Oct 2020 at 18:20, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, Oct 30, 2020 at 06:04:42PM +1100, Anand K Mistry wrote:
> > > This mirrors support for exporting atomic_t values.
> > >
> > > Signed-off-by: Anand K Mistry <amistry@google.com>
> > >
> > > ---
> > >
> > >  fs/debugfs/file.c       | 37 +++++++++++++++++++++++++++++++++++++
> > >  include/linux/debugfs.h |  6 ++++++
> > >  2 files changed, 43 insertions(+)
> > >
> > > diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
> > > index a768a09430c3..798bd3bdedec 100644
> > > --- a/fs/debugfs/file.c
> > > +++ b/fs/debugfs/file.c
> > > @@ -770,6 +770,43 @@ void debugfs_create_atomic_t(const char *name, umode_t mode,
> > >  }
> > >  EXPORT_SYMBOL_GPL(debugfs_create_atomic_t);
> > >
> > > +static int debugfs_atomic64_t_set(void *data, u64 val)
> > > +{
> > > +     atomic64_set((atomic64_t *)data, val);
> > > +     return 0;
> > > +}
> > > +static int debugfs_atomic64_t_get(void *data, u64 *val)
> > > +{
> > > +     *val = atomic64_read((atomic64_t *)data);
> > > +     return 0;
> > > +}
> > > +DEFINE_DEBUGFS_ATTRIBUTE(fops_atomic64_t, debugfs_atomic64_t_get,
> > > +                     debugfs_atomic64_t_set, "%lld\n");
> > > +DEFINE_DEBUGFS_ATTRIBUTE(fops_atomic64_t_ro, debugfs_atomic64_t_get, NULL,
> > > +                     "%lld\n");
> > > +DEFINE_DEBUGFS_ATTRIBUTE(fops_atomic64_t_wo, NULL, debugfs_atomic64_t_set,
> > > +                     "%lld\n");
> > > +
> > > +/**
> > > + * debugfs_create_atomic64_t - create a debugfs file that is used to read and
> > > + * write an atomic64_t value
> > > + * @name: a pointer to a string containing the name of the file to create.
> > > + * @mode: the permission that the file should have
> > > + * @parent: a pointer to the parent dentry for this file.  This should be a
> > > + *          directory dentry if set.  If this parameter is %NULL, then the
> > > + *          file will be created in the root of the debugfs filesystem.
> > > + * @value: a pointer to the variable that the file should read to and write
> > > + *         from.
> > > + */
> > > +void debugfs_create_atomic64_t(const char *name, umode_t mode,
> > > +                            struct dentry *parent, atomic64_t *value)
> > > +{
> > > +     debugfs_create_mode_unsafe(name, mode, parent, value,
> > > +                                &fops_atomic64_t, &fops_atomic64_t_ro,
> > > +                                &fops_atomic64_t_wo);
> > > +}
> > > +EXPORT_SYMBOL_GPL(debugfs_create_atomic64_t);
> > > +
> > >  ssize_t debugfs_read_file_bool(struct file *file, char __user *user_buf,
> > >                              size_t count, loff_t *ppos)
> > >  {
> > > diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
> > > index 851dd1f9a8a5..0fac84c53eab 100644
> > > --- a/include/linux/debugfs.h
> > > +++ b/include/linux/debugfs.h
> > > @@ -126,6 +126,8 @@ void debugfs_create_size_t(const char *name, umode_t mode,
> > >                          struct dentry *parent, size_t *value);
> > >  void debugfs_create_atomic_t(const char *name, umode_t mode,
> > >                            struct dentry *parent, atomic_t *value);
> > > +void debugfs_create_atomic64_t(const char *name, umode_t mode,
> > > +                                  struct dentry *parent, atomic64_t *value);
> > >  struct dentry *debugfs_create_bool(const char *name, umode_t mode,
> > >                                 struct dentry *parent, bool *value);
> > >
> > > @@ -291,6 +293,10 @@ static inline void debugfs_create_atomic_t(const char *name, umode_t mode,
> > >                                          atomic_t *value)
> > >  { }
> > >
> > > +static inline void debugfs_create_atomic64_t(const char *name, umode_t mode,
> > > +                                          struct dentry *parent, atomic64_t *value)
> > > +{ }
> > > +
> > >  static inline struct dentry *debugfs_create_bool(const char *name, umode_t mode,
> > >                                                struct dentry *parent,
> > >                                                bool *value)
> >
> > Looks good, but where is the user of this code?  I can't add new apis
> > without a user.
> 
> Fair enough. Right now, the user is just some local
> debugging/performance measuring which will never be upstreamed.
> Happy to let this drop.

Now dropped!

> > And are you _SURE_ you want to be using an atomic64_t in the first
> > place?  We are starting to reduce the "raw" usage of atomic variables as
> > almost no one needs them, they should be using something else instead,
> > or just a u64 as atomics are not needed for simple statistics.
> 
> I understand, and would generally never use atomics in real code. I
> used an atomic since I wanted accuracy (for some of the benchmarks I
> want to run) but can't use anything that blocks (spinlock/mutex) since
> the code is somewhere inside the scheduler.

You can't be "accurate" for a single value from a single file read by
userspace as you don't know if it changed right after you read the value :)

Again, people abuse atomic values thinking they are something they
really aren't...

thanks,

greg k-h
