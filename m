Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE1D2D151D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 16:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgLGPuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 10:50:46 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:39082 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbgLGPuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 10:50:46 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kmIm4-0000xs-J5; Mon, 07 Dec 2020 15:50:04 +0000
From:   Colin King <colin.king@canonical.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org
Subject: [PATCH] arch: fix spelling mistakes in Kconfig
Date:   Mon,  7 Dec 2020 15:50:04 +0000
Message-Id: <20201207155004.171962-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are a few spelling mistakes in the Kconfig comments and help
text. Fix these.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 arch/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index f7f246e68ff5..a52f8e8d16ad 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -261,7 +261,7 @@ config ARCH_HAS_SET_DIRECT_MAP
 
 #
 # Select if the architecture provides the arch_dma_set_uncached symbol to
-# either provide an uncached segement alias for a DMA allocation, or
+# either provide an uncached segment alias for a DMA allocation, or
 # to remap the page tables in place.
 #
 config ARCH_HAS_DMA_SET_UNCACHED
@@ -314,14 +314,14 @@ config ARCH_32BIT_OFF_T
 config HAVE_ASM_MODVERSIONS
 	bool
 	help
-	  This symbol should be selected by an architecure if it provides
+	  This symbol should be selected by an architecture if it provides
 	  <asm/asm-prototypes.h> to support the module versioning for symbols
 	  exported from assembly code.
 
 config HAVE_REGS_AND_STACK_ACCESS_API
 	bool
 	help
-	  This symbol should be selected by an architecure if it supports
+	  This symbol should be selected by an architecture if it supports
 	  the API needed to access registers and stack entries from pt_regs,
 	  declared in asm/ptrace.h
 	  For example the kprobes-based event tracer needs this API.
@@ -336,7 +336,7 @@ config HAVE_RSEQ
 config HAVE_FUNCTION_ARG_ACCESS_API
 	bool
 	help
-	  This symbol should be selected by an architecure if it supports
+	  This symbol should be selected by an architecture if it supports
 	  the API needed to access function arguments from pt_regs,
 	  declared in asm/ptrace.h
 
-- 
2.29.2

