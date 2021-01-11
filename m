Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E95FE2F0D2C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 08:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbhAKH1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 02:27:39 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:12188 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727418AbhAKH1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 02:27:39 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5ffbfdc20000>; Sun, 10 Jan 2021 23:26:58 -0800
Received: from [10.2.61.11] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 11 Jan
 2021 07:26:57 +0000
Subject: Re: [PATCH 0/1] mm: restore full accuracy in COW page reuse
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yu Zhao <yuzhao@google.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Minchan Kim" <minchan@kernel.org>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Nadav Amit <nadav.amit@gmail.com>, Jens Axboe <axboe@kernel.dk>
References: <20210110004435.26382-1-aarcange@redhat.com>
 <CAHk-=wghqNywtf=sRv_5FmG=+hPGqj=KWakw34tNeoZ1wPuaHg@mail.gmail.com>
 <CAHk-=wj5=1DKbQut1-21EwQbMSghNL3KOSd82rNrBhuG9+eekA@mail.gmail.com>
 <X/prosulFrEoNnoF@redhat.com>
 <CAHk-=wjZTMsv0_GOyQpLRk_5U1r5W8e21f8sV0jykK=z47hjGQ@mail.gmail.com>
 <CAHk-=wgi31FKc9AL6m87+pb2B79V2g_QjdhmtJNW8Pnq2ERQ-Q@mail.gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <45806a5a-65c2-67ce-fc92-dc8c2144d766@nvidia.com>
Date:   Sun, 10 Jan 2021 23:26:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgi31FKc9AL6m87+pb2B79V2g_QjdhmtJNW8Pnq2ERQ-Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1610350018; bh=V3jZWyS0o/TKWgXi/0u/OEHx5PeFoE3S+tnbYQhoPtw=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=BPH7HXZnuY44oYibc6WX2DQVkEELCdtiVj347qOnPW4XEsAX4wpvZ+eyuaaSSDfd8
         ZaRcbGPtArCDXcgSjGxT45QM/QnHo2kxG13T4ysr8ql5fd6OyjUyB4uBek8mZAkYir
         9AGfP9VYxI/IhvVVadVarfk8etrVNmVLEY9TiJJR8gSZvkgBy5CHJ+l9k3UTEjQivd
         JDEpHoG9NcJIEakKcUfvleFkcNn0YBg/oVt6NcTHVaf8LNlPYJg8/YRbT/wxT4rgtb
         fNTamGyglm/eXszVkgpwRj60/7G30icCqVcJ4lFAHr7cV6z/GHid3B9hDIrBXI1b6W
         WFEGuREUo/fpQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/21 11:30 AM, Linus Torvalds wrote:
> On Sat, Jan 9, 2021 at 7:51 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>
> Just having a bit in the page flags for "I already made this
> exclusive, and fork() will keep it so" is I feel the best option. In a
> way, "page is writable" right now _is_ that bit. By definition, if you
> have a writable page in an anonymous mapping, that is an exclusive
> user.
> 
> But because "writable" has these interactions with other operations,
> it would be better if it was a harder bit than that "maybe_pinned()",
> though. It would be lovely if a regular non-pinning write-GUP just
> always set it, for example.
> 
> "maybe_pinned()" is good enough for the fork() case, which is the one
> that matters for long-term pinning. But it's admittedly not perfect.
> 

There is at least one way to improve this part of it--maybe.

IMHO, a lot of the bits in page _refcount are still being wasted (even
after GUP_PIN_COUNTING_BIAS overloading), because it's unlikely that
there are many callers of gup/pup per page. If anyone points out that
that is wrong, then the rest of this falls apart, but...if we were to
make a rule that "only a very few FOLL_GET or FOLL_PIN pins are ever
simultaneously allowed on a given page", then several things become
possible:

1) "maybe dma pinned" could become "very likely dma-pinned", by allowing
perhaps 23 bits for normal page refcounts (leaving just 8 bits for dma
pins), thus all but ensuring no aliasing between normal refcounts and
dma pins. The name change below to "likely" is not actually necessary,
I'm just using it to make the point clear:


diff --git a/include/linux/mm.h b/include/linux/mm.h
index ecdf8a8cd6ae..28f7f64e888f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1241,7 +1241,7 @@ static inline void put_page(struct page *page)
   * get_user_pages and page_mkclean and other calls that race to set up page
   * table entries.
   */
-#define GUP_PIN_COUNTING_BIAS (1U << 10)
+#define GUP_PIN_COUNTING_BIAS (1U << 23)

  void unpin_user_page(struct page *page);
  void unpin_user_pages_dirty_lock(struct page **pages, unsigned long npages,
@@ -1274,7 +1274,7 @@ void unpin_user_pages(struct page **pages, unsigned long npages);
   * @Return:    True, if it is likely that the page has been "dma-pinned".
   *             False, if the page is definitely not dma-pinned.
   */
-static inline bool page_maybe_dma_pinned(struct page *page)
+static inline bool page_likely_dma_pinned(struct page *page)
  {
         if (hpage_pincount_available(page))
                 return compound_pincount(page) > 0;


2) Doing (1) allows, arguably, failing mprotect calls if
page_likely_dma_pinned() returns true, because the level of confidence
is much higher now.

3) An additional counter, for normal gup (FOLL_GET) is possible: divide
up the top 8 bits into two separate counters of just 4 bits each. Only
allow either FOLL_GET or FOLL_PIN (and btw, I'm now mentally equating
FOLL_PIN with FOLL_LONGTERM), not both, on a given page. Like this:

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ecdf8a8cd6ae..ce5af27e3057 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1241,7 +1241,8 @@ static inline void put_page(struct page *page)
   * get_user_pages and page_mkclean and other calls that race to set up page
   * table entries.
   */
-#define GUP_PIN_COUNTING_BIAS (1U << 10)
+#define DMA_PIN_COUNTING_BIAS (1U << 23)
+#define GUP_PIN_COUNTING_BIAS (1U << 27)

  void unpin_user_page(struct page *page);
  void unpin_user_pages_dirty_lock(struct page **pages, unsigned long npages,

So:

FOLL_PIN: would use DMA_PIN_COUNTING_BIAS to increment page refcount.
These are long term pins for dma.

FOLL_GET: would use GUP_PIN_COUNTING_BIAS to increment page refcount.
These are not long term pins.

Doing (3) would require yet another release call variant:
unpin_user_pages() would need to take a flag to say which refcount to
release: FOLL_GET or FOLL_PIN. However, I think that's relatively easy
(compared to the original effort of teasing apart generic put_page()
calls, into unpin_user_pages() calls). We already have all the
unpin_user_pages() calls in place, and so it's "merely" a matter of
adding a flag to 74 call sites.

The real question is whether we can get away with supporting only a very
low count of FOLL_PIN and FOLL_GET pages. Can we?


thanks,
-- 
John Hubbard
NVIDIA
