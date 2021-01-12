Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E47CD2F3CC7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437191AbhALVeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 16:34:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436557AbhALUEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 15:04:46 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56A2C061786
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 12:04:05 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id i24so3731279edj.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 12:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zdxtVLMD51rvFAUy0uouYzv2JNuR8PLKzsDJKh3c7Cc=;
        b=CgpDpWy/pkuZnqaYJDLuySEgBXiA4xKvWHC6DDiTgu764C6H2UCvCPUgHrlwGCzNgn
         fUPc1JLbqFUNBeCqrSEzGK8bJsHxrYcGVhvWQ61okYi8XBqIFrRUo/7g7pMkXeEDHvCa
         MyeA+dDYsLk+ftkMn3+9QPWX7bV5ijeBGChWSoAyKPKc9q42zWa9VlQF0vBw0z2xw9f9
         vWDACqEUBquj/+PzQCjr+uwpecPRHxBT/oDEcZt5AzrxJ4HfTHhe46p36xDJ/Bp+lxM0
         /5mQZHjY9h9MRqM4jAEgXFCkH91me6ItJ+CUCFgE+bTMLqtnIHXlIxnl6dDyQksB2VhH
         vsBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zdxtVLMD51rvFAUy0uouYzv2JNuR8PLKzsDJKh3c7Cc=;
        b=EFVFTlLXrQcyC05wY6tSwrg2ubFM15H2t75gJa+YaPQzsqR2jwujdc8ts4fCbFLeGq
         4YdqRQ4bkj3yxLucyb0pAfKGiOJyxOW6STyV/mgvk4iE5l9pR4PjYHHXtmOxDw6TBkMX
         VbN/gDNDR2g4mXo9kvE48tlsmeuDxKNjpOfNmn0v2cy7lXqCscgWir6QjBkUk5+E3sJG
         ITnUs3uINovI4MbGG9jKrN3q77ooeLqN/Wt+EefvUbH7Lb2MbDVAtjwN1GIZ4sa+6wYo
         iWdl9KjAXyIVPBPPj+4xSOE810Qe+ZrP7/n94qKokZ3wFjObHEUwfpIwud0RJA4MgiLX
         qnXA==
X-Gm-Message-State: AOAM5333oDxlxtghKP1VhhXBFVyME+DpliDiIuaY6qEl1uKFT8eNtjBm
        Zobn5o3x462pD9CB+PlLGwxITJ1K4TT0uE+5iI0d4w==
X-Google-Smtp-Source: ABdhPJx9xG3m3PHJqgK6syqsFY+KpasjAjyzludTeiiipSmlClrjWTgEwzevdI3KyXO0/VPNMVZJDuulLjmGdX6Q/p0=
X-Received: by 2002:aa7:c2d8:: with SMTP id m24mr661543edp.300.1610481844483;
 Tue, 12 Jan 2021 12:04:04 -0800 (PST)
MIME-Version: 1.0
References: <161044407603.1482714.16630477578392768273.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161044409809.1482714.11965583624142790079.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210112095345.GA12534@linux>
In-Reply-To: <20210112095345.GA12534@linux>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 12 Jan 2021 12:03:55 -0800
Message-ID: <CAPcyv4gb3t+QDqYXacgL-5npQ3ieL8XG9PvmgBSjZ5cdr_hF+A@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] mm: Fix page reference leak in soft_offline_page()
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        stable <stable@vger.kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 1:54 AM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Tue, Jan 12, 2021 at 01:34:58AM -0800, Dan Williams wrote:
> > The conversion to move pfn_to_online_page() internal to
> > soft_offline_page() missed that the get_user_pages() reference needs to
> > be dropped when pfn_to_online_page() fails.
>
> I would be more specific here wrt. get_user_pages (madvise).
> soft_offline_page gets called from more places besides madvise_*.

Sure.

>
> > When soft_offline_page() is handed a pfn_valid() &&
> > !pfn_to_online_page() pfn the kernel hangs at dax-device shutdown due to
> > a leaked reference.
> >
> > Fixes: feec24a6139d ("mm, soft-offline: convert parameter to pfn")
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: Michal Hocko <mhocko@kernel.org>
> > Cc: Oscar Salvador <osalvador@suse.de>
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> LGTM, thanks for catching this:
>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
>
> A nit below.
>
> > ---
> >  mm/memory-failure.c |   20 ++++++++++++++++----
> >  1 file changed, 16 insertions(+), 4 deletions(-)
> >
> > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > index 5a38e9eade94..78b173c7190c 100644
> > --- a/mm/memory-failure.c
> > +++ b/mm/memory-failure.c
> > @@ -1885,6 +1885,12 @@ static int soft_offline_free_page(struct page *page)
> >       return rc;
> >  }
> >
> > +static void put_ref_page(struct page *page)
> > +{
> > +     if (page)
> > +             put_page(page);
> > +}
>
> I am not sure this warrants a function.
> I would probably go with "if (ref_page).." in the two corresponding places,
> but not feeling strong here.

I'll take another look, it felt cluttered...

>
> > +
> >  /**
> >   * soft_offline_page - Soft offline a page.
> >   * @pfn: pfn to soft-offline
> > @@ -1910,20 +1916,26 @@ static int soft_offline_free_page(struct page *page)
> >  int soft_offline_page(unsigned long pfn, int flags)
> >  {
> >       int ret;
> > -     struct page *page;
> >       bool try_again = true;
> > +     struct page *page, *ref_page = NULL;
> > +
> > +     WARN_ON_ONCE(!pfn_valid(pfn) && (flags & MF_COUNT_INCREASED));
>
> Did you see any scenario where this could happen? I understand that you are
> adding this because we will leak a reference in case pfn is not valid anymore.
>

I did not, more future proofing / documenting against refactoring that
fails to consider that case.
