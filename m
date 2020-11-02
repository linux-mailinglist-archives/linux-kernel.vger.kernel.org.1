Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 745BA2A2D1B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 15:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgKBOkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 09:40:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgKBOkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 09:40:32 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D25C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 06:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bNVXHRt2j5TVq+P2Oa2ykU3JjLaZgnmCgBfTsAuZWMc=; b=KWKkiOwvAzN2or175mvatzQWqJ
        ipyVU06RQPLkD8FRX8QuJ78U3df7XRmP/Qg7Bccv3ZQ1A1VvR92fcpXtuYjjwGYZvETs9kuLT3lTJ
        fkv0ZMbO4mRYgKoSWkLPqzjh8mGHn9to7ZSuKm5rLfcNMRCT8QRtiWohoyk03cxrLikpm0a1G57pL
        jbRNNPE51Mbtw9s5MZ4PcyJC3iGsTwskMKvqc/JTgMfGIbWFcjeOcBmKaAQ/PlrTBjfkCnqRrW4Lj
        ZLigtPWW2yUrZ71JUw7g0vuDvlWbvDIqtRY6NB50K3TdUjK4rNTmHYhy3+G8GSgjk4eLioBnFqsvK
        0xhZIu6g==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kZb0U-0006yS-2Y; Mon, 02 Nov 2020 14:40:26 +0000
Date:   Mon, 2 Nov 2020 14:40:25 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Joe Perches <joe@perches.com>, Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] mm: shmem: Convert shmem_enabled_show to use
 sysfs_emit_at
Message-ID: <20201102144025.GL27442@casper.infradead.org>
References: <cover.1604261483.git.joe@perches.com>
 <a06810c216a45e5f6f1b9f49fbe2f332ca3c8972.1604261483.git.joe@perches.com>
 <20201101204834.GF27442@casper.infradead.org>
 <616b92af9378e9f9697555074bba1e377450477f.camel@perches.com>
 <20201101211910.GG27442@casper.infradead.org>
 <bc1a4a2a7ff69eeee131744881e1e8c72444be01.camel@perches.com>
 <20201101220604.GI27442@casper.infradead.org>
 <20201102133343.GA1011963@kroah.com>
 <20201102140836.GJ27442@casper.infradead.org>
 <20201102143259.GA1024551@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102143259.GA1024551@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 03:32:59PM +0100, Greg Kroah-Hartman wrote:
> On Mon, Nov 02, 2020 at 02:08:36PM +0000, Matthew Wilcox wrote:
> > On Mon, Nov 02, 2020 at 02:33:43PM +0100, Greg Kroah-Hartman wrote:
> > > > Oh, ugh, sysfs_emit() should be able to work on a buffer that isn't
> > > > page aligned.  Greg, how about this?
> > > 
> > > How can sysfs_emit() be called on a non-page-aligned buffer?  It's being
> > > used on the buffer that was passed to the sysfs call.
> > > 
> > > And if you are writing multiple values to a single sysfs file output,
> > > well, not good...
> > 
> > See shmem_enabled_show() in mm/shmem.c (output at
> > /sys/kernel/mm/transparent_hugepage/shmem_enabled on your machine).
> > 
> > I don't claim it's a good interface, but it exists.
> 
> Ok, that's a common pattern for sysfs files, not that bad.
> 
> What's wrong with using sysfs_emit_at()?  We want sysfs_emit() to "know"
> that the buffer is PAGE_SIZE big, if you try to allow offsets in it,
> that defeats the purpose of the check.

For someone who's used to C "strings", it's pretty common to do
something like:

	buf += sprintf(buf, "foo ");
	buf += sprintf(buf, "bar ");

sysfs_emit_at instead wants me to do:

	len += sprintf(buf + len, "foo ");
	len += sprintf(buf + len, "bar ");

I don't see how the code I wrote defeats the check.  It checks that the
buffer never crosses a PAGE_SIZE boundary, which is equivalently safe.
