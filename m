Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94036279D00
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 02:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbgI0AFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 20:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbgI0AFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 20:05:00 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE27C0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 17:04:59 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id w3so5426438ljo.5
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 17:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U1OUqNTBnVCMPp1ia2uQg45U9rR6Q8tgrXbVfMePRQs=;
        b=CmacqtDMqmSt6zlNRn6vPCkQB5zdpAqt8v8RN0LEGgbCnEGv1D+2OztGRck+T6aaQE
         yycrdozsfp4ydQKjMWyOEluArt7NX0xdprQuuRUGiiFEqxpn4RtcmKRnkL4BjDLpGXdF
         aEKlIfuHb7kE+yxm6N6kbm9UO0f0bQBp0nJ7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U1OUqNTBnVCMPp1ia2uQg45U9rR6Q8tgrXbVfMePRQs=;
        b=myDlEYB4uR4e4BgaVKr11mZuH7YQSMFZhrvBY1jEL6QBLIFUWXqnbkWagLcAH/E+Vu
         Qk/cip39Uy9JHA5TGtUST270wbgps9MYDyiePZrCq9jBIznfbh3EBdEgf0FyyyuS5dy5
         ucjnskmb3nYxTLmlFnAsxCvtcUDZ5cE8V4jkC9KMgPbbmm4DHCbliIrQmvoUdwQf1J4+
         PzRNGN2H0W31VCzHrHCuquNMjuvJPtxd3FoiWo4VoWW+1WbYaFeAaBCsnbposK6HBmeF
         rRGjeCNAmej4KElKTpfkQfeH1Hzw24Qdpx7uhXLBwvJRRsnHwbzFbEuZDK0N96EG0wW2
         T/+g==
X-Gm-Message-State: AOAM531sixvs6HlQB091Wj5y3OLSrj+ltBvghDqmeIdm6se2ojXq1wCd
        r8XEvpHMxnn414mKMM1ECPTFvhTp29kq+Q==
X-Google-Smtp-Source: ABdhPJxGmm5PP6xTtrQ0SIFF/zRW9OW6s+wXFW2tVAh7KtDQrhTPCc5UldobUxkvLwvILkBHIv3SIA==
X-Received: by 2002:a2e:8ec1:: with SMTP id e1mr3458483ljl.84.1601165097470;
        Sat, 26 Sep 2020 17:04:57 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id c17sm2205538lfs.62.2020.09.26.17.04.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Sep 2020 17:04:54 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id w3so5426382ljo.5
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 17:04:54 -0700 (PDT)
X-Received: by 2002:a05:651c:514:: with SMTP id o20mr3433991ljp.312.1601165094039;
 Sat, 26 Sep 2020 17:04:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200925222600.6832-1-peterx@redhat.com> <20200925222600.6832-4-peterx@redhat.com>
 <20200926232335.GA348793@ziepe.ca>
In-Reply-To: <20200926232335.GA348793@ziepe.ca>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 26 Sep 2020 17:04:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh5pE+gXTigysiGf4vf+6jG7K58gwdk8b7qk_QUeEgKWA@mail.gmail.com>
Message-ID: <CAHk-=wh5pE+gXTigysiGf4vf+6jG7K58gwdk8b7qk_QUeEgKWA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] mm: Do early cow for pinned pages during fork()
 for ptes
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Peter Xu <peterx@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, Yang Shi <shy828301@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 26, 2020 at 4:23 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> Linus's version doesn't do pte_sw_mkyoung(), but looks OK to have it

I don't think it matters. But I don't think it should make it young,
since there's no access, but it's not like it's a big deal.

> > +                             pte = maybe_mkwrite(pte_mkdirty(pte), new);
>
> maybe_mkwrite() was not in Linus's version but it is wp_page_copy().

Actually, it is in my version too, just in a different form.

I did it using

        if (vma->vm_flags & VM_WRITE)
                *src_pte = pte_mkwrite(*src_pte);

instead, ie avoiding the write to src_pte if it wasn't a writable vma
(and I had checked that it was dirty and not done this at all if not,
so no need for the mkdirty).

> It seemed like mk_pte() should set the proper write
> bit already from the vm_page_prot?

No, vm_page_prot won't have the writable bit for a COW mapping.

The write bit gets set when the write happens (which may be on the
first access, of course), by the code that makes sure it's a private
copy.

> Perhaps this is harmless but redundant?

No, the pte_mkwrite() is required in some form, whether it's that
"maybe_mkwrite()" that looks at the vm flags, or in that explicit
form.

> > +                             page_add_new_anon_rmap(new_page, new, addr, false);
> > +                             rss[mm_counter(new_page)]++;
> > +                             set_pte_at(dst_mm, addr, dst_pte, pte);
>
> Linus's patch had a lru_cache_add_inactive_or_unevictable() here, like
> wp_page_copy()

Yeah, I do think that is needed so that we have the new page on the
LRU and it gets properly evicted under memory pressure.

                   Linus
