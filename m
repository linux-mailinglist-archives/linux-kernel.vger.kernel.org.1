Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9CBF1AF632
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Apr 2020 03:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbgDSB6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Apr 2020 21:58:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:34980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbgDSB57 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 21:57:59 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01A3E21D91;
        Sun, 19 Apr 2020 01:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587261479;
        bh=gyswfYZtdXPqF+LXQGoN3Io3M6E6chIV97t2MjFPJR0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EFhAL1p5iGR38hnLxopWgPvVDL8LV0zfSbuuqo3xQxRRZGpT0GUog/4iuplEngzLx
         skdRG/HCEr34HdbJxWV6oWUpiwVGHHCVB42f840c8ptiYWcjIp78fxrWUYzpC4yeW7
         a3UU/iJdyZDZ9VprIJSBnicKYzIiQUb5PNMlsY08=
From:   Sasha Levin <sashal@kernel.org>
To:     mingo@kernel.org, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, jolsa@redhat.com,
        alexey.budankov@linux.intel.com, songliubraving@fb.com,
        acme@redhat.com, allison@lohutok.net,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH v2 01/12] tools headers: Add kprobes.h header
Date:   Sat, 18 Apr 2020 21:57:43 -0400
Message-Id: <20200419015754.24456-2-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200419015754.24456-1-sashal@kernel.org>
References: <20200419015754.24456-1-sashal@kernel.org>
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
2.20.1

