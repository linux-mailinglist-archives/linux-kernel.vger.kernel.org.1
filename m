Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A00A027F5FB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 01:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732320AbgI3X1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 19:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730192AbgI3X06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 19:26:58 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E77C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 16:26:58 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id z2so2803570qtv.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 16:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QYFXqJkpWwNHWn45HDc4xPYLfZFQs73v+wcJibg2ncI=;
        b=kJUsDmf3lco5P+YD/j58UOEmKbo+GoiJA2V3Z1FFEczpRqtI8xR8187j30EqlUyi8Z
         Pym66gmusyN2Pt6z6t4Le10rbm8rf09VSyn4OdkTiK+9mXD2dvCc4/2xJE9kb3kH9W3Q
         1RTawqwnwbfc/FQIe6qJQfccQdliHVY8RyEZkhwjStES2oaDzCZCddvRJMs5ew3bJn/E
         3ZvO5CxVYbFBuEoi9zIDq3iLbedeelXF+PE3SigZIBih8QmCltG/heWCIfQbNLQiKJ0N
         jDaHT6Y7+iXHypDhX43ERuWIrbHCXdEjrowqFFE732q80p7Hupn3IXT0F/ldHk5t408e
         iVXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QYFXqJkpWwNHWn45HDc4xPYLfZFQs73v+wcJibg2ncI=;
        b=EZwpf3SA93GQAkPDYOhzzxlT1xp62lLopPro6dI00iTmsQ+6OQfliE0gZlzW76L3rK
         J6AAxgfXKgFTWhzl6h0pGJ5wFrv0SuIQDQvjWlnj+O1Y1Q2C8P7JFsd5NhTy86LyT8dU
         huACW31T8eSguhpCKcI+uYScAWgQdvAcWsuXkYil1HVSDw+RamQfdk602LeBzzGRJXmV
         FozFxyYZKsBvkhk+ypwKG9x1ZAoveTL/ztZ3+ss2CQi+O+yg2wdxVjvLb3jG3bZ9gcq4
         h2xypPAPPsbz3UmrhEXKeWVS3FX9x8U6ryiE8hvSTYynC7a6FkXEhQEZ69Q31fvP/8ue
         FqOA==
X-Gm-Message-State: AOAM530EtHNma+XVoP4YbkLjNtU2IcwtCeaocsjAP+jhCxyOgieuu2Rq
        VzTTiPdsYaa0J0ZJ/sR++yMeJQ==
X-Google-Smtp-Source: ABdhPJx0Ptq8Rn7jIQg8667tHirN8NeH8LBlxqTnmJRotl6mZoQ2FfpLkjbrx0nLyfZQAzU3XdbH7A==
X-Received: by 2002:ac8:409e:: with SMTP id p30mr4768472qtl.208.1601508417240;
        Wed, 30 Sep 2020 16:26:57 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id 8sm3982768qkc.100.2020.09.30.16.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 16:26:56 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kNlUt-004PIm-R3; Wed, 30 Sep 2020 20:26:55 -0300
Date:   Wed, 30 Sep 2020 20:26:55 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Michel Lespinasse <walken@google.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH 3/4] mmap locking API: Don't check locking if the mm
 isn't live yet
Message-ID: <20200930232655.GE9916@ziepe.ca>
References: <20200930011944.19869-1-jannh@google.com>
 <CAG48ez03YJG9JU_6tGiMcaVjuTyRE_o4LEQ7901b5ZoCnNAjcg@mail.gmail.com>
 <20200930123000.GC9916@ziepe.ca>
 <CAG48ez2z1R8MLS0_pjhBSGnJC8RwaHMpiGdv8GhJUCrwtsLOPg@mail.gmail.com>
 <CAG48ez0fhY0twgriBDv9RU1YG8mBxg_KoK_YsLPWYo4feAQ=Sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez0fhY0twgriBDv9RU1YG8mBxg_KoK_YsLPWYo4feAQ=Sg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 10:14:57PM +0200, Jann Horn wrote:
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

Any chance the mmap lock can just be held from mm_struct allocation
till exec inserts it into the process?

> Does that sound reasonable?

My only concern is how weird it is to do this with a variable, I've
never seen something like this before

Jason
