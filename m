Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6CA23C277
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Aug 2020 02:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgHEAKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 20:10:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:46822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727863AbgHEAKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 20:10:47 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70F8E2177B;
        Wed,  5 Aug 2020 00:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596586247;
        bh=9CtMykP6oJ+nIhNvBvmA2uj0QvW5lXqLZxmIqM3j2LI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GFdlGbxcrbp3270MlGfrZ8Q+siwyz1R42hHyJdi5IiHA8/xQOw4reIJor3tFnH+NV
         aKzgNKqBvMcKTIcH4WUuxqsQLBvay6HXgUZhUVQUTccTG58/PuDCiKmYEXFpeGV7YG
         VDE++BowBLkgjH98NeqegIeXwOcrFft6Zp6MgX9w=
From:   Sasha Levin <sashal@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     mingo@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH v4 01/14] tools headers: Add kprobes.h header
Date:   Tue,  4 Aug 2020 20:10:30 -0400
Message-Id: <20200805001043.3331907-2-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200805001043.3331907-1-sashal@kernel.org>
References: <20200805001043.3331907-1-sashal@kernel.org>
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

