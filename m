Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2E927F30D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 22:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbgI3UP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 16:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3UPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 16:15:25 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64474C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 13:15:25 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id qp15so3777161ejb.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 13:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3sPuIrm/H+6tsFTaFl1P+i+ksxlkVa8mKtAEYrx+o10=;
        b=L4wb/BfMnZfM59FoYSsrhnYFcWBnMSB7P03EwiydngMaA8RgPXyoP0JWUwlef486pY
         To9zt++muYCma88hlI3FOgRBHQKL9CjK/1aGelay7Vl9uCQhVeg5byiKXrwSRyQJGb9x
         F43pf5V/ZAS0vVVmxyBP9l9M1sIozAIA3/PJ5PqkRsW8rhJaVOmyGi9McLQDi8kf8l89
         yR7tWr/YgWH7VTtV2W+Hur56sTq8j5p2Vl3vHm1UnikeVFptnc5vJYrsJI9hTthV9CKy
         U1+5DiWI2OYYWmb/tyFOp+J/VD9NK+xfOLPx/0N6sorU4kqAql9dXbqX4WzEWAd4ekih
         cc4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3sPuIrm/H+6tsFTaFl1P+i+ksxlkVa8mKtAEYrx+o10=;
        b=piPCTdyNJz0xcfKhAd5ofveJASSX9JMCTi8FzIxo2x1CY6uKIa/L6vabXTLDWEBTS9
         EhB7pmEhEytnTYqm7YgRuDBEXq/t3KHlAg93+nWs5XCPU7zem1YicngME04nHyBuim0G
         apGn855e+tQ7pE6khfpxNZSngAse/ot+ywdxwatkTP8km8ZyvkvqYLLgcAc0SepJQlQR
         53gx6Qji5/4yghwwoyVYUEqMijzcwhA59ApHOI+maOgm+bt7DFIqHL6PM3GbU07urwbv
         B9rm5uBSNBs6j/mvZ6HiPZaCBIGMtGeNMniX5dAZLuuiC7jm/qAHHErnhCpwHe0U8tMs
         IENQ==
X-Gm-Message-State: AOAM530hTFSP0EhSLCsnq2J8YZKUBsVVxu64kAxwFnzaY4s3lKTosbhn
        IriRiwxDzQa4fa5T1c3f/UiZLIpMnrtkpva0GpRR8A==
X-Google-Smtp-Source: ABdhPJw5Nn4AQT8htAqMK3nUr3VFWxN3Qkl4eMUl7dH3m+0DYnTprr2Z2/ryFq1vHTExiXLd4l0psdD2JFaOlcQ5Hok=
X-Received: by 2002:a17:906:980f:: with SMTP id lm15mr4759153ejb.184.1601496923121;
 Wed, 30 Sep 2020 13:15:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200930011944.19869-1-jannh@google.com> <CAG48ez03YJG9JU_6tGiMcaVjuTyRE_o4LEQ7901b5ZoCnNAjcg@mail.gmail.com>
 <20200930123000.GC9916@ziepe.ca> <CAG48ez2z1R8MLS0_pjhBSGnJC8RwaHMpiGdv8GhJUCrwtsLOPg@mail.gmail.com>
In-Reply-To: <CAG48ez2z1R8MLS0_pjhBSGnJC8RwaHMpiGdv8GhJUCrwtsLOPg@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 30 Sep 2020 22:14:57 +0200
Message-ID: <CAG48ez0fhY0twgriBDv9RU1YG8mBxg_KoK_YsLPWYo4feAQ=Sg@mail.gmail.com>
Subject: Re: [PATCH 3/4] mmap locking API: Don't check locking if the mm isn't
 live yet
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Michel Lespinasse <walken@google.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 2:50 PM Jann Horn <jannh@google.com> wrote:
> On Wed, Sep 30, 2020 at 2:30 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > On Tue, Sep 29, 2020 at 06:20:00PM -0700, Jann Horn wrote:
> > > In preparation for adding a mmap_assert_locked() check in
> > > __get_user_pages(), teach the mmap_assert_*locked() helpers that it's fine
> > > to operate on an mm without locking in the middle of execve() as long as
> > > it hasn't been installed on a process yet.
> >
> > I'm happy to see lockdep being added here, but can you elaborate on
> > why add this mmap_locked_required instead of obtaining the lock in the
> > execv path?
>
> My thinking was: At that point, we're logically still in the
> single-owner initialization phase of the mm_struct. Almost any object
> has initialization and teardown steps that occur in a context where
> the object only has a single owner, and therefore no locking is
> required. It seems to me that adding locking in places like
> get_arg_page() would be confusing because it would suggest the
> existence of concurrency where there is no actual concurrency, and it
> might be annoying in terms of lockdep if someone tries to use
> something like get_arg_page() while holding the mmap_sem of the
> calling process. It would also mean that we'd be doing extra locking
> in normal kernel builds that isn't actually logically required.
>
> Hmm, on the other hand, dup_mmap() already locks the child mm (with
> mmap_write_lock_nested()), so I guess it wouldn't be too bad to also
> do it in get_arg_page() and tomoyo_dump_page(), with comments that
> note that we're doing this for lockdep consistency... I guess I can go
> change this in v2.

Actually, I'm taking that back. There's an extra problem:
get_arg_page() accesses bprm->vma, which is set all the way back in
__bprm_mm_init(). We really shouldn't be pretending that we're
properly taking the mmap_sem when actually, we keep reusing a
vm_area_struct pointer.

So for that reason I prefer the approach in the existing patch, where
we make it clear that mm_struct has two different lifetime phases in
which GUP works, and that those lifetime phases have very different
locking requirements.

Does that sound reasonable?
