Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D70C02043DE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 00:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731319AbgFVWnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 18:43:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:59728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731269AbgFVWnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 18:43:05 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C815720786;
        Mon, 22 Jun 2020 22:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592865784;
        bh=WXTjaO/GWX+4a+95F2PVE95dKGK8yFuYV1kK1j13JUc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VaXx+6eSfGYLiiHYkg3kSx2wFywLxOwzl8MmoOZVUUEqtZJCbPGZF+vo4gmHCbo4I
         Uy3cCzBu8V4+0eA+HaudBF+FUzj0cmi2Y/Q3mXPzBQ3BJoQY6j6p8r332KAuZ7RCTV
         vbPe1HYz7FNsQzRJQXxMYVjkuwnMdl7Dj6TDjJcQ=
From:   Sasha Levin <sashal@kernel.org>
To:     peterz@infradead.org
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        jolsa@redhat.com, alexey.budankov@linux.intel.com,
        songliubraving@fb.com, acme@redhat.com, allison@lohutok.net,
        sashal@kernel.org
Subject: [PATCH v3 02/14] tools headers: Add rcupdate.h header
Date:   Mon, 22 Jun 2020 18:42:46 -0400
Message-Id: <20200622224258.1208588-3-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200622224258.1208588-1-sashal@kernel.org>
References: <20200622224258.1208588-1-sashal@kernel.org>
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

