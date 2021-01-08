Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7A3F2EF6A2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 18:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbhAHRk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 12:40:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbhAHRk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 12:40:56 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFE8C061380
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 09:40:16 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id m12so24801069lfo.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 09:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/gS/KBB48sNHxIKyaAcalJJEy56yMvuCpJTPQDCPvnM=;
        b=fuP5ENd+jDrQ7z8zz270BOZWcAD9/W0zejZgHYetzb3nWJ0PCPv8TsXRldfyze1BrV
         17V8qBBhignCfVSUag+ig7roYZVsl66ah5n0Vk/fdov570y+MV9qzkcploJitGiiWvsr
         CGxM46LnVs18D9ir5EDzVCH1q/idUZpOh0ltQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/gS/KBB48sNHxIKyaAcalJJEy56yMvuCpJTPQDCPvnM=;
        b=LjDUX0hdUVIa99+2Qma+ndg/eieQ4pWfrrVfNTMNuBK3D2kw8aki+1n3hjxbrK9nf5
         gTka5VoOZsmEhNTQ6HVAbaVwuTteesvjgsBBDlqofaohXS7P6xdtxRCVC/wOTCLuI2pT
         eVh5AV0hx+Lh+Z+EJusmpKJdpWAaEJePycl7MrSWcHhEbW/OUM6Fo9zNbFcyJe7O3TUy
         AtrCX8RZ9LbjgCatFn+6uZNMDg9n4B4RuE6AyLK2IdgCaZtehG/XlaREJdnXPgTRAcKJ
         WHv0q/FK7/uBoGz/ewYtRJwCj2wtwuj88QOqXXLQb+wvjUW84bbnaH2xRUfk5jpdRWzV
         F11A==
X-Gm-Message-State: AOAM532p4OIRD9nK+AIr/iR6/11wmM64WC2VxhH7QBevZBT2ttj0ENR/
        1Tcw1NP5ZGCjKitBfrKxYJ9Nah7WhC+4MA==
X-Google-Smtp-Source: ABdhPJzIQw5kZ0lAKjga0/oyf4o2pQPwGb/WRdjFkssFG66hE9bvF8NwrX+KGFm5OQGOrUfQJRSdeA==
X-Received: by 2002:a19:7718:: with SMTP id s24mr2212274lfc.277.1610127614406;
        Fri, 08 Jan 2021 09:40:14 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id 29sm2079437lfr.304.2021.01.08.09.40.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jan 2021 09:40:12 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id x20so24706119lfe.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 09:40:12 -0800 (PST)
X-Received: by 2002:a19:7d85:: with SMTP id y127mr2167866lfc.253.1610127612227;
 Fri, 08 Jan 2021 09:40:12 -0800 (PST)
MIME-Version: 1.0
References: <20210107200402.31095-3-aarcange@redhat.com> <CAHk-=whg-91=EF=8=ayyDQGx_3iuWKp3aHUkDCDkgUb15Yh8AQ@mail.gmail.com>
 <X/d2DyLfXZmBIreY@redhat.com> <CAHk-=wjs9v-hp_7HV_TrTmisu7pNX=MwZ62ZV82i0evLhPwS1Q@mail.gmail.com>
 <X/eLwQPd5bi620Vt@redhat.com> <CAHk-=whjS3pUZRJLR_HdgB0_1Sd4gWXUbLLyShKxOg0ySCdnUA@mail.gmail.com>
 <CAHk-=wgRZ5o5pUqKC6cwTLU=V-G+rF5DTexGh1kCMGrgXDufew@mail.gmail.com>
 <X/edsWgguQDgsOtx@redhat.com> <CAHk-=whTCBa6Frpbveuy7Hnz17P+g03yQvynkApFbBjV5rVrsA@mail.gmail.com>
 <20210108124815.GA4512@willie-the-truck> <X/iEyk0ijxhSvs9T@redhat.com>
In-Reply-To: <X/iEyk0ijxhSvs9T@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 8 Jan 2021 09:39:56 -0800
X-Gmail-Original-Message-ID: <CAHk-=wizOEqJTomh=K5CR300mtTCwWdj+QYYCXKHaiU-R0YE9Q@mail.gmail.com>
Message-ID: <CAHk-=wizOEqJTomh=K5CR300mtTCwWdj+QYYCXKHaiU-R0YE9Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: soft_dirty: userfaultfd: introduce wrprotect_tlb_flush_pending
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Will Deacon <will@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yu Zhao <yuzhao@google.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 8, 2021 at 8:14 AM Andrea Arcangeli <aarcange@redhat.com> wrote:
>
> page_count in do_wp_page is a fix for the original security issue

Not just that.

page_count() is simply the right and efficient thing to do.

You talk about all these theoretical inefficiencies for cases like
zygote and page pinning, which have never ever been seen except as a
possible attack vector.

Stop talking about irrelevant things. Stop trying to "optimize" things
that never happen and don't matter.

Instead, what matters is the *NORMAL* VM flow.

Things like COW.

Things like "oh, now that we check just the page count, we don't even
need the page lock for the common case any more".

> For the long term, I can't see how using page_count in do_wp_page is a
> tenable proposition,

I think you should re-calibrate your expectations, and accept that
page_count() is the right thing to do, and live with it.

And instead of worrying about irrelevant special-case code, start
worrying about the code that gets triggered tens of thousands of times
a second, on regular loads, without anybody doing anything odd or
special at all, just running plain and normal shell scripts or any
other normal traditional load.

Those irrelevant special cases should be simple and work, not badly
optimized to the point where they are buggy. And they are MUCH LESS
IMPORTANT than the normal VM code, so if somebody does something odd,
and it's slow, then that is the problem for the _odd_ case, not for
the normal codepaths.

This is why I refuse to add crazy new special cases to core code. Make
the rules simple and straightforward, and make the code VM work well.

                  Linus
