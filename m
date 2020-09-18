Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C138526EA65
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 03:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgIRBUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 21:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbgIRBUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 21:20:41 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A7BC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 18:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=pf8sGJi3GTL/XA1LmGKqZqDEtcNgbydr7OLlpO9nbMU=; b=ck9FapdJeNSbBflKZdwpcNqs8I
        LhBNuGV7eKX00VofYUdBoBjXgwhMRT2XDZ2lvGXZAxLs8wHNgXQWajNPtXCq7uqXLQMubMwvwHcop
        NpoewbCCSDGObM6C99M9nUOSBKDgVJiwVXFgiyVXzfJOvleDurUCiSkeoGTLR9u7RsD1z/wdTo8aW
        W+RkdCkYQBGJV1cgtfSOJjep4Rt0LpZBY8cOvQk19LotK6EFcYJfeA1GJ7AldCQa+Gjwn3KXf2Ish
        Nbx79Rzz0oGgtDI+r7Mu9XmpS/2BhVMrkSTv7nh3TOjaYH9H/+BI0LTnzO/jCGqDd+KBP3eiQzTaM
        sjzwxy0w==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kJ54p-0007th-0c; Fri, 18 Sep 2020 01:20:39 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH RESEND] ntfs: drop unneeded semi-colons
Date:   Thu, 17 Sep 2020 18:20:34 -0700
Message-Id: <20200918012034.6305-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coccinelle scripts report:

fs/ntfs/lcnalloc.c:902:2-3: Unneeded semicolon
fs/ntfs/super.c:1615:2-3: Unneeded semicolon
fs/ntfs/super.c:1684:2-3: Unneeded semicolon

so remove the extraneous semicolons.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Anton Altaparmakov <anton@tuxera.com>
Cc: linux-ntfs-dev@lists.sourceforge.net
Cc: Andrew Morton <akpm@linux-foundation.org>
---
Adding Andrew to recipients, otherwise this patch is lost/ignored.

 fs/ntfs/lcnalloc.c |    2 +-
 fs/ntfs/super.c    |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

--- linux-next-20200917.orig/fs/ntfs/lcnalloc.c
+++ linux-next-20200917/fs/ntfs/lcnalloc.c
@@ -899,7 +899,7 @@ s64 __ntfs_cluster_free(ntfs_inode *ni,
 		}
 		/* We have freed @to_free real clusters. */
 		real_freed = to_free;
-	};
+	}
 	/* Go to the next run and adjust the number of clusters left to free. */
 	++rl;
 	if (count >= 0)
--- linux-next-20200917.orig/fs/ntfs/super.c
+++ linux-next-20200917/fs/ntfs/super.c
@@ -1612,7 +1612,7 @@ read_partial_attrdef_page:
 		memcpy((u8*)vol->attrdef + (index++ << PAGE_SHIFT),
 				page_address(page), size);
 		ntfs_unmap_page(page);
-	};
+	}
 	if (size == PAGE_SIZE) {
 		size = i_size & ~PAGE_MASK;
 		if (size)
@@ -1681,7 +1681,7 @@ read_partial_upcase_page:
 		memcpy((char*)vol->upcase + (index++ << PAGE_SHIFT),
 				page_address(page), size);
 		ntfs_unmap_page(page);
-	};
+	}
 	if (size == PAGE_SIZE) {
 		size = i_size & ~PAGE_MASK;
 		if (size)
