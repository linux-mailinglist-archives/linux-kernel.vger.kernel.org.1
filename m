Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC66275CCE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 18:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbgIWQIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 12:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgIWQIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 12:08:04 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B73C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 09:08:03 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id nw23so410539ejb.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 09:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ytpQX50zZMaEMQaAlIh0adb4P84Vsg6tw8C6NwQ+stk=;
        b=EOLE5mJUi4mJrrvSyx0iP2oqTE+pryWZIck1qLqp23MF0iBaUWYwzFN/94Hkc3a7Ov
         B9kmZGDXCgAg7tLR5zzD9Aszz/1WQZqreUiI4vvG3h34F95rVFvXeS1MQTK7dgPVfp4o
         CQqoSfduPZZqkyrQC4FetsbzlOAB+1mG0prHc5H8Vu3jAK7ZiDnGbQw5UbpZz+k70kKk
         LZEayFtnOoWkEvgebh4n6q0sZclmKduaH9XRmxYCdT640hCL9Z3rsM/DEkkYQh56svGX
         b+7LkxBg0F0vHdMZ4n0abSJINZAY4ur0/wT4HUhs+10KhNhUhIoMYQZNersv/G21yPFR
         Q77A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ytpQX50zZMaEMQaAlIh0adb4P84Vsg6tw8C6NwQ+stk=;
        b=hIze1caVlhBmJyQJqqjg7/yqasESUTZxtH+j7bw8a575RmOIlJW8/iWfDkGLXUBWIW
         vvA0Mkyym8k61urV7HE7zf0ECZnvNQaDw666eJFoPMOrvUA/El4SEQWE9bkKl8U/Adj8
         ac5YWbUDJF+09DsX1I511Cp23NgiRqarIrz5i/gxlblT9x+jjaw1mL8NJECZ1FPt3vEj
         GU9Oboo+lxPjaNwItNMB816TrtyeIT8mZboD3rUDmapz1vCkUg0KaRMwIafx0cJXTaJW
         d2rt/96eQO63B5frX20WMUTNIpX806rUCMSU75ABm+qnglVhf59yphn0HU1hWiK5xZXA
         d6xw==
X-Gm-Message-State: AOAM532UOWMNJSJZSMyMwbPUsaEtpG5i0ukZoMVaOo+WpLVuLlCiSH8a
        uy8X1yGcNm9PFnM3vpPrnJ2Vhg85AyjSBjFD63tuABOApq36NQ==
X-Google-Smtp-Source: ABdhPJy2mvZO8nnJZWgDCc07HwUVWuH6YOlb3YxRoyTAukIUclE1P+QiWn4/UpavJrB9WxROjJROhSVLgWWrIXeSPCg=
X-Received: by 2002:a17:906:8297:: with SMTP id h23mr325450ejx.383.1600877282397;
 Wed, 23 Sep 2020 09:08:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200921211744.24758-1-peterx@redhat.com> <20200921212031.25233-1-peterx@redhat.com>
 <20200922120505.GH8409@ziepe.ca> <20200923152409.GC59978@xz-x1>
In-Reply-To: <20200923152409.GC59978@xz-x1>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 23 Sep 2020 09:07:49 -0700
Message-ID: <CAHbLzkr_C-4g+ArA3JXyvFHiAzU1ObHA9f4t1anj=N9b8oi7wQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] mm/thp: Split huge pmds/puds if they're pinned when fork()
To:     Peter Xu <peterx@redhat.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Hugh Dickins <hughd@google.com>,
        Leon Romanovsky <leonro@nvidia.com>, Jan Kara <jack@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 8:26 AM Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Sep 22, 2020 at 09:05:05AM -0300, Jason Gunthorpe wrote:
> > On Mon, Sep 21, 2020 at 05:20:31PM -0400, Peter Xu wrote:
> > > Pinned pages shouldn't be write-protected when fork() happens, because follow
> > > up copy-on-write on these pages could cause the pinned pages to be replaced by
> > > random newly allocated pages.
> > >
> > > For huge PMDs, we split the huge pmd if pinning is detected.  So that future
> > > handling will be done by the PTE level (with our latest changes, each of the
> > > small pages will be copied).  We can achieve this by let copy_huge_pmd() return
> > > -EAGAIN for pinned pages, so that we'll fallthrough in copy_pmd_range() and
> > > finally land the next copy_pte_range() call.
> > >
> > > Huge PUDs will be even more special - so far it does not support anonymous
> > > pages.  But it can actually be done the same as the huge PMDs even if the split
> > > huge PUDs means to erase the PUD entries.  It'll guarantee the follow up fault
> > > ins will remap the same pages in either parent/child later.
> > >
> > > This might not be the most efficient way, but it should be easy and clean
> > > enough.  It should be fine, since we're tackling with a very rare case just to
> > > make sure userspaces that pinned some thps will still work even without
> > > MADV_DONTFORK and after they fork()ed.
> > >
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > >  mm/huge_memory.c | 26 ++++++++++++++++++++++++++
> > >  1 file changed, 26 insertions(+)
> > >
> > > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > > index 7ff29cc3d55c..c40aac0ad87e 100644
> > > +++ b/mm/huge_memory.c
> > > @@ -1074,6 +1074,23 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
> > >
> > >     src_page = pmd_page(pmd);
> > >     VM_BUG_ON_PAGE(!PageHead(src_page), src_page);
> > > +
> > > +   /*
> > > +    * If this page is a potentially pinned page, split and retry the fault
> > > +    * with smaller page size.  Normally this should not happen because the
> > > +    * userspace should use MADV_DONTFORK upon pinned regions.  This is a
> > > +    * best effort that the pinned pages won't be replaced by another
> > > +    * random page during the coming copy-on-write.
> > > +    */
> > > +   if (unlikely(READ_ONCE(src_mm->has_pinned) &&
> > > +                page_maybe_dma_pinned(src_page))) {
> > > +           pte_free(dst_mm, pgtable);
> > > +           spin_unlock(src_ptl);
> > > +           spin_unlock(dst_ptl);
> > > +           __split_huge_pmd(vma, src_pmd, addr, false, NULL);
> > > +           return -EAGAIN;
> > > +   }
> >
> > Not sure why, but the PMD stuff here is not calling is_cow_mapping()
> > before doing the write protect. Seems like it might be an existing
> > bug?
>
> IMHO it's not a bug, because splitting a huge pmd should always be safe.
>
> One thing I can think of that might be special here is when the pmd is
> anonymously mapped but also shared (shared, tmpfs thp, I think?), then here
> we'll also mark it as wrprotected even if we don't need to (or maybe we need it
> for some reason..).  But again I think it's safe anyways - when page fault

For tmpfs map, the pmd split just clears the pmd entry without
reinstalling ptes (oppositely anonymous map would reinstall ptes). It
looks this patch intends to copy at pte level by splitting pmd. But
I'm afraid this may not work for tmpfs mappings.

> happens, wp_huge_pmd() should split it into smaller pages unconditionally.  I
> just don't know whether it's the ideal way for the shared case.  Andrea should
> definitely know it better (because it is there since the 1st day of thp).
>
> >
> > In any event, the has_pinned logic shouldn't be used without also
> > checking is_cow_mapping(), so it should be added to that test. Same
> > remarks for PUD
>
> I think the case mentioned above is also the special case here when we didn't
> check is_cow_mapping().  The major difference is whether we'll split the page
> right now, or postpone it until the next write to each mm.  But I think, yes,
> maybe I should better still keep the is_cow_mapping() to be explicit.
>
> Thanks,
>
> --
> Peter Xu
>
