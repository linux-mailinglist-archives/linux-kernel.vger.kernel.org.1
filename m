Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFF6269A58
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 02:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgIOAT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 20:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbgIOATX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 20:19:23 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0A1C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 17:19:22 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id k25so1257856ljk.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 17:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NZ/X7Z1ojnGM1c/SapOK8GvcEU91nHo1ce5yJcGFuqE=;
        b=C1z9mpPdVuT7rcGZrLZVAaF2cq1LYNf/HFVhxP5utJEBX3TwILpnb8fWI3/bprzx9B
         a8Ku50zNIR/rB9Pym36a4xwgWcV9TuJAxI9292KLBbdvcFjc5bI95VjT+gjB3G8nSOOV
         lW4/QVnW97B9Kh8PAFpB06DAaPV3Tb0L/8nr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NZ/X7Z1ojnGM1c/SapOK8GvcEU91nHo1ce5yJcGFuqE=;
        b=QmI/szudHYFU9/LmtlMBfVPgsqz1NTtIek60I6TZaobIbkGK3J6bVQHC9DyYyFE2Hx
         /7px3ohgs5mEeIiwK7I5QD4axJ98JDvj/yKaZa827Ti0ORxbwpXpClrTGbDdhGfiDxxM
         qh0YYutDLmF1iStrIKNp6kWZnBN+B5BM9asW6AD+7XojAM9bAhD5F2v7cLxlGvMfzoU+
         ZLoOioM5H9vSLW1ZyK+2BmaednqatwVDS3fgKBXMncgHZPpnflQVWuRqk7Zf3xcFFngX
         Eu/DF5KrMKad8hGqLPSSFtOUo3XyQ9mfz+cIBsZZ/CENiKGB5eqwBy9zhneBOFHfhoqB
         VfTA==
X-Gm-Message-State: AOAM533meT01e/6RIiBD3JjuF+e2kK7xnqSQUzXIlsHe30kB2hnPYkIU
        BVNQG/VUKm+kv2G4S8FGjjBw93wZqMpj8w==
X-Google-Smtp-Source: ABdhPJy3To2SReTmwfpmG+C8/fIDo4Z8qgrylFXPn3GKm1EmBL03JqjUt5qQ1ig4/F53Xai8uDdbwQ==
X-Received: by 2002:a2e:99c4:: with SMTP id l4mr6320695ljj.428.1600129160668;
        Mon, 14 Sep 2020 17:19:20 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id k205sm3954309lfk.19.2020.09.14.17.19.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 17:19:19 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id a15so1242491ljk.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 17:19:18 -0700 (PDT)
X-Received: by 2002:a2e:84d6:: with SMTP id q22mr5387477ljh.70.1600129158238;
 Mon, 14 Sep 2020 17:19:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200821234958.7896-1-peterx@redhat.com> <20200821234958.7896-2-peterx@redhat.com>
 <20200914143829.GA1424636@nvidia.com> <CAHk-=wj1EDd3dUGz_992_oRqvsy3LGDvxvyQBvutLhBqkYqgcQ@mail.gmail.com>
 <20200914183436.GD30881@xz-x1> <20200914211515.GA5901@xz-x1>
 <20200914225542.GO904879@nvidia.com> <CAHk-=wgdn5sJ0UEVZRQvj6r5kqOkU24jA_V6cPkqb9tqoAKBJg@mail.gmail.com>
 <20200914232851.GH1221970@ziepe.ca>
In-Reply-To: <20200914232851.GH1221970@ziepe.ca>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 14 Sep 2020 17:19:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh8-FpGdVRYoOvcfuL_YyB5oF2A9qyzpyxbAU4HnAqXeg@mail.gmail.com>
Message-ID: <CAHk-=wh8-FpGdVRYoOvcfuL_YyB5oF2A9qyzpyxbAU4HnAqXeg@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm: Trial do_wp_page() simplification
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Peter Xu <peterx@redhat.com>, Leon Romanovsky <leonro@nvidia.com>,
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 4:28 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> Hmm. If symptoms stop with this patch should we investigate
> MADV_DONTFORK?

I took a quick look at it, and it all looks trivially correct.

All MADV_DONTFORK does is to set the VM_DONTCOPY flag in the vma.

And dup_mmap() in kernel/fork.c is very trivial, and does

                if (mpnt->vm_flags & VM_DONTCOPY) {
                        vm_stat_account(mm, mpnt->vm_flags, -vma_pages(mpnt));
                        continue;
                }

for a vma that has that VM_DONTCOPY flag.

So I don't think it's MADV_DONTFORK, and in fact if that _had_ been
broken, then the old "look at page_mapcount()" would have shown the
problem too, since by definition a fork() would have increased that
count.

That said, the thing Hugh worried about was random other VM-internal
reasons why the page flags end up being elevated, that aren't due to
these things. And he's right. The new aggressive COW by that
do_wp_page() simplification will basically COW for any random thing.

My argument to Hugh was that if the page has become private to a
single mapping, even if it has its count elevated it should all simply
be writable, ie it shouldn't have gotten the paeg fault that causes
the COW in the first place. IOW, my thinking was that any proper page
pinning will also have to make sure that the page is already writable
and dirty, so no amount of other page counts should even matter.

But that argument may be entirely bogus, because I didn't think of
case "insert random case here".

My original force-COW patch for GUP avoided this issue, exactly
because it basically said that a GUP is a write - so it didn't care
about whatever state the page had, it *forced* the page to be mapped
dirty and writable in the target.

But part of the argument for the do_wp_page() simplification thing was
that it allowed us to remove my force-COW thing.

Is there perhaps some easy test-case that shows this that doesn't
require any actual rdma hardware?

                  Linus
