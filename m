Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 256FE273C9A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 09:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbgIVHuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 03:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgIVHuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 03:50:00 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C2AC061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 00:50:00 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0bfb00524dde00a85e5113.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:fb00:524d:de00:a85e:5113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 993F01EC03E3;
        Tue, 22 Sep 2020 09:49:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600760998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=SEqCYKrftYdSK0ZzCa+CWrXz2tugdzvxCUEalPUUeos=;
        b=noRktBhtiHiBfYZ9iGPDT0dgt2i6l/sDg36B1TQE71qBCislOcudRwc4Gfz/l1mKT9sx+N
        A6cthNgA4rPV1Y2WOl6ngb+2mtNhio5P57zWUZgIC1qdiXC3wSSP0Z912d1NvSTS1TeRTn
        0dyQVjvLiTRVrFMDbkcjjmC/gCq6hrw=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Balbir Singh <sblbir@amazon.com>
Subject: [PATCH] arch/um: Add a dummy cacheflush.h header
Date:   Tue, 22 Sep 2020 09:49:51 +0200
Message-Id: <20200922074951.2192-1-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

... in order to fix the defconfig build:

  ./arch/x86/include/asm/cacheflush.h: In function ‘l1d_flush_hw’:
  ./arch/x86/include/asm/cacheflush.h:15:6: error: implicit declaration of \
	  function ‘static_cpu_has’; did you mean ‘static_key_false’? [-Werror=implicit-function-declaration]
     15 |  if (static_cpu_has(X86_FEATURE_FLUSH_L1D)) {
        |      ^~~~~~~~~~~~~~
        |      static_key_false
  cc1: some warnings being treated as errors
  ./arch/x86/include/asm/cacheflush.h:16:3: error: implicit declaration of \
  function ‘wrmsrl’ [-Werror=implicit-function-declaration]
     16 |   wrmsrl(MSR_IA32_FLUSH_CMD, L1D_FLUSH);
        |

Fixes: a9210620ec36 ("x86/mm: Optionally flush L1D on context switch")
Reported-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Richard Weinberger <richard@nod.at>
Cc: Balbir Singh <sblbir@amazon.com>
---
 arch/um/include/asm/cacheflush.h | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 arch/um/include/asm/cacheflush.h

diff --git a/arch/um/include/asm/cacheflush.h b/arch/um/include/asm/cacheflush.h
new file mode 100644
index 000000000000..b9dee9760043
--- /dev/null
+++ b/arch/um/include/asm/cacheflush.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_UML_CACHEFLUSH_H
+#define _ASM_UML_CACHEFLUSH_H
+
+#undef ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE
+#include <asm-generic/cacheflush.h>
+
+static inline int l1d_flush_hw(void) { return -EOPNOTSUPP; }
+#endif /* _ASM_UML_CACHEFLUSH_H */
-- 
2.21.0

