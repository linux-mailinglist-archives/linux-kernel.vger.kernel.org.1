Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1B522DAE1
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jul 2020 02:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbgGZAiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jul 2020 20:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbgGZAiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 20:38:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21DB7C08C5C0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 17:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=2T/PUN88Psz81W4kabGMSiLLMlk2kni8wR69pWFEh14=; b=lp/m3pgbKggIHxgb/4vtKt2yHt
        MEz6zLVrdzcqPbuYA/zmfqqG45pME8e4/RfeLeCFZo6ZJZdRdCdE2Gnqp0LUNagVVTyGCL5yTiKNG
        PjMf4/AdxtiaD3mQAFocEREMIF3Ulldosr7AIEHmgmAPeyR+qegZPDoIzNKnospWBj7Wbs/gKDe9R
        DSKMqz8x5X+HP2iKxnGmH2JS3hh392p8n2mnnFM6o6AVfPc2+7rQ8lfqw5y28BjfO8mO0/N60dtqs
        KoCKZhdCRWG8h0tX/pSGa8FVfJ+aVh2UM5DTGe96y3E/DyRVDJBtv+GUycjC73tt5sp6nJTlhhOMd
        Mnr9RAkA==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzUgC-0003Cq-Aw; Sun, 26 Jul 2020 00:38:16 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/9] powerpc: book3s: radix-4k.h: delete duplicated word
Date:   Sat, 25 Jul 2020 17:38:02 -0700
Message-Id: <20200726003809.20454-3-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200726003809.20454-1-rdunlap@infradead.org>
References: <20200726003809.20454-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the repeated word "per".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/include/asm/book3s/64/radix-4k.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200720.orig/arch/powerpc/include/asm/book3s/64/radix-4k.h
+++ linux-next-20200720/arch/powerpc/include/asm/book3s/64/radix-4k.h
@@ -11,7 +11,7 @@
 #define RADIX_PGD_INDEX_SIZE  13  // size: 8B << 13 = 64KB, maps 2^13 x 512GB =   4PB
 
 /*
- * One fragment per per page
+ * One fragment per page
  */
 #define RADIX_PTE_FRAG_SIZE_SHIFT  (RADIX_PTE_INDEX_SIZE + 3)
 #define RADIX_PTE_FRAG_NR	(PAGE_SIZE >> RADIX_PTE_FRAG_SIZE_SHIFT)
