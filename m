Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3EE23448B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 13:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732740AbgGaL3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jul 2020 07:29:54 -0400
Received: from mga01.intel.com ([192.55.52.88]:55999 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732104AbgGaL3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 07:29:54 -0400
IronPort-SDR: Y9DFRp5ipRAGcx2Q5pfu7EWHCgOy2SFKn4EITFSGf9y0pCp8BGnkyMxfCLXKWMKLtdzcVy1iXY
 dul7FumueITg==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="169873090"
X-IronPort-AV: E=Sophos;i="5.75,418,1589266800"; 
   d="scan'208";a="169873090"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2020 04:29:54 -0700
IronPort-SDR: xNrSD2UDhA04eBbYkGNQTjxs6ZQ3LROmSht8ZpRPY019Vqv9xHHZXgVeoV9ZRDLjnMUcLlZRV0
 wEbrmPR+FyoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,418,1589266800"; 
   d="scan'208";a="465591503"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 31 Jul 2020 04:29:52 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E6CA521D; Fri, 31 Jul 2020 14:29:51 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Eric Biggers <ebiggers@google.com>, linux-kernel@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] once: Fix trivia typo Not -> Note
Date:   Fri, 31 Jul 2020 14:29:51 +0300
Message-Id: <20200731112951.70567-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix trivia typo Not -> Note in the comment to DO_ONCE().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/once.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/once.h b/include/linux/once.h
index 9225ee6d96c7..095c6debd63b 100644
--- a/include/linux/once.h
+++ b/include/linux/once.h
@@ -16,7 +16,7 @@ void __do_once_done(bool *done, struct static_key_true *once_key,
  * out the condition into a nop. DO_ONCE() guarantees type safety of
  * arguments!
  *
- * Not that the following is not equivalent ...
+ * Note that the following is not equivalent ...
  *
  *   DO_ONCE(func, arg);
  *   DO_ONCE(func, arg);
-- 
2.27.0

