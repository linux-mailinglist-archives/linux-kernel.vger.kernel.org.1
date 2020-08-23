Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0333C24EB1A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Aug 2020 06:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbgHWEFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Aug 2020 00:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725139AbgHWEFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 00:05:14 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D25C061573
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 21:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=7xtGPUY2YI50++rdmQLqZw2Qohi+IdPMJKOV3dwr+NE=; b=rs+d5IZ+FLsJw28x4cMHVApy00
        KMCzWYBwZoF6ib7rPasrEFzjjHDW6GEWjW6Qe5g8dzZ9Uhj+ZM7Nz13mmYE+KTFYpRD/JDoc2DaON
        Gy2nm4CrZbzOEYlY/6xjEq3n2O6M8fQIcMvcBVI9dHI4iQBo9Qes7GMIHkVOfTOvyRMfpEpDp4pDv
        ynYB1l8lRDiyUd5B27M0NkfEaciZcPbJ1FAz1RRZxcmyU/ACeasgoQKts1s2QcqS8vIz6jaYhwsaP
        pJrHeNb8WF7obwmZWfJLzsfnRdTA3lgHFm42bLFHiCJPKcx0558wa/BzwqoILa5B9b5r2M+8Js9HZ
        BD83lZfA==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k9hFo-0004rx-7X; Sun, 23 Aug 2020 04:05:12 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] lib: radix-tree: delete duplicated words
Date:   Sat, 22 Aug 2020 21:05:08 -0700
Message-Id: <20200823040508.26086-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the repeated word "be".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
---
 lib/radix-tree.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200730.orig/lib/radix-tree.c
+++ linux-next-20200730/lib/radix-tree.c
@@ -325,7 +325,7 @@ static __must_check int __radix_tree_pre
 	int ret = -ENOMEM;
 
 	/*
-	 * Nodes preloaded by one cgroup can be be used by another cgroup, so
+	 * Nodes preloaded by one cgroup can be used by another cgroup, so
 	 * they should never be accounted to any particular memory cgroup.
 	 */
 	gfp_mask &= ~__GFP_ACCOUNT;
