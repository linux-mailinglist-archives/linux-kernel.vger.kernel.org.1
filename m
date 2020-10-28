Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 827ED29D874
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:32:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733268AbgJ1WcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:32:24 -0400
Received: from mga11.intel.com ([192.55.52.93]:11242 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388066AbgJ1WcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:32:17 -0400
IronPort-SDR: fR984K4StptNhf1YJklrh4X0YpejD48M5CAGo8M9awe9nMto6PqgRMWYBGSDprnskI3g6MbyxR
 hhrOKmaNwE1w==
X-IronPort-AV: E=McAfee;i="6000,8403,9788"; a="164801095"
X-IronPort-AV: E=Sophos;i="5.77,427,1596524400"; 
   d="scan'208";a="164801095"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2020 10:28:30 -0700
IronPort-SDR: 9n+7FIccD+eP2hk3pvzeBsqJvzGPKAmWSYcqRTbx47T/6knbJNt72YVPBrNNCtq3ozD8HWc/l1
 ZlA3prTyEvFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,427,1596524400"; 
   d="scan'208";a="318665931"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 28 Oct 2020 10:28:27 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D485B2A0; Wed, 28 Oct 2020 19:28:26 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] kernel.h: Drop unneeded <linux/kernel.h> inclusion from other headers
Date:   Wed, 28 Oct 2020 19:28:26 +0200
Message-Id: <20201028172826.41635-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no evidence we need kernel.h inclusion in certain headers.
Drop unneeded <linux/kernel.h> inclusion from other headers.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/rwsem.h    | 1 -
 include/linux/spinlock.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index 25e3fde85617..97571bf1286d 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -11,7 +11,6 @@
 #include <linux/linkage.h>
 
 #include <linux/types.h>
-#include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/spinlock.h>
 #include <linux/atomic.h>
diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 79897841a2cc..520f32c93745 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -53,7 +53,6 @@
 #include <linux/compiler.h>
 #include <linux/irqflags.h>
 #include <linux/thread_info.h>
-#include <linux/kernel.h>
 #include <linux/stringify.h>
 #include <linux/bottom_half.h>
 #include <linux/lockdep.h>
-- 
2.28.0

