Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF4FC1AF635
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Apr 2020 03:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgDSB6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Apr 2020 21:58:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:35214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726123AbgDSB6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 21:58:06 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 949B222209;
        Sun, 19 Apr 2020 01:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587261485;
        bh=9s1PS3TUw7Zsqgs3UGzHhRFfsoLeo9wjHRqNuA7KWTU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ePzuP7ikNlCmbFI3pygAZAlpB685sVlxstJtdh/3uGQ9q3ofyqIhCPC0/V1EFw11M
         F6TMxL/DDOqS0g7REkZiJYBRxe1sXydwl97KPIRIc9aYNIkwHxsKCybZ6c0/yU7huA
         2DUrcK58MVTr/+/tzhnADlOW37eTIt+RJsGo0eZo=
From:   Sasha Levin <sashal@kernel.org>
To:     mingo@kernel.org, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, jolsa@redhat.com,
        alexey.budankov@linux.intel.com, songliubraving@fb.com,
        acme@redhat.com, allison@lohutok.net,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH v2 06/12] tools/kernel.h: add BUILD_BUG_ON_NOT_POWER_OF_2 macro
Date:   Sat, 18 Apr 2020 21:57:48 -0400
Message-Id: <20200419015754.24456-7-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200419015754.24456-1-sashal@kernel.org>
References: <20200419015754.24456-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is now needed as a result of 12593b7467f9 ("locking/lockdep: Reduce
space occupied by stack traces").

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/include/linux/kernel.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/include/linux/kernel.h b/tools/include/linux/kernel.h
index d2b3e1cc0218e..cc3d60623ca47 100644
--- a/tools/include/linux/kernel.h
+++ b/tools/include/linux/kernel.h
@@ -38,6 +38,12 @@
 #define BUILD_BUG_ON(condition) ((void)sizeof(char[1 - 2*!!(condition)]))
 #define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:-!!(e); }))
 
+/* Force a compilation error if a constant expression is not a power of 2 */
+#define __BUILD_BUG_ON_NOT_POWER_OF_2(n)        \
+	BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
+#define BUILD_BUG_ON_NOT_POWER_OF_2(n)                  \
+	BUILD_BUG_ON((n) == 0 || (((n) & ((n) - 1)) != 0))
+
 #ifndef max
 #define max(x, y) ({				\
 	typeof(x) _max1 = (x);			\
-- 
2.20.1

