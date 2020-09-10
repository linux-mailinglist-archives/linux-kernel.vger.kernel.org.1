Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C908263CC8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 07:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbgIJFyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 01:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbgIJFve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 01:51:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB852C0613ED;
        Wed,  9 Sep 2020 22:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=d/1oapeqMoUX4fyEWjc4oR9/HMmOIqyxIeXpBbH5I6g=; b=uOu1pQyJkN91O28k3NNeK+gmQF
        hrvf0kLD+AJr/uyZi5OXbLR3iOtsmxbT10BEvJu+V0Qs0jVvBr/CTgD4ImAAG37J8q5aDlOh2nUlM
        pliPvINsf86YsBNuz6MyTXIdXiVBn2zoy7xSuV/yvQzhG1sAqw3lvykveX+nL+Dvb4AwDkxCOBJIH
        8pD7ovGBGDAYCzRlbRN3Z3axTJ3zvbIpOkVCnTgix8b8LiQ2wxfgeWX261plaiaAGclHU/2IpzWzB
        5D+4jEUmv/3Yd5X9Ta1Sg5WDA32b142gJkiCRM9zlrkJKsL2h+6Cw8E9vVXC4Uy7TSedjMPaiL6bL
        xv7eJNCw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGFUG-00036l-Oo; Thu, 10 Sep 2020 05:51:12 +0000
Date:   Thu, 10 Sep 2020 06:51:12 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Russell King <linux@armlinux.org.uk>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 3/4] mm/pageblock: work around multiple arch's cmpxchg
 support issue
Message-ID: <20200910055112.GA11727@infradead.org>
References: <1599116482-7410-1-git-send-email-alex.shi@linux.alibaba.com>
 <1599116482-7410-3-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599116482-7410-3-git-send-email-alex.shi@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03, 2020 at 03:01:22PM +0800, Alex Shi wrote:
> Armv6, sh2, sparc32 and xtensa can not do cmpxchg1, so we have to use
> cmpxchg4 on it.
> 
> Here we mark above 4 arch's NO_CMPXCHG_BYTE, and would add more if we
> found.
> 
> This is the first usages of cmpxchg flase sharing change. We'd better
> check more cmpxchg usages in current kernel...

I think a positive symbol, e.g. HAVE_CMPXCHG_BYTE is a lot easier to
understand, and also fool-proof.
