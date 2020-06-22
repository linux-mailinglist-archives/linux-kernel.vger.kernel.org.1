Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A83592043E9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 00:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731497AbgFVWo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 18:44:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:59706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730937AbgFVWnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 18:43:03 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 680F12084D;
        Mon, 22 Jun 2020 22:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592865783;
        bh=9CtMykP6oJ+nIhNvBvmA2uj0QvW5lXqLZxmIqM3j2LI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IyoPhIWVH/IK03GN5qJpcQWJ+ldGfRIVtOd5fzR7iSR7JWjykpOKUnTQGzgIa5oY1
         I5rV8GGJDI8KFlw48Lj/vdCjmHTObI5Ese3xupWIPCOdo3ty9DIIMoJCuWaF8Bbuom
         YWWUYihjikwQB/XYn1CeSilCOKXwtwW0N/eNGgu4=
From:   Sasha Levin <sashal@kernel.org>
To:     peterz@infradead.org
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        jolsa@redhat.com, alexey.budankov@linux.intel.com,
        songliubraving@fb.com, acme@redhat.com, allison@lohutok.net,
        sashal@kernel.org
Subject: [PATCH v3 01/14] tools headers: Add kprobes.h header
Date:   Mon, 22 Jun 2020 18:42:45 -0400
Message-Id: <20200622224258.1208588-2-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200622224258.1208588-1-sashal@kernel.org>
References: <20200622224258.1208588-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is now needed by liblockdep as a result of 2f43c6022d84 ("kprobes:
Prohibit probing on lockdep functions").

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/include/linux/kprobes.h | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 tools/include/linux/kprobes.h

diff --git a/tools/include/linux/kprobes.h b/tools/include/linux/kprobes.h
new file mode 100644
index 0000000000000..f665725ea4d59
--- /dev/null
+++ b/tools/include/linux/kprobes.h
@@ -0,0 +1,7 @@
+#ifndef _TOOLS_LINUX_KPROBES_H_
+#define _TOOLS_LINUX_KPROBES_H_
+
+#define NOKPROBE_SYMBOL(x)
+#define nokprobe_inline
+
+#endif
-- 
2.25.1

