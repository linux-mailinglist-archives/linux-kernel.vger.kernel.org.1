Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F70B1AF63C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Apr 2020 03:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbgDSB6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Apr 2020 21:58:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:35020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725960AbgDSB6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 21:58:00 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57DAA21D93;
        Sun, 19 Apr 2020 01:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587261480;
        bh=fSftPc2z9GL978aBgdRnFoG53Jp1bOOrXP9DcVQritQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fj868i5O3TZFU5liwUpZPOWju7j9Ihp4UdmCiP47KCvc9V1dWchkTzBLsMtW5JWmZ
         XiJwYfXv0xr04R5iR+D2+OQYUbkk0PD+xaOUNE+cJ6Yhw/EQaALPv83P3siEunZYdL
         IcYOfIhW8S43k0oo9mLpgWtrxoSrdMhhftCu3t4k=
From:   Sasha Levin <sashal@kernel.org>
To:     mingo@kernel.org, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, jolsa@redhat.com,
        alexey.budankov@linux.intel.com, songliubraving@fb.com,
        acme@redhat.com, allison@lohutok.net,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH v2 02/12] tools headers: Add rcupdate.h header
Date:   Sat, 18 Apr 2020 21:57:44 -0400
Message-Id: <20200419015754.24456-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200419015754.24456-1-sashal@kernel.org>
References: <20200419015754.24456-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is now needed by liblockdep as a result of a0b0fd53e1e6
("locking/lockdep: Free lock classes that are no longer in use").

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/include/linux/rcupdate.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 tools/include/linux/rcupdate.h

diff --git a/tools/include/linux/rcupdate.h b/tools/include/linux/rcupdate.h
new file mode 100644
index 0000000000000..1b7abc86f4336
--- /dev/null
+++ b/tools/include/linux/rcupdate.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LIBLOCKDEP_RCUPDATE_H_
+#define _LIBLOCKDEP_RCUPDATE_H_
+
+#define call_rcu(x, y)
+#define init_rcu_head(x)
+
+struct rcu_head {
+	char dummy;
+};
+
+#endif
-- 
2.20.1

