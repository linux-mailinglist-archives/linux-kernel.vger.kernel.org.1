Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69BEC2E10C2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 01:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgLWAVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 19:21:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgLWAVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 19:21:48 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E82C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 16:21:07 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id o17so36138947lfg.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 16:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DLFc43+zWZaHz7DJE5w0IA8m/d3/STNRHdNjNBYY/r8=;
        b=Kv96F1RjqhLKNH4Di/XoAkh4fGcFanJF/35mBeZg8s5yZd6emVuhDTmAbKdCOPjTHy
         2Flkg4YAHNfaKVQVpWzaowFcfIsg0qWnCHYScg1wPkWTGMP48AsbRBDUDmFxjUz6rUTh
         Xoab7E7PwRF0MbFD3jGQK+ux0O7RWJxy/Q1DA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DLFc43+zWZaHz7DJE5w0IA8m/d3/STNRHdNjNBYY/r8=;
        b=QB1p5IMaP4oNvylLh3DN1K11OodNO6PLWQfkE2q466DuddHXoHiOlGpj9Zaqei88Sv
         gte7Tqg/RsiT8VHiCQj/VA71OYVoqq3vP+25KI7NdZr/fxUK/EMcD82vf5oJF2Wy3mbO
         OF96py4RT3Wu0VTPNXiDcp8tZu+KOC9NWDBtw0gDBnVRBgp+6TrE33Uw2BTluxPy90/i
         iEyHqrfVpu+h+rMEnWEh1eDvI9pFDr1MHnwmtRw9OHou6YoG9G6QFw72OHhrF5jeiLAU
         Nn8xJctCIQFi9ocXF/SwzfzLTD6lu1dd5AIH/wHEtaA1ErASO+4KHaM+7z6NoAn6tO2N
         BoJw==
X-Gm-Message-State: AOAM532xyrgF7PpvY+VgIVmtAyhuSqs6VnBH2aWIENFMDkYJoCQFLGSP
        JnH/MBkAX9XuI5fbBVQPxIOS6I2Dc78HmQ==
X-Google-Smtp-Source: ABdhPJytMSTqWgxkf4kWLXYHjMZ/hFVu6Obar87/hQMXdv8nDYZ72u40AZozJseC0Krw8XCaLXtBZg==
X-Received: by 2002:ac2:4463:: with SMTP id y3mr9261320lfl.94.1608682865330;
        Tue, 22 Dec 2020 16:21:05 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id o138sm2528357lfa.171.2020.12.22.16.21.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Dec 2020 16:21:04 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id m12so36107395lfo.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 16:21:03 -0800 (PST)
X-Received: by 2002:a05:6512:338f:: with SMTP id h15mr9238858lfg.40.1608682863624;
 Tue, 22 Dec 2020 16:21:03 -0800 (PST)
MIME-Version: 1.0
References: <9E301C7C-882A-4E0F-8D6D-1170E792065A@gmail.com>
 <CAHk-=wg-Y+svNy3CDkJjj0X_CJkSbpERLg64-Vqwq5u7SC4z0g@mail.gmail.com>
 <X+ESkna2z3WjjniN@google.com> <1FCC8F93-FF29-44D3-A73A-DF943D056680@gmail.com>
 <20201221223041.GL6640@xz-x1> <CAHk-=wh-bG4thjXUekLtrCg8FRrdWjtT40ibXXLSm_hzQG8eOw@mail.gmail.com>
 <CALCETrV=8tY7h=aaudWBEn-MJnNkm2wz5qjH49SYqwkjYTpOaA@mail.gmail.com>
 <X+JJqK91plkBVisG@redhat.com> <X+JhwVX3s5mU9ZNx@google.com>
 <X+Js/dFbC5P7C3oO@redhat.com> <X+KDwu1PRQ93E2LK@google.com> <CAHk-=wiBWkgxLtwD7n01irD7hTQzuumtrqCkxxZx=6dbiGKUqQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiBWkgxLtwD7n01irD7hTQzuumtrqCkxxZx=6dbiGKUqQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 22 Dec 2020 16:20:47 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjNedWcjAfPW7pdPTM0-gSXABsv9AA+wCebXbh3tuRTRQ@mail.gmail.com>
Message-ID: <CAHk-=wjNedWcjAfPW7pdPTM0-gSXABsv9AA+wCebXbh3tuRTRQ@mail.gmail.com>
Subject: Re: [PATCH] mm/userfaultfd: fix memory corruption due to writeprotect
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        stable <stable@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 22, 2020 at 3:50 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The rule is that the TLB flush has to be done before the page table
> lock is released.

I take that back. I guess it's ok as long as the mmap_sem is held for
writing. Then the TLB flush can be delayed until just before releasing
the mmap_sem. I think.

The stale TLB entries still mean that somebody else can write through
them in another thread, but as long as anybody who actually unmaps the
page (and frees it - think rmap etc) is being careful, mprotect()
itself can probably afford to be a bit laissez-faire.

So mprotect() itself should be ok, I think, because it takes things for writing.

Even with the mmap_sem held for writing, truncate and friends can see
the read-only page table entries (because they can look things up
using the file i_mmap thing instead), but then they rely on the page
table lock and they'll also be careful if they then change that PTE
and will force their own TLB flushes.

So I think a pending TLB flush outside the page table lock is fine -
but once again only if you hold the mmap_sem for writing. Not for
reading, because then the page tables need to be synchronized with the
TLB so that other readers don't see the not-yet-synchronized state.

It once again looks like it's just userfaultfd that would trigger this
due to the read-lock on the mmap_sem. And mprotect() itself is fine.

Am I missing something?

But apparently Nadav sees problems even with that lock changed to a
write lock. Navad?

           Linus
