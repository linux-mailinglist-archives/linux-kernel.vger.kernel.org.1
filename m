Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF47227ABAE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 12:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgI1KSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 06:18:12 -0400
Received: from mail.zx2c4.com ([192.95.5.64]:54339 "EHLO mail.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbgI1KSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 06:18:12 -0400
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTP id d4bd6608
        for <linux-kernel@vger.kernel.org>;
        Mon, 28 Sep 2020 09:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=/cDJPA+uVkTExsxg1g0sjxHghPU=; b=cQtCvm
        ir5ZdM6+FYUD9nu/iMN6JHl039WOp3CjGv97mkA7B//1xGoUo4LHceBe20quyhiZ
        j6facUcGMe5ThikkqrYcju3xmNxkztLPV0MurUjojmkRXp1nDm4JSpTDk42JXVfO
        mRBTvCXFOY2qokfBcWkaPpPJEcmDu06CsYxKzeygL/3aUfM13p+4K9+39gqtqjtq
        zsByCtOp2INQztRuHZVM6U7uNF8y+Zh1iqB4Jmm0OASQIAfgJ0ozJzv3WyshT4Zb
        sQmNL/2jT1KwzN5nIkAM6XgU0ksKqBn2AHygvGTOFB6OdGs4ELzDh72A7lQZ765R
        X1FPBPzIyGEcR8Nw==
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ff185978 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Mon, 28 Sep 2020 09:46:43 +0000 (UTC)
Received: by mail-il1-f170.google.com with SMTP id e5so632227ilr.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 03:18:10 -0700 (PDT)
X-Gm-Message-State: AOAM533G/xm5WbFHf7UMDBJjiKo1w+oOyqBDgQXlIaqBzavyAcGSaZt0
        tenUyakeVhERLsNuCM3YiyjEXqBYXrd87XvBmUI=
X-Google-Smtp-Source: ABdhPJxwCebYVRZYRiOo5Ycu/i+iis87iyV5mmfF9PYcRsC9zNKzgWrCiZDzI1BqWrOozXl//DLKVSXT/VozZAmU2m0=
X-Received: by 2002:a05:6e02:6d0:: with SMTP id p16mr491957ils.64.1601288289457;
 Mon, 28 Sep 2020 03:18:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9odvKzyAG7HgzSE-1gLOfiU=HL1MB5w4z=AwOsjz9WJPA@mail.gmail.com>
 <CAHmME9qPo_MNrVioY=qgOVNxYBVY1_i_eep5wzP-7Akq5fH1Xg@mail.gmail.com>
In-Reply-To: <CAHmME9qPo_MNrVioY=qgOVNxYBVY1_i_eep5wzP-7Akq5fH1Xg@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 28 Sep 2020 12:17:58 +0200
X-Gmail-Original-Message-ID: <CAHmME9qBtUuOSEU3Cb9rL7SHaBAwk862VEPdmYcisnSHDERtvQ@mail.gmail.com>
Message-ID: <CAHmME9qBtUuOSEU3Cb9rL7SHaBAwk862VEPdmYcisnSHDERtvQ@mail.gmail.com>
Subject: Re: 5.9-rc7 null ptr deref in __i915_gem_userptr_get_pages_worker
To:     Jason Gunthorpe <jgg@ziepe.ca>, Peter Xu <peterx@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     intel-gfx@lists.freedesktop.org,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alright, the failing code seems to be in mm:

        if (flags & FOLL_PIN)
                atomic_set(&current->mm->has_pinned, 1);

Apparently you can't rely on current->mm being valid in this context;
it's null here, hence the +0x64 for has_pinned's offset.

This was added by 008cfe4418b3 ("mm: Introduce mm_struct.has_pinned"),
which is new for rc7 indeed.

The crash goes away when changing that to:

        if ((flags & FOLL_PIN) && current->mm)
                atomic_set(&current->mm->has_pinned, 1);

But I haven't really evaluated whether or not that's racy or if I need
to take locks to do such a thing.
