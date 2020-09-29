Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2D8A27D5EB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 20:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbgI2ShE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 14:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728341AbgI2ShD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 14:37:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93EE4C061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 11:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=K+ua4ilxGZY+R7uCpvZH1pW8+jQPHb2dEUKGY/Z2ut4=; b=OpJfVjna6FTnFwvjsJf91qM8om
        Fg9/rlI59FkU1b8pXl6Pnu+PufkAHaDE2HPEsJ2WxXgZ1+0cS0ESw+huZVlaFHuipdGaOoXV7HbmV
        MNtg49FiPrfZSDv8pOtQ9Dn9Mxt/n4DWgSlRaLWp32jSjJpAVixjQD+8YiBogTnGB1VV82PtRIt89
        sFuAmSNkomv8NSH6P+NZbjq74WAAPxgM5b0CP5kQnCEu9Krq2YunC5pW7+c86Cvu6/gJas1MM7KVF
        gNc7w7WvDUvYwuKpQaOiOWd0QfLDtNnO4e/fJE9UB/iGf5xFZazg7XjVHDXIr1uljx4I+MiZJYsCO
        uNSDus8g==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kNKUc-0003aM-BC; Tue, 29 Sep 2020 18:36:50 +0000
Date:   Tue, 29 Sep 2020 19:36:50 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/12] mm/shmem: Use pagevec_lookup in
 shmem_unlock_mapping
Message-ID: <20200929183650.GJ20115@casper.infradead.org>
References: <20200914130042.11442-1-willy@infradead.org>
 <20200914130042.11442-3-willy@infradead.org>
 <20200929082828.GB10896@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929082828.GB10896@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 10:28:28AM +0200, Jan Kara wrote:
> On Mon 14-09-20 14:00:32, Matthew Wilcox (Oracle) wrote:
> > The comment shows that the reason for using find_get_entries() is now
> > stale; find_get_pages() will not return 0 if it hits a consecutive run
> > of swap entries, and I don't believe it has since 2011.  pagevec_lookup()
> > is a simpler function to use than find_get_pages(), so use it instead.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> Looks good to me. BTW, I think I've already reviewed this... You can add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

So you did!  My apologies for missing that.
