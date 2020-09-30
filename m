Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4E1B27F61B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 01:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731870AbgI3Xmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 19:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730470AbgI3Xmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 19:42:37 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE293C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 16:42:36 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id b142so2601196ybg.9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 16:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=luDVp57wMcfpdftNDbDKSeVu1a5GQyNIzBHQaw4nI84=;
        b=sIW19YFFz+zsmEro8C1rNIpiF39LuiwMUcIGYtUS7Lu/+X/MqVJk6EXLGsFyk69z08
         dIfCxKpTgTmIEDuF/zowUKJxBeJHpPzPcavxn1oW2a0d9htzi7MzFXYHBbs4a+rSn9HV
         2wDwtTwPflyJ0D+bqBAo2wBJDV4VPW6TAqkt2zWieAOhFySixWDxf3XpYSmdDBXKmjUs
         fOokQkaHh7sZoEN+TD5rpMcCcnXbjTH7DqPfKOJqRTJGCaVDJNzKLleMfYhjM26ZrlOf
         twz26tv0h8W8qBOUO0lJl1nH8SJaYyVJvounETnWTzOAICmNSHfbJwM8gdDj+PNW/GIg
         p2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=luDVp57wMcfpdftNDbDKSeVu1a5GQyNIzBHQaw4nI84=;
        b=HM8Z/b9lbNoLmNRVDiPfwr9nq0czhf/t3yBKPYKdFrP5JTpwftEJhf9lnpwnqt9vyN
         6DEYVb2ohHV5n7AIGgzC8VWpx+tEETFXpFkg6f/WTFigfXnCj7K4lQoVVlcZKxcxIMK4
         71La0GmqK+CaBcp57NHIp1K3U70UE4Mk+MRrs7OKtx1yaVMemVluLtJY3DCSIsBNm02z
         Vfn1bYPoYFKca5AGcSBUG0L7Fufft42tMtK43/whTPTktMxGLRr/GutrmvDcJGGqhJSi
         MjTwSrFxDhKkshXe2y4ImjDz0Kq9yBPBWJXy+H149A7hwzln5mjjj0Qm4se72xfiTWRj
         JwLg==
X-Gm-Message-State: AOAM530MSKqij6GDXPdXPXM5NYvsrJo/ueSWCyoB9fVNGD16oEyGMVGH
        l4RSIOcT+XeoJ322swZhplmro96COVGwiWbieapeoA==
X-Google-Smtp-Source: ABdhPJyjKYPRns8jRytqvCWE8ZRfS7jx6rNxLXa2BRBQRCGLDzj42tWa7l9AT04SW0GPR2MfdO/2wHEWMG0/6tpHKLs=
X-Received: by 2002:a25:5056:: with SMTP id e83mr6637772ybb.287.1601509355833;
 Wed, 30 Sep 2020 16:42:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200930011944.19869-1-jannh@google.com> <CAG48ez03YJG9JU_6tGiMcaVjuTyRE_o4LEQ7901b5ZoCnNAjcg@mail.gmail.com>
 <20200930123000.GC9916@ziepe.ca> <CAG48ez2z1R8MLS0_pjhBSGnJC8RwaHMpiGdv8GhJUCrwtsLOPg@mail.gmail.com>
 <CAG48ez0fhY0twgriBDv9RU1YG8mBxg_KoK_YsLPWYo4feAQ=Sg@mail.gmail.com>
In-Reply-To: <CAG48ez0fhY0twgriBDv9RU1YG8mBxg_KoK_YsLPWYo4feAQ=Sg@mail.gmail.com>
From:   Michel Lespinasse <walken@google.com>
Date:   Wed, 30 Sep 2020 16:42:22 -0700
Message-ID: <CANN689FeQbw0Qa-c5ERNvhnSkPH4GgO_pCjRbmdcBi+tgzy_UA@mail.gmail.com>
Subject: Re: [PATCH 3/4] mmap locking API: Don't check locking if the mm isn't
 live yet
To:     Jann Horn <jannh@google.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 1:15 PM Jann Horn <jannh@google.com> wrote:
> On Wed, Sep 30, 2020 at 2:50 PM Jann Horn <jannh@google.com> wrote:
> > On Wed, Sep 30, 2020 at 2:30 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > On Tue, Sep 29, 2020 at 06:20:00PM -0700, Jann Horn wrote:
> > > > In preparation for adding a mmap_assert_locked() check in
> > > > __get_user_pages(), teach the mmap_assert_*locked() helpers that it's fine
> > > > to operate on an mm without locking in the middle of execve() as long as
> > > > it hasn't been installed on a process yet.
> > >
> > > I'm happy to see lockdep being added here, but can you elaborate on
> > > why add this mmap_locked_required instead of obtaining the lock in the
> > > execv path?
> >
> > My thinking was: At that point, we're logically still in the
> > single-owner initialization phase of the mm_struct. Almost any object
> > has initialization and teardown steps that occur in a context where
> > the object only has a single owner, and therefore no locking is
> > required. It seems to me that adding locking in places like
> > get_arg_page() would be confusing because it would suggest the
> > existence of concurrency where there is no actual concurrency, and it
> > might be annoying in terms of lockdep if someone tries to use
> > something like get_arg_page() while holding the mmap_sem of the
> > calling process. It would also mean that we'd be doing extra locking
> > in normal kernel builds that isn't actually logically required.
> >
> > Hmm, on the other hand, dup_mmap() already locks the child mm (with
> > mmap_write_lock_nested()), so I guess it wouldn't be too bad to also
> > do it in get_arg_page() and tomoyo_dump_page(), with comments that
> > note that we're doing this for lockdep consistency... I guess I can go
> > change this in v2.
>
> Actually, I'm taking that back. There's an extra problem:
> get_arg_page() accesses bprm->vma, which is set all the way back in
> __bprm_mm_init(). We really shouldn't be pretending that we're
> properly taking the mmap_sem when actually, we keep reusing a
> vm_area_struct pointer.
>
> So for that reason I prefer the approach in the existing patch, where
> we make it clear that mm_struct has two different lifetime phases in
> which GUP works, and that those lifetime phases have very different
> locking requirements.
>
> Does that sound reasonable?

I'm really not a fan of adding such exceptions; I think it's both
unusual and adds complexity that is not strictly contained into the
init paths.

I don't really understand the concern with the bprm vma in
get_arg_page(); I'm not super familiar with this code but isn't it a
normal vma within the process that __do_execve_file() is creating ? I
received Jason's last email while I was composing this one, but I
think I have the same concern/approach as him, i.e. I think it would
be simplest to keep the new MM locked through the __do_execve_file()
call and avoid adding the mmap_lock_required exception to the
mmap_assert_locked rule.

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
