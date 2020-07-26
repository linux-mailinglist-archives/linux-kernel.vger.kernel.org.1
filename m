Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 254AB22DABB
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jul 2020 02:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgGZARl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jul 2020 20:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbgGZARl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 20:17:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1121C08C5C0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 17:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=bIzdukHQ+ATBfHLpRDrfYN1nk7nF43j1x33WTc27/H4=; b=Ye5o+OVzQqZPY09OgVKgkiYRox
        UzF1lfxQ5ygjF+dzA0Q5eufEWU4AfBfMUITe3VkQSKMNvm51ye+yR1luQU/vKkfsIzXAKS+r+TUHk
        TwN9NSglqWFESQrkIMfPPTLbobEmupZKolAUOWTZ2BKGY4HyLuyHFmUNvmx9MhjwUl1YuFeDjWOCC
        GfCYViJ2PQCEHqMBiNlTwtUv79GAPuJWLIL9iGyS1MEBVGKQXdFArIN9tFFA+zjhwkMcvVt0ejnTm
        fXpBlVTdLclXblKYHSpnHEKBSywW5TjBs2+91hHiPs3znL9C4uMTxgLy/CZcwYoMWGx8e4S86u/nh
        hsAUmfyw==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzUMB-0002Mn-Kk; Sun, 26 Jul 2020 00:17:36 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org
Subject: [PATCH] xen: hypercall.h: fix duplicated word
Date:   Sat, 25 Jul 2020 17:17:31 -0700
Message-Id: <20200726001731.19540-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the repeated word "as" to "as a".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: xen-devel@lists.xenproject.org
---
 arch/x86/include/asm/xen/hypercall.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200720.orig/arch/x86/include/asm/xen/hypercall.h
+++ linux-next-20200720/arch/x86/include/asm/xen/hypercall.h
@@ -82,7 +82,7 @@ struct xen_dm_op_buf;
  *     - clobber the rest
  *
  * The result certainly isn't pretty, and it really shows up cpp's
- * weakness as as macro language.  Sorry.  (But let's just give thanks
+ * weakness as a macro language.  Sorry.  (But let's just give thanks
  * there aren't more than 5 arguments...)
  */
 
