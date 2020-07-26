Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2D3122DAE0
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jul 2020 02:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbgGZAiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jul 2020 20:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbgGZAiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 20:38:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378D5C08C5C0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 17:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=nykLTZWn1gv7h+c5D13sk5wem/+F6Ly2kQ0s//8/eTg=; b=tvOhN3pVaeDKpCyp1ryqTpovlw
        ItSknlLqkepENbopJuQg4D0oerCDfyaSIHWAMeoIhwKaTv27OAnk5GNBJib9dyzbWSGuCaRDAj7oB
        S9LZBLskKoWbAQO3OELg+TkkdYbP4qfTzOu9qQHJmbiLJRBqp/qZuIXUe9U9s3XEVDjU1IOkLLC8R
        anM/egy4Wt1kC3EiEDSTPzJcJPVux97LZHnutNde+0/JUabE4Yx3OFovWPtZuC3FxKzoj1A50YSiv
        kt0Svl856cKHLpjE9BtxL+PGTjLlbjHVdb/SQPXmtpEi38poNtQ4BIROep5wrwc1l1LYi7plQjNxV
        RYVucK/A==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzUgA-0003Cq-7E; Sun, 26 Jul 2020 00:38:14 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/9] powerpc: book3s: mmu-hash.h: delete duplicated word
Date:   Sat, 25 Jul 2020 17:38:01 -0700
Message-Id: <20200726003809.20454-2-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200726003809.20454-1-rdunlap@infradead.org>
References: <20200726003809.20454-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the repeated word "below".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/include/asm/book3s/64/mmu-hash.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200720.orig/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ linux-next-20200720/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -793,7 +793,7 @@ static inline unsigned long get_vsid(uns
 }
 
 /*
- * For kernel space, we use context ids as below
+ * For kernel space, we use context ids as
  * below. Range is 512TB per context.
  *
  * 0x00001 -  [ 0xc000000000000000 - 0xc001ffffffffffff]
