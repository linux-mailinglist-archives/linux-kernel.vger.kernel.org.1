Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 280D72CCF90
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 07:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387452AbgLCGgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 01:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgLCGgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 01:36:49 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AC6C061A4E
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 22:36:08 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id t22so1326074ljk.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 22:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fgGce5d2yAZS6m6L4xmz24ka0m1kBzvLu4ihu4nUPWw=;
        b=kPQ/QTfwYyAjzYSkLLp93KBgoyBH/9hLXK6DyOrIxfe0Ml8RKjfZ6lwons4vzAJHc+
         hb9O5BZqZqF4L7xkk6wC6uWjWyWb7rIp4ERTvM81PhmSRiZ8g9o6ZWW0R+lTomYFCTif
         OrMu2CsS34knQMQyAOTTS1I+FIu5GkqpSDVejDLhuc9JKEVmc5LSeuTqPCYatJJaw+zk
         5NfcSEqcm8/8OCHAeXqCZZusWudiMPd8MBKi7QP9kJlWP6PrnENzcUj/M9C+T1n+VTw7
         IGCVG08dorgJ2INNBa52x11VeHnD6tipVtrcaCTYFT4bTdXmYRiFbhacCTbFdpT9I9/2
         pbVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fgGce5d2yAZS6m6L4xmz24ka0m1kBzvLu4ihu4nUPWw=;
        b=bLY9sDFQ95LJFUdGnZdoA4SIcfGPiFKJcZa6NEeH7bbc1geiS/qgunJvPcF0cuGGU9
         YJXlwqMDjyFD9rLIKTSzPFE7Gvdf2WX5ONwGc3F0HASMj5wyZLvUPSIpe3YOiEvAY03s
         DuSLB7cOmH1IUwf0L1NDGufT0mLN/bORS8/RZSEUzwLjCzWjeK+kwFEewGhiaf8BMd4G
         26+xzArDtlAYv6nqeOzRwuvX1rXIJWA2maxLQgv/akJ+LfIU40iFPoat+bh+CNR5+JFR
         xOfFa4iF+c8jgPB2I7cdAQWSGzoWh+ylBv5XhxFOu9z8QhTwL+Dwf5kfFIHUVG0ZuAQS
         iI2w==
X-Gm-Message-State: AOAM533e36E8WxEXD2WZ3e36CefZYJAa+WO4jPJqCEb7mJBJU3sCWgwV
        tnOqPJjjIB8S2guQLLuHo/pwqUHetwS5bKd6uGg=
X-Google-Smtp-Source: ABdhPJxJSkrX+hGZ5dFReE9Hc1bmA1E7FQw8sqL+cUySfe5VkbFmwLAfS2/Pflf/Nk2xRMzNho29oRapMhKcE6dxgm4=
X-Received: by 2002:a2e:894e:: with SMTP id b14mr669643ljk.370.1606977367097;
 Wed, 02 Dec 2020 22:36:07 -0800 (PST)
MIME-Version: 1.0
References: <20201202145837.48040-1-foxhlchen@gmail.com> <20201202145837.48040-3-foxhlchen@gmail.com>
 <X8fcmiEgJUeW6jqR@kroah.com>
In-Reply-To: <X8fcmiEgJUeW6jqR@kroah.com>
From:   Fox Chen <foxhlchen@gmail.com>
Date:   Thu, 3 Dec 2020 14:35:54 +0800
Message-ID: <CAC2o3DK2UfYsXuY7nfpeHHHOhUMZPd+7=ofs9osiU+aB9MiPHA@mail.gmail.com>
Subject: Re: [PATCH 2/2] kernfs: remove mutex in kernfs_dop_revalidate
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     tj@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 3, 2020 at 2:26 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Dec 02, 2020 at 10:58:37PM +0800, Fox Chen wrote:
> > There is a big mutex in kernfs_dop_revalidate which slows down the
> > concurrent performance of kernfs.
> >
> > Since kernfs_dop_revalidate only does some checks, the lock is
> > largely unnecessary. Also, according to kernel filesystem locking
> > document:
> > https://www.kernel.org/doc/html/latest/filesystems/locking.html
> > locking is not in the protocal for d_revalidate operation.
> >
> > This patch remove this mutex from
> > kernfs_dop_revalidate, so kernfs_dop_revalidate
> > can run concurrently.
> >
> > Signed-off-by: Fox Chen <foxhlchen@gmail.com>
> > ---
> >  fs/kernfs/dir.c | 9 +++------
> >  1 file changed, 3 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> > index 9aec80b9d7c6..c2267c93f546 100644
> > --- a/fs/kernfs/dir.c
> > +++ b/fs/kernfs/dir.c
> > @@ -26,7 +26,6 @@ static DEFINE_SPINLOCK(kernfs_idr_lock);    /* root->ino_idr */
> >
> >  static bool kernfs_active(struct kernfs_node *kn)
> >  {
> > -     lockdep_assert_held(&kernfs_mutex);
> >       return atomic_read(&kn->active) >= 0;
> >  }
> >
> > @@ -557,10 +556,9 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
> >
> >       /* Always perform fresh lookup for negatives */
> >       if (d_really_is_negative(dentry))
> > -             goto out_bad_unlocked;
> > +             goto out_bad;
> >
> >       kn = kernfs_dentry_node(dentry);
> > -     mutex_lock(&kernfs_mutex);
> >
> >       /* The kernfs node has been deactivated */
> >       if (!kernfs_active(kn))
> > @@ -579,11 +577,8 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
> >           kernfs_info(dentry->d_sb)->ns != kn->ns)
> >               goto out_bad;
> >
> > -     mutex_unlock(&kernfs_mutex);
> >       return 1;
> >  out_bad:
> > -     mutex_unlock(&kernfs_mutex);
> > -out_bad_unlocked:
> >       return 0;
> >  }
> >
> > @@ -650,6 +645,8 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
> >       kn->mode = mode;
> >       kn->flags = flags;
> >
> > +     rwlock_init(&kn->iattr_rwlock);
>
> Ah, now you initialize this, it should go into patch 1, right? :)
>
Yes, it's my fault. It should be in patch 1. Sorry.
