Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 610E22D6373
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 18:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392217AbgLJRZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 12:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733165AbgLJRY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 12:24:59 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3DEC0617A6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 09:24:15 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id s11so7572865ljp.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 09:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c8GZHV70SIMPnsG/im0NZ1nvlbdKEj02vN3NUYrxHb4=;
        b=NUepeImek9g6AkAD8FP2WpSlLYMQ/jndgfbQYnX33PYoGJkeaWhM41SQ4PYFMxds9i
         8KPSUbc/mSnK8nMSeWE8bE9HJJVm2FkBbsHLGAsFTXqlZLGSU3mpdMA+0D2KkOgKY6O5
         hPXsCpdYHUJ74krd32q8hOzJQ+Ls46rsXJEbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c8GZHV70SIMPnsG/im0NZ1nvlbdKEj02vN3NUYrxHb4=;
        b=OMsw7y7mDifDW3k2zxy2ji8j2P969J/lBTVhMgzi0EuhuFZVkBhVLynnkrLm90I2oS
         2N3VNRVDTT4+Nr06VjsZ4nfDdRQT/W/irqnoEbnJ+aQH/KA0ie8/3znxEb5cWlFWJGNb
         3XzhybzW1X5BkpZQcXVa7FQKbLnVO+aDiKl31i4l2mNe80lEdrUSmkACtMI+HBsNkhnu
         DDtKNtoVHhezWZF8bQyJm+7fwSehHtV+HJsZWKtTJBUYw+GamVpVtFAwUk6PDg6fQTN6
         U9z1A4MkBa3jIGwEbGFRyCvzkWg8Y3AMBW3r2e5KPK1Wh9DztlBRb7hB+ZB37+csFgm6
         RC+g==
X-Gm-Message-State: AOAM533qMCY+Yvqb6NRujlIP9rGK4HBJwE+jJyzGGlQgOvd9VpRH+kE5
        ICgSnG3ilbq0hi/GLIEajNd8XzeVge6+0g==
X-Google-Smtp-Source: ABdhPJwh/z+pcVcFj7F/bdCBZ274glfhr+9jYzSM1ZTFZ0KrHxtDFP9h5PrwnY2ZdUZI466aNIlvpQ==
X-Received: by 2002:a2e:98da:: with SMTP id s26mr3393901ljj.445.1607621053551;
        Thu, 10 Dec 2020 09:24:13 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id 192sm587214lfa.219.2020.12.10.09.24.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 09:24:12 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id o17so6446594lfg.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 09:24:11 -0800 (PST)
X-Received: by 2002:a05:6512:338f:: with SMTP id h15mr2925765lfg.40.1607621050581;
 Thu, 10 Dec 2020 09:24:10 -0800 (PST)
MIME-Version: 1.0
References: <20201209163950.8494-1-will@kernel.org> <20201209163950.8494-2-will@kernel.org>
 <CAHk-=wgos=vgteG52=J=rVSeq6-Y2g2+Kn1=xV=wYjVzM6O9UQ@mail.gmail.com>
 <20201209184049.GA8778@willie-the-truck> <CAHk-=wgVqGh402dxfhR=bx2QSH=+4kq9doarNmD77baqDKdiUg@mail.gmail.com>
 <20201210150828.4b7pg5lx666r7l2u@black.fi.intel.com>
In-Reply-To: <20201210150828.4b7pg5lx666r7l2u@black.fi.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Dec 2020 09:23:53 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiU8ktvak2hCj2TWJ6wMSwVsUSvi5Bjf4i1JGvpGmyUZw@mail.gmail.com>
Message-ID: <CAHk-=wiU8ktvak2hCj2TWJ6wMSwVsUSvi5Bjf4i1JGvpGmyUZw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: Allow architectures to request 'old' entries when prefaulting
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 7:08 AM Kirill A. Shutemov
<kirill.shutemov@linux.intel.com> wrote:
>
> See lightly tested patch below. Is it something you had in mind?

This is closer, in that at least it removes the ostensibly blocking
allocation (that can't happen) from the prefault path.

But the main issue remains:

> > At that point, I think the current very special and odd
> > do_fault_around() pre-allocation could be made into just a _regular_
> > "allocate the pmd if it doesn't exist". And then the pte locking could
> > be moved into filemap_map_pages(), and suddenly the semantics and
> > rules around all that would be a whole lot more obvious.
>
> No. It would stop faultaround code from mapping huge pages. We had to
> defer pte page table mapping until we know we don't have huge pages in
> page cache.

Can we please move that part to the callers too - possibly with a
separate helper function?

Because the real issue remains: as long the map_set_pte() function
takes the pte lock, the caller cannot rely on it.

And the filemap_map_pages() code really would like to rely on it.
Because if the lock is taken there *above* the loop - or even in the
loop iteration at the top, the code can now do things that rely on "I
know I hold the page table lock".

In particular, we can get rid of that very very expensive page locking.

Which is the reason I know about the horrid current issue with
"pre-allocate in one place, lock in another, and know we are atomic in
a third place" issue. Because I had to walk down these paths and
realize that "this loop is run under the page table lock, EXCEPT for
the first iteration, where it's taken by the first time we do that
non-allocating alloc_set_pte()".

See?

             Linus
