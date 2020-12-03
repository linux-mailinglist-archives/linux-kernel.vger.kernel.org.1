Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25AF92CCFBD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 07:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbgLCGpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 01:45:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgLCGpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 01:45:43 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310ACC061A4E
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 22:44:57 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id v14so1157826lfo.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 22:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kbcXL/+kU9hPNf8FXRUNg2uWyxYCdjqYQbGrq1r6KhA=;
        b=oEGJrIpm9a38pNjDtPp1He8aT2Mng0xbpFXrpLvLxPsz+GO99iDT0tA/E3vi7w6/cf
         NQuuGft9VJikrYZuNxPviPdKtBpoTCn+folVXXp5m25/IsCaft9VauzNEDHmys1LzZuj
         Kgvzc5cBdoxf+mVLE/r9Wds/yT9Gtjz8/0lNNwqazAkaiRuN/o9dcTzCRdDvZbuIVxyw
         NVz/BczsnyCPIqIFel+S0YW7fn9Zth9G5nZ6G5nW7cqyqxUtv9C2cm/OBKKSIJEkaZ72
         w1+tHdgVyVg1aHp+SJlq+EIsEKXzob1JXSu99sdHrzi2hW20qQND7LqYDRcD6pbnuR3R
         XeoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kbcXL/+kU9hPNf8FXRUNg2uWyxYCdjqYQbGrq1r6KhA=;
        b=CdrUcz64SHrwqEaTgba1zpGx/9DBWQZiUAMtUCuF0B2QxwBnK6E2r1TikGDjVtIkJL
         WzG1kbVOxZu4ty5gxDbG8w5o1Gd2vlcNnZrg3PFwKbqSUMDt0SOWgGZ/f/ykbrdTxXDN
         Ud6B4xSCVXJaSk1u5DmpbAkpR8wzAmlS6gkxIlQwV2Q8pcNaD2cFi7QsK+BuYGEwuF1Z
         gZ3k+lGGiLyAENDZe0MJFrGw1G0NwbYNJptET7ZX39TQ7OsTvvEdaETnRDQ5e5g9qmxv
         YfvotJahrV5SRo4q0v/ZS4oIwjF5PWHe8HA/Q9/9umMePjIHXjP7zEwdrWjZ9nsam46w
         5f0g==
X-Gm-Message-State: AOAM531jvm8hRRd4mDFMB4FYq8h7r8gAPyne4SdRkyGix2zWtWfJpGro
        gDm4OIVs/RtvpWa6wP/WSYUr7b7erixD54oepJzUTmO/oV1WkH0H
X-Google-Smtp-Source: ABdhPJy549w1/PPWziNAZXzdsO2bcqxkvnQjUXbzpqNqrhqbX9elpOdldkN4VVZaLAW2VFVmVnwfCJt6vIUvQSOXfYw=
X-Received: by 2002:a19:913:: with SMTP id 19mr701558lfj.147.1606977895678;
 Wed, 02 Dec 2020 22:44:55 -0800 (PST)
MIME-Version: 1.0
References: <20201202145837.48040-1-foxhlchen@gmail.com> <20201202145837.48040-3-foxhlchen@gmail.com>
 <X8fg8CVS8RVQ8GCO@mtj.duckdns.org>
In-Reply-To: <X8fg8CVS8RVQ8GCO@mtj.duckdns.org>
From:   Fox Chen <foxhlchen@gmail.com>
Date:   Thu, 3 Dec 2020 14:44:43 +0800
Message-ID: <CAC2o3DJymdhdTc1maAkWaPpgwaLNgBx8RC2Zb-x5CT4OeRjJRQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] kernfs: remove mutex in kernfs_dop_revalidate
To:     Tejun Heo <tj@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 3, 2020 at 2:46 AM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
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
>
> That's just describing the rules seen from vfs side. It doesn't say anything
> about locking rules internal to each file system implementation.

Oh, Ok, I got it.

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
>
> I don't see how this can be safe. Nothing even protects the dentry from
> turning negative in the middle and it may end up trying to deref NULL. I'm
> sure we can make this not need kernfs_mutex but that'd have to be a lot more
> careful.
>

Sorry Tejun, I don't get it. Even before the patch

if (d_really_is_negative(dentry))
     goto out_bad_unlocked;

kn = kernfs_dentry_node(dentry);
mutex_lock(&kernfs_mutex);  <-------- we lock here

status of d_really_is_negative is not preserved by the mutex. It could
turn negative between we checked it and we lock kernfs_mutex.
Is it a bug here??


thanks,
fox
