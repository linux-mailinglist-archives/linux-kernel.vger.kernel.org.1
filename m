Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0D62FE3EC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 08:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbhAUH2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 02:28:01 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:49249 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727344AbhAUHVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 02:21:43 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 10L7Kfi4023827;
        Thu, 21 Jan 2021 08:20:41 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, valentin.schneider@arm.com,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 1/9] tools/nolibc: the definition dup() was missing
Date:   Thu, 21 Jan 2021 08:20:23 +0100
Message-Id: <20210121072031.23777-2-w@1wt.eu>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20210121072031.23777-1-w@1wt.eu>
References: <20210121072031.23777-1-w@1wt.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dup() was mistakenly forgotten while sys_dup() was defined.
[This is nolibc's upstream commit 47cc42a79c92]

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/nolibc.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index e61d36cd4e50..3115c6467d10 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -1852,6 +1852,18 @@ int close(int fd)
 	return ret;
 }
 
+static __attribute__((unused))
+int dup(int fd)
+{
+	int ret = sys_dup(fd);
+
+	if (ret < 0) {
+		SET_ERRNO(-ret);
+		ret = -1;
+	}
+	return ret;
+}
+
 static __attribute__((unused))
 int dup2(int old, int new)
 {
-- 
2.28.0

