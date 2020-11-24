Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D53FB2C24F8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 12:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733059AbgKXLvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 06:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733039AbgKXLvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 06:51:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7645CC0613D6;
        Tue, 24 Nov 2020 03:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5kw0QxLQoOgDyVGj4iKmiuA5NMWKFQFej/HFL8JZlH4=; b=hKJIBhFP4aGspoOz/5N86hxScK
        ucjZLQ76V2OlRxEZD9uHaySwMEhir8SlIqu34afox2tfguAdfYYjQMenNlaBOoddmuvmXH20p60kN
        jXXCfLO4YjJY9EN7nosXyN5sAs5lOr+7iQCfScnN+L3+bXkh7HFSI7+bvhKtjhxNDtFXbyVjkHyHf
        1b+nkIcom9n2+t67POw/+ph54B8edFfXKBD76y6n7tAqipRCRWlxC+HHgSZkHrXHfEJ8GKQvQ5sUM
        sGfcGhnoEX+0d3NS66+3gdoG7szLA0ZcuPp5y9UmVyqBb/tylyIE+PEtHSEHY0/VkY5I0PQ5JMm9W
        BK63/xPw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khWqY-0000NM-3G; Tue, 24 Nov 2020 11:50:58 +0000
Date:   Tue, 24 Nov 2020 11:50:58 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Jann Horn <jannh@google.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Tom Rix <trix@redhat.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        kernel-janitors@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] zlib: define get_unaligned16() only when used
Message-ID: <20201124115058.GA32060@infradead.org>
References: <20201124104030.903-1-lukas.bulwahn@gmail.com>
 <CAG48ez1FqJYay1F=LUt84DVHd+k0=gXohwhTnwv=t1sv=hTSjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez1FqJYay1F=LUt84DVHd+k0=gXohwhTnwv=t1sv=hTSjw@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 12:08:40PM +0100, Jann Horn wrote:
> > Since commit acaab7335bd6 ("lib/zlib: remove outdated and incorrect
> > pre-increment optimization"), get_unaligned16() is only used when
> > !CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS.
> >
> > Hence, make CC=clang W=1 warns:
> >
> >   lib/zlib_inflate/inffast.c:20:1:
> >     warning: unused function 'get_unaligned16' [-Wunused-function]
> >
> > Define get_unaligned16() only when it is actually used.
> >
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> 
> AFAICS a nicer option would be to "#include <asm/unaligned.h>" and
> then use "get_unaligned", which should automatically do the right
> thing everywhere and remove the need for defining get_unaligned16()
> and checking CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS entirely?

Yes, that is the right thing to do.
