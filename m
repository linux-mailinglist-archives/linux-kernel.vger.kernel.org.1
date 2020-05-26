Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C091AAB0C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 17:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S371089AbgDOOzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 10:55:48 -0400
Received: from mga02.intel.com ([134.134.136.20]:41479 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S371073AbgDOOzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 10:55:43 -0400
IronPort-SDR: 8zcR+T0+NbiV+3Ql9vMDZ+f3rLFPSJI4vkNaieWxxhSNbh/yVzcYbrBAaAkWAacxtl1hLaES5m
 fjvR8rsgLBFQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 07:55:42 -0700
IronPort-SDR: lkIsegztChUG2UdlulFOtxgSR/g4jjKcHx7nB01BSjRW44m2IO3pHdwiT86La/h2+gWr0MgxK3
 tfT6hoLlLgFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,387,1580803200"; 
   d="scan'208";a="288571249"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 15 Apr 2020 07:55:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 24C7149F; Wed, 15 Apr 2020 17:55:40 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 2/9] x86/quirks: Add missed include to satisfy static checker
Date:   Wed, 15 Apr 2020 17:55:17 +0300
Message-Id: <20200415145524.31745-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200415145524.31745-1-andriy.shevchenko@linux.intel.com>
References: <20200415145524.31745-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Static checker is not happy with

.../kernel/quirks.c:666:6: warning: symbol 'x86_apple_machine' was not declared. Should it be static?

This is due to missed inclusion. Add it to satisfy the static checker.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/kernel/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/quirks.c b/arch/x86/kernel/quirks.c
index 896d74cb5081..7c054650b3a6 100644
--- a/arch/x86/kernel/quirks.c
+++ b/arch/x86/kernel/quirks.c
@@ -4,6 +4,7 @@
  */
 #include <linux/dmi.h>
 #include <linux/pci.h>
+#include <linux/platform_data/x86/machine.h>
 #include <linux/irq.h>
 
 #include <asm/hpet.h>
-- 
2.25.1

