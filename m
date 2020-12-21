Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE502E02E4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 00:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbgLUXXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 18:23:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgLUXXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 18:23:36 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D579C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 15:22:56 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id m25so27589928lfc.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 15:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=buZJFKyPYBzgbeXC66/N/0dTpo1YFcNm0CccjQ3HclY=;
        b=BaAudlumzhLJFyMaOvrwQsrDy2D4LVnE2wm1c82U854eO+hECKkarKXbDK2eQaxVB+
         FUFFWTdEOS/xy8UHt0PWSrAWdiRa763LeATnu6tLnSSMu9m0wgZkjpHp47KRSyeS3zOC
         K5sYkTtO4S/K/zSR0sI9++ObqZ1CbYGik3uQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=buZJFKyPYBzgbeXC66/N/0dTpo1YFcNm0CccjQ3HclY=;
        b=j9fIoi4Cq7vaq4DE1CuBxn4xhYNzJcRGlUUkQ017ang8QwheqgtJHVfB64Xythz+IS
         uemNPlnrmt3InZgkYey7/Hg2kUJM5lINnv78jx0U+IJyGKWRDElp7ScBl/SXeVX+J5PJ
         UvWxW1z2K27qKAaa5fiZIWKkK6K+Exd1hVTNj2iQtkZa+sHbMLM7EjOUpuircr6r/r9a
         CbiiJKvdadjC4bn1AM5ZNpyZKfGfrpE6s8GRo83SMcEBnugFiEisUEdYdl+r/a51tbtO
         tIYvX4WYSSZS5MXgBir9iW0kfX/9MxHWJFmP2LwZujOkuwNM14No8XtyUw9HrE0y841e
         FqEw==
X-Gm-Message-State: AOAM533tMQqgVBmc4WqDHV7OkIjOtQ0rYC8GSDNow8hH4A6GZkcrGQ1S
        akt1LeI6efOqbVcadCmrI6nfV29H2qhwtw==
X-Google-Smtp-Source: ABdhPJxgiOhA9psR9xEwKv9FOu1pHLvRMJbJO1QZ1MvQsm1Pr0MA+zl7/iTVZLCFx+CUJ26pILtpxg==
X-Received: by 2002:a19:4cf:: with SMTP id 198mr7425260lfe.136.1608592974659;
        Mon, 21 Dec 2020 15:22:54 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id j20sm2488836ljc.47.2020.12.21.15.22.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Dec 2020 15:22:53 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id y19so27543858lfa.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 15:22:53 -0800 (PST)
X-Received: by 2002:a19:7d85:: with SMTP id y127mr7803717lfc.253.1608592973153;
 Mon, 21 Dec 2020 15:22:53 -0800 (PST)
MIME-Version: 1.0
References: <X97pprdcRXusLGnq@google.com> <DDA15360-D6D4-46A8-95A4-5EE34107A407@gmail.com>
 <20201221172711.GE6640@xz-x1> <76B4F49B-ED61-47EA-9BE4-7F17A26B610D@gmail.com>
 <X+D0hTZCrWS3P5Pi@google.com> <CAHk-=wg_UBuo7ro1fpEGkMyFKA1+PxrE85f9J_AhUfr-nJPpLQ@mail.gmail.com>
 <9E301C7C-882A-4E0F-8D6D-1170E792065A@gmail.com> <CAHk-=wg-Y+svNy3CDkJjj0X_CJkSbpERLg64-Vqwq5u7SC4z0g@mail.gmail.com>
 <X+ESkna2z3WjjniN@google.com> <1FCC8F93-FF29-44D3-A73A-DF943D056680@gmail.com>
 <20201221223041.GL6640@xz-x1>
In-Reply-To: <20201221223041.GL6640@xz-x1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 21 Dec 2020 15:22:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh-bG4thjXUekLtrCg8FRrdWjtT40ibXXLSm_hzQG8eOw@mail.gmail.com>
Message-ID: <CAHk-=wh-bG4thjXUekLtrCg8FRrdWjtT40ibXXLSm_hzQG8eOw@mail.gmail.com>
Subject: Re: [PATCH] mm/userfaultfd: fix memory corruption due to writeprotect
To:     Peter Xu <peterx@redhat.com>
Cc:     Nadav Amit <nadav.amit@gmail.com>, Yu Zhao <yuzhao@google.com>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 2:30 PM Peter Xu <peterx@redhat.com> wrote:
>
> AFAIU mprotect() is the only one who modifies the pte using the mmap write
> lock.  NUMA balancing is also using read mmap lock when changing pte
> protections, while my understanding is mprotect() used write lock only because
> it manipulates the address space itself (aka. vma layout) rather than modifying
> the ptes, so it needs to.

So it's ok to change the pte holding only the PTE lock, if it's a
*one*way* conversion.

That doesn't break the "re-check the PTE contents" model (which
predates _all_ of the rest: NUMA, userfaultfd, everything - it's
pretty much the original model for our page table operations, and goes
back to the dark ages even before SMP and the existence of a page
table lock).

So for example, a COW will always create a different pte (not just
because the page number itself changes - you could imagine a page
getting re-used and changing back - but because it's always a RO->RW
transition).

So two COW operations cannot "undo" each other and fool us into
thinking nothing changed.

Anything that changes RW->RO - like fork(), for example - needs to
take the mmap_lock.

NUMA balancing should be ok wrt COW, because it doesn't do that RW->RO
thing, it uses the present bit.

I think that you are right that NUMA balancing itself might cause
other issues, because it can cause that "pte changed and then came
back" (for numa protectoipn and then a numa fault) all with just the
mmap lock for reading.

However, even that shouldn't matter for COW, because the write protect
bit is the one that proptects the *contents* of the page, so even if
NUMA balancing caused that "load original PTE, then re-check later" to
succeed (despite the PTE actually changing in the middle), the
_contents_ of the page cannot have changed, so COW is ok. NUMA
balancing won't be making a read-only page temporarily writable.

           Linus
