Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE551D8957
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 22:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgERUgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 16:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbgERUgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 16:36:03 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399C4C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 13:36:02 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id w10so11335815ljo.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 13:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3L59nRthiFfkytay0hS/vHEY6X7pgsTeIQ+1Fo4gUXg=;
        b=SmZaZsDyw7GcMLk81eBDm80EPCTMBbXKR9C3yTzJwxSO01tUBrvmpyoFK1EIYATfw7
         vlcIOZgFCAqWgZFgvkxhXt4QYMKxCUTF1cv+i3B7/VToVBSDKPvauPxraf1h3Q0U6LwI
         wgk0/VVMKdLDTxOuI8VsdAYYkYI7r8kikf+YcONg9Gb0XW9lWTFUnIXjBFPt03J9tIEk
         X3OFi4LVEPVgtCuzZGTRvzu7JGInPPNZjkXFSPaQ/K70GBaom5acNi3+/EHqjbhOHIgg
         ft0/dZxDJyZyrmn76Ai2Fard59qXKbiWriyRtYhh+0WIGvqz+QmM/Roq97E7dAWcG3S4
         JDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3L59nRthiFfkytay0hS/vHEY6X7pgsTeIQ+1Fo4gUXg=;
        b=Gcov+wFJcd4KrhAuKjs5WrjS89vo58aB5x0glrGe9sPqkF73BOQ/MvlLbYHgr3eAji
         U8b3fMjcWoi67Gtq5YUxy0nJ/wsPNvAoyEgqr7OsYovp8CbypFuahCQ4g3RSg+oddF7f
         HmQuROYU45Xwc5j2iHxE14QijL5DBEBM0XBX+ntygkXVlP8FlfAN3Zd4VWGYVaENW0LO
         Ty/F7274c3/WzRmjNVHYx6fP+fN8DJmnQpWOg+wrQQ2rXkaD/Ae3QZ4Ym1AHmXGOBnTZ
         KM6tL14nkHwyYfXf1TEmyqEC7UOcWMcxP2lSnadS3E2F/HHrPuuwZ+KCKxz89KzCSeq/
         UBRA==
X-Gm-Message-State: AOAM5320g+xvOnm8cw6r16aSbPxbvP57PFaV2W7bgdozWnUAM0f1utlv
        Q4v8TTLewQySYBkHz3U8MsCpyF/fcEE9J0x9YTNzNvu9
X-Google-Smtp-Source: ABdhPJwphy4mnxySWsCfrCGpUDbuyK5wlVe+z53mZjWJjOpJ2rJ0VcCksH6Fuhxx0vqcUdLwwOACQcy6cEKrSvg24CU=
X-Received: by 2002:a05:651c:50e:: with SMTP id o14mr11720435ljp.52.1589834160491;
 Mon, 18 May 2020 13:36:00 -0700 (PDT)
MIME-Version: 1.0
References: <1589831903-27800-1-git-send-email-jrdr.linux@gmail.com> <20200518201737.GV16070@bombadil.infradead.org>
In-Reply-To: <20200518201737.GV16070@bombadil.infradead.org>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 19 May 2020 02:14:01 +0530
Message-ID: <CAFqt6zbcn5kEbtY1fod4yy_PETKX8zVM2NjsY0HHyOixiu2q4w@mail.gmail.com>
Subject: Re: [RFC] mm/gup.c: Use gup_flags as parameter instead of passing
 write flag
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 19 May, 2020, 1:47 AM Matthew Wilcox, <willy@infradead.org> wrote:
>
> On Tue, May 19, 2020 at 01:28:23AM +0530, Souptick Joarder wrote:
> > The idea is to get rid of write parameter. Instead caller will pass
> > FOLL_WRITE to __get_user_pages_fast(). This will not change any
> > functionality of the API. Once it is upstream all the callers will
> > be changed to pass FOLL_WRITE.
>
> Uhh ... until you change all the callers, haven't you just broken all
> the callers?

All the callers have called the API with either 1 or 0.  I think, it's
not going to break
any of the callers.

>
> > -int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
> > -                       struct page **pages)
> > +int __get_user_pages_fast(unsigned long start, int nr_pages,
> > +                     unsigned int gup_flags, struct page **pages)
> >  {
> >       unsigned long len, end;
> >       unsigned long flags;
> > @@ -2685,10 +2692,7 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
> >        * Internally (within mm/gup.c), gup fast variants must set FOLL_GET,
> >        * because gup fast is always a "pin with a +1 page refcount" request.
> >        */
> > -     unsigned int gup_flags = FOLL_GET;
> > -
> > -     if (write)
> > -             gup_flags |= FOLL_WRITE;
> > +     gup_flags |= FOLL_GET;
