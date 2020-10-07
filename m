Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2E0285FBD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 15:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbgJGNGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 09:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728177AbgJGNGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 09:06:36 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771AFC061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 06:06:36 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id u21so2864569eja.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 06:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JtiTAC1lCqywnD4Z2Vg4zVbVRlofQtOWuMfZmgMPCws=;
        b=IVfaH4OrbWAN6uzg0UIk/strWAow/Q6FzTRKahgOrF9EF7kqJXUGjYDmctFaBHvyOo
         FYBn0VINGYPuQRP0p46AU6UBnVUkbrZOzWZ9Ys2I27aCChyOeG+vJ8llmAULxl7kC8wj
         mqztEpzuIt/NtFC/8GqwQM3qEJxAHpZi5HRdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JtiTAC1lCqywnD4Z2Vg4zVbVRlofQtOWuMfZmgMPCws=;
        b=J1K9Hc19/8pZH4TqiEEaLPJT+OTddlXTauJ9boi0FJrtP1wvzkfH148Ijemp2oyM5j
         jJvqW/I64QKK/35aiH6bHhncawyBQ+5LB6xIkVoSAJAgJnRcDZpvInNkEtbP1yHLfEXQ
         V4k3meg5r2NQVdOn5TEEqZ0q+oaz2rV1cV0KixNKh/lKZ69qPF+oVC7yto8rNY630MmF
         gUXHe7JstxpeqYMqr83xyKdymKhcVZ6B0wjRJWxzDcf9N6zoqx0gUrHdo5eQPs6+1Hlb
         ULj7Qx+hIza2dKSNfSODy3r+bjkVb0BOHDPwgZpZ7WjpgmX7QIsVkDx9aNMlImNdHydY
         lKxA==
X-Gm-Message-State: AOAM5324kw43PP3I/+BgTjr+1zzkH9QGVQC75h8of7o5Pvr1ZxhrazZq
        /IkfXIxvCSddSJP4pN+6jOKkWegJ7QKHGA==
X-Google-Smtp-Source: ABdhPJxARwdBHkIWN98qScZtvGKIdE/82iKDjxJgs6kT+hjD+HW3p8XLU3Te+IInEXCekAsitj/l8w==
X-Received: by 2002:a17:906:f119:: with SMTP id gv25mr3185482ejb.373.1602075992578;
        Wed, 07 Oct 2020 06:06:32 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id ba6sm1447690edb.61.2020.10.07.06.06.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2020 06:06:31 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id p15so2222339wmi.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 06:06:30 -0700 (PDT)
X-Received: by 2002:a1c:2d85:: with SMTP id t127mr3180500wmt.22.1602075989680;
 Wed, 07 Oct 2020 06:06:29 -0700 (PDT)
MIME-Version: 1.0
References: <20201002175303.390363-1-daniel.vetter@ffwll.ch>
 <20201002175303.390363-2-daniel.vetter@ffwll.ch> <20201002180603.GL9916@ziepe.ca>
 <CAKMK7uGF+y-r4swLXmodhduRMy0NPa=ASBY8JOXS_g=9Rq9XQw@mail.gmail.com> <20201002233118.GM9916@ziepe.ca>
