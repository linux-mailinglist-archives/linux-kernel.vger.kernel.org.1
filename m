Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 575AD268BDA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 15:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgINNMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 09:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbgINNBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 09:01:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CF5C06178A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 06:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=GWRJyLjdVO4jgh6/sQUjrWOKvqlBp8yIabvH26g1NiE=; b=tEJgbqYFKOssFq0pkK5lWbH6zX
        fO5X9lF44IVizTHlGGmSxUN+1X7nITBfnKhefQfHkHEkOYr35lniISV2d98LBmUMkKaW3DuqfFLXT
        qX8AkKNGfddwwixbtmuWresJPjdrvR6m9Y4JyXs2Zuj1EFihMA75ej4/WbM5mkGUgAdfEWRYwdiLp
        blH5zvYXCoJKadsG8SE6xqeLp9stc4TMFVZJp0pFTK0P0/nZnaWEb3WKvgXplrDz5cbEjKgYHLjt0
        8YpSR7LeH6Qvwgbm3GbdYLoupRBLZdWYTu89VZ7AeH+JDS7Q7sDRReNyC0TR1HukUJiMdgNvtV3l7
        eLCOBEmA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kHo67-0002zf-Ev; Mon, 14 Sep 2020 13:00:44 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/12] Overhaul multi-page lookups for THP
Date:   Mon, 14 Sep 2020 14:00:30 +0100
Message-Id: <20200914130042.11442-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The critical patch to review here is patch 11, "Handle truncates that
split THPs".  This code is shared with shmem, and while xfstests passes
(both with the tmpfs filesystem and with THPs enabled for XFS), it is
terribly subtle.

I posted a similar patch series a few weeks ago [1], but this goes a few
steps further than that one did.  In addition to the unification of
find_get_entries() and pagevec_lookup_entries(), this patch series
includes:

 - Only return the head pages from tagged lookups
 - Factor a lot of common code out of the various batch lookup routines
 - Add mapping_seek_hole_data()
 - Only return head pages from find_get_entries

I also have a patch to iomap to use mapping_seek_hole_data(), but I'm
not including that as part of this batch of patches -- I'll send it
through the iomap tree once mapping_seek_hole_data() lands upstream.

[1] https://lore.kernel.org/linux-mm/20200819184850.24779-1-willy@infradead.org/

Matthew Wilcox (Oracle) (12):
  mm: Make pagecache tagged lookups return only head pages
  mm/shmem: Use pagevec_lookup in shmem_unlock_mapping
  mm/filemap: Add helper for finding pages
  mm/filemap: Add mapping_seek_hole_data
  mm: Add and use find_lock_entries
  mm: Add an 'end' parameter to find_get_entries
  mm: Add an 'end' parameter to pagevec_lookup_entries
  mm: Remove nr_entries parameter from pagevec_lookup_entries
  mm: Pass pvec directly to find_get_entries
  mm: Remove pagevec_lookup_entries
  mm/truncate,shmem: Handle truncates that split THPs
  mm/filemap: Return only head pages from find_get_entries

 include/linux/pagemap.h |   5 +-
 include/linux/pagevec.h |   4 -
 mm/filemap.c            | 267 +++++++++++++++++++++++++++-------------
 mm/internal.h           |   5 +
 mm/shmem.c              | 214 +++++++-------------------------
 mm/swap.c               |  38 +-----
 mm/truncate.c           | 249 ++++++++++++++-----------------------
 7 files changed, 329 insertions(+), 453 deletions(-)

-- 
2.28.0

