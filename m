Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADFD327B4A8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 20:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgI1Sjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 14:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgI1Sjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 14:39:31 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA856C061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 11:39:30 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id j10so969189qvk.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 11:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QojT9TgDU+CsWYco4TCvXduWy2QP7Gs2vHLY0goYgnU=;
        b=GmtvDFVavvKQMUl/ma0Pm6Bl9VfREFQPF8KAUqbRMAQZfbs1cpdr0Q6viw5sIKGOye
         hoyU0SclRWDMng9a3aot9KTr5CNxs1PPbUS9VWEL3cfmRxYKb8fYOqpbyxmblb5uVRnJ
         mR1AJ6VQY4B/XOq79sgaEMSBlZBMQapjtSp/S1mPwBQATeLrkp5KYN1f81z7CAxP4zyM
         j92WLhH61mqdrg3vPCoKdoxkpej0D/qP+GMg90U6W1UvKUD/Z08trPUYA0FDB/OCwEtV
         qeAu3hZz56UI7ImUyoX0LeBPLXhXZHo0sMswyorPIcR6rjlCWi4XooxSmEMsp07yWeV6
         5F3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QojT9TgDU+CsWYco4TCvXduWy2QP7Gs2vHLY0goYgnU=;
        b=GKxxPOyv0kX2dpz0GIB8eIHfnmylZZsv8ym8565F73UGBjT/EG73KA8wzFqqmLjXUW
         XQv8Jtwvj5BG8uylNxIVJ5zyc1zhDwI54lzbP/1XbK8hhjFGgHkCwVgmRABbIetM8TAu
         TaoSI5b1shprTHaDkcdEPNw2l0ZrVWmv09Snf0tKeGyMxmu73jYDu7mV37ROjEU4wW+I
         O84wERAZV+rFexHwfoDWvjZPcPGm6buvmZHNg011aWFUHwKG5ZcB6W8iIUtvHjeKLMlY
         rP+DJ4ZvMVXI0NmkXPuGSHcViDMcrz+uyVCSb9rzidNOfDcj8tJfY+gNvHyt218bTi3m
         G/kg==
X-Gm-Message-State: AOAM530nJZFOT4Hx6outrqfTskYvQNduvu3Sh0QLZNNGN12lbPimZ9EG
        EVCynk+/Bo403XPOjRM6vTLRUvjuakpGFOSK
X-Google-Smtp-Source: ABdhPJyKC947gKvBbGydXx49IehA8jWfsTSAsHh1FpOQ1V10dmVJaKuVvYI/Ld9MTP7P2ziJUbmSgQ==
X-Received: by 2002:a05:6214:1784:: with SMTP id ct4mr871185qvb.10.1601318369933;
        Mon, 28 Sep 2020 11:39:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id 192sm1853863qkm.110.2020.09.28.11.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 11:39:29 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kMy3c-002TBq-Ju; Mon, 28 Sep 2020 15:39:28 -0300
Date:   Mon, 28 Sep 2020 15:39:28 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>, Leon Romanovsky <leonro@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH 1/5] mm: Introduce mm_struct.has_pinned
Message-ID: <20200928183928.GR9916@ziepe.ca>
References: <20200926004136.GJ9916@ziepe.ca>
 <CAHk-=wiutA_J-OfvrD8Kp3SoYcfMHUwsU7ViOH48q7QN0AQ6eg@mail.gmail.com>
 <CAHk-=wi_gd+JWj-8t8tc8cy3WZ7NMj-_1hATfH3Rt0ytUxtMpQ@mail.gmail.com>
 <20200927062337.GE2280698@unreal>
 <CAHk-=winqSOFsdn1ntYL13s2UuhpQQ9+GRvjWth3sA5APY4Wwg@mail.gmail.com>
 <CAHk-=wj61s30pt8POVtKYVamYTh6h=7-_ser2Hx9sEjqeACkDA@mail.gmail.com>
 <20200928124937.GN9916@ziepe.ca>
 <CAHk-=wj6aTsqq6BAUci-NYJ3b-EkDwVgz_NvW_kW8KBqGocouQ@mail.gmail.com>
 <20200928172256.GB59869@xz-x1>
 <CAHk-=wi=iCnYCARbPGjkVJu9eyYeZ13N64tZYLdOB8CP5Q_PLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi=iCnYCARbPGjkVJu9eyYeZ13N64tZYLdOB8CP5Q_PLw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 10:54:28AM -0700, Linus Torvalds wrote:
> On Mon, Sep 28, 2020 at 10:23 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > Yes...  Actually I am also thinking about the complete solution to cover
> > read-only fast-gups too, but now I start to doubt this, at least for the fork()
> > path.  E.g. if we'd finally like to use pte_protnone() to replace the current
> > pte_wrprotect(), we'll be able to also block the read gups, but we'll suffer
> > the same degradation on normal fork()s, or even more.  Seems unacceptable.
> 
> So I think the real question about pinned read gups is what semantics
> they should have.
> 
> Because honestly, I think we have two options:
> 
>  - the current "it gets a shared copy from the page tables"
>
>  - the "this is an exclusive pin, and it _will_ follow the source VM
> changes, and never break"

The requirement depends on what the driver is doing. Consider a simple
ring-to-device scheme:

   ring = mmap()
   pin_user_pages(FOLL_LONGTERM)
   ring[0] = [..]
   trigger_kernel()

Sort of like iouring. Here the kernel will pin the zero page and will
never see any user modifications to the buffer. We must do #2.

While something like read(O_DIRECT) which only needs the buffer to be
stable during a system call would be fine with #1 (and data
incoherence in general)

> In other words, a read pin isn't really any different from a read GUP.
> You get a reference to a page that is valid at the time of the page
> lookup, and absolutely nothing more.

Yes, so far all this new pin stuff has really focused on the write
side - the motivating issue was the set_page_dirty() oops
 
> But honestly, that is largely going to _be_ the same as a write pin,
> because it absolutely needs to do a page COW at the time of the
> pinning to get that initial exclusive guarantee in the first place.
> Without that initial exclusivity, you cannot avoid future COW events
> breaking the wrong way.

Right, I see places using FOLL_WRITE when they only need read. It is a
bit ugly, IMHO.

> The downside of a write pin is that it not only makes that page
> exclusive, it also (a) marks it dirty and (b) requires write access.

RDMA adds FOLL_FORCE because people complained they couldn't do
read-only transfers from .rodata - uglyier still :\

> So the copy_page_range() code would do a write count around the copy:
> 
>     write_seqcount_begin(&mm->seq);
>     .. do the copy ..
>     write_seqcount_end(&mm->seq);

All of gup_fast and copy_mm could be wrappered in a seq count so that
gup_fast always goes to the slow path if fork is concurrent. 

That doesn't sound too expensive and avoids all the problems you
pointed with the WP scheme.

As you say fork & pin & threads is already questionable, so an
unconditional slow path on race should be OK.

> If we want to and really need to.

I would like to see some reasonable definition for the
read-side. Having drivers do FOLL_FORCE | FOLL_WRITE for read is just
confusing and weird for a driver facing API.

It may also help focus the remaining discussion for solving
set_page_dirty() if pin_user_pages() had a solid definition.

I prefer the version where read pin and write pin are symmetric. The
PTE in the MM should not change once pinned.

This is useful and if something only needs the original GUP semantics
then GUP is still there.

Jason

