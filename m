Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF0C2746B2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 18:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgIVQba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 12:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbgIVQb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 12:31:29 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCE9C061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 09:31:27 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id z19so18757179lfr.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 09:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DFpj/fnUMBVQLv0uLvE3QXIgKUcQAnB9yQv3L++wgJU=;
        b=YkybzvgsCHqPgIFq6Rud8tyuaqdZr9vGTAyZxsIiWRVexRhWCRrS+v9oNSbrCu4xIR
         8UcTYJaVaI/Gu3cfE/F1I43yvPFkhcJBS/XIFCWtBjzB7SQ6lY7UOhuCPISzX1jLKYxR
         39zZRGKf5CbJwSqWpkH7pq/5qL2nGedfUDJHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DFpj/fnUMBVQLv0uLvE3QXIgKUcQAnB9yQv3L++wgJU=;
        b=OZHXQDf0Ca6ayNzn2bHCYe42ynxNhneaR5EEp/zmufM0H/FszKFoJcl3l2+tfhWVRk
         mIZbl8I1QrprHGL6WV62hgtESTXx8cVJZ5iNpZXtsQOD129XLpTRyK3VPOPFhBc0caZL
         42SjlbuPCZ+I48i22x7J3KD3yIpn7om8yvgJju/p0CbSthfWCFM2pgsEZXtpQ/OJIxub
         VC2FzuHJD/AX89Um3NTQVYul44aTYqQ8HiXWT08rqXBHiMt7WQAVjfMkPGbB5XNd07ES
         17uHtrXrKPQIG3rUKR0KF3Pb2KzeCtFKdCuh4JOJNCNgGP4x273z55G+KN1IybvzxwMF
         otAw==
X-Gm-Message-State: AOAM531Azx3ZdQcQpjRoZ0V9/zP3PTuLahRH7VmLIydl/X4sLoZTf+0f
        PLHsaYbJ0zoCrW8v8En72ala6/LQg6thmg==
X-Google-Smtp-Source: ABdhPJyXQ+g3HVPsoRYNwBYfyyBPYbSrpb7UIA5zjOIsUnqsTVLjqZNXgZMcTAeQ6uf/BX5WOzWiSw==
X-Received: by 2002:ac2:4477:: with SMTP id y23mr2155497lfl.378.1600792285416;
        Tue, 22 Sep 2020 09:31:25 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id y26sm3921964ljy.88.2020.09.22.09.31.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 09:31:23 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id u21so14672412ljl.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 09:31:22 -0700 (PDT)
X-Received: by 2002:a05:651c:104c:: with SMTP id x12mr1929758ljm.285.1600792282400;
 Tue, 22 Sep 2020 09:31:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200921211744.24758-1-peterx@redhat.com> <20200921211744.24758-2-peterx@redhat.com>
 <CAG48ez0o+yBpYdzR_-bU3A0nrpzXyM+c+Yk=ZtOZ92qe5x0izA@mail.gmail.com>
 <20200921223004.GB19098@xz-x1> <CAG48ez25krKvd5hWqn0R3w5_AAPVWtWKofiOHEfKaB2+YoDoPw@mail.gmail.com>
 <20200922115436.GG8409@ziepe.ca> <20200922142802.GC19098@xz-x1> <20200922155604.GA731578@ziepe.ca>
In-Reply-To: <20200922155604.GA731578@ziepe.ca>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 22 Sep 2020 09:25:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiNcEu+xFxKH=jba42DEp_yGMcywEsrbLBgpGmZxAGV-g@mail.gmail.com>
Message-ID: <CAHk-=wiNcEu+xFxKH=jba42DEp_yGMcywEsrbLBgpGmZxAGV-g@mail.gmail.com>
Subject: Re: [PATCH 1/5] mm: Introduce mm_struct.has_pinned
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Peter Xu <peterx@redhat.com>, Jann Horn <jannh@google.com>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 8:56 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> I thought MAP_PRIVATE without PROT_WRITE was nonsensical,

MAP_PRIVATE without PROT_WRITE is very common.

It's what happens for every executable mapping, for example.

And no, it's not the same as MAP_SHARED, for a couple of simple
reasons. It does end up being similar for all the *normal* cases, but
there are various cases where it isn't.

 - mprotect() and friends. MAP_PRIVATE is fixed, but it might have
been writable in the past, and it might become writable in the future.

 - breakpoints and ptrace. This will punch through even a non-writable
mapping and force a COW (since that's the whole point: executables are
not writable, but to do a SW breakpoint you have to write to the page)

So no, MAP_PRIVATE is not nonsensical without PROT_WRITE, and it's not
even remotely unusual.

              Linus
