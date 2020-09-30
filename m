Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 756AA27E8AC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 14:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729935AbgI3Mgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 08:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbgI3Mgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 08:36:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D47C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 05:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6tFTYb3Wzz6b6nVEOaTY19MAg+Ujicir9pWVpfj4BXw=; b=uAafF/ovoRVJBuCHGMjnocW1uJ
        o9ScRK+acOA2IP5Ei8tkYbSZhzXEatgM6hiwLSRffLgVhrpklA51kFiaLT1Str5aocPUOOe74mSUt
        aSW+79AUAFsfbkzUj7WNyhOtB0CMNXFEF1HDgf3/x5mSN1Yibb1Sj6KIVceCqC4Y4ZmjrX7aAqq9u
        8sEqCJOvS8nLL34fF6FOcJvatgoF2FKOAnSxok/rCXpbAbWHlagIquRxiyBVZie3aulQnB6V3cvFm
        Wiw6Xtw0yyqfBtWKgjNwB6wmFADTJ8/SEXrG13LfTcCby0UCAUOft//ENpTiqepH1D1jMztURvIMX
        0tZ5NY6A==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kNbLZ-0002y9-3K; Wed, 30 Sep 2020 12:36:37 +0000
Date:   Wed, 30 Sep 2020 13:36:37 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/12] mm/filemap: Return only head pages from
 find_get_entries
Message-ID: <20200930123637.GP20115@casper.infradead.org>
References: <20200914130042.11442-1-willy@infradead.org>
 <20200914130042.11442-13-willy@infradead.org>
 <20200930121512.GT10896@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930121512.GT10896@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 02:15:12PM +0200, Jan Kara wrote:
> On Mon 14-09-20 14:00:42, Matthew Wilcox (Oracle) wrote:
> > All callers now expect head (and base) pages, and can handle multiple
> > head pages in a single batch, so make find_get_entries() behave that way.
> > Also take the opportunity to make it use the pagevec infrastructure
> > instead of open-coding how pvecs behave.  This has the side-effect of
> > being able to append to a pagevec with existing contents, although we
> > don't make use of that functionality anywhere yet.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> Looks good to me. You can add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> I'm just curious: What has happened to pagevec_lookup_entries() call in
> invalidate_inode_pages2_range()? Your series appears to be based on a tree
> where the call already does not exist...

That went away in patch 10 of this series.
