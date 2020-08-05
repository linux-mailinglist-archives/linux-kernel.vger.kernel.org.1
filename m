Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B122223C276
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Aug 2020 02:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgHEAKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 20:10:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:46828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726011AbgHEAKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 20:10:48 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AFA922CA0;
        Wed,  5 Aug 2020 00:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596586247;
        bh=WXTjaO/GWX+4a+95F2PVE95dKGK8yFuYV1kK1j13JUc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C8tPZ5aPc/Y9AaEwHcmxSs9UaQZdWCiz+4EUTBR977mDDnj2cpTgF+3xvfF7iKpE7
         s1yr2AvqHwBEG2+YaM7bGX/BUhZ6UduY1VtI0Pwa8SEpUYcP3WSAnd4F1dgOSpzl4Q
         otr5FxKm22KT5BOlrOnIYWRoS5uCxcD3vPOmAgTI=
From:   Sasha Levin <sashal@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     mingo@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH v4 02/14] tools headers: Add rcupdate.h header
Date:   Tue,  4 Aug 2020 20:10:31 -0400
Message-Id: <20200805001043.3331907-3-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200805001043.3331907-1-sashal@kernel.org>
References: <20200805001043.3331907-1-sashal@kernel.org>
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
2.25.1

