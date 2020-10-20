Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC8052943ED
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 22:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409477AbgJTUcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 16:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404936AbgJTUcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 16:32:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3E8C0613CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 13:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=r1+rsc+u5oeDM3b5y4kLiI/q8RBlERnropKYC9dMtsI=; b=Ou/MiX9/kpNLemB5OSzFrtpZa5
        ONkeKG7CilQAhsjaDXaPxOLk82By9Y7poMDaR/2p8+EEYBgdRKbzFtWZuTZ8sQzg07T1NVMc37tjn
        /+d6DHoox8AvESntRcnxvD2lC6Gy7cvy2VhRaLonqQjSlMaD4T7E1KtxDHhn9QU11FdVW7vJBqmCM
        F6RGMh/gJxfKsOsHlHA7aaol0YZSmOnp3ZOa+ug/cruGSnPtFTuvF9uGBh1un+TE1jjLheMuSmaqM
        aGG0bFH54VuZQYlb3O2hT08vW3J2AzY5i6YHH+14CsEmGYlfNEl4L69Axdke3haVsDkNNa6nffyDQ
        2jzHNumA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kUyIs-0006Hx-Hf; Tue, 20 Oct 2020 20:32:18 +0000
Date:   Tue, 20 Oct 2020 21:32:18 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: XArray pull for 5.9
Message-ID: <20201020203218.GD20115@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 856deb866d16e29bd65952e0289066f6078af773:

  Linux 5.9-rc5 (2020-09-13 16:06:00 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/willy/xarray.git tags/xarray-5.9

for you to fetch changes up to 84c34df158cf215b0cd1475ab3b8e6f212f81f23:

  XArray: Fix xas_create_range for ranges above 4 billion (2020-10-13 08:53:29 -0400)

----------------------------------------------------------------
XArray updates for 5.9

 - Fix the test suite after introduction of the local_lock
 - Fix a bug in the IDA spotted by Coverity
 - Change the API that allows the workingset code to delete a node
 - Fix xas_reload() when dealing with entries that occupy multiple indices
 - Add a few more tests to the test suite
 - Fix an unsigned int being shifted into an unsigned long

----------------------------------------------------------------
Hui Su (1):
      radix-tree: fix the comment of radix_tree_next_slot()

Matthew Wilcox (Oracle) (8):
      radix tree test suite: Fix compilation
      ida: Free allocated bitmap in error path
      XArray: Test two more things about xa_cmpxchg
      XArray: Test marked multiorder iterations
      XArray: Fix xas_for_each_conflict documentation
      XArray: Add private interface for workingset node deletion
      XArray: Fix xas_reload for multi-index entries
      XArray: Fix xas_create_range for ranges above 4 billion

 include/linux/radix-tree.h                  |  3 ++-
 include/linux/xarray.h                      | 34 ++++++++++++++++++++----------
 lib/idr.c                                   |  1 +
 lib/radix-tree.c                            |  1 -
 lib/test_xarray.c                           | 32 ++++++++++++++++++++++------
 lib/xarray.c                                | 25 +++++++++++++++++++++-
 mm/workingset.c                             | 13 ++----------
 tools/testing/radix-tree/idr-test.c         | 29 +++++++++++++++++++++++++
 tools/testing/radix-tree/linux/kernel.h     |  1 +
 tools/testing/radix-tree/linux/local_lock.h |  8 +++++++
 tools/testing/radix-tree/test.h             |  4 ----
 11 files changed, 116 insertions(+), 35 deletions(-)
 create mode 100644 tools/testing/radix-tree/linux/local_lock.h

