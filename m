Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A918227CF77
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 15:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730311AbgI2NjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 09:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729958AbgI2NjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 09:39:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20AD3C0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JVdM3afc/YXIjdB8I/oCcRIHSX+4wscc850PEE+wd4k=; b=Rs6r/RNxuUjCouIoyH1LgIFHig
        ZTsO/l01bEIOP/met2gMeh1XazUKKhGCBp+i68Dkbp7Ly9EChLkEQSuchYSoJrYUQQIjdRWJqPQ6l
        ZXsLtL9t5Bm96uttlO7747k2sz47KKux/V+2BjsvOGk7kXw3J6vBab1uwPhMufU90Dy6f9IaFQiBV
        7nHPha5AX4B9vUKBvMY88fyAm1zzjbSNlRZBt45AVxJ/WBqpYAhV2AadCHo1r2aHTWJtoydUVOdd9
        vfmHZpNf8857K3QZ+SW5hXeM7WmYdJ3X/P/+ljwT1SOzDQs4utR2GQt/1G9fkT5pDp+rrM4oOrXFh
        XgpoCeJQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kNFqY-0001ow-7D; Tue, 29 Sep 2020 13:39:10 +0000
Date:   Tue, 29 Sep 2020 14:39:10 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/12] mm/filemap: Add mapping_seek_hole_data
Message-ID: <20200929133910.GD20115@casper.infradead.org>
References: <20200914130042.11442-1-willy@infradead.org>
 <20200914130042.11442-5-willy@infradead.org>
 <20200929084653.GC10896@quack2.suse.cz>
 <20200929124251.GB20115@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929124251.GB20115@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 01:42:51PM +0100, Matthew Wilcox wrote:
> On Tue, Sep 29, 2020 at 10:46:53AM +0200, Jan Kara wrote:
> > Also for shmem you've dropped the PageUptodate check which I'm not sure is
> > safe?
> 
> That was unintentional.  I did run xfstests against this patch (just did
> it again ... it passes), so I suspect it doesn't create a !Uptodate page.
> I'll see if I can enhance the existing xfstests to catch this case.

Ah.  Diff'ing the output between before and after ...

-Test skipped as fs doesn't support unwritten extents.
+07.01 SEEK_HOLE expected 0 or 45056, got 0.                       succ
+07.02 SEEK_HOLE expected 1 or 45056, got 1.                       succ
+07.03 SEEK_DATA expected 40960 or 40960, got 40960.               succ
+07.04 SEEK_DATA expected 40960 or 40960, got 40960.               succ

so, er, the tests didn't report that I'd broken it because it was just an
automatically skipped test.  Not sure what to do about that; obviously
we should skip tests that aren't applicable, but it'd be nice to see a
warning that tmpfs used to support this and now doesn't.

