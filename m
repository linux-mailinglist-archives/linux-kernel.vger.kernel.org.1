Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10BB12E2F3B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Dec 2020 22:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgLZVnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Dec 2020 16:43:24 -0500
Received: from casper.infradead.org ([90.155.50.34]:32964 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbgLZVnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Dec 2020 16:43:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4olHbSDjwG6n/OG9RW7BnLDOSD34WqpyWEqi+69B4eE=; b=YCjWq3kWsb8g53CSpAlmT2oaBJ
        nC3GR3LqUiN58lfPazvooKGIqeZw+N8fT/SjFreJtYzhNVnSPkwxr9kry2bsF/o3CmwIWm8bQkX7E
        HPXqNppGbGwdHXE4ceNhseY+eTumJa1pasQp7UjZSKq9L7h0sz6yNdUGIiCyreO5zIFaEIpU6gTiU
        F7YxNhV07CE+NOUky2TE+Bh3MnSQOdMcGM5cYsrLQeI+dDk1uU2iQFPcW8mpioX4hQ+Wgx17rwb+7
        1bCLlHh6ZB19a58yalcvBYWRf7CLrHts52+R64fkG2HsCaud6HSHMSy7QjTkKB4PZtZQXk/JNpqZk
        JoseuZDw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ktHJC-0001eD-Cl; Sat, 26 Dec 2020 21:41:17 +0000
Date:   Sat, 26 Dec 2020 21:41:06 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH 1/2] mm: Allow architectures to request 'old' entries
 when prefaulting
Message-ID: <20201226214106.GA5479@casper.infradead.org>
References: <CAHk-=wiyPTnQ9E1dT9LJtNxeVmLaykursk_MSecUqFjSb3gwAw@mail.gmail.com>
 <20201218110400.yve45r3zsv7qgfa3@box>
 <CAHk-=wgO2LsoKhX7MjSECo+Xrj1-Me7tzRfNcsdEZBRwJW1cQg@mail.gmail.com>
 <20201219124103.w6isern3ywc7xbur@box>
 <CAHk-=wifcVaxaTn_RbZ=idfYFazTPwm8t5cB1rY6xEBjbcfO5g@mail.gmail.com>
 <20201222100047.p5zdb4ghagncq2oe@box>
 <alpine.LSU.2.11.2012231905300.5723@eggly.anvils>
 <20201225113157.e7hmluffh56fszfc@box>
 <CAHk-=wiT50aEErZgZOrbFQ=GhFuM3MnBmHoSBSScN9rmXMnOKQ@mail.gmail.com>
 <20201226204335.dikqkrkezqet6oqf@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201226204335.dikqkrkezqet6oqf@box>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 26, 2020 at 11:43:35PM +0300, Kirill A. Shutemov wrote:
> +static struct page *next_stable_page(struct page *page, struct vm_fault *vmf,
> +				     struct xa_state *xas, pgoff_t end_pgoff)

A "stable page" means one that doesn't currently have an outstanding
write (see wait_for_stable_page()).  It's really "Next trivially
insertable page".  I might call it "next_uptodate_page()" and gloss
over the other reasons this might fail to return a page.

