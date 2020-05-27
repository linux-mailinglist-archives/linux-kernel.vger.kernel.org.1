Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 319B81E4821
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 17:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390028AbgE0PsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 11:48:11 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:44218 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbgE0PsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:48:09 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id BBFFF2A3AC0
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org
Cc:     mingo@redhat.com, dvhart@infradead.org, kernel@collabora.com,
        krisman@collabora.com,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH 4/4] futex: Consistently use fshared as boolean
Date:   Wed, 27 May 2020 12:47:47 -0300
Message-Id: <20200527154747.36931-5-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527154747.36931-1-andrealmeid@collabora.com>
References: <20200527154747.36931-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since fshared is meant to true/false values, declare it as bool. If the
code ever reaches the code beneath again label, we are sure that the
futex is shared, so we can use the true value instead of the variable.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 kernel/futex.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index 7bc5340396aa..a04f3793114f 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -457,7 +457,7 @@ static u64 get_inode_sequence_number(struct inode *inode)
 /**
  * get_futex_key() - Get parameters which are the keys for a futex
  * @uaddr:	virtual address of the futex
- * @fshared:	0 for a PROCESS_PRIVATE futex, 1 for PROCESS_SHARED
+ * @fshared:	false for a PROCESS_PRIVATE futex, true for PROCESS_SHARED
  * @key:	address where result is stored.
  * @rw:		mapping needs to be read/write (values: FUTEX_READ,
  *              FUTEX_WRITE)
@@ -479,7 +479,8 @@ static u64 get_inode_sequence_number(struct inode *inode)
  * lock_page() might sleep, the caller should not hold a spinlock.
  */
 static int
-get_futex_key(u32 __user *uaddr, int fshared, union futex_key *key, enum futex_access rw)
+get_futex_key(u32 __user *uaddr, bool fshared, union futex_key *key,
+	      enum futex_access rw)
 {
 	unsigned long address = (unsigned long)uaddr;
 	struct mm_struct *mm = current->mm;
@@ -516,7 +517,7 @@ get_futex_key(u32 __user *uaddr, int fshared, union futex_key *key, enum futex_a
 
 again:
 	/* Ignore any VERIFY_READ mapping (futex common case) */
-	if (unlikely(should_fail_futex(fshared)))
+	if (unlikely(should_fail_futex(true)))
 		return -EFAULT;
 
 	err = get_user_pages_fast(address, 1, FOLL_WRITE, &page);
@@ -604,7 +605,7 @@ get_futex_key(u32 __user *uaddr, int fshared, union futex_key *key, enum futex_a
 		 * A RO anonymous page will never change and thus doesn't make
 		 * sense for futex operations.
 		 */
-		if (unlikely(should_fail_futex(fshared)) || ro) {
+		if (unlikely(should_fail_futex(true)) || ro) {
 			err = -EFAULT;
 			goto out;
 		}
-- 
2.26.2

