Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15CEC2889B8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 15:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388421AbgJIN1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 09:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728317AbgJIN1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 09:27:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AEE7C0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 06:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tsezONzJMfkFX30+r+1t4DO2YlfenS+R1OBhP8jUdUY=; b=AEYovlRcHdYEmLvcxLmsViEwsK
        nKoePB6eopAL0DojvUsx94E683xebkX5h2Bmxop+w+oDYK+uh+OTa3M6A9mKpq1cr4YDefZKCCb4o
        AB80rGgrO142Y82BKLzybAHnnAxEK/q5hGHlAAm/rD5OjatOOJ0gJbxWxEuGJbO+4P31OIXbhT/ey
        /nchtyYT5BWOHx1ziy97Igd8tjvi0GHA6CqBk2ihImtKDvRbGLOwgn2s+OszweuxumxOkB3pQtbOn
        EB9TjlU9l4rh9EGpJUFHVOmZVMrGgPleeQVbYeoN0V6q6KpRv/8HtJGrZZmIMOfH9GYTwF63TEJ9s
        zGtEMmCQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQsQK-00027j-7w; Fri, 09 Oct 2020 13:27:04 +0000
Date:   Fri, 9 Oct 2020 14:27:04 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Rafael Aquini <aquini@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH] mm: Fix a race during split THP
Message-ID: <20201009132704.GS20115@casper.infradead.org>
References: <20201009073647.1531083-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009073647.1531083-1-ying.huang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 09, 2020 at 03:36:47PM +0800, Huang, Ying wrote:
> +	if (PageSwapCache(head)) {
> +		swp_entry_t entry = { .val = page_private(head) };
> +
> +		split_swap_cluster(entry);
> +	}
...
> -		if (PageSwapCache(head)) {
> -			swp_entry_t entry = { .val = page_private(head) };
> -
> -			ret = split_swap_cluster(entry);

Are we sure split_swap_cluster() can't fail?  Or if it does fail, it's
OK to continue with the split and not report the error?
