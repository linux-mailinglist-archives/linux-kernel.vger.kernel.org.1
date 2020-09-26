Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 303282795EA
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 03:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729971AbgIZBQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 21:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729729AbgIZBQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 21:16:02 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017F2C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 18:16:02 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id 77so4791943lfj.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 18:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hpchNS/oWTSmppDZkrORDu0nnNayAF0+YJG3NCCqrs4=;
        b=UDmpX01c0bTTWobylw+tZ/OUa9A9C6aMBxlpL2FZ0IWoS6Me35OFasjN/vnNQk7wxv
         5MgRTlYBvfRBIZC9uj749H22vgFQeBOKbm1LgiBESn3scwoJJo/0JeF9tjORZGV5hmZO
         DVGyCz2vJF4oFYb+jzkVHjYKBzOGTX67JSf4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hpchNS/oWTSmppDZkrORDu0nnNayAF0+YJG3NCCqrs4=;
        b=sN/y1PeS+POWGXzFTlVSRx8VkEud9LtaCWcgzDnDamqvuo1j+FX4RzYpRrpzcIZQHO
         mY7KSICOoXylwZz+w7uk62v4jogaiKwxVm49TE19fYc+9fze38V40/QLhx5oa/aXYYZ6
         cjAT3mDAm573i765XsVMs517CKqd7mytbmezWDDPMdT6a7/eV9dE/W0NqVzSlmgIeSq3
         UNO+7iJhnUq+J93q7DEWtcpPp+aspa3th8xjQoJR/3ouOXhv/1ix0EkatZrpL6s5vXYA
         mRhL4EFk7eyI9Fc67lZ9H74SVA6mAzRt6LMp545DcAD3Vygtkbzyx8eG7cxXH6hWwaAL
         QJ8Q==
X-Gm-Message-State: AOAM530ZYA1cnsSvvZlYu1mzB8DHZyTKEM/f5wtKG8ukoxmbQ4QhONtq
        WAZJXo3y5UgudkdqNrX8iamnxG9/EM5zng==
X-Google-Smtp-Source: ABdhPJzlGMnV0j3w4SRGChuVBde0RCyhscjVNRmkGdokVk07UwS2lWJiulBPMCgW5wLNPXm38i2cyw==
X-Received: by 2002:a19:fc02:: with SMTP id a2mr412538lfi.443.1601082959607;
        Fri, 25 Sep 2020 18:15:59 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id 140sm543143lfj.146.2020.09.25.18.15.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2020 18:15:54 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id w11so4797930lfn.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 18:15:54 -0700 (PDT)
X-Received: by 2002:ac2:4a6a:: with SMTP id q10mr409204lfp.534.1601082953646;
 Fri, 25 Sep 2020 18:15:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200923170759.GA9916@ziepe.ca> <20200924143517.GD79898@xz-x1>
 <20200924165152.GE9916@ziepe.ca> <20200924175531.GH79898@xz-x1>
 <20200924181501.GF9916@ziepe.ca> <20200924183418.GJ79898@xz-x1>
 <20200924183953.GG9916@ziepe.ca> <20200924213010.GL79898@xz-x1>
 <CAHk-=wgz5SXKA6-uZ_BimOP1C7pHJag0ndz=tnJDAZS_Z+FrGQ@mail.gmail.com>
 <CAHk-=whDSH_MRMt80JaSwoquzt=1nQ-0n3w0aVngoWPAc10BCw@mail.gmail.com> <20200926004136.GJ9916@ziepe.ca>
In-Reply-To: <20200926004136.GJ9916@ziepe.ca>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 25 Sep 2020 18:15:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiutA_J-OfvrD8Kp3SoYcfMHUwsU7ViOH48q7QN0AQ6eg@mail.gmail.com>
Message-ID: <CAHk-=wiutA_J-OfvrD8Kp3SoYcfMHUwsU7ViOH48q7QN0AQ6eg@mail.gmail.com>
Subject: Re: [PATCH 1/5] mm: Introduce mm_struct.has_pinned
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Peter Xu <peterx@redhat.com>, John Hubbard <jhubbard@nvidia.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 5:41 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> I don't completely grok the consequences of the anon_vma check. We
> can exclude file backed mappings as they are broken for pinning
> anyhow, so what is left that could be MAP_PRIVATE of a non-anon_vma?

It really shouldn't ever happen.

The only way a COW vma can have a NULL anon_vma should be if it has no
pages mapped at all.

Technically I think it could happen if you only ever mapped the
special zero page in there (but that shouldn't then get to the
"vm_normal_page()").

> Otherwise, I do prefer Peter's version because of the GFP_KERNEL. To
> touch on your other email..

Yeah, no, I just hadn't seen a new version, so I started getting antsy
and that's when I decided to see what a minimal patch looks like.

I think that over the weekend I'll do Peter's version but with the
"page_mapcount() == 1"  check, because I'm starting to like that
better than the mm->has_pinned.

Comments on that plan?

              Linus
