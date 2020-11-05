Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F375A2A8981
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 23:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732647AbgKEWD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 17:03:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:59894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732600AbgKEWD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 17:03:26 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AB5120936;
        Thu,  5 Nov 2020 22:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604613805;
        bh=2+HotQE+QHTjPInTwscwXtw7Cu74cQYbDgwRy6uoWSs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jpi8vFYw5w/SN0IHCGdTyQJsnIPAR4C0X0VjvEEmyz5eQPKGKJ/9TfjN1oYSAy/1o
         Qon0nuKQxKXefanlgU/UJuv4j7CWrAVrwMEwtooMLQqXZQ6f8XZrr/2Fku4PYfCa6t
         8YBx2o49UrD6sn7/fB5nzKNEdRQOYbmQjTjF31h4=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 2/3] kcsan: Never set up watchpoints on NULL pointers
Date:   Thu,  5 Nov 2020 14:03:23 -0800
Message-Id: <20201105220324.15808-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105220302.GA15733@paulmck-ThinkPad-P72>
References: <20201105220302.GA15733@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

Avoid setting up watchpoints on NULL pointers, as otherwise we would
crash inside the KCSAN runtime (when checking for value changes) instead
of the instrumented code.

Because that may be confusing, skip any address less than PAGE_SIZE.

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/encoding.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/kcsan/encoding.h b/kernel/kcsan/encoding.h
index 1a6db2f..4f73db6 100644
--- a/kernel/kcsan/encoding.h
+++ b/kernel/kcsan/encoding.h
@@ -48,7 +48,11 @@
 
 static inline bool check_encodable(unsigned long addr, size_t size)
 {
-	return size <= MAX_ENCODABLE_SIZE;
+	/*
+	 * While we can encode addrs<PAGE_SIZE, avoid crashing with a NULL
+	 * pointer deref inside KCSAN.
+	 */
+	return addr >= PAGE_SIZE && size <= MAX_ENCODABLE_SIZE;
 }
 
 static inline long
-- 
2.9.5

