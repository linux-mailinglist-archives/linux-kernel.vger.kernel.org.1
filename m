Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC0612DB811
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 02:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgLPBAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 20:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgLPBAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 20:00:09 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F77C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 16:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IJxLN9Ywu+iYJmYwr16S6CLr7afjQtXeJBBI1QC+Bfs=; b=GeSLTVEQDI/MjerlDLr2oUb/6G
        NhbzywT+z3JR3cjh2rTl94BB5h1II2p3iYHCqie4cv+FNhbwKIWJeI+3/yB/RsDl+SadOOjiZ83O3
        UFMhhJ52ejTvxnmHYlcXuPPNXUMqu1NILhSv///BaS4Ur2R2D3Gh/DBj9r9AeEjxaM9D4bzBT7m7H
        +TK0ONo0lguYmoEav/w+JmUg0xwGuxYjv77K/OO521D/9ChqVi2D+ip2PDh4HZfOJ6D3Z++zbxW/q
        7hO4quVarVF+Tsrz4020PlBkRoCF/2TWLw5nPv8GPQeMG8DE3pDyhMJRhdQDCRjpdsa9b2f/ShCOu
        fQYjRYhQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kpL9t-0001Hz-PC; Wed, 16 Dec 2020 00:59:13 +0000
Date:   Wed, 16 Dec 2020 00:59:13 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/11] mm: VM_BUG_ON lru page flags
Message-ID: <20201216005913.GW2443@casper.infradead.org>
References: <20201207220949.830352-1-yuzhao@google.com>
 <20201207220949.830352-8-yuzhao@google.com>
 <20201207222429.GC7338@casper.infradead.org>
 <X9la29qelClATtpP@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X9la29qelClATtpP@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 05:54:51PM -0700, Yu Zhao wrote:
> On Mon, Dec 07, 2020 at 10:24:29PM +0000, Matthew Wilcox wrote:
> > On Mon, Dec 07, 2020 at 03:09:45PM -0700, Yu Zhao wrote:
> > > Move scattered VM_BUG_ONs to two essential places that cover all
> > > lru list additions and deletions.
> > 
> > I'd like to see these converted into VM_BUG_ON_PGFLAGS so you have
> > to take that extra CONFIG step to enable checking them.
> 
> Right. I'll make sure it won't slip my mind again in v2.

Hugh has enlightened me that VM_BUG_ON_PGFLAGS() should not be used for
this purpose.  Sorry for the bad recommendation.
