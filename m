Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 415E42580BC
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 20:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729661AbgHaSSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 14:18:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:51734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729420AbgHaSSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:18:08 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A0E621548;
        Mon, 31 Aug 2020 18:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598897887;
        bh=JZzcvhBHgf45+Cg48Gn+T3E4XDtu40+IMTpazm85zU0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=krx4K0jklm6lfWNIs1x3SDbjNpM9qroeDdR9DPXTUVPwMZHSF3H+mqlWPQAGKT1o8
         Z7tCajikUAmcZRF3aJoGzbLabkSdmvEZT++RwfdfEDY5AQ6HVT286XOUz+ASFzDA5g
         uVJsf1kyenmfIIukIrUiUWpvUZD8PPJ6Zm/S0BdM=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 09/19] instrumented.h: Introduce read-write instrumentation hooks
Date:   Mon, 31 Aug 2020 11:17:55 -0700
Message-Id: <20200831181805.1833-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831181715.GA1530@paulmck-ThinkPad-P72>
References: <20200831181715.GA1530@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

Introduce read-write instrumentation hooks, to more precisely denote an
operation's behaviour.

KCSAN is able to distinguish compound instrumentation, and with the new
instrumentation we then benefit from improved reporting. More
importantly, read-write compound operations should not implicitly be
treated as atomic, if they aren't actually atomic.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/instrumented.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/include/linux/instrumented.h b/include/linux/instrumented.h
index 43e6ea5..42faebb 100644
--- a/include/linux/instrumented.h
+++ b/include/linux/instrumented.h
@@ -43,6 +43,21 @@ static __always_inline void instrument_write(const volatile void *v, size_t size
 }
 
 /**
+ * instrument_read_write - instrument regular read-write access
+ *
+ * Instrument a regular write access. The instrumentation should be inserted
+ * before the actual write happens.
+ *
+ * @ptr address of access
+ * @size size of access
+ */
+static __always_inline void instrument_read_write(const volatile void *v, size_t size)
+{
+	kasan_check_write(v, size);
+	kcsan_check_read_write(v, size);
+}
+
+/**
  * instrument_atomic_read - instrument atomic read access
  *
  * Instrument an atomic read access. The instrumentation should be inserted
@@ -73,6 +88,21 @@ static __always_inline void instrument_atomic_write(const volatile void *v, size
 }
 
 /**
+ * instrument_atomic_read_write - instrument atomic read-write access
+ *
+ * Instrument an atomic read-write access. The instrumentation should be
+ * inserted before the actual write happens.
+ *
+ * @ptr address of access
+ * @size size of access
+ */
+static __always_inline void instrument_atomic_read_write(const volatile void *v, size_t size)
+{
+	kasan_check_write(v, size);
+	kcsan_check_atomic_read_write(v, size);
+}
+
+/**
  * instrument_copy_to_user - instrument reads of copy_to_user
  *
  * Instrument reads from kernel memory, that are due to copy_to_user (and
-- 
2.9.5

