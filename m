Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1DC12E1DE8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 16:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgLWPbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 10:31:01 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:17883 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgLWPbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 10:31:01 -0500
Received: from grover.flets-west.jp (softbank126090214151.bbtec.net [126.90.214.151]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 0BNFTprb004643;
        Thu, 24 Dec 2020 00:29:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 0BNFTprb004643
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1608737391;
        bh=3V9/g8jv3wZ4k4llLf0sTJEXgeqAlYrfvft7N8129y8=;
        h=From:To:Cc:Subject:Date:From;
        b=luzmys9pOqrxk9J3QptJ//UHKMVLNSWFP+A1v4YaKb8WpWOYpyf8+EU+cwASodecS
         foMMowf1iJ8ScBbWtmB2Wr8W4E23XD0g67k8Bwcu6xYs9t2s2TD7qMErrWXZIbMJ/0
         8fISAV8y2KdM1i4D1f85ds4vHDrQxkpyeElTxf4de60oHoZZQgkvOKfE1eyHtBsfRd
         XS3hmTjYDyJAPPWLHmKnYqNYsqR5Xx52QVNV/Draoo3bATwmisHmYsGGgJBGXI0nVd
         vGBxo5hhT/o3FiXupSzA6S7RRYS5CQuNrGM6nN9m9XLwHb4beJnxnjUiE/6tGLLzuz
         SRfP/TOorGwew==
X-Nifty-SrcIP: [126.90.214.151]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Michal Simek <monstr@monstr.eu>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] microblaze: do not select TRACING_SUPPORT directly
Date:   Thu, 24 Dec 2020 00:29:46 +0900
Message-Id: <20201223152947.698744-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Microblaze is the only architecture that selects TRACING_SUPPORT.

In my understanding, it is computed by kernel/trace/Kconfig:

  config TRACING_SUPPORT
          bool
          depends on TRACE_IRQFLAGS_SUPPORT
          depends on STACKTRACE_SUPPORT
          default y

Microblaze enables both TRACE_IRQFLAGS_SUPPORT and STACKTRACE_SUPPORT,
so there is no change in the resulted configuration.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/microblaze/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index a0e0c43a2852..acd6d0e68089 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -39,7 +39,6 @@ config MICROBLAZE
 	select OF_EARLY_FLATTREE
 	select PCI_DOMAINS_GENERIC if PCI
 	select PCI_SYSCALL if PCI
-	select TRACING_SUPPORT
 	select VIRT_TO_BUS
 	select CPU_NO_EFFICIENT_FFS
 	select MMU_GATHER_NO_RANGE
-- 
2.27.0

