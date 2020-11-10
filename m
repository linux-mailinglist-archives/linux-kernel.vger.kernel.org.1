Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63AA22AE015
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 20:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730542AbgKJTuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 14:50:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:38180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbgKJTuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 14:50:39 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE66E206B6;
        Tue, 10 Nov 2020 19:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605037838;
        bh=mRi18aUbpZTnjTjgUWsVLKGyzEbgOtyXxgU2zSLUAgg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AQUw2JPSs7pvi6d1s9zJvtKDAW393r6WnAA88ULaAfy5/A3n3o9vJyx7F51DMgz6q
         qWeNZq8TDRIvitIK/UbeFzQUZgu8PgCQ2SVLYJdNa2KmEi4LspoWOB90fjWLVNucdF
         Xw3tJjLJEl2gtwYzFP2RMBgdoxQ469C4rFUeB6hg=
Date:   Tue, 10 Nov 2020 11:50:37 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH] mm/filemap: add static for function
 __add_to_page_cache_locked
Message-Id: <20201110115037.f6a53faec8d65782ab65d8b4@linux-foundation.org>
In-Reply-To: <CAFqt6zZU76NOF6uD_c1vRPmEHwOzLp9wEWAmSX2ficpQb0zf6g@mail.gmail.com>
References: <1604661895-5495-1-git-send-email-alex.shi@linux.alibaba.com>
        <CAFqt6zZU76NOF6uD_c1vRPmEHwOzLp9wEWAmSX2ficpQb0zf6g@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Nov 2020 08:39:24 +0530 Souptick Joarder <jrdr.linux@gmail.com> wrote:

> On Fri, Nov 6, 2020 at 4:55 PM Alex Shi <alex.shi@linux.alibaba.com> wrote:
> >
> > Otherwise it cause gcc warning:
> >           ^~~~~~~~~~~~~~~
> > ../mm/filemap.c:830:14: warning: no previous prototype for
> > ‘__add_to_page_cache_locked’ [-Wmissing-prototypes]
> >  noinline int __add_to_page_cache_locked(struct page *page,
> >               ^~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Is CONFIG_DEBUG_INFO_BTF enabled in your .config ?

hm, yes.

> >
> > Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: linux-mm@kvack.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  mm/filemap.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/filemap.c b/mm/filemap.c
> > index d90614f501da..249cf489f5df 100644
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -827,7 +827,7 @@ int replace_page_cache_page(struct page *old, struct page *new, gfp_t gfp_mask)
> >  }
> >  EXPORT_SYMBOL_GPL(replace_page_cache_page);
> >
> > -noinline int __add_to_page_cache_locked(struct page *page,
> > +static noinline int __add_to_page_cache_locked(struct page *page,
> >                                         struct address_space *mapping,
> >                                         pgoff_t offset, gfp_t gfp,
> >                                         void **shadowp)

It's unclear to me whether BTF_ID() requires that the target symbol be
non-static.  It doesn't actually reference the symbol:

#define BTF_ID(prefix, name) \
        __BTF_ID(__ID(__BTF_ID__##prefix##__##name##__))

Alexei, can you please comment?
