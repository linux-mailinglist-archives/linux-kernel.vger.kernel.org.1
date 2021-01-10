Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D169C2F04BA
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 02:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbhAJBow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 20:44:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbhAJBov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 20:44:51 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77907C06179F
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jan 2021 17:44:05 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id ce23so19716108ejb.8
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jan 2021 17:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uBVkrWF/ITar/TCRB0GlVs8VwamJlUjk1ZeB4Qt+7CQ=;
        b=OVfU5l5FRJKWzy0gPczQthTegFzC6xnQ2MOTRxvojatPuTnPfi539OuCVllS+6LMII
         mhrWP++mZblQDRv00D8nSfg8WdwVc6kke9jo8QJ7hr0ToXIYuk2O0WtvxiMwSeaFiZNw
         UU1h1bCjbfkAEabzFJuhnFGnSW/Hk4Fjjs9K8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uBVkrWF/ITar/TCRB0GlVs8VwamJlUjk1ZeB4Qt+7CQ=;
        b=joP/+aKUtswpfa4O9hpk0y0g2DKUYCHwjPGjUjPWGX4QgwdTxmqNlu779qOmoz5CUC
         ftA4kbM0bZ9+tVebpavaHb5MTpImhiZp0l0bIwMub8JsbfpY7rc8AsrlZTU4epsspZQx
         yyeLu2k9P9+K+0sLtTId+ZCCYulu10X6TOClcs1wm9+59Fqub+UsfilEHYDBG9LN2ws6
         KHgbgsjHS1smK7m/cJNFdKevOIeQUJNbZrZ7/C0RRSYAhE59jrkCQIdqn3UzmLntgDC0
         496a3DHWfFlf04T89ZkWm01YKcan4alD4ryhHkUUfDUiiZGF/q12aqMms9+wZKUdAnEa
         4U+A==
X-Gm-Message-State: AOAM531rrxZvzalveafqfSsQ4ybicFzzM5t5+n8d1HGk+BHM32VzTVUi
        OfggEYerT3X8OGv8QWXkI+FFIPOttaqK2A==
X-Google-Smtp-Source: ABdhPJxM4nSRLyY6W1XiKMf3GwaqKQckRqXM+SDqfzq1Y9lGHE3b+pGz4zxnL2gDBeeh5IXrbOoUsw==
X-Received: by 2002:a17:906:5e0d:: with SMTP id n13mr6664630eju.500.1610243043972;
        Sat, 09 Jan 2021 17:44:03 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id dk16sm5173420ejb.85.2021.01.09.17.44.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Jan 2021 17:44:03 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id g20so19812006ejb.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jan 2021 17:44:03 -0800 (PST)
X-Received: by 2002:a19:f014:: with SMTP id p20mr4272695lfc.421.1610242645588;
 Sat, 09 Jan 2021 17:37:25 -0800 (PST)
MIME-Version: 1.0
References: <20210110004435.26382-1-aarcange@redhat.com> <CAHk-=wghqNywtf=sRv_5FmG=+hPGqj=KWakw34tNeoZ1wPuaHg@mail.gmail.com>
 <CAHk-=wj5=1DKbQut1-21EwQbMSghNL3KOSd82rNrBhuG9+eekA@mail.gmail.com>
In-Reply-To: <CAHk-=wj5=1DKbQut1-21EwQbMSghNL3KOSd82rNrBhuG9+eekA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 9 Jan 2021 17:37:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg3zWaXaKN1N=qTWiuLFvEz3e_d5oZSgOEfbSOrXJvVtQ@mail.gmail.com>
Message-ID: <CAHk-=wg3zWaXaKN1N=qTWiuLFvEz3e_d5oZSgOEfbSOrXJvVtQ@mail.gmail.com>
Subject: Re: [PATCH 0/1] mm: restore full accuracy in COW page reuse
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yu Zhao <yuzhao@google.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Nadav Amit <nadav.amit@gmail.com>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 9, 2021 at 5:19 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And no, I didn't make the UFFDIO_WRITEPROTECT code take the mmap_sem
> for writing. For whoever wants to look at that, it's
> mwriteprotect_range() in mm/userfaultfd.c and the fix is literally to
> turn the read-lock (and unlock) into a write-lock (and unlock).

Oh, and if it wasn't obvious, we'll have to debate what to do with
trying to mprotect() a pinned page. Do we just ignore the pinned page
(the way my clear_refs patch did)? Or do we turn it into -EBUSY? Or
what?

So it's not *just* the locking that needs to be fixed. But just take a
look at that suggested clear_refs patch of mine - it sure isn't
complicated.

              Linus
