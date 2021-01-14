Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9882F5C8F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 09:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbhANIlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 03:41:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbhANIle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 03:41:34 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7D0C061786
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 00:40:47 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id dj23so2246813edb.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 00:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=nCtrmkviUmQktLTVIGnwrV1sO0fnA2RJE1RYOo29das=;
        b=lnOkDlN7/8UGVYbFJTDV66RwQH6829K2lvepyTWbmrJT5RVZD+omMcYU7c+ztgtF+F
         GQvcaKrnxeTmT+uFqg7ZFP5F+jQyrI0JJrinGB97LRx+92T8BTpuRjptxdja/JTUk/NK
         P5mpSfUgYyGncrHLq21yo9pyA4ntXJjDz/zQ/T7mVHUtdyAfFaYFR6VBF8Ut/Eaos0Lr
         CgFl0md1kZY6NCNowoDCGxyUYkfU0GD91BBsoQvdF3OL0UKZh4nIbYmwcXWSuziVY+BO
         f2WCAgiSIulOwQNaD9KSXad8Zqau3MKhQhjcvJGHX2NCeyrpc6T0WwMWa1/I3FIg0DT+
         b0bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=nCtrmkviUmQktLTVIGnwrV1sO0fnA2RJE1RYOo29das=;
        b=pDmxpBMEDv1vktmM/TW1JvGgGIi985PiIGrIj0P8r4z9bCSEDslI0vZrZjkTFUqiMy
         lQRVSltv82LZN37nJKNXb6OPluQtaH+bkuG4rjWMhhBU5Bu3Hqvf7A5RnYxb7ThA0P2W
         ybsT1rGQ+mTfhzJtNZilKoGrQ7+eiSkL/MixCuS+bYVQa7TrVksM3EUoqHXUGZuLZh6w
         SK+8eaqpxGmH2snJJndqxrpfoJew09NcCo82Dqy8ft5HPEdO3nw5iOmLn1UpLu4I8cu6
         NGGHX1t7pH2XSV+lGD8ZP8lEUlnoR+1XRk+7snjaqMOF5z6aWTvLVoCWnTvo/cJAqtqz
         +S9g==
X-Gm-Message-State: AOAM530MWoWZHYU1vGakfvESFh072efj50RV0lhR8wGlyadh2ApAMJlZ
        xnVhXJ9kxMVPOAW7G9g479NIEPKRpR3j5QzGNf02yBIgegA=
X-Google-Smtp-Source: ABdhPJwpnHpv7lH6vsWp+Af2WWueJFgZFqWpgXnw12CttLIrK1bc/7sPBUmz9nECBF70QWGeiwHMhlJlnmDqhqRcnWA=
X-Received: by 2002:a05:6402:17:: with SMTP id d23mr4993820edu.341.1610613646639;
 Thu, 14 Jan 2021 00:40:46 -0800 (PST)
MIME-Version: 1.0
References: <20201125152247.30809-1-brgl@bgdev.pl> <20201125152247.30809-4-brgl@bgdev.pl>
 <X/+GQIhGmyHlIe0+@google.com>
In-Reply-To: <X/+GQIhGmyHlIe0+@google.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 14 Jan 2021 09:40:36 +0100
Message-ID: <CAMpxmJUQF8DwJzZN0960U10tjADh10GiexKmJv9o7AMp=9=caw@mail.gmail.com>
Subject: Re: [PATCH 3/4] configfs: implement committable items
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 12:46 AM Joel Becker <jlbec@evilplan.org> wrote:
>
> On Wed, Nov 25, 2020 at 04:22:46PM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > This implements configfs committable items. We mostly follow the
> > documentation except that we extend config_group_ops with uncommit_item()
> > callback for reverting the changes made by commit_item().
>
> Woohoo!  A long time coming, but thank you for working on the
> implementation!
>
> > Each committable group has two sub-directories: pending and live. New
> > items can only be created in pending/. Attributes can only be modified
> > while the item is in pending/. Once it's ready to be committed, it must
> > be moved over to live/ using the rename() system call. This is when the
> > commit_item() function will be called.
>
> The original API intended for live items to still be modifyable.  The
> live/ path forbids mkdir()/rmdir(), but it allows store().  Otherwise,
> items can't be adjusted at all while in use, which is severely limiting.
> Obviously the store() handler must not allow transitions from
> valid-value->invalid-value, but the handler would reject invalid values
> anyway, wouldn't it?
>
> > diff --git a/fs/configfs/file.c b/fs/configfs/file.c
> > index 1f0270229d7b..a20e55fd05e8 100644
> > --- a/fs/configfs/file.c
> > +++ b/fs/configfs/file.c
> > @@ -243,9 +243,17 @@ fill_write_buffer(struct configfs_buffer * buffer, const char __user * buf, size
> >  static int
> >  flush_write_buffer(struct file *file, struct configfs_buffer *buffer, size_t count)
> >  {
> > +     struct config_item *parent_item = buffer->item->ci_parent;
> >       struct configfs_fragment *frag = to_frag(file);
> > +     struct configfs_dirent *sd;
> >       int res = -ENOENT;
> >
> > +     if (parent_item && parent_item->ci_dentry) {
> > +             sd = parent_item->ci_dentry->d_fsdata;
> > +             if (sd->s_type & CONFIGFS_GROUP_LIVE)
> > +                     return -EPERM;
> > +     }
> > +
> >       down_read(&frag->frag_sem);
> >       if (!frag->frag_dead)
> >               res = buffer->attr->store(buffer->item, buffer->page, count);
>
> Basically, I would just leave this hunk out.
>

I would make this configurable per-attribute because for the use-case
I need this for we definitely don't want the items to be modifiable
once they're "live".

Bartosz
