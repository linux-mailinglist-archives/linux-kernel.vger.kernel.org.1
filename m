Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 923652E7A90
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 16:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgL3PpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 10:45:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbgL3PpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 10:45:00 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F70CC061799
        for <linux-kernel@vger.kernel.org>; Wed, 30 Dec 2020 07:44:19 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id h16so15747510edt.7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Dec 2020 07:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5hBnQDw081gPYRJZ5sSOQpvtWrIndiY9aAJP6hoGoCI=;
        b=jF9zBs3u6j4Qo5O+462fi/y8Z3H2Rg/kS494qsVJ1AZwXnP4CZKBWtNfWVC4M+XY2L
         a4QSfGMk/T0BX8WKgAXjGmwlhjMR7jUfuM2MJMUhMMzVoz9BLvH3vgISA3wl+9ipOCg7
         0Qetw+q4d2hE88fpkR4idIMOjFu7r0tivYhG8TVkhRtIgbM86B8C7RpW5EP6KPEYDHtC
         vItSy1oO9aljOyRk1izLO06eG2w4wHJ+0sSw2J77SK31m7y6YeOFi1L64eSfXn/5DXnp
         hbTTEwqrK98bNoVh9B93pHxvRkTOtAv++3QeaGy3wk9I8XYNKJVnZC34WbIzngDe6Wgn
         Is7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5hBnQDw081gPYRJZ5sSOQpvtWrIndiY9aAJP6hoGoCI=;
        b=ePPDZjqUO2nF2h/1GU3Z1l8Xbu9Okx4bkhmVt2BhiXEMJ/yqhIrLpGejRymUv87/MF
         YzFyc86PoxABJvTpj/ntQUm/JEhHyeBwSYssHstlDNvSRyHCcPQbtFWqVdBmom/R+hS3
         ZslRUhP16Dommgcb2AeI8ZNWviyjzrixMhSpMitI1td6h0AzDj+k5fLsf4zdqRDPlqe6
         SwnmWgkNhnAOA4vhCkApDwz04XDcATLwNi5FZji6qgBXdUKkqPxWq+3dbkfR5GrQll0t
         21ACTzA2oQp25pd4vFYEByTFQYtvlxdVp8bpRxxAzLPPLtqhhWTqcnqUJzqQUs7hd7YU
         w7nw==
X-Gm-Message-State: AOAM532X4NvVpq2OqoLg9tHwQANT41bXMI4STuZHAKLPgEZpnzQVuRIK
        ydPvsXcY9pbmpOGCOqSVeRvpaXg+sLf7WBH83BmVKzKBu9Y=
X-Google-Smtp-Source: ABdhPJzdhrxVcS8QaW5SwjUUsVlQzNcZNKy+323jJeGcsyxbQ7R92UwEPNUX1N2RLnmmTIXQIt78Z+E0q7QwZmHhaZE=
X-Received: by 2002:a50:b5c5:: with SMTP id a63mr50773533ede.227.1609343058152;
 Wed, 30 Dec 2020 07:44:18 -0800 (PST)
MIME-Version: 1.0
References: <20201013013416.390574-1-dima@arista.com> <20201013013416.390574-3-dima@arista.com>
 <CADyq12y4WAjT7O3_4E3FmBv4dr5fY6utQZod1UN0Xv8PhOAnQA@mail.gmail.com> <d25ad10c-6f67-8c11-18c3-0193b8ea14c4@arista.com>
In-Reply-To: <d25ad10c-6f67-8c11-18c3-0193b8ea14c4@arista.com>
From:   Brian Geffon <bgeffon@google.com>
Date:   Wed, 30 Dec 2020 07:43:42 -0800
Message-ID: <CADyq12w0+ZA6nwJOtJJ-66vHuq4aWwQw22NOUymz7KQa9DXqHQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] mm/mremap: For MREMAP_DONTUNMAP check security_vm_enough_memory_mm()
To:     Dmitry Safonov <dima@arista.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Minchan Kim <minchan@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ah, you're right. This individual patch looks good to me.

Brian

On Mon, Dec 28, 2020 at 11:12 AM Dmitry Safonov <dima@arista.com> wrote:
>
> On 12/28/20 6:21 PM, Brian Geffon wrote:
> > This looks good to me with a small comment.
> >
> >>         if (do_munmap(mm, old_addr, old_len, uf_unmap) < 0) {
> >>                 /* OOM: unable to split vma, just get accounts right */
> >> -               if (vm_flags & VM_ACCOUNT)
> >> +               if (vm_flags & VM_ACCOUNT && !(flags & MREMAP_DONTUNMAP))
> >>                         vm_acct_memory(new_len >> PAGE_SHIFT);
> >
> > Checking MREMAP_DONTUNMAP in the do_munmap path is unnecessary as
> > MREMAP_DONTUNMAP will have already returned by this point.
>
> In this code it is also used as err-path. In case move_page_tables()
> fails to move all page tables or .mremap() callback fails, the new VMA
> is unmapped.
>
> IOW, MREMAP_DONTUNMAP returns under:
> :       if (unlikely(!err && (flags & MREMAP_DONTUNMAP))) {
>
> --
>           Dima
