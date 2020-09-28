Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBDD27B54E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 21:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgI1TaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 15:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbgI1TaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 15:30:17 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B59C061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 12:30:16 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id v23so1996830ljd.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 12:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wY4Gq79q0P/2bX+CuESc1n2E6IaS6wqp2Rm0+ZTB6Q0=;
        b=de4GMA4QpsyK1q3+qSjbj6c/bLM77xIl2+5sVk0F/tdoa8BfjO8UHtRwPAqhaCHHUk
         3uuZoHZ6nnGsdkuYJCmNPv8mLzeOXJVMpSpnADjB0rjFW0XGsiRnswMvG/RD1vL90qBW
         9kJvFSyX6yVkV/XpEYZh26BJn07eZw9TlrY9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wY4Gq79q0P/2bX+CuESc1n2E6IaS6wqp2Rm0+ZTB6Q0=;
        b=ScyKu90qFzke7cshu94RaxTkZ3Rq1YDaGEMbZe8sJtk4p7x9QKA8DR7gqEi294rXfh
         1XBwyOI9MKB7HjHCS4SW8bdxXz3ji8g4iqcXnbVXx33bRNwhjPFHHpffeRCpQfOgaaQQ
         /FzjQmsRQiuQyWCjwRanYmjZTpEhNhjhdQIeltpc/0dEKKoo6iCAgFFOYYHU6lbQfZe2
         KWDkxh+DMnJB9E+yvsGH8epcZZTQDB02iLdekY2UjBPfToSP1cT6rARomtlNf+lWagZu
         Y8VLZH7R01Eg/JUMslfbKtq8WlfcbGSpLwGIDdjO6k+bRINpw78StSBllk9DBDpBekMU
         FePw==
X-Gm-Message-State: AOAM532HeqTpYc9x6dJ+L+O4AeidhYdqOE0nD3S/Qm0+IWR6hGAuyBai
        vcc2+ngqAN/cqa7Y1od5O70BCtfJQq0wgA==
X-Google-Smtp-Source: ABdhPJzhHRDpJYRODQqxMRJs26plE99bxvzBLBxbm3NYKbadhIWb6AvUWAMjLYmzqHgBIwfpy/sLwA==
X-Received: by 2002:a2e:2244:: with SMTP id i65mr34914lji.185.1601321414584;
        Mon, 28 Sep 2020 12:30:14 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id g74sm2918715lfd.152.2020.09.28.12.30.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2020 12:30:13 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id m5so2662939lfp.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 12:30:12 -0700 (PDT)
X-Received: by 2002:ac2:4a6a:: with SMTP id q10mr899873lfp.534.1601321412324;
 Mon, 28 Sep 2020 12:30:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200926004136.GJ9916@ziepe.ca> <CAHk-=wiutA_J-OfvrD8Kp3SoYcfMHUwsU7ViOH48q7QN0AQ6eg@mail.gmail.com>
 <CAHk-=wi_gd+JWj-8t8tc8cy3WZ7NMj-_1hATfH3Rt0ytUxtMpQ@mail.gmail.com>
 <20200927062337.GE2280698@unreal> <CAHk-=winqSOFsdn1ntYL13s2UuhpQQ9+GRvjWth3sA5APY4Wwg@mail.gmail.com>
 <CAHk-=wj61s30pt8POVtKYVamYTh6h=7-_ser2Hx9sEjqeACkDA@mail.gmail.com>
 <20200928124937.GN9916@ziepe.ca> <CAHk-=wj6aTsqq6BAUci-NYJ3b-EkDwVgz_NvW_kW8KBqGocouQ@mail.gmail.com>
 <20200928172256.GB59869@xz-x1> <CAHk-=wi=iCnYCARbPGjkVJu9eyYeZ13N64tZYLdOB8CP5Q_PLw@mail.gmail.com>
 <20200928183928.GR9916@ziepe.ca>
In-Reply-To: <20200928183928.GR9916@ziepe.ca>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Sep 2020 12:29:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiRHLVK7Usrfdbh0MF7b86NLZ7gBWHV-Y89K_p3GU4KQg@mail.gmail.com>
Message-ID: <CAHk-=wiRHLVK7Usrfdbh0MF7b86NLZ7gBWHV-Y89K_p3GU4KQg@mail.gmail.com>
Subject: Re: [PATCH 1/5] mm: Introduce mm_struct.has_pinned
To:     Jason Gunthorpe <jgg@ziepe.ca>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 11:39 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> I prefer the version where read pin and write pin are symmetric. The
> PTE in the MM should not change once pinned.

The thing is, I don't really see how to do that.

Right now the write pin fastpath part depends on the PTE being
writable. That implies "this VM has access to this page".

For a read pin there simply is no other way to do it.

So we'd basically say "fast read pin only works on writable pages",
and then we'd have to go to the slow path if it isn't dirty and
writable.

And the slow path would then do whatever COW is required, but it
wouldn't mark the result dirty (and in the case of a shared mapping,
couldn't mark it writable).

So a read pin action would basically never work for the fast-path for
a few cases, notably a shared read-only mapping - because we could
never mark it in the page tables as "fast pin accessible"

See the problem? A read-only pin is fundamentally different from a
write one, because a write one has that fundamental mark of "I have
private access to this page" in ways a read one simply does not.

So we could make the requirement be that a pinned page is either

 (a) from a shared mapping (so the pinning depends on the page cache
association). But we can't test this in the fast path.

or

 (b) for a private mapping we require page_mapcount() == 1 and that
it's writable.

but since (a) requires the mapping type, we can't check in the fast
path - we only have the PTE and the page. So the fast-path can only
"emulate" it by that "writable", which is a proper subset of (a) or
(b), but it's not something that is in any way guaranteed.

End result: FOLL_PIN would really only work on private pages, and only
if you don't want to share with the page cache.

And it would basically have no advantages over a writable FOLL_PIN. It
would break the association with any backing store for private pages,
because otherwise it can't follow future writes.

                   Linus