In-Reply-To: <20201002233118.GM9916@ziepe.ca>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 7 Oct 2020 15:06:17 +0200
X-Gmail-Original-Message-ID: <CAAFQd5DkzxeHmHvipMR2YgDVC1uZrvVWgyWWYdyEM=yCOM7HwQ@mail.gmail.com>
Message-ID: <CAAFQd5DkzxeHmHvipMR2YgDVC1uZrvVWgyWWYdyEM=yCOM7HwQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm/frame-vec: use FOLL_LONGTERM
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Pawel Osciak <pawel@osciak.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>, Oded Gabbay <oded.gabbay@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 3, 2020 at 1:31 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Fri, Oct 02, 2020 at 08:16:48PM +0200, Daniel Vetter wrote:
> > On Fri, Oct 2, 2020 at 8:06 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > On Fri, Oct 02, 2020 at 07:53:03PM +0200, Daniel Vetter wrote:
> > > > For $reasons I've stumbled over this code and I'm not sure the chan=
ge
> > > > to the new gup functions in 55a650c35fea ("mm/gup: frame_vector:
> > > > convert get_user_pages() --> pin_user_pages()") was entirely correc=
t.
> > > >
> > > > This here is used for long term buffers (not just quick I/O) like
> > > > RDMA, and John notes this in his patch. But I thought the rule for
> > > > these is that they need to add FOLL_LONGTERM, which John's patch
> > > > didn't do.
> > > >
> > > > There is already a dax specific check (added in b7f0554a56f2 ("mm:
> > > > fail get_vaddr_frames() for filesystem-dax mappings")), so this see=
ms
> > > > like the prudent thing to do.
> > > >
> > > > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > > Cc: John Hubbard <jhubbard@nvidia.com>
> > > > Cc: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
> > > > Cc: Jan Kara <jack@suse.cz>
> > > > Cc: Dan Williams <dan.j.williams@intel.com>
> > > > Cc: linux-mm@kvack.org
> > > > Cc: linux-arm-kernel@lists.infradead.org
> > > > Cc: linux-samsung-soc@vger.kernel.org
> > > > Cc: linux-media@vger.kernel.org
> > > > Hi all,
> > > >
> > > > I stumbled over this and figured typing this patch can't hurt. Real=
ly
> > > > just to maybe learn a few things about how gup/pup is supposed to b=
e
> > > > used (we have a bit of that in drivers/gpu), this here isn't really
> > > > ralated to anything I'm doing.
> > >
> > > FOLL_FORCE is a pretty big clue it should be FOLL_LONGTERM, IMHO
> >
> > Since you're here ... I've noticed that ib sets FOLL_FORCE when the ib
> > verb access mode indicates possible writes. I'm not really clear on
> > why FOLL_WRITE isn't enough any why you need to be able to write
> > through a vma that's write protected currently.
>
> Ah, FOLL_FORCE | FOLL_WRITE means *read* confusingly enough, and the
> only reason you'd want this version for read is if you are doing
> longterm stuff. I wrote about this recently:
>
> https://lore.kernel.org/linux-mm/20200928235739.GU9916@ziepe.ca/
>
> > > Since every driver does this wrong anything that uses this is creatin=
g
> > > terrifying security issues.
> > >
> > > IMHO this whole API should be deleted :(
> >
> > Yeah that part I just tried to conveniently ignore. I guess this dates
> > back to a time when ioremaps where at best fixed, and there wasn't
> > anything like a gpu driver dynamically managing vram around, resulting
> > in random entirely unrelated things possibly being mapped to that set
> > of pfns.
>
> No, it was always wrong. Prior to GPU like cases the lifetime of the
> PTE was tied to the vma and when the vma becomes free the driver can
> move the things in the PTEs to 'free'. Easy to trigger use-after-free
> issues and devices like RDMA have security contexts attached to these
> PTEs so it becomes a serious security bug to do something like this.
>
> > The underlying follow_pfn is also used in other places within
> > drivers/media, so this doesn't seem to be an accident, but actually
> > intentional.
>
> Looking closely, there are very few users, most *seem* pointless, but
> maybe there is a crazy reason?
>
> The sequence
>   get_vaddr_frames();
>   frame_vector_to_pages();
>   sg_alloc_table_from_pages();
>
> Should be written
>   pin_user_pages_fast(FOLL_LONGTERM);
>   sg_alloc_table_from_pages()
>
> There is some 'special' code in frame_vector_to_pages() that tries to
> get a struct page for things from a VM_IO or VM_PFNMAP...
>
> Oh snap, that is *completely* broken! If the first VMA is IO|PFNMAP
> then get_vaddr_frames() iterates over all VMAs in the range, of any
> kind and extracts the PTEs then blindly references them! This means it
> can be used to use after free normal RAM struct pages!! Gah!
>
> Wow. Okay. That has to go.
>
> So, I *think* we can assume there is no sane cases where
> frame_vector_to_pages() succeeds but pin_user_pages() wasn't called.
>
> That means the users here:
>  - habanalabs:  Hey Oded can you fix this up?
>
>  - gpu/exynos: Daniel can you get someone there to stop using it?
>
>  - media/videobuf via vb2_dma_sg_get_userptr()
>
> Should all be switched to the standard pin_user_pages sequence
> above.
>
> That leaves the only interesting places as vb2_dc_get_userptr() and
> vb2_vmalloc_get_userptr() which both completely fail to follow the
> REQUIRED behavior in the function's comment about checking PTEs. It
> just DMA maps them. Badly broken.

Note that vb2_vmalloc is only used for in-kernel CPU usage, e.g. the
contents being copied by the driver between vb2 buffers and some
hardware FIFO or other dedicated buffers. The memory does not go to
any hardware DMA.

Could you elaborate on what "the REQUIRED behavior is"? I can see that
both follow the get_vaddr_frames() -> frame_vector_to_pages() flow, as
you mentioned. Perhaps the only change needed is switching to
pin_user_pages after all?

>
> Guessing this hackery is for some embedded P2P DMA transfer?
>

That's not the case. There are two usage scenarios:

1) Regular user pointer support, i.e. using malloc()ed memory as a
video input or output buffer. This is deemed to be deprecated, but
still used quite widely by various applications. Quite common for
video decoder input and video encoder output, because the other side
of the pipeline is CPU, e.g. network stack.

2) Sharing carveout buffers (without struct pages attached) between
two devices. I believe this predates DMA-buf and CMA (which enabled
carveouts with struct pages) and I'm not sure how commonly it is used
these days.

> After he three places above should use pin_user_pages_fast(), then
> this whole broken API should be moved into videobuf2-memops.c and a
> big fat "THIS DOESN'T WORK" stuck on it.
>
> videobuf2 should probably use P2P DMA buf for this instead.

See above.

Best regards,
Tomasz
