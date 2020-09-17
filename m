Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAF5126E386
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 20:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgIQS2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 14:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbgIQS00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 14:26:26 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2521C061788
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 11:26:21 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id u8so3272356lff.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 11:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+mpoyqx3mxsDyuRiiNHu6NufBQVIYLoY1L/3VBEofe4=;
        b=hCD7+WAuUU01eFe1Jc50npe5xb7OtkBBbWJ6mCXZrO2bBS8k+KZahRQRDycsdra938
         OOiI10P4yId0P07N+qEKZ1H2LSRKMnm9Sc41SuHORgPw8g2eGGXHHduC/t8zGy7bZeIC
         H1noIOp7B5z/HdZvYg7VUXZeGcTMvgZdLaxfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+mpoyqx3mxsDyuRiiNHu6NufBQVIYLoY1L/3VBEofe4=;
        b=ppj1logINkICvmARYWBkhrka1v4+0j/RqNNNju1yVTTyW0J95VvpGv5WIfuLGFQSv1
         SKOESP0nMx4x38FnVPJLDJf73dvxhnrCrBURmWxQ5RvXX0cWuIvQXhSguj3K1kj6CSHb
         lzy2ewGQYNKzCdErJQZyGulmKX2fwzcwmubJFY84K1UruwRngPPifZ6GpDhpFecKHIul
         FYMF592+kMqbym8x0lfc9t0VEzgHriDZtCsFV8m0hs9RBrvg4yVrAwgj2eOICHxHcsry
         xv7BnI9txe1KfPR8GYKnNuS34ANzXZ0vLttI5L4og4OUSZEXgJ+nfyUImoe2Ss4NLbHg
         tvmw==
X-Gm-Message-State: AOAM530YMRgJYt8FIEGwFwUqVR72MXn9MnKlt0GfIST68NaCNnmpt0Ib
        iOzUCGVFNW60OZj2ptXLiMPpvSy2VWh78g==
X-Google-Smtp-Source: ABdhPJxs7KYZ9WG6U7GCdjvzHdwEJ93xjr6uITeOAPjB6/ZR+SSvnBMrOasc3AtFD5f258bsU5sibA==
X-Received: by 2002:a19:c6d3:: with SMTP id w202mr9167035lff.433.1600367179901;
        Thu, 17 Sep 2020 11:26:19 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id e17sm71140ljn.18.2020.09.17.11.26.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2020 11:26:18 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id y11so3258596lfl.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 11:26:18 -0700 (PDT)
X-Received: by 2002:ac2:4ec7:: with SMTP id p7mr8620939lfr.352.1600367177963;
 Thu, 17 Sep 2020 11:26:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200915160553.GJ1221970@ziepe.ca> <20200915182933.GM1221970@ziepe.ca>
 <20200915191346.GD2949@xz-x1> <20200915193838.GN1221970@ziepe.ca>
 <20200915213330.GE2949@xz-x1> <20200915232238.GO1221970@ziepe.ca>
 <e6c352f8-7ee9-0702-10a4-122d2c4422fc@nvidia.com> <20200916174804.GC8409@ziepe.ca>
 <20200916184619.GB40154@xz-x1> <20200917112538.GD8409@ziepe.ca> <20200917181411.GA133226@xz-x1>
In-Reply-To: <20200917181411.GA133226@xz-x1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 17 Sep 2020 11:26:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgMVPAhD7C24ipe03+MScgp6F=zMS-roOznvxJ+hOGfSA@mail.gmail.com>
Message-ID: <CAHk-=wgMVPAhD7C24ipe03+MScgp6F=zMS-roOznvxJ+hOGfSA@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm: Trial do_wp_page() simplification
To:     Peter Xu <peterx@redhat.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Maya B . Gokhale" <gokhale2@llnl.gov>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        Kirill Shutemov <kirill@shutemov.name>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Jan Kara <jack@suse.cz>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 11:14 AM Peter Xu <peterx@redhat.com> wrote:
>
> In my humble opinion, the real solution is still to use MADV_DONTFORK properly
> so we should never share the DMA pages with others when we know the fact.

Is this all just because somebody does a fork() after doing page pinning?

If so, I feel this should be trivially fixed in  copy_one_pte().
That's where we currently do

        /*
         * If it's a COW mapping, write protect it both
         * in the parent and the child
         */
        if (is_cow_mapping(vm_flags) && pte_write(pte)) {
                ptep_set_wrprotect(src_mm, addr, src_pte);
                pte = pte_wrprotect(pte);
        }

and I feel that that is where we could just change the code to do a
COW event for pinned pages (and *not* mark the parent write protected,
since the parent page now isn't a COW page).

Because if that's the case that Jason is hitting, then I feel that
really is the correct fix: make sure that the pinning action is
meaningful.

As mentioned, I really think the whole (and only) point of page
pinning is that it should keep the page locked in the page tables. And
by "locked" I mean exactly that: not just present, but writable.

And then the "we never COW a pinned page" comes not from the COW code
doing magic, but by it simply never becoming non-writable - because
the page table entry is locked!

               Linus
