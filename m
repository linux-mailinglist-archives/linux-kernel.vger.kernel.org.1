Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBF72E0289
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 23:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgLUWcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 17:32:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56699 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726140AbgLUWcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 17:32:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608589846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/0nOtRjyRXqUdfVgnLEJZJLZpSyfauPx9TpoxNOMLQc=;
        b=BcN7z3wbg0KXkZy++I+KLqknDQm3BxmfKknuq2jou0uD5WxuUGN9BmhnV+hiyxwqyGFQFm
        ++oFzoJEukxIyoMw9Y0o/DlJIwF+ugPg8K3UXnTnyKEO6ZvM2mNtX2IIKF8TUY3OVcyNRI
        LYyUnUqedIWKlARbBCWKQdghitunS+c=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-90-O61_H6zyMbSiO5VREQKyjg-1; Mon, 21 Dec 2020 17:30:44 -0500
X-MC-Unique: O61_H6zyMbSiO5VREQKyjg-1
Received: by mail-qt1-f197.google.com with SMTP id b8so2547928qtr.18
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 14:30:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/0nOtRjyRXqUdfVgnLEJZJLZpSyfauPx9TpoxNOMLQc=;
        b=lD/OQWJfQjojgxFdTdlUCj4yn3RCpFF5zhUFXVK6KQLvjMTdhTDt33QXnt3+7RGTaM
         OgTirF4fB/jOEgsT2VpmLYShlCOAHrBqq2YyFithY3W8mAZ92l1rfqABto2juxgqQi5I
         w6LrqkrI5H7M3QrfdhTPSXmfxzZ0DiK/OHHzMNpPI58QXXHiylGEohVREzZdkxqEiVMx
         f4soyw+oZEcNb73O7XUiVxpxsro4XyJdquk9o4qDENnyTl98ybQQrPEnH46G5PwPAbPv
         xAf1lJMkzhvA3729DccQVhdEd8MolGEKKbOyIICxPnRm0bsen2qMLS8maLOz7TESQDwo
         hQZg==
X-Gm-Message-State: AOAM530zJn0D6l5hugV0yOiDd5zmtUfu6moY3pmmsPJaSm4Z05NwEfyB
        OMFeGZNhiNr/JE1kZpwQ5RYq4i3gCAIJKZKkntc5VIzyMivwW3vdqd3DkHkoXdw6xawjVoElGyD
        fyUK7AV9inrBsseRqI4Y/xpme
X-Received: by 2002:a0c:f850:: with SMTP id g16mr19255294qvo.14.1608589844019;
        Mon, 21 Dec 2020 14:30:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwsyvGQ+Zlz+F4Ln7DFyojEIAwfAH7eIeF2+0g/BLBE8jYg9DoCNA01RbxX54HEjqCZPSWhnQ==
X-Received: by 2002:a0c:f850:: with SMTP id g16mr19255269qvo.14.1608589843776;
        Mon, 21 Dec 2020 14:30:43 -0800 (PST)
Received: from xz-x1 ([142.126.83.202])
        by smtp.gmail.com with ESMTPSA id a35sm12063468qtk.82.2020.12.21.14.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 14:30:42 -0800 (PST)
Date:   Mon, 21 Dec 2020 17:30:41 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Yu Zhao <yuzhao@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        stable <stable@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] mm/userfaultfd: fix memory corruption due to writeprotect
Message-ID: <20201221223041.GL6640@xz-x1>
References: <X97pprdcRXusLGnq@google.com>
 <DDA15360-D6D4-46A8-95A4-5EE34107A407@gmail.com>
 <20201221172711.GE6640@xz-x1>
 <76B4F49B-ED61-47EA-9BE4-7F17A26B610D@gmail.com>
 <X+D0hTZCrWS3P5Pi@google.com>
 <CAHk-=wg_UBuo7ro1fpEGkMyFKA1+PxrE85f9J_AhUfr-nJPpLQ@mail.gmail.com>
 <9E301C7C-882A-4E0F-8D6D-1170E792065A@gmail.com>
 <CAHk-=wg-Y+svNy3CDkJjj0X_CJkSbpERLg64-Vqwq5u7SC4z0g@mail.gmail.com>
 <X+ESkna2z3WjjniN@google.com>
 <1FCC8F93-FF29-44D3-A73A-DF943D056680@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1FCC8F93-FF29-44D3-A73A-DF943D056680@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 01:49:55PM -0800, Nadav Amit wrote:
> BTW: In general, I think that you are right, and that changing of PTEs
> should not require taking mmap_lock for write. However, I am not sure
> cow_user_page() is not the only one that poses a problem and whether a more
> systematic solution is needed. If cow_user_pages() is the only problem, do
> you think it is possible to do the copying while holding the PTL? It works
> for normal-pages, but I am not sure whether special-pages pose special
> problems.
> 
> Anyhow, this is an enhancement that we can try later.

AFAIU mprotect() is the only one who modifies the pte using the mmap write
lock.  NUMA balancing is also using read mmap lock when changing pte
protections, while my understanding is mprotect() used write lock only because
it manipulates the address space itself (aka. vma layout) rather than modifying
the ptes, so it needs to.

At the pte level, it seems always to be the pgtable lock that serializes things.

So it's perfectly legal to me for e.g. a driver to modify ptes with the read
lock of mmap_sem, unless I'm severely mistaken.. as long as the pgtable lock is
taken when doing so.

If there's a driver that manipulated the ptes, changed the content of the page,
recover the ptes to origin, and all these happen right after wp_page_copy()
unlocked the pgtable lock but before wp_page_copy() retakes the same lock
again, we may face the same issue finding that the page got copied contains
corrupted data at last.  While I don't know what to blame on the driver either
because it seems to be exactly following the rules.

I believe changing into write lock would solve the race here because tlb
flushing would be guaranteed along the way, but I'm just a bit worried it's not
the best way to go..

Thanks,

-- 
Peter Xu

