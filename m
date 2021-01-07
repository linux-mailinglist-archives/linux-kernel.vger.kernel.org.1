Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB542EE881
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 23:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbhAGWZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 17:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728417AbhAGWZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 17:25:33 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BE0C0612F8
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 14:25:18 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id o10so7442891lfl.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 14:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xVA8EX3Ya3VLCzTYD/3HJV6vu9wnB8Ksxcppehb8wkg=;
        b=aLBwEkrzH2dog7skXswOuCmN1wVRMYhtQrVhh0cQ18YIv5bYB9fwSP2jkbCjq16RT+
         7ZkrMMH8a+h9i/8LFGi5/v1m3OdFSKYDZaVpFHUGE7g/N7Bt360Bkv1ZfSzJUBd7uOu+
         izF6/BGaqMIJpf7bImRHw95nrI9Iwi165eJuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xVA8EX3Ya3VLCzTYD/3HJV6vu9wnB8Ksxcppehb8wkg=;
        b=oqf/bHLIYXmo38jn2ryEVhW29L0O6CN28BzNFLyzZfyBwuMzcuxI5UT3q+hUwIgBuW
         gc6KX+ngsPSpXhgoJ6g06pCqu7WTX2VO7cP65lQD+5r4M63sdU83JGSfEjluPY2nVRnl
         buneVoOBF6MkXmXrNrJi+eMee2Nf7rrftq1YDm+GDc40nPBCRU/zIxLks9pn5SHKwd5L
         aqbVn4gngJ6d8UjJRxygB+JTWxBqqMXMDvwjFv+HfYVVT7Evq1S9mw8uI2w3vHNpWeQx
         AwRNaYDmssNf5kkmdXT9lIUX/iieV0jxsJCYe+DQ2ATqCgbCKcvKAGLMBz9TPol4kRQl
         SjWw==
X-Gm-Message-State: AOAM530JATiOlIid9Z/7DEvNjBLbU+SJw7r+//YKJiJERJsplv6DnQBi
        3HSMq52n2u7EbgJnvS0fd6CnKvMOLXjCsw==
X-Google-Smtp-Source: ABdhPJxWynGQHaP/GRE8TbOBO/qxWaWiJOr653gLSZwC0iDzXb+4O6RCMUQKRy8ZYBPyWJ4Y4cTKHw==
X-Received: by 2002:a19:5050:: with SMTP id z16mr358665lfj.48.1610058316638;
        Thu, 07 Jan 2021 14:25:16 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id 84sm1442275lfd.131.2021.01.07.14.25.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 14:25:15 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id s26so18309282lfc.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 14:25:15 -0800 (PST)
X-Received: by 2002:a19:7d85:: with SMTP id y127mr381008lfc.253.1610058315292;
 Thu, 07 Jan 2021 14:25:15 -0800 (PST)
MIME-Version: 1.0
References: <B1B85771-B211-4FCC-AEEF-BDFD37332C25@vmware.com>
 <20210107200402.31095-1-aarcange@redhat.com> <20210107200402.31095-3-aarcange@redhat.com>
 <CAHk-=whg-91=EF=8=ayyDQGx_3iuWKp3aHUkDCDkgUb15Yh8AQ@mail.gmail.com>
 <X/d2DyLfXZmBIreY@redhat.com> <CAHk-=wjs9v-hp_7HV_TrTmisu7pNX=MwZ62ZV82i0evLhPwS1Q@mail.gmail.com>
 <4100a6f5-ab0b-f7e5-962f-ea1dbcb1e47e@nvidia.com> <CAHk-=wjde11Wz+GiVeuttdAPaNBrNydkvUcVm3xBmVWjwA-kNQ@mail.gmail.com>
 <394e17bc-8bed-4d17-5dba-9ab8052c8bea@nvidia.com> <CAHk-=wi691+mXC4NCXZ_f1+kf_YAB9WBM-LqhrX8=eSmYM=WFw@mail.gmail.com>
In-Reply-To: <CAHk-=wi691+mXC4NCXZ_f1+kf_YAB9WBM-LqhrX8=eSmYM=WFw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 7 Jan 2021 14:24:59 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgDhSzz56=us=X2PXHh2XfvcYc76PkarZYNnVaUG=iSmw@mail.gmail.com>
Message-ID: <CAHk-=wgDhSzz56=us=X2PXHh2XfvcYc76PkarZYNnVaUG=iSmw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: soft_dirty: userfaultfd: introduce wrprotect_tlb_flush_pending
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
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
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 7, 2021 at 2:20 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Hmm, add a check for the page being PageAnon(), perhaps?
>
> If it's a shared vma, then the page can be pinned shared with multiple
> mappings, I agree.

Or check the vma directly for whether it's a COW vma. That's probably
a more obvious test, but would have to be done outside of
page_maybe_dma_pinned().

For example, in copy_present_page(), we've already done that COW-vma
test, so if we want to strengthen just _that_ test, then it would be
sufficient to just add a

        /* This cannot be a pinned page if it has more than one mapping */
        if (page_mappings(page) != 1)
                return 1;

to copy_present_page() along with the existing page_maybe_dma_pinned() test.

No?

            Linus
