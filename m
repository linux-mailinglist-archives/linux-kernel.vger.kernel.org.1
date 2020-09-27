Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B7E27A261
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 20:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgI0Spv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 14:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbgI0Spu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 14:45:50 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6103BC0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 11:45:50 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id k25so6511146ljg.9
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 11:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HXbBaZxONg8BBAGgxG9uroKUYXpPci8VT24wKfZAHcM=;
        b=BqNVX6Og/7MJqL+uGc4Tn1aIhplzn+9dXtqbLqfHVzvhPcCAyk/NAqTMdz3VyJChWf
         UQy8RSXWzY1mFmi4PwmJEkCVJQBH/24apYcwKpgx73X0VIEp6D8lw5H933o53NDzOImf
         CUH+TBXPlcio3GBoEZ1U/BE/1kJypHqJXlJm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HXbBaZxONg8BBAGgxG9uroKUYXpPci8VT24wKfZAHcM=;
        b=HgbQJ4A+Fvn22UIyTZtDKRrgtYfPdy7E8hxbUPUnt2WafdeJXKuEcr4x6GAxejAJeu
         eRPJ5YExkm4LTAg06G2wrtLXfJAdkpQjLxzxqlBTw1fKNt70rxwRglU+K0tOPxAJ9tQ1
         iOOCzgptKeKKZGHgQxHulMRhM4YzsRFeHecDEeGYciB1ALRLlO4b84emSSd3U7L/X924
         xEdlZ84N1gD+U3W6slOHSEznDNrX1ZWNEaX+W59GU/7vzWDDhc82QmYm2/r7hejZlVUb
         N+nvx9KRCmR4kyKAT7pVg7O0380MsVsF7qsKV+pMQOcmE0aJfNYvSaGcljgh8FNDQTQs
         X+1Q==
X-Gm-Message-State: AOAM532pDZlKI1LCKTWwNiSFdh76K4evYsIZ3GLwXgT0/rOivzqJT4rC
        0wdsrOBoHij7H+1P+mZuszFIcrhjw58k7w==
X-Google-Smtp-Source: ABdhPJwxYYmwwhgeuAY6eLGQc5q+eJ7W1PglTKxnzYFdJ2y2xkhW6vrBJZDCGQkQR7hNhXXzqf+qcA==
X-Received: by 2002:a2e:9218:: with SMTP id k24mr3868731ljg.306.1601232348267;
        Sun, 27 Sep 2020 11:45:48 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id f25sm5675138ljn.29.2020.09.27.11.45.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Sep 2020 11:45:46 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id d15so8517837lfq.11
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 11:45:46 -0700 (PDT)
X-Received: by 2002:ac2:4a6a:: with SMTP id q10mr2513864lfp.534.1601232346153;
 Sun, 27 Sep 2020 11:45:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200924175531.GH79898@xz-x1> <20200924181501.GF9916@ziepe.ca>
 <20200924183418.GJ79898@xz-x1> <20200924183953.GG9916@ziepe.ca>
 <20200924213010.GL79898@xz-x1> <CAHk-=wgz5SXKA6-uZ_BimOP1C7pHJag0ndz=tnJDAZS_Z+FrGQ@mail.gmail.com>
 <CAHk-=whDSH_MRMt80JaSwoquzt=1nQ-0n3w0aVngoWPAc10BCw@mail.gmail.com>
 <20200926004136.GJ9916@ziepe.ca> <CAHk-=wiutA_J-OfvrD8Kp3SoYcfMHUwsU7ViOH48q7QN0AQ6eg@mail.gmail.com>
 <CAHk-=wi_gd+JWj-8t8tc8cy3WZ7NMj-_1hATfH3Rt0ytUxtMpQ@mail.gmail.com>
 <20200927062337.GE2280698@unreal> <CAHk-=winqSOFsdn1ntYL13s2UuhpQQ9+GRvjWth3sA5APY4Wwg@mail.gmail.com>
In-Reply-To: <CAHk-=winqSOFsdn1ntYL13s2UuhpQQ9+GRvjWth3sA5APY4Wwg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 27 Sep 2020 11:45:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj61s30pt8POVtKYVamYTh6h=7-_ser2Hx9sEjqeACkDA@mail.gmail.com>
Message-ID: <CAHk-=wj61s30pt8POVtKYVamYTh6h=7-_ser2Hx9sEjqeACkDA@mail.gmail.com>
Subject: Re: [PATCH 1/5] mm: Introduce mm_struct.has_pinned
To:     Leon Romanovsky <leonro@nvidia.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Peter Xu <peterx@redhat.com>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 27, 2020 at 11:16 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Btw, I'm not convinced about the whole "turn the pte read-only and
> then back". If the fork races with another thread doing a pinning
> fast-GUP on another CPU, there are memory ordering issues etc too.
> That's not necessarily visible on x86 (the "turn read-only being a
> locked op will force serialization), but it all looks dodgy as heck.

.. looking at it more, I also think it could possibly lose the dirty
bit for the case where another CPU did a HW dirty/accessed bit update
in between the original read of the pte, and then us writing back the
writable pte again.

Us holding the page table lock means that no _software_ accesses will
happen to the PTE, but dirty/accessed bits can be modified by hardware
despite the lock.

That is, of course, a completely crazy case, and I think that since we
only do this for a COW mapping, and only do the PTE changes if the pte
was writable, the pte will always have been dirty already.

So I don't think it's an _actual_ bug, but it's another "this looks
dodgy as heck" marker. It may _work_, but it sure ain't pretty.

But despite having looked at this quite a bit, I don't see anything
that looks actively wrong, so I think the series is fine. This is more
of a note for people to perhaps think about.

                Linus
