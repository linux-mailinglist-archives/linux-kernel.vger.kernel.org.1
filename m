Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 484FA293049
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 23:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732638AbgJSVLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 17:11:02 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:48564 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731259AbgJSVLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 17:11:02 -0400
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id 396D01816C70D;
        Mon, 19 Oct 2020 23:11:00 +0200 (CEST)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Cd8X12QAzLvm; Mon, 19 Oct 2020 23:10:59 +0200 (CEST)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id oZr2pnQWGW2U; Mon, 19 Oct 2020 23:10:59 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-um@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, willy@infradead.org,
        anton.ivanov@cambridgegreys.com,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH] um: Call pgtable_pmd_page_dtor() in __pmd_free_tlb()
Date:   Mon, 19 Oct 2020 23:10:49 +0200
Message-Id: <20201019211049.22524-1-richard@nod.at>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b2b29d6d0119 ("mm: account PMD tables like PTE tables") uncovered
a bug in uml, we forgot to call the destructor.
While we are here, give x a sane name.

Reported-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Co-developed-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/include/asm/pgalloc.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/um/include/asm/pgalloc.h b/arch/um/include/asm/pgalloc.=
h
index 5393e13e07e0..2bbf28cf3aa9 100644
--- a/arch/um/include/asm/pgalloc.h
+++ b/arch/um/include/asm/pgalloc.h
@@ -33,7 +33,13 @@ do {							\
 } while (0)
=20
 #ifdef CONFIG_3_LEVEL_PGTABLES
-#define __pmd_free_tlb(tlb,x, address)   tlb_remove_page((tlb),virt_to_p=
age(x))
+
+#define __pmd_free_tlb(tlb, pmd, address)		\
+do {							\
+	pgtable_pmd_page_dtor(virt_to_page(pmd));	\
+	tlb_remove_page((tlb),virt_to_page(pmd));	\
+} while (0)						\
+
 #endif
=20
 #endif
--=20
2.26.2

