Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C534622DAF9
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jul 2020 02:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbgGZAle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jul 2020 20:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727869AbgGZAld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 20:41:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD52BC08C5C0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 17:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=0/SqncWLEFRMIbCAA8NWW0A+JcXwyV45WcjL1+/uDeQ=; b=nuvfYqmnYUmWtcNGTLX+wGOPic
        O4LRyGlMWuU5Ebu6vdNgpom/4JJ0z6e7yYXzPqEqiVELZfFpEHcZom+P0HwI7MAYKEL5N0+0M2U8I
        QJN8M3AbmiMUtFE5VWGIxBNKidyX1ZQg11kQgY3uNgDIDYlu2rXm+iDHdi5l86x2q+OcaFdIcs6zk
        /+gmtQIIBbrIxp4CxdaCPQQVdB6An7MYJOA11MeouECf8yzIIPg5foHfujTI1mymcw0tfLnE7BFL/
        kDkzRMh+4vQVuIdCh2KnGcIysdHGZVzzqgl0/eWUJ12wQaOCX9/vNBTRC/1WpWu5896PBkgunFX37
        R8xsMeWw==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzUjL-0003QZ-UF; Sun, 26 Jul 2020 00:41:32 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Subject: [PATCH 2/3] x86: cmpxchg_32.h: delete duplicated word
Date:   Sat, 25 Jul 2020 17:41:23 -0700
Message-Id: <20200726004124.20618-3-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200726004124.20618-1-rdunlap@infradead.org>
References: <20200726004124.20618-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the repeated word "you".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
---
 arch/x86/include/asm/cmpxchg_32.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200720.orig/arch/x86/include/asm/cmpxchg_32.h
+++ linux-next-20200720/arch/x86/include/asm/cmpxchg_32.h
@@ -3,7 +3,7 @@
 #define _ASM_X86_CMPXCHG_32_H
 
 /*
- * Note: if you use set64_bit(), __cmpxchg64(), or their variants, you
+ * Note: if you use set64_bit(), __cmpxchg64(), or their variants,
  *       you need to test for the feature in boot_cpu_data.
  */
 
