Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C86B2EE8F3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 23:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbhAGWnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 17:43:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727873AbhAGWnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 17:43:17 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12493C0612F8
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 14:42:37 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id o19so18488503lfo.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 14:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I2VAaNooKAP114VF8q9qfQ7iBV3xbqVNp+M3Nn15V6w=;
        b=FJ5HMdnIYce/w7nocOiHyJeqY0eiEDEIH3wAcoe914foKCJZawDo0CEQxYXKZLb5U1
         XND4juga6KTAAsoswTEvWjaYNCWc8UzZgS2Gex7XRbGcMmlsr/t9KqvVaJlsCZfEIE5X
         +SS3NC4qIEdZZLL+TymU5o/SisNG7UcB0yc+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I2VAaNooKAP114VF8q9qfQ7iBV3xbqVNp+M3Nn15V6w=;
        b=DHpUFcrc+f4qjaqOSXjO30e3oHzfVomDGYFACd4hPUPFwLkuRF4cuQRpMDrCI0qMTU
         zXQvFX7URAJ3SHvzAnGZO/mz6xBB7/8DLHO7urEF6f9LFW1rG388GtuA5wmn2rd3AmY0
         yK7kUuzQcbCfyM1Sm0pElT22W+KUWviZxcOdrLyntKYEEHi5pfO99TIX1Tvk4hfc24EZ
         0X84BcUBK3tV44nUsD8nuWoR66t1NnAqAFkJ8MlF6zgk/7ygqNt+SWxCziYZHyl2n4+8
         /iwrM/sDSngLn/D2hYliQmuA2KsxJymVkLViBTSottYJo3hygjRLPy6Axsezrz/08q62
         AuNg==
X-Gm-Message-State: AOAM533v0XkxPH0uG7vPNSR4742J2fxnkooo4m7EtvIRMoUT9I81cwqK
        +h0tdcpSEA5vGXn8tsqadh3izEFNd8T+MA==
X-Google-Smtp-Source: ABdhPJxAP+ADhg3iF39yt8GmwjXKU+tn/xTfro6NjwcW7q4eIRwQb+vGOijN0zw/l/9OHHxBh0z5EA==
X-Received: by 2002:a05:651c:1254:: with SMTP id h20mr274353ljh.211.1610059355166;
        Thu, 07 Jan 2021 14:42:35 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id r8sm1440625lfc.35.2021.01.07.14.42.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 14:42:34 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id o19so18488320lfo.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 14:42:33 -0800 (PST)
X-Received: by 2002:a05:6512:789:: with SMTP id x9mr348260lfr.487.1610059353457;
 Thu, 07 Jan 2021 14:42:33 -0800 (PST)
MIME-Version: 1.0
References: <B1B85771-B211-4FCC-AEEF-BDFD37332C25@vmware.com>
 <20210107200402.31095-1-aarcange@redhat.com> <20210107200402.31095-3-aarcange@redhat.com>
 <CAHk-=whg-91=EF=8=ayyDQGx_3iuWKp3aHUkDCDkgUb15Yh8AQ@mail.gmail.com>
 <X/d2DyLfXZmBIreY@redhat.com> <CAHk-=wjs9v-hp_7HV_TrTmisu7pNX=MwZ62ZV82i0evLhPwS1Q@mail.gmail.com>
 <X/eLwQPd5bi620Vt@redhat.com>
In-Reply-To: <X/eLwQPd5bi620Vt@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 7 Jan 2021 14:42:17 -0800
X-Gmail-Original-Message-ID: <CAHk-=whjS3pUZRJLR_HdgB0_1Sd4gWXUbLLyShKxOg0ySCdnUA@mail.gmail.com>
Message-ID: <CAHk-=whjS3pUZRJLR_HdgB0_1Sd4gWXUbLLyShKxOg0ySCdnUA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: soft_dirty: userfaultfd: introduce wrprotect_tlb_flush_pending
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
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
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 7, 2021 at 2:31 PM Andrea Arcangeli <aarcange@redhat.com> wrote:
>
> Random memory corruption will still silently materialize as result of
> the speculative lookups in the above scenario.

Explain.

Yes, you'll get random memory corruption if you keep doing wrprotect()
without mmap_sem held for writing.

But I thought we agreed earlier that that is a bug. And I thought the
softdirty code already got it for writing.

           Linus
