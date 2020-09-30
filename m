Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE96E27F64D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 01:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730528AbgI3XwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 19:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgI3XwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 19:52:01 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FAEC061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 16:52:01 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id j11so5413383ejk.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 16:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MY9a7xp4hw7GjU0Q4T5BNjAGiuJEGP50wyCFWUgZk1k=;
        b=AELe5H3n4BIlWjHXZ8r0jnQ4ThIPG3VpSN0Dy8jgcOZhwowpmOkqepQ+PBeMU8jyIc
         VlwXwFPyC4nbDVO4YfZgsLK3gKvQzJ3SSb1X/Hx5t/0UcMhkLahc8Uft9DAEusFGCap+
         CX2HC8TiovDz5sO/UufY0huVNWGDL5aAuyeBZwYfpHmL1DJTgPuz0hy6etNKObn7Fhfz
         a0Xu9WDxHFrMgnqOiyX0tbmvXGLB3ilFCon8VJ1WxNWS4M9erfImNmmkWzNutY9TU5iT
         rDm5YKC0eJr5qK2Oz5W5YhRzq0Bt9JAVYa0sZYI5dpw14H6udz3ch80exedbQtaF1rzp
         ipKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MY9a7xp4hw7GjU0Q4T5BNjAGiuJEGP50wyCFWUgZk1k=;
        b=StmORjtm9WLqWJ1V9cSph1Z+zklja2HFj0qN2I+sRmAJ/gRxes2A4m4lji6o6Bpj8r
         XCZlDcyWbl4zE53Xon7RDamvd8ciPTBY+++DbfwWHPcBDn5iWJD0tRAJrZhxsAdRal7r
         nKgxuRI6dVTtPbekq6y5D+wKhzsD+X5/jUR3zTNDegZI6vjs75IGmG1iSkHaY2EqyaXF
         lip8pBaD2ohioqwZS0LQ0ZPMNsY1fPOD7ucvUvMOxprP+hxIVxcKZ6d1Opk4Kd0Ky2U/
         Iwhn9JW15JbAMwXQEQ5wL6d1uMkJ7xQgH1mVkP7wkebvvYEysKVYG0KETQ2Qgk0ZVXqg
         Ri6g==
X-Gm-Message-State: AOAM531LeNJrPF4LPp2ot0zsOXRdXlFvmWEb5gVSSGBS9hn1VdPA8oBh
        jtgLBDK9JwkaSDC6ZbT04orXeOBnb8RVqlrt6X6Tog==
X-Google-Smtp-Source: ABdhPJxi4XR1rICV8jycnbPWuvIV1E5qABoEjoeptfU443YtnIYKxH/CWIOkKlATnPQlcsu9HWYVvbzX43bL93pJXPc=
X-Received: by 2002:a17:906:394:: with SMTP id b20mr4134151eja.513.1601509919666;
 Wed, 30 Sep 2020 16:51:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200930011944.19869-1-jannh@google.com> <CAG48ez03YJG9JU_6tGiMcaVjuTyRE_o4LEQ7901b5ZoCnNAjcg@mail.gmail.com>
 <20200930123000.GC9916@ziepe.ca> <CAG48ez2z1R8MLS0_pjhBSGnJC8RwaHMpiGdv8GhJUCrwtsLOPg@mail.gmail.com>
 <CAG48ez0fhY0twgriBDv9RU1YG8mBxg_KoK_YsLPWYo4feAQ=Sg@mail.gmail.com> <20200930232655.GE9916@ziepe.ca>
In-Reply-To: <20200930232655.GE9916@ziepe.ca>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 1 Oct 2020 01:51:33 +0200
Message-ID: <CAG48ez0i2++2Jg1Z-RyCKn-uZ-gcszVknAaCyXbJyptuMxbCsg@mail.gmail.com>
Subject: Re: [PATCH 3/4] mmap locking API: Don't check locking if the mm isn't
 live yet
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Michel Lespinasse <walken@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 1, 2020 at 1:26 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> On Wed, Sep 30, 2020 at 10:14:57PM +0200, Jann Horn wrote:
> > On Wed, Sep 30, 2020 at 2:50 PM Jann Horn <jannh@google.com> wrote:
> > > On Wed, Sep 30, 2020 at 2:30 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > > On Tue, Sep 29, 2020 at 06:20:00PM -0700, Jann Horn wrote:
> > > > > In preparation for adding a mmap_assert_locked() check in
> > > > > __get_user_pages(), teach the mmap_assert_*locked() helpers that it's fine
> > > > > to operate on an mm without locking in the middle of execve() as long as
> > > > > it hasn't been installed on a process yet.
> > > >
> > > > I'm happy to see lockdep being added here, but can you elaborate on
> > > > why add this mmap_locked_required instead of obtaining the lock in the
> > > > execv path?
> > >
> > > My thinking was: At that point, we're logically still in the
> > > single-owner initialization phase of the mm_struct. Almost any object
> > > has initialization and teardown steps that occur in a context where
> > > the object only has a single owner, and therefore no locking is
> > > required. It seems to me that adding locking in places like
> > > get_arg_page() would be confusing because it would suggest the
> > > existence of concurrency where there is no actual concurrency, and it
> > > might be annoying in terms of lockdep if someone tries to use
> > > something like get_arg_page() while holding the mmap_sem of the
> > > calling process. It would also mean that we'd be doing extra locking
> > > in normal kernel builds that isn't actually logically required.
> > >
> > > Hmm, on the other hand, dup_mmap() already locks the child mm (with
> > > mmap_write_lock_nested()), so I guess it wouldn't be too bad to also
> > > do it in get_arg_page() and tomoyo_dump_page(), with comments that
> > > note that we're doing this for lockdep consistency... I guess I can go
> > > change this in v2.
> >
> > Actually, I'm taking that back. There's an extra problem:
> > get_arg_page() accesses bprm->vma, which is set all the way back in
> > __bprm_mm_init(). We really shouldn't be pretending that we're
> > properly taking the mmap_sem when actually, we keep reusing a
> > vm_area_struct pointer.
>
> Any chance the mmap lock can just be held from mm_struct allocation
> till exec inserts it into the process?

Hm... it should work if we define a lockdep subclass for this so that
lockdep is happy when we call get_user() on the old mm_struct while
holding that mmap lock.

> > Does that sound reasonable?
>
> My only concern is how weird it is to do this with a variable, I've
> never seen something like this before

It seems clearer to me this way than taking locks when there is no
concurrency that we actually need to guard against. But since both you
and Michel seem to hate it, I'll go and code up the version with a
lockdep subclass. Under protest. :P
