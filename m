Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7442A9EBE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 21:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbgKFUz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 15:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728408AbgKFUz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 15:55:58 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EB9C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 12:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BQCsdYcW7P+jix+PsOpY98zMadVYG0lOPq2m1W8EA9k=; b=I4RhnakvykgPcPZdI9SG8stW6Y
        4nVxEtR2UM2tmUrdSbk8fNEFI40T0Rr/G3haSzG+nidLXTDs/+6IuGqtVSTK0EJrNfdrUp7KTrCLS
        5RE0H6weuIzsNN2D+3+NrcMbYLAuz9EGCqgIowSlsXDBQtY+DkTDsW45S8fSSVKyLRzZRIM9YRjAs
        esBG+LnIJ6VQzgqikoB2IDVssiGmsD3bLEGrGNEqtMvtZyiJtk9HiBMNzwn9Q1w/MzM3QGpFlhqqf
        47s45NUXlSkY6DjN3iuolYnlAP4hz5R+b2AdeohtMEmXDbPj2Qzqikz/P+gtLaGd2Awz0FSmzt0O2
        pRzoNl8g==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kb8lk-0001hG-Aa; Fri, 06 Nov 2020 20:55:36 +0000
Date:   Fri, 6 Nov 2020 20:55:36 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Rong Chen <rong.a.chen@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Qian Cai <cai@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org, lkp@intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com
Subject: Re: [mm] e6e88712e4: stress-ng.tmpfs.ops_per_sec -69.7% regression
Message-ID: <20201106205536.GS17076@casper.infradead.org>
References: <20201030071715.GV31092@shao2-debian>
 <20201030131711.GJ27442@casper.infradead.org>
 <dc3864d6-f474-02b8-fdf2-ca138afe3735@intel.com>
 <20201030145835.GL27442@casper.infradead.org>
 <d57f327c-a22e-1fb0-26fe-68b4964e75dc@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d57f327c-a22e-1fb0-26fe-68b4964e75dc@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 01:21:39PM +0800, Rong Chen wrote:
> we compared the tmpfs.ops_per_sec: (363 / 103.02) between this commit and
> parent commit.

Thanks!  I see about a 50% hit on my system, and this patch restores the
performance.  Can you verify this works for you?

diff --git a/mm/madvise.c b/mm/madvise.c
index 9b065d412e5f..e602333f8c0d 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -225,7 +225,7 @@ static void force_shm_swapin_readahead(struct vm_area_struct *vma,
 		struct address_space *mapping)
 {
 	XA_STATE(xas, &mapping->i_pages, linear_page_index(vma, start));
-	pgoff_t end_index = end / PAGE_SIZE;
+	pgoff_t end_index = linear_page_index(vma, end + PAGE_SIZE - 1);
 	struct page *page;
 
 	rcu_read_lock();
