Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB342CA235
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 13:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbgLAMKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 07:10:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:40526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730754AbgLAMKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 07:10:37 -0500
Received: from mail.kernel.org (unknown [95.90.213.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66570221EB;
        Tue,  1 Dec 2020 12:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606824555;
        bh=DreSxhkMMB3tGmZOHNv6fA7UpQIlvb/ogVoiJVVWjjc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wsShp1icSluoIt2SoQfqu9N4NfaDFScUsO/6kVwWgGkKrnc2mbM0QCg4HjnC/TUpu
         RLaRJ4046yYc0TGI2E9jZrfcPc/0uSKMIGK0J0718FGjHeGUucy8Fdi2QMXnOFicCJ
         /56GcqZ5h2AcXabc0wUqjOl/oTQAL/CGP8UjoC8U=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kk4T3-00DGdU-A3; Tue, 01 Dec 2020 13:09:13 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v5 15/16] refcount.h: fix a kernel-doc markup
Date:   Tue,  1 Dec 2020 13:09:08 +0100
Message-Id: <afb9bb1e675bf5f72a34a55d780779d7d5916b4c.1606823973.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1606823973.git.mchehab+huawei@kernel.org>
References: <cover.1606823973.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel-doc markup is wrong: it is asking the tool to document
struct refcount_struct, instead of documenting typedef refcount_t.

Fix it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 include/linux/refcount.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/refcount.h b/include/linux/refcount.h
index 497990c69b0b..b8a6e387f8f9 100644
--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -72,65 +72,65 @@
  * Do note that inc_not_zero() provides a control dependency which will order
  * future stores against the inc, this ensures we'll never modify the object
  * if we did not in fact acquire a reference.
  *
  * The decrements will provide release order, such that all the prior loads and
  * stores will be issued before, it also provides a control dependency, which
  * will order us against the subsequent free().
  *
  * The control dependency is against the load of the cmpxchg (ll/sc) that
  * succeeded. This means the stores aren't fully ordered, but this is fine
  * because the 1->0 transition indicates no concurrency.
  *
  * Note that the allocator is responsible for ordering things between free()
  * and alloc().
  *
  * The decrements dec_and_test() and sub_and_test() also provide acquire
  * ordering on success.
  *
  */
 
 #ifndef _LINUX_REFCOUNT_H
 #define _LINUX_REFCOUNT_H
 
 #include <linux/atomic.h>
 #include <linux/bug.h>
 #include <linux/compiler.h>
 #include <linux/limits.h>
 #include <linux/spinlock_types.h>
 
 struct mutex;
 
 /**
- * struct refcount_t - variant of atomic_t specialized for reference counts
+ * typedef refcount_t - variant of atomic_t specialized for reference counts
  * @refs: atomic_t counter field
  *
  * The counter saturates at REFCOUNT_SATURATED and will not move once
  * there. This avoids wrapping the counter and causing 'spurious'
  * use-after-free bugs.
  */
 typedef struct refcount_struct {
 	atomic_t refs;
 } refcount_t;
 
 #define REFCOUNT_INIT(n)	{ .refs = ATOMIC_INIT(n), }
 #define REFCOUNT_MAX		INT_MAX
 #define REFCOUNT_SATURATED	(INT_MIN / 2)
 
 enum refcount_saturation_type {
 	REFCOUNT_ADD_NOT_ZERO_OVF,
 	REFCOUNT_ADD_OVF,
 	REFCOUNT_ADD_UAF,
 	REFCOUNT_SUB_UAF,
 	REFCOUNT_DEC_LEAK,
 };
 
 void refcount_warn_saturate(refcount_t *r, enum refcount_saturation_type t);
 
 /**
  * refcount_set - set a refcount's value
  * @r: the refcount
  * @n: value to which the refcount will be set
  */
 static inline void refcount_set(refcount_t *r, int n)
 {
 	atomic_set(&r->refs, n);
-- 
2.28.0

