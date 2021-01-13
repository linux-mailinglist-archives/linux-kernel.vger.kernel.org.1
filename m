Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 257972F4B5B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 13:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbhAMMdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 07:33:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbhAMMdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 07:33:15 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503BEC061575
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 04:32:35 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id o17so2506057lfg.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 04:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=G4I/u23B9cutM4KrBlaPjQW4iYtRm9vAHciYINpRKrU=;
        b=YCjdWD0DN/Sz51SeG2Vf99qoFIZeSDy2px9F0Z3ObU5M2sN+GRf14GX8WeuK/nh+2y
         I+BN787g/iaQwOS7ttXO1puD5Cg10RQnUykfy9JNLIYQOsKP4OcSOrlvbyx7vYD5mSz4
         T6kI0yRI3nB5x212HwSIBAvZioG0ax6acgqVdqufAWt+zsObVYU0Uxa2M7oC1+7M8qjQ
         ygsUFujWf8C5TKD5aaPWHR6sADMF+KhlfeIGf9F3Ft3DLCJMvekzvXhANulVAfhn4/uP
         +Gu+vA+Q9tNuTtlKH0YI3N9rUl30bCmIfPuvk2L28OZuU5QeU2bO74v4rSlaeF5kya+B
         paeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G4I/u23B9cutM4KrBlaPjQW4iYtRm9vAHciYINpRKrU=;
        b=rdqSrrmHTusQIIUQJOinQ1pGW7eW+hmvIWRIg1+Z28d/XMlt4T3kkTUOvsrN78J6Ot
         UZ4N36a9YGRIqpfP25J99bbtcI8VXZfWuqRcVItOKGvndyeibP3mCsTuwFmhl7W9EIrH
         lcYEeLZRDJSwJnGCk9Xy43aQPkgfZI2HKZxT5FuyKnJlhag3lH81R8tvjNCV3rA0ngy4
         hpSjL0mwZ++dQPGiXIPoHjepofs4bTvxeiquHyvIrKizd5ajoEalsYampJXpGJAvqxwu
         4Y7euyEHxHSXKOmV5gSBvLqo2IXaEh6Ngza+Dz9bMurnUfE+n7zJmQeGfHGUbO8UpsZb
         zbYQ==
X-Gm-Message-State: AOAM531qfYHO+S9/EdBYKbSgC2WasTuO+XUTz3FAEGI8+xxqaYA8y0wE
        m5ybdJzAYIZowI4jda+GshGglw==
X-Google-Smtp-Source: ABdhPJwys7kzAKkTMVE5V6fYyRNsRneoayL3CuYZfpkTNZMZMOPcNttxH9fAr4vxP0c03o8XhZi4dg==
X-Received: by 2002:a19:381c:: with SMTP id f28mr770707lfa.339.1610541153879;
        Wed, 13 Jan 2021 04:32:33 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id g4sm197824lfc.85.2021.01.13.04.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 04:32:33 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 1661E102D04; Wed, 13 Jan 2021 15:32:32 +0300 (+03)
Date:   Wed, 13 Jan 2021 15:32:32 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Nadav Amit <nadav.amit@gmail.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 0/1] mm: restore full accuracy in COW page reuse
Message-ID: <20210113123232.62vv6xsrpitne7hc@box>
References: <CAHk-=wghqNywtf=sRv_5FmG=+hPGqj=KWakw34tNeoZ1wPuaHg@mail.gmail.com>
 <CAHk-=wj5=1DKbQut1-21EwQbMSghNL3KOSd82rNrBhuG9+eekA@mail.gmail.com>
 <X/prosulFrEoNnoF@redhat.com>
 <CAHk-=wjZTMsv0_GOyQpLRk_5U1r5W8e21f8sV0jykK=z47hjGQ@mail.gmail.com>
 <CAHk-=wgi31FKc9AL6m87+pb2B79V2g_QjdhmtJNW8Pnq2ERQ-Q@mail.gmail.com>
 <45806a5a-65c2-67ce-fc92-dc8c2144d766@nvidia.com>
 <CAHk-=wipa-9wEuWHBjourmXAVHdeqDa59UxW6ZJ_Oqg6-Dwvdw@mail.gmail.com>
 <CAHk-=wje9r3fREBdZcOu=NihGczBtkqkhXRPDhY-ZkNVv=thiQ@mail.gmail.com>
 <20210113021619.GL35215@casper.infradead.org>
 <CAHk-=wjWMieNV3nAJgoG5prEHBEcOZiREmLUr499tA9NMttEqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjWMieNV3nAJgoG5prEHBEcOZiREmLUr499tA9NMttEqQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 07:31:07PM -0800, Linus Torvalds wrote:
> On Tue, Jan 12, 2021 at 6:16 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > The thing about the speculative page cache references is that they can
> > temporarily bump a refcount on a page which _used_ to be in the page
> > cache and has now been reallocated as some other kind of page.
> 
> Oh, and thinking about this made me think we might actually have a
> serious bug here, and it has nothing what-so-ever to do with COW, GUP,
> or even the page count itself.
> 
> It's unlikely enough that I think it's mostly theoretical, but tell me
> I'm wrong.
> 
> PLEASE tell me I'm wrong:
> 
> CPU1 does page_cache_get_speculative under RCU lock
> 
> CPU2 frees and re-uses the page
> 
>     CPU1                CPU2
>     ----                ----
> 
>     page = xas_load(&xas);
>     if (!page_cache_get_speculative(page))
>             goto repeat;
>     .. succeeds ..
> 
>                         remove page from XA
>                         release page
>                         reuse for something else

How can it be reused if CPU1 hold reference to it?

> 
>     .. and then re-check ..
>     if (unlikely(page != xas_reload(&xas))) {
>             put_page(page);
>             goto repeat;
>     }
> 

-- 
 Kirill A. Shutemov
