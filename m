Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B011280791
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 21:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730116AbgJATPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 15:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729990AbgJATPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 15:15:14 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3BAC0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 12:15:14 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id q10so3661253qvs.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 12:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uGMkAxhuDj5FfbPsEDifWNGaWo692405WXUEZbsRCxM=;
        b=C075waHWdFnvMYTjG2o2S/1v9Ieo4CgRqHCOGyFXaWG9ko3GVbvVpXH4GOPqSz23HI
         fdc546AqCcRdZFfjsbRlpB73EL+0myi94C6xKRWd9uG3Qi2XwCQBjCJLXrH1IEZ/TqPg
         lvhSrK7UQul624Zt5Hp8oDrFUuoSF3ZgkMLjPpUIb7oKjszadpthUhsyRyfcWsD28j9/
         bkxHP4nxyCFr07cpLkaj42rYJeEjqoFqdtBmnsbssegHP43VGzPrwihFT0MLmj0e5YWD
         naUR8y+qtXvrlJGdjYSozYInRX6pdnKfVXXPmhLr250+G7LGVioE80ArnGyW0olfmzdN
         ibkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uGMkAxhuDj5FfbPsEDifWNGaWo692405WXUEZbsRCxM=;
        b=Eyct0ChVMbmyA0ujdiOTHEKZt55PTxTngC316bf/sQZ++2g+n5p6Brb3TdkBFYgmKi
         3fBtcQZPNDTcapKCQkUl+H1WeOe7D0efwZrw0Tr3+qGeihDdgWL8nqeY6juPty2MJ+U4
         uSeR8hHKzhH5g0slIkfSErukRtnPPd6SYVXpMvqjz7/jl40573lUUyk7PyQ7cBh4ZM9B
         ao2TqlgvSVAFX77VCFgSvl0noJ1/W7FbmzxEGJWfxkGenKV29a5X1F+2nrdpWVfoLRe2
         vkFbnXWooDVtsyG8dJHnv44V4U6wL7a1a5DbR5erImxvcpqR7cswGCtpOQsTZ9srZhkS
         GAGA==
X-Gm-Message-State: AOAM532QVUk0Xan9wBwmtdRR49wwLf8P1gcGSvcH56taaN7u8ZMOu2fg
        wNBYiAP+dZPa4sTcWXTpj/tppQ==
X-Google-Smtp-Source: ABdhPJwwcqAc4N1pLQ+ReR/iq1+k/8ZjmtVO90TFUjWFep363ro6Y0YtgjDBEKGQXpeNTqoOUP0kIQ==
X-Received: by 2002:ad4:4e8f:: with SMTP id dy15mr8752477qvb.45.1601579713399;
        Thu, 01 Oct 2020 12:15:13 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id h199sm7089007qke.112.2020.10.01.12.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 12:15:12 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kO42q-004rcz-1L; Thu, 01 Oct 2020 16:15:12 -0300
Date:   Thu, 1 Oct 2020 16:15:12 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jann Horn <jannh@google.com>
Cc:     Michel Lespinasse <walken@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH 3/4] mmap locking API: Don't check locking if the mm
 isn't live yet
Message-ID: <20201001191512.GF9916@ziepe.ca>
References: <20200930011944.19869-1-jannh@google.com>
 <CAG48ez03YJG9JU_6tGiMcaVjuTyRE_o4LEQ7901b5ZoCnNAjcg@mail.gmail.com>
 <20200930123000.GC9916@ziepe.ca>
 <CAG48ez2z1R8MLS0_pjhBSGnJC8RwaHMpiGdv8GhJUCrwtsLOPg@mail.gmail.com>
 <CAG48ez0fhY0twgriBDv9RU1YG8mBxg_KoK_YsLPWYo4feAQ=Sg@mail.gmail.com>
 <20200930232655.GE9916@ziepe.ca>
 <CAG48ez0i2++2Jg1Z-RyCKn-uZ-gcszVknAaCyXbJyptuMxbCsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez0i2++2Jg1Z-RyCKn-uZ-gcszVknAaCyXbJyptuMxbCsg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 01, 2020 at 01:51:33AM +0200, Jann Horn wrote:
> On Thu, Oct 1, 2020 at 1:26 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > On Wed, Sep 30, 2020 at 10:14:57PM +0200, Jann Horn wrote:
> > > On Wed, Sep 30, 2020 at 2:50 PM Jann Horn <jannh@google.com> wrote:
> > > > On Wed, Sep 30, 2020 at 2:30 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > > > On Tue, Sep 29, 2020 at 06:20:00PM -0700, Jann Horn wrote:
> > > > > > In preparation for adding a mmap_assert_locked() check in
> > > > > > __get_user_pages(), teach the mmap_assert_*locked() helpers that it's fine
> > > > > > to operate on an mm without locking in the middle of execve() as long as
> > > > > > it hasn't been installed on a process yet.
> > > > >
> > > > > I'm happy to see lockdep being added here, but can you elaborate on
> > > > > why add this mmap_locked_required instead of obtaining the lock in the
> > > > > execv path?
> > > >
> > > > My thinking was: At that point, we're logically still in the
> > > > single-owner initialization phase of the mm_struct. Almost any object
> > > > has initialization and teardown steps that occur in a context where
> > > > the object only has a single owner, and therefore no locking is
> > > > required. It seems to me that adding locking in places like
> > > > get_arg_page() would be confusing because it would suggest the
> > > > existence of concurrency where there is no actual concurrency, and it
> > > > might be annoying in terms of lockdep if someone tries to use
> > > > something like get_arg_page() while holding the mmap_sem of the
> > > > calling process. It would also mean that we'd be doing extra locking
> > > > in normal kernel builds that isn't actually logically required.
> > > >
> > > > Hmm, on the other hand, dup_mmap() already locks the child mm (with
> > > > mmap_write_lock_nested()), so I guess it wouldn't be too bad to also
> > > > do it in get_arg_page() and tomoyo_dump_page(), with comments that
> > > > note that we're doing this for lockdep consistency... I guess I can go
> > > > change this in v2.
> > >
> > > Actually, I'm taking that back. There's an extra problem:
> > > get_arg_page() accesses bprm->vma, which is set all the way back in
> > > __bprm_mm_init(). We really shouldn't be pretending that we're
> > > properly taking the mmap_sem when actually, we keep reusing a
> > > vm_area_struct pointer.
> >
> > Any chance the mmap lock can just be held from mm_struct allocation
> > till exec inserts it into the process?
> 
> Hm... it should work if we define a lockdep subclass for this so that
> lockdep is happy when we call get_user() on the old mm_struct while
> holding that mmap lock.

A subclass isn't right, it has to be a _nested annotation.

nested locking is a pretty good reason to not be able to do this, this
is something lockdep does struggle to model.

Jason
