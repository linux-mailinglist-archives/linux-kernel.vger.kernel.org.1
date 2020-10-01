Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8470A28084E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 22:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732995AbgJAUSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 16:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbgJAUSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 16:18:01 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F39C0613E4
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 13:17:03 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id qp15so9035100ejb.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 13:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KoOUahrMeyAsDE3oQQyqv2s9yY8l3xOTS/NeUkZg2MI=;
        b=cs9lvKVsNx/11Qr3REjeolUBHOiaVpoLUXk6f1C2zVadx1U7tV6p0ycccRnj0KUavS
         Y9TzZ4I3c726eRkbW2TGrgqYswDo6SfIP+38ukO+trgWznYHvEi3MvUiceLmBvibes8i
         ZtYTFjpMBsCyJjKB796uYMKj5L3uzo4LLgvjHtWcBeo1Tk4Yx+LFc+PqFfAKiE+o+2AS
         fora95yyPF8K5ifGMtGSbZ+C7u8C0sOCaimllNZzE61LAfI2/IQIVe0I2dxrhhiG5luz
         Q78dy/6lXP2MWiYmvHi3CEOkrGfwf7PdK2NUBcb6YJpZwrXx7c+E74tGnE6zBQwEddRG
         eGIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KoOUahrMeyAsDE3oQQyqv2s9yY8l3xOTS/NeUkZg2MI=;
        b=DZVIiTj4jfoOcRW8xBD8RFMHKguv3bWgz4Efy1fdU9pxfCeV4xd+eNLz7jRylgvpE5
         /aoG6syCyX/eOyiYUtW+qZ1aTDwYC4zgGNXxs9he2aZiwRjp8dKs7EKeKFNn4tlJI/K3
         Wv2fpq3MVIR6ocdrEJTz0t8bZahTM+u4lmk8ta5l1lp2FhQkGkM+clNmxxvTq04LWmnj
         a8bsSeQQWdWBs6TqQtuhb9AXssAg6miUrfKDkzf4Xk+L1VfyfNpxvRmSyw6Vx04Izwqz
         +NUr/foyEtg+gz04Ux6Yo7u9E/1hPe3/dsxP4ga1ZKQNFcCoeQEPzkqpjGuPkxYmtkj2
         RtdQ==
X-Gm-Message-State: AOAM530APdtP/V/SX7xrwroqv1qwFylS5Zrt7AN4YNK9p6jpv0T99d2R
        78f2skx+wQsjm4FFqD/MDrEPcXl710Fh5EvdZNBTHw==
X-Google-Smtp-Source: ABdhPJxEM1ybNkLizKQYPuPD+Hu/qotsVG407dmmyfWsSnoQftdD93KL2bi2VTCAZfipItJRNzt7iQm9QVdZV7XDK9w=
X-Received: by 2002:a17:907:94cf:: with SMTP id dn15mr10231781ejc.114.1601583422367;
 Thu, 01 Oct 2020 13:17:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200930011944.19869-1-jannh@google.com> <CAG48ez03YJG9JU_6tGiMcaVjuTyRE_o4LEQ7901b5ZoCnNAjcg@mail.gmail.com>
 <20200930123000.GC9916@ziepe.ca> <CAG48ez2z1R8MLS0_pjhBSGnJC8RwaHMpiGdv8GhJUCrwtsLOPg@mail.gmail.com>
 <CAG48ez0fhY0twgriBDv9RU1YG8mBxg_KoK_YsLPWYo4feAQ=Sg@mail.gmail.com>
 <20200930232655.GE9916@ziepe.ca> <CAG48ez0i2++2Jg1Z-RyCKn-uZ-gcszVknAaCyXbJyptuMxbCsg@mail.gmail.com>
 <20201001191512.GF9916@ziepe.ca>
In-Reply-To: <20201001191512.GF9916@ziepe.ca>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 1 Oct 2020 22:16:35 +0200
Message-ID: <CAG48ez3GW9sRfZWwx+YpKdouAVT+o9zQR73-itJMbLCXTiUxBw@mail.gmail.com>
Subject: Re: [PATCH 3/4] mmap locking API: Don't check locking if the mm isn't
 live yet
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Michel Lespinasse <walken@google.com>,
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

On Thu, Oct 1, 2020 at 9:15 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> On Thu, Oct 01, 2020 at 01:51:33AM +0200, Jann Horn wrote:
> > On Thu, Oct 1, 2020 at 1:26 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > On Wed, Sep 30, 2020 at 10:14:57PM +0200, Jann Horn wrote:
> > > > On Wed, Sep 30, 2020 at 2:50 PM Jann Horn <jannh@google.com> wrote:
> > > > > On Wed, Sep 30, 2020 at 2:30 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > > > > On Tue, Sep 29, 2020 at 06:20:00PM -0700, Jann Horn wrote:
> > > > > > > In preparation for adding a mmap_assert_locked() check in
> > > > > > > __get_user_pages(), teach the mmap_assert_*locked() helpers that it's fine
> > > > > > > to operate on an mm without locking in the middle of execve() as long as
> > > > > > > it hasn't been installed on a process yet.
> > > > > >
> > > > > > I'm happy to see lockdep being added here, but can you elaborate on
> > > > > > why add this mmap_locked_required instead of obtaining the lock in the
> > > > > > execv path?
> > > > >
> > > > > My thinking was: At that point, we're logically still in the
> > > > > single-owner initialization phase of the mm_struct. Almost any object
> > > > > has initialization and teardown steps that occur in a context where
> > > > > the object only has a single owner, and therefore no locking is
> > > > > required. It seems to me that adding locking in places like
> > > > > get_arg_page() would be confusing because it would suggest the
> > > > > existence of concurrency where there is no actual concurrency, and it
> > > > > might be annoying in terms of lockdep if someone tries to use
> > > > > something like get_arg_page() while holding the mmap_sem of the
> > > > > calling process. It would also mean that we'd be doing extra locking
> > > > > in normal kernel builds that isn't actually logically required.
> > > > >
> > > > > Hmm, on the other hand, dup_mmap() already locks the child mm (with
> > > > > mmap_write_lock_nested()), so I guess it wouldn't be too bad to also
> > > > > do it in get_arg_page() and tomoyo_dump_page(), with comments that
> > > > > note that we're doing this for lockdep consistency... I guess I can go
> > > > > change this in v2.
> > > >
> > > > Actually, I'm taking that back. There's an extra problem:
> > > > get_arg_page() accesses bprm->vma, which is set all the way back in
> > > > __bprm_mm_init(). We really shouldn't be pretending that we're
> > > > properly taking the mmap_sem when actually, we keep reusing a
> > > > vm_area_struct pointer.
> > >
> > > Any chance the mmap lock can just be held from mm_struct allocation
> > > till exec inserts it into the process?
> >
> > Hm... it should work if we define a lockdep subclass for this so that
> > lockdep is happy when we call get_user() on the old mm_struct while
> > holding that mmap lock.
>
> A subclass isn't right, it has to be a _nested annotation.
>
> nested locking is a pretty good reason to not be able to do this, this
> is something lockdep does struggle to model.

Did I get the terminology wrong? I thought they were the same. The
down_*_nested() APIs take an argument "subclass", with the default
subclass for the functions without "_nested" being 0.

Anyway, I wrote a patch for this yesterday, I'll send it out later
today after testing that it still boots without lockdep warnings. Then
you can decide whether you prefer it to the current patch.
