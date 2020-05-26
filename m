Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75F941B0854
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 13:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgDTLy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 07:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726381AbgDTLyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 07:54:55 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5CEC0610D6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 04:54:54 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id a2so7677399ejx.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 04:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xz434+emhPfWjjKXYErvQLCog0qnyrqkr9U47Pj8EAE=;
        b=eMGJ6i/Tp+yHljfYp7aMYd/mUsv2EnqVE+fCxu3XOH5yGdB0h61gy+ScRLFSyuRmgb
         qURUHX6I6Ir8eepIVf+Ri2YviGMLt6DWjxys1zOQJEVUfWPlsKPJUpkbtTkdGn4w0n0B
         1MP04jnPqpFSU10941aKvkRA4UrFsDmfSRMik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xz434+emhPfWjjKXYErvQLCog0qnyrqkr9U47Pj8EAE=;
        b=F7Nh/wylWwnQgfEin1ryp2xjjsfBCxJI6fD8cWOTdYK8gAERn2YRwl3uPBjUP4/J9x
         V06poJGawnBHET9sMJp6huu4ASz9QlhFTMxOBmuyoLA0aB29BM0b9DGyKH3Y15ddjpH6
         bL69uoNj96HtB6PGfiH5PgI8nIEqHkZpDGZeYCRLd15iAML0TcP6b0Ve4bBXroBflFoX
         Iy6/DN0R4lgMqi/RFSMeQDTvDFsBTOhLDp21aOO0XvbM87CyaHdZUhXB+iWWbPlk65j/
         /9rOtc5HjSYxE6g857Ttn7/v8kqyIQ72twB1lODuLTIaEgAuUDIGmbbQ32vxEL1yY/9R
         Ktbw==
X-Gm-Message-State: AGi0Pub42p79UykA0Rinlw1V1y6Wf+Eq/z2lGRnvR0L2tUgQmOqKW3WA
        SjLbNA97cAw+VWSaZpuDhpZOC5KjXWi13+dwblx9dw==
X-Google-Smtp-Source: APiQypLbTn+lSf9tXQjoSINzOkViouA+EuTM208dkpb3K/JiwqGLK/tHyeL8eS/wVDrlTm/f0ngTgrLv3Gua9FB3DGg=
X-Received: by 2002:a17:906:8549:: with SMTP id h9mr15204554ejy.145.1587383692787;
 Mon, 20 Apr 2020 04:54:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200414150233.24495-1-willy@infradead.org> <20200414150233.24495-25-willy@infradead.org>
 <CAJfpegsZF=TFQ67vABkE5ghiZoTZF+=_u8tM5U_P6jZeAmv23A@mail.gmail.com> <20200420114300.GB5820@bombadil.infradead.org>
In-Reply-To: <20200420114300.GB5820@bombadil.infradead.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 20 Apr 2020 13:54:41 +0200
Message-ID: <CAJfpeguKAbE+_=ctxp+_3gtbqADevMPrRQ1XV6t8AHXbKwDKvg@mail.gmail.com>
Subject: Re: [PATCH v11 24/25] fuse: Convert from readpages to readahead
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        William Kucharski <william.kucharski@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 1:43 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Apr 20, 2020 at 01:14:17PM +0200, Miklos Szeredi wrote:
> > > +       for (;;) {
> > > +               struct fuse_io_args *ia;
> > > +               struct fuse_args_pages *ap;
> > > +
> > > +               nr_pages = readahead_count(rac) - nr_pages;
> >
> > Hmm.  I see what's going on here, but it's confusing.   Why is
> > __readahead_batch() decrementing the readahead count at the start,
> > rather than at the end?
> >
> > At the very least it needs a comment about why nr_pages is calculated this way.
>
> Because usually that's what we want.  See, for example, fs/mpage.c:
>
>         while ((page = readahead_page(rac))) {
>                 prefetchw(&page->flags);
>                 args.page = page;
>                 args.nr_pages = readahead_count(rac);
>                 args.bio = do_mpage_readpage(&args);
>                 put_page(page);
>         }
>
> fuse is different because it's trying to allocate for the next batch,
> not for the batch we're currently on.
>
> I'm a little annoyed because I posted almost this exact loop here:
>
> https://lore.kernel.org/linux-fsdevel/CAJfpegtrhGamoSqD-3Svfj3-iTdAbfD8TP44H_o+HE+g+CAnCA@mail.gmail.com/
>
> and you said "I think that's fine", modified only by your concern
> for it not being obvious that nr_pages couldn't be decremented by
> __readahead_batch(), so I modified the loop slightly to assign to
> nr_pages.  The part you're now complaining about is unchanged.

Your annoyance is perfectly understandable.   This is something I
noticed now, not back then.

>
> > > +               if (nr_pages > max_pages)
> > > +                       nr_pages = max_pages;
> > > +               if (nr_pages == 0)
> > > +                       break;
> > > +               ia = fuse_io_alloc(NULL, nr_pages);
> > > +               if (!ia)
> > > +                       return;
> > > +               ap = &ia->ap;
> > > +               nr_pages = __readahead_batch(rac, ap->pages, nr_pages);
> > > +               for (i = 0; i < nr_pages; i++) {
> > > +                       fuse_wait_on_page_writeback(inode,
> > > +                                                   readahead_index(rac) + i);
> >
> > What's wrong with ap->pages[i]->index?  Are we trying to wean off using ->index?
>
> It saves reading from a cacheline?  I wouldn't be surprised if the
> compiler hoisted the read from rac->_index to outside the loop and just
> iterated from rac->_index to rac->_index + nr_pages.

Hah, if such optimizations were worth anything with codepaths
involving roundtrips to userspace...

Anyway, I'll let these be, and maybe clean them up later.

Acked-by:  Miklos Szeredi <mszeredi@redhat.com>

Thanks,
Miklos
