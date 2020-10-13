Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2045A28CD98
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 14:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbgJMMAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 08:00:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:58144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727473AbgJMLym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 07:54:42 -0400
Received: from mail.kernel.org (ip5f5ad5b2.dynamic.kabel-deutschland.de [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2C0C22384;
        Tue, 13 Oct 2020 11:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602590081;
        bh=hBdl3lIVj4oe9LNqfVXBf7iTw2vtsjwNz0H5DBowN7g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NR4vvpRDK31oV3OutaD555kjA5zix8kj3hXl2yNCQm9bDGef7raS82Ugm9xdq87iN
         uVJtNCHaR9/MAta6DPyPUEnfBpii89gXFED30z3htrXO4GuR/5CD4c6l4lEqcTV3nB
         y/K5g1rwQZC1B1O/SK3uGgcne39adCjZQVPCIT+8=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kSIt5-006CWG-Iu; Tue, 13 Oct 2020 13:54:39 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v6 66/80] locking/refcount: document the new "oldp" pointer value
Date:   Tue, 13 Oct 2020 13:54:21 +0200
Message-Id: <b233b8d610fae376472d0ef4e43b256efb69bdfa.1602589096.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602589096.git.mchehab+huawei@kernel.org>
References: <cover.1602589096.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset a435b9a14356 ("locking/refcount: Provide __refcount API to obtain the old value")
added a new parameter to most refcount functions, but didn't update
the kernel-doc markups.

Add a description for it on all touched functions.

Fixes: a435b9a14356 ("locking/refcount: Provide __refcount API to obtain the old value")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 include/linux/refcount.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/refcount.h b/include/linux/refcount.h
index 0e3ee25eb156..24c343bed889 100644
--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -151,6 +151,7 @@ static inline unsigned int refcount_read(const refcount_t *r)
  * refcount_add_not_zero - add a value to a refcount unless it is 0
  * @i: the value to add to the refcount
  * @r: the refcount
+ * @oldp: if not NULL, stores the previous value of the refcount
  *
  * Will saturate at REFCOUNT_SATURATED and WARN.
  *
@@ -184,6 +185,7 @@ static inline __must_check bool refcount_add_not_zero(int i, refcount_t *r)
  * refcount_add - add a value to a refcount
  * @i: the value to add to the refcount
  * @r: the refcount
+ * @oldp: if not NULL, stores the previous value of the refcount
  *
  * Similar to atomic_add(), but will saturate at REFCOUNT_SATURATED and WARN.
  *
@@ -209,6 +211,7 @@ static inline void refcount_add(int i, refcount_t *r)
 /**
  * refcount_inc_not_zero - increment a refcount unless it is 0
  * @r: the refcount to increment
+ * @oldp: if not NULL, stores the previous value of the refcount
  *
  * Similar to atomic_inc_not_zero(), but will saturate at REFCOUNT_SATURATED
  * and WARN.
@@ -227,6 +230,7 @@ static inline __must_check bool refcount_inc_not_zero(refcount_t *r)
 /**
  * refcount_inc - increment a refcount
  * @r: the refcount to increment
+ * @oldp: if not NULL, stores the previous value of the refcount
  *
  * Similar to atomic_inc(), but will saturate at REFCOUNT_SATURATED and WARN.
  *
@@ -245,6 +249,7 @@ static inline void refcount_inc(refcount_t *r)
  * refcount_sub_and_test - subtract from a refcount and test if it is 0
  * @i: amount to subtract from the refcount
  * @r: the refcount
+ * @oldp: if not NULL, stores the previous value of the refcount
  *
  * Similar to atomic_dec_and_test(), but it will WARN, return false and
  * ultimately leak on underflow and will fail to decrement when saturated
@@ -279,6 +284,7 @@ static inline __must_check bool refcount_sub_and_test(int i, refcount_t *r)
 /**
  * refcount_dec_and_test - decrement a refcount and test if it is 0
  * @r: the refcount
+ * @oldp: if not NULL, stores the previous value of the refcount
  *
  * Similar to atomic_dec_and_test(), it will WARN on underflow and fail to
  * decrement when saturated at REFCOUNT_SATURATED.
@@ -297,6 +303,7 @@ static inline __must_check bool refcount_dec_and_test(refcount_t *r)
 /**
  * refcount_dec - decrement a refcount
  * @r: the refcount
+ * @oldp: if not NULL, stores the previous value of the refcount
  *
  * Similar to atomic_dec(), it will WARN on underflow and fail to decrement
  * when saturated at REFCOUNT_SATURATED.
-- 
2.26.2

