Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4566028B9F3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 16:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730940AbgJLOFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 10:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390962AbgJLOEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 10:04:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B05C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 07:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=doJFFSyvcU7VbeZKRVxa7jy5QsamSL6RMsp4hiSbnrE=; b=ihpxXwzg28+rsqkLxE+VQ1InB1
        r02IzIY4IMS9Cqb1jN6Iwuw9RLPQSRbfTZ/rPd/LiOErEaXR75r6oYCoYUfUEJueGrT3ikZ8O0Dg+
        ZV21o7IekH2vSOBGZg4Ko2NNP7zdwnumXAwPiLL5r/nbDITHj7EpsNGsLTtf5mE/e1MVzUZZVmVNA
        gCzWvzGhMcvAAYNeTdrGeOH8HAC3mk6iy0X2EgAFCm+/eN9qFgUcwFmILhaMqtVSiyu5XKbGDuzpX
        5mc/mV4cATLKQcUaRmtm7gQPiPGeCwNH+44mg3anRVfCoKGm4EnAFlZhcTVtP541COyY8H7A5Lx2c
        4rhDxOWw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kRyRN-0002rT-Me; Mon, 12 Oct 2020 14:04:42 +0000
Date:   Mon, 12 Oct 2020 15:04:41 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     linmiaohe <linmiaohe@huawei.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Question Resend] About z3fold page migration
Message-ID: <20201012140441.GZ20115@casper.infradead.org>
References: <6d803d0cf27840caa64619949c2c3dd1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d803d0cf27840caa64619949c2c3dd1@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 02:00:17PM +0000, linmiaohe wrote:
> Hi all:
> 
> 	Many thanks for brilliant z3fold code. I am reading it and have some questions about it. It's very nice of you if you can explain it for me.
> 	1.page->private is used in z3fold but PagePrivate flag is never set, should we SetPagePrivate for it?

No.  SetPagePrivate and page->private are related in interesting and
complicated ways.  I'm working on some documentation for it at the moment,
but the short answer is: no.

> 	2.Since PagePrivate flag is never set, why we ClearPagePrivate in free_z3fold_page and z3fold_page_migrate?

That's probably a bug.

> 	3.Should we add page to the unbuddied list in z3fold_page_putback() when zhdr->refcount does not reach 0 since we remove it from unbuddied list
> in z3fold_page_isolate? Or When we will add page to the unbuddied list after z3fold_page_putback?

This one I do not know the answer to.
