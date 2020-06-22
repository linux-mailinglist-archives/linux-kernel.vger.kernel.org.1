Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96BA32043CE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 00:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731333AbgFVWnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 18:43:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:59740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731275AbgFVWnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 18:43:06 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22EBA2078E;
        Mon, 22 Jun 2020 22:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592865786;
        bh=ZG0oMv+HAmfDvF6gKBVrwMs/TY/KDebSAxhQTCOFCJQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ci3EMpbouBoHNIOqrEXL813Y6Uhev2BcUCnKV5JtCD/fquS/TEwbJ+OHF02UUKYU0
         2dR5Iw6HdvcHvup2srVfNxf5ZKOLwq9wMkpmkubEJ4BTD+AjqTEwZb4lAKSDP3ufmt
         7zsUjkBWy9r5+gdTaT0ajC7QW3aS7PiQmcxjcDw4=
From:   Sasha Levin <sashal@kernel.org>
To:     peterz@infradead.org
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        jolsa@redhat.com, alexey.budankov@linux.intel.com,
        songliubraving@fb.com, acme@redhat.com, allison@lohutok.net,
        sashal@kernel.org
Subject: [PATCH v3 03/14] tools/kernel.h: extend with dummy RCU functions
Date:   Mon, 22 Jun 2020 18:42:47 -0400
Message-Id: <20200622224258.1208588-4-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200622224258.1208588-1-sashal@kernel.org>
References: <20200622224258.1208588-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These calls were added by 108c14858b9e ("locking/lockdep: Add support
for dynamic keys") and require no special handling in userspace, so just
add empty function definitions.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/include/linux/kernel.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/include/linux/kernel.h b/tools/include/linux/kernel.h
index a7e54a08fb54c..902d3b9ab4c17 100644
--- a/tools/include/linux/kernel.h
+++ b/tools/include/linux/kernel.h
@@ -117,4 +117,11 @@ int scnprintf_pad(char * buf, size_t size, const char * fmt, ...);
 #define current_gfp_context(k) 0
 #define synchronize_rcu()
 
+static __maybe_unused int system_state;
+#define SYSTEM_SCHEDULING 0
+
+#define might_sleep()
+#define rcu_read_lock()
+#define rcu_read_unlock()
+
 #endif
-- 
2.25.1

