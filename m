Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6236C22DAC4
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jul 2020 02:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgGZAWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jul 2020 20:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbgGZAWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 20:22:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DF7C08C5C0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 17:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=xhV0Benv3VefaUhXEHmyjX8yxKTDsckJSRvSN4FMtn8=; b=C/cN/6HER1OivX+zta6x7TD14m
        XuT67Hc8u4Bb7P/QS7M/sPkJ1hd/aOLU/x0Gqah/7BUZqh7kODjiovpjVeAzEL5HanzYV+4v2Onfq
        qKiM0OVmf1dbWmtlGqVxbf03zG8V4iEx5axaCEAYXcRrRJgq6zVUNp9mzKr7z0DKBsh8U+MJGGIXV
        NH7yxZMWB2eqQdOm9HcphdOkRRaClxTLE24kDJ/tFlx6uMXswjKwtBcUPtP3f8ma0LBOAE8MsRuhn
        0dZanAnTnDWpoBFN7vmavRDC8kz633t0h4DI78fssf5EcUKsXNdOCBdPoRbK1yA6wUHrBnKJpxZxZ
        pVnhuj0w==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzUQU-0002Xl-6B; Sun, 26 Jul 2020 00:22:02 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm: unwind.h: fix duplicated word
Date:   Sat, 25 Jul 2020 17:21:59 -0700
Message-Id: <20200726002159.19846-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the repeated words "the" to "to the".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm/include/asm/unwind.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200720.orig/arch/arm/include/asm/unwind.h
+++ linux-next-20200720/arch/arm/include/asm/unwind.h
@@ -10,7 +10,7 @@
 
 #ifndef __ASSEMBLY__
 
-/* Unwind reason code according the the ARM EABI documents */
+/* Unwind reason code according to the ARM EABI documents */
 enum unwind_reason_code {
 	URC_OK = 0,			/* operation completed successfully */
 	URC_CONTINUE_UNWIND = 8,
