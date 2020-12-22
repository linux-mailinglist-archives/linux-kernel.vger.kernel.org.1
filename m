Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9EF2E0F77
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 21:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbgLVUkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 15:40:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbgLVUkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 15:40:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D45C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 12:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=tQUpm8etH6snW7WfiSHzS0QYahDTXLO8tTkPD0yqoA8=; b=RpxeFr5fCcqPuMAQnJ1AEpis3c
        Uo7BAVoGmBcllP1SzDaJt6IpQzBa50AB2BJUy/57FHoKe40nvWd7Eiez9vC08NqKSGVysAlUjQqeA
        PWZ3ZDu/VmIgOH1UfqcyvulBLhOFFz8mrjEK/yn7zfNazRKBHI5wCSAUUKkUl5OuUu97mUWfY+/XM
        lTuZpDKvGHcStdHGo+Goe2aZOn6MVKbo5QGPJ3JYMPlBZAblLMy2ueCEiKmuPs8yKlSAsAW/Owfta
        NTBwAESFvYGFnah3R0YUCYJ7FZcQyHsxLjEcGk74T5ildogQJqXdJ2nT6pcHCqfMJSLJyoB4PkzNM
        0GjR/e4A==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kroRs-0004Sj-Bf; Tue, 22 Dec 2020 20:40:00 +0000
Date:   Tue, 22 Dec 2020 20:40:00 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Alex Shi <alex.shi@linux.alibaba.com>
Subject: Re: [PATCH] mm: add prototype for __add_to_page_cache_locked()
Message-ID: <20201222204000.GN874@casper.infradead.org>
References: <1608646792-29073-1-git-send-email-jrdr.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1608646792-29073-1-git-send-email-jrdr.linux@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 22, 2020 at 07:49:52PM +0530, Souptick Joarder wrote:
> Otherwise it cause gcc warning:
>           ^~~~~~~~~~~~~~~

That line is just confusing.

> ../mm/filemap.c:830:14: warning: no previous prototype for
> ‘__add_to_page_cache_locked’ [-Wmissing-prototypes]
>  noinline int __add_to_page_cache_locked(struct page *page,
>               ^~~~~~~~~~~~~~~~~~~~~~~~~~

And I don't think those two lines add much value, do you?

> A previous attempt to make this function static leads to
> compile error for few architectures.

It might be better to say why it has to be non-static here (because it's
an error injection point).  And it's not architecture dependent (afaik),
it's whether error injection is enabled in the config.

> Adding a prototype will silence the warning.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Cc: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  include/linux/mm.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 5299b90a..ac07f65 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -216,6 +216,12 @@ int overcommit_kbytes_handler(struct ctl_table *, int, void *, size_t *,
>  		loff_t *);
>  int overcommit_policy_handler(struct ctl_table *, int, void *, size_t *,
>  		loff_t *);
> +/*
> + * Any attempt to mark this function as static leads to build failure
> + * for few architectures. Adding a prototype to silence gcc warning.
> + */

We don't need a comment here for this.  The commit log is enough.

> +int __add_to_page_cache_locked(struct page *page, struct address_space *mapping,
> +		pgoff_t offset, gfp_t gfp, void **shadowp);

Please name that 'index', not 'offset'.

