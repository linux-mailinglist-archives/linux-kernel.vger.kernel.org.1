Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81CA12E740A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 21:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgL2UyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 15:54:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgL2Ux7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 15:53:59 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78077C061574
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 12:53:19 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id l11so33530459lfg.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 12:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dX68ilDXqjy1fUBrgW9VQ3uuQmcUVgu3Z6hs0+zxIIQ=;
        b=a7wrY1O1/RN5nqFj+D0sSZcwTHnPS+6PSYnz1H9gUqvKMTfoLcKsnadMRpS1VAe7Gb
         2yuzNGMoVPr0fpElXREonWdunB/Skoh9fNn9Rbft22u05UDRbxuQEdwAZM8o24/8t8RS
         uV26HhsyamQZTdN492hG4xq57TiZr2bLR9/KU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dX68ilDXqjy1fUBrgW9VQ3uuQmcUVgu3Z6hs0+zxIIQ=;
        b=oks+s/jOgJsdAGm2l1DIAeep2L9g5GVFveFEDCWvmYGS0/i0Yx8Z5UL3dru8ajuw4w
         RcMcPDNLBtHRv5MBL0W+LtI8p30Jul0z5WSxX5jPJZ3ErAegXH63VEve4Z3lzuw+bIFD
         5nnEAFPVimTJAV+ChIqXSMKKWqxhyZmHRYU55ozpkg8dpdGANde0f3NqOfwgQd+RGYq0
         68UOSJA/iBzgTZPxOwTZXmyMz1LIZgklrWh6n8TvVjybxUSLEKZvouEF1crl+acMSSj4
         67vqmUWTQswr5IiAPCuEwZMBDiphAkj+mlhkkL+qZQgICXWFnTO2aFvCyM5oVviEpp4/
         37Tw==
X-Gm-Message-State: AOAM530FwJ4lwCdXBgP7kRESBuOP2WOIorcUN6HNFyc/frAFS8tpAGQg
        AIz/rePnm5YXZQsoNdk/6JnzCjWrPx36FQ==
X-Google-Smtp-Source: ABdhPJzfYH4ITsGaafzYMy1gj0TeFjTqC92sjV9bIT71uxhttuGboz5AOzl/pRLP1A8vUmIMTnvhNQ==
X-Received: by 2002:a19:d86:: with SMTP id 128mr23210417lfn.317.1609275197233;
        Tue, 29 Dec 2020 12:53:17 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id x8sm5756440lfn.226.2020.12.29.12.53.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Dec 2020 12:53:15 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id h205so33438577lfd.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 12:53:15 -0800 (PST)
X-Received: by 2002:a2e:8995:: with SMTP id c21mr23846649lji.251.1609275194794;
 Tue, 29 Dec 2020 12:53:14 -0800 (PST)
MIME-Version: 1.0
References: <20201226224016.dxjmordcfj75xgte@box> <alpine.LSU.2.11.2012261623140.1022@eggly.anvils>
 <alpine.LSU.2.11.2012261816520.1071@eggly.anvils> <CAHk-=wjHvipz5DqWUFP5zuPK-kWM4QD-eokf75V8NGNATnn+BQ@mail.gmail.com>
 <20201227234853.5mjyxcybucts3kbq@box> <CAHk-=wiVrd4R2EVGCGtmybt6+u9LoGgMdnf12zc=sYL=QbvRWQ@mail.gmail.com>
 <alpine.LSU.2.11.2012272233170.24487@eggly.anvils> <20201228125352.phnj2x2ci3kwfld5@box>
 <CAHk-=wg4bzJ9ugrOp7DBoMjNpHechm4QWb0-HC3A_pN564RU5A@mail.gmail.com>
 <CAHk-=whwJcJubrP8ELH=UvEHX146_Jdmfn992W55KJgPvUx_Uw@mail.gmail.com> <20201229132819.najtavneutnf7ajp@box>
In-Reply-To: <20201229132819.najtavneutnf7ajp@box>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 29 Dec 2020 12:52:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiyzbEEUF7PH4P2pufS60E0HSKs3Wdho7-gh-mGnOVwvg@mail.gmail.com>
Message-ID: <CAHk-=wiyzbEEUF7PH4P2pufS60E0HSKs3Wdho7-gh-mGnOVwvg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: Allow architectures to request 'old' entries when prefaulting
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 29, 2020 at 5:28 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> I reworked do_fault_around() so it doesn't touch vmf->address and pass
> original address down to ->map_pages(). No need in the new argument in
> ->map_pages. filemap_map_pages() calculates address based on pgoff of the
> page handled.

So I really like how the end result looks, but it worries me how many
problems this patch has had, and I'd love to try to make it more
incremental.

In particular, I really liked your re-write of the loop in
filemap_map_pages(), and how you separated out the pmd case to be a
separate early case. I think that was some of the nicest part of the
patch.

And I really like how you changed the vmf->address meaning in this
latest version, and pass the real address down, and pass the range
just in the start/end_pgoff. That just looks like the RightThing(tm)
to do.

But I think these nice cleanups could and should be independent of
some of the other changes.

The unlocking change, for example, that changed the return type from
void to vm_fault_t, also looks like a nice cleanup, but that's also
the one that caused the last series of odd problems for Hugh.

The fix for that then also caused that ugly "goto out" mess, which
undid some of the "this looks really nice" effects.

I don't even see the need for that "goto out". Yes, it resets the
'vmf->address' back to what it should be (so that __do_fault()
fallback can work right), but the two first "goto out" cases haven't
actually changed it (or ther mmap_miss), so why did they need to do
that?

Anyway, I really like how it all looks (apart from that odd "goto out"
detail - nitpicking here) but it does worry me that it changes so much
and had so many small problems..

         Linus
