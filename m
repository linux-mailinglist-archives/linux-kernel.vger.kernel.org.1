Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD8B22DACD
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jul 2020 02:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbgGZAcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jul 2020 20:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbgGZAcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 20:32:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA409C08C5C0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 17:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=zhDcsNqUMabcRuZU3bhe0JOSSR6QtC38rAzzmtYzVAE=; b=rHFPPFpl8GZg7oXEnBjRJro+q7
        bGDaoxdj2xMlGiOKlDcwG5hyWSrgYOf75XImi9z1sNnWZ9XYOTpahCnQJwpoEcUMovlA+7cqBKlpA
        fl8HcKwC6ATUlS1hQKLeD/Z4hJ4un5nrr9qjs2R9LHZk2bxuJh43gRVIQRq4zd+V2IH7b9cAngKvP
        0jskRRcZwY4bT0zZskZiQiudg4z/Alo6Zcj3tcvoxwkfyk86ZjWVOOYFZKdi7qOnDrp5507/OhzwX
        ZTTjVBcd3pcwAMTHgIHb7X8yQqRgKhA+SQwiPt1MhvGILAkMyPY7xvWmAWJgJXOHj3y6l1+X8/ZxS
        SLS0Ud9g==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzUaM-0002x2-0x; Sun, 26 Jul 2020 00:32:14 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/3] arm64: ptrace.h: delete duplicated word
Date:   Sat, 25 Jul 2020 17:32:06 -0700
Message-Id: <20200726003207.20253-3-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200726003207.20253-1-rdunlap@infradead.org>
References: <20200726003207.20253-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the repeated word "the".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/include/asm/ptrace.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200720.orig/arch/arm64/include/asm/ptrace.h
+++ linux-next-20200720/arch/arm64/include/asm/ptrace.h
@@ -27,7 +27,7 @@
  *
  * Some code sections either automatically switch back to PSR.I or explicitly
  * require to not use priority masking. If bit GIC_PRIO_PSR_I_SET is included
- * in the  the priority mask, it indicates that PSR.I should be set and
+ * in the priority mask, it indicates that PSR.I should be set and
  * interrupt disabling temporarily does not rely on IRQ priorities.
  */
 #define GIC_PRIO_IRQON			0xe0
