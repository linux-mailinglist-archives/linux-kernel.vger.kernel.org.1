Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47F9B2254E6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 02:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgGTAOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jul 2020 20:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbgGTAOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 20:14:32 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCDAC0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 17:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=iJmvNKittmUboWtfUegvKsjqzuyEPCgFWp+jGG8AOyg=; b=3hvw/8oja1mm3MQ1dZcFPrI6CF
        CAQzIO/CqthmVWg0ukcKMFvHrEBIjSJk315Q7bBpLzolrhgaQj/WIob9UFP7+WvnAIXxWSRdlRaqE
        Oi/67roCgtf3PdoQ6Bugf2SelOt4CjiGRpzvQVAjZ/ExNw0st4jt9MBRaF2tfxGUpaMYT82Qb3ggL
        r8N5hi15Nr48p0NP+9xb7sRXObuqH5dxWCurRkMNzY5/jVmxf6e22dZJdXyVjOWT7Swee9OW7XSgW
        cxQaeIEB2/iRD4P0Bn7m0Kab397wtqZwnqkMeqve+VuzHQoJu/wFWacUtJq9rtHz8VjPLiP6c5Dfq
        JmCGfhyw==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxJRq-0003zx-2P; Mon, 20 Jul 2020 00:14:26 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        ocfs2-devel@oss.oracle.com
Subject: [PATCH] ocfs2: suballoc.h: delete a duplicated word
Date:   Sun, 19 Jul 2020 17:14:21 -0700
Message-Id: <20200720001421.28823-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the repeated word "is" in a comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: ocfs2-devel@oss.oracle.com
---
 fs/ocfs2/suballoc.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200717.orig/fs/ocfs2/suballoc.h
+++ linux-next-20200717/fs/ocfs2/suballoc.h
@@ -40,7 +40,7 @@ struct ocfs2_alloc_context {
 
 	u64    ac_last_group;
 	u64    ac_max_block;  /* Highest block number to allocate. 0 is
-				 is the same as ~0 - unlimited */
+				 the same as ~0 - unlimited */
 
 	int    ac_find_loc_only;  /* hack for reflink operation ordering */
 	struct ocfs2_suballoc_result *ac_find_loc_priv; /* */
