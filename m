Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3CDB24A27E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 17:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728747AbgHSPG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 11:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgHSPGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 11:06:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60685C061383
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 08:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=VMU155OtGZK5NBkT7Jr2yah70BMKrGVtMioV19uHfRk=; b=UTcsu//BYBRvVYf5ipwrND1UdG
        lieFl00JmTxT9xg68X9yM/U8CzQQC38hrr+gzL1ijrtliV00+PDPrmp9whTNG5HjDhErpb2LS1TI+
        kU2Ow1TOcAH2flHoUFLW1zJxbRKqrv2AkMuJVD1lKGsj2GnpMq4NIbMYgVHsfHqtTy4zBBTc00RMu
        1XhhWWiIbB4LW3eOw/dYYU7MSqKb9S5AE60OSM3Jla200AMo52frbqx4lWQNhiivKybELP0ISWkNl
        v16CLtzzd4TWTwVGPFLQgTMcD36K2vhW7b4HOzMGrXXHjxjdoPTG58vCJozzSL4+0Dd3VWhoY4OIX
        uyLc049w==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8Pf3-0008FX-PW; Wed, 19 Aug 2020 15:05:58 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] Overhaul find_get_entries and pagevec_lookup_entries
Date:   Wed, 19 Aug 2020 16:05:48 +0100
Message-Id: <20200819150555.31669-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This started out as part of the THP patchset, but it's turned into a
nice simplification in its own right.  Essentially we end up unifying
find_get_entries() and pagevec_lookup_entries() into one function that's
better than either, and we get rid of a lot of code in the callers as
a result.

I'm running this through xfstests right now, but something similar to
this has already passed xfstests as part of the THP patchset.

I've done my best to avoid off-by-one errors for 'end', but I wouldn't be
surprised if I made a mistake.  We're not consistent with whether 'end'
is inclusive or exclusive and I didn't want to make extensive changes
to ensure they were consistent.

Matthew Wilcox (Oracle) (7):
  mm: Use pagevec_lookup in shmem_unlock_mapping
  mm: Rewrite shmem_seek_hole_data
  mm: Add an 'end' parameter to find_get_entries
  mm: Add an 'end' parameter to pagevec_lookup_entries
  mm: Remove nr_entries parameter from pagevec_lookup_entries
  mm: Pass pvec directly to find_get_entries
  mm: Remove pagevec_lookup_entries

 include/linux/pagemap.h |  3 +-
 include/linux/pagevec.h |  4 --
 mm/filemap.c            | 19 +++++----
 mm/shmem.c              | 85 ++++++++++++++---------------------------
 mm/swap.c               | 38 +-----------------
 mm/truncate.c           | 33 +++-------------
 6 files changed, 45 insertions(+), 137 deletions(-)

-- 
2.28.0

