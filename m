Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02ACB2F62FD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 15:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbhANOUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 09:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbhANOUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 09:20:10 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D4BC061574
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 06:19:29 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id q22so8405143eja.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 06:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ehumhbovMQDBmbv6S/fWaQDWOkoIxN7QeqVysJIGvCE=;
        b=TtoLQsTQ8Tw17+inL6jLVEIF0Mwr3eUOZzPszfr9oJvXUSZ/rFJW5stu1uhaVSr1hv
         hskDQgtzgrh/SxEOn3ocJnfAzQKll+UtGUKqMfzgOCtRqA3X0gRvQsqMJUJOCtrQuHLo
         8ZD3uIH2mAE2GHGM8f3VsxWCQiYR2DfnQbHwThXycm4yMEPcKcbjGb2sGKA1Mt/2V6eI
         j2WE+n69ZHwZ6dGL3PkDkh4TvzhQWyWHxlEvs+FqI5lw08Zh12Kk23rNrDPouEAJiFzV
         xbrOvnX50H9myHDXAxJCWAeG2Hqz0GHCNI4lcmAM+47dToNoz+EYh5RE6XIY6b9Jot9g
         kONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ehumhbovMQDBmbv6S/fWaQDWOkoIxN7QeqVysJIGvCE=;
        b=S8x/KgzDW0xBhgmYbweJFzg/AIkQkM9MEQNnmZyymJp7IfmXw43DgB0+vRUoqYoS7l
         wsVzG4qwMa8OJr4MWu2DoKvrmauz5btFHdREJHrPpq08BQmEWOIrUnII6D9mUxJuIbDb
         VUGz8cN4rWLK1xTWEANJqZhY8yoNdRTwFSpWMvTTHF76orD9P3oYtwh6xfWW2t/5Hm73
         OxQ2IyJPMo2oHhSZHsBzDgVSauYafZ9hpR6QXon5qCE8FC8nDm/tv3myUq023X5Mb4NJ
         Bxf4wlaRJhxiFCZBEtj/feNDiWNBzz49wLTyyjWUBSrqN/g4B68Be9xjB6+lD0yuvK2C
         mFUg==
X-Gm-Message-State: AOAM530wHjHUWNiIRfB26PcS89UqeT/ql+xQkn7ab8FsvYqbuMNCrE1R
        ASp9eD5KH5PwjhcJV5kSqUpZKYz7/0+W4fvzXnloUD2zYAM=
X-Google-Smtp-Source: ABdhPJycwT/knmuh0xkzadyk7Px0w8K8Cszdtf//fGxZI8vgx6KRNMRv0vzXRurU7IdjZ3ukqiCYoOmfoxTG/NS7Mfs=
X-Received: by 2002:a17:906:5912:: with SMTP id h18mr5354396ejq.261.1610633968405;
 Thu, 14 Jan 2021 06:19:28 -0800 (PST)
MIME-Version: 1.0
References: <20201125152247.30809-1-brgl@bgdev.pl> <20201125152247.30809-4-brgl@bgdev.pl>
 <X/+GQIhGmyHlIe0+@google.com> <CAMpxmJUQF8DwJzZN0960U10tjADh10GiexKmJv9o7AMp=9=caw@mail.gmail.com>
In-Reply-To: <CAMpxmJUQF8DwJzZN0960U10tjADh10GiexKmJv9o7AMp=9=caw@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 14 Jan 2021 15:19:17 +0100
Message-ID: <CAMRc=MfGy8KvncoiBqSV8T8dp=u9CR1fRjASOtGbd6qqZ7en0Q@mail.gmail.com>
Subject: Re: [PATCH 3/4] configfs: implement committable items
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Christoph Hellwig <hch@lst.de>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 9:40 AM Bartosz Golaszewski
<bgolaszewski@baylibre.com> wrote:
>
> On Thu, Jan 14, 2021 at 12:46 AM Joel Becker <jlbec@evilplan.org> wrote:
> >
> > On Wed, Nov 25, 2020 at 04:22:46PM +0100, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > >
> > > This implements configfs committable items. We mostly follow the
> > > documentation except that we extend config_group_ops with uncommit_item()
> > > callback for reverting the changes made by commit_item().
> >
> > Woohoo!  A long time coming, but thank you for working on the
> > implementation!
> >
> > > Each committable group has two sub-directories: pending and live. New
> > > items can only be created in pending/. Attributes can only be modified
> > > while the item is in pending/. Once it's ready to be committed, it must
> > > be moved over to live/ using the rename() system call. This is when the
> > > commit_item() function will be called.
> >
> > The original API intended for live items to still be modifyable.  The
> > live/ path forbids mkdir()/rmdir(), but it allows store().  Otherwise,
> > items can't be adjusted at all while in use, which is severely limiting.
> > Obviously the store() handler must not allow transitions from
> > valid-value->invalid-value, but the handler would reject invalid values
> > anyway, wouldn't it?
> >
> > > diff --git a/fs/configfs/file.c b/fs/configfs/file.c
> > > index 1f0270229d7b..a20e55fd05e8 100644
> > > --- a/fs/configfs/file.c
> > > +++ b/fs/configfs/file.c
> > > @@ -243,9 +243,17 @@ fill_write_buffer(struct configfs_buffer * buffer, const char __user * buf, size
> > >  static int
> > >  flush_write_buffer(struct file *file, struct configfs_buffer *buffer, size_t count)
> > >  {
> > > +     struct config_item *parent_item = buffer->item->ci_parent;
> > >       struct configfs_fragment *frag = to_frag(file);
> > > +     struct configfs_dirent *sd;
> > >       int res = -ENOENT;
> > >
> > > +     if (parent_item && parent_item->ci_dentry) {
> > > +             sd = parent_item->ci_dentry->d_fsdata;
> > > +             if (sd->s_type & CONFIGFS_GROUP_LIVE)
> > > +                     return -EPERM;
> > > +     }
> > > +
> > >       down_read(&frag->frag_sem);
> > >       if (!frag->frag_dead)
> > >               res = buffer->attr->store(buffer->item, buffer->page, count);
> >
> > Basically, I would just leave this hunk out.
> >
>
> I would make this configurable per-attribute because for the use-case
> I need this for we definitely don't want the items to be modifiable
> once they're "live".
>
> Bartosz

After a second thought: I agree this can be left to the user's
discretion so I'll just remove this and enforce it in the sample code.

One thing I'm unsure about is whether we should allow to change the
group's name when moving it from pending to live. Any thoughts?

Bartosz
