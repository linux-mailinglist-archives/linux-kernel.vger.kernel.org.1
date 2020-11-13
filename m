Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 952532B22EF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 18:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgKMRrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 12:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbgKMRqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 12:46:52 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B40C0617A6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 09:46:52 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id o11so10577567ioo.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 09:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0XXhH7qcVrLXeOHTjqjbb9SlOasuwoAvKOqdPfs+ZZI=;
        b=LiZHAO+FzlcE+5DwCJmZb2Q6fHxkPymunRNrhdla31wrTq7VEJBoRagRW2Sbr9rr4C
         BtEMYb0LE7CNvn5NIqbfYgpiA0jFg00Osu14Y9CParAbyd/mFMrHwkU+kY43EZgDdv5+
         5AGo0gHKdq5JfUfZLqFT2pWxevxsBrfOydx0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0XXhH7qcVrLXeOHTjqjbb9SlOasuwoAvKOqdPfs+ZZI=;
        b=dHEUXnuIMl8ArQfGbRVfiZ18U1L5SfocGay7e+Z30UKB9tjdaPt3Rdy5xMzsXlqZDg
         T1fj2AxTiWGT87XdDCKtenGV3lgEiaEi5F/IAcSUpzpGo72nkMCm0tZM1vEBP7O6ZNWr
         RLcccKDSHDbcNilgjczyxPOo+hLwAu6b9Ldm0JNA0IHRmLqno13enMJPyjdkQcjz78Z+
         /Us0wKFnB7DquwPM1+HIfV/rvMnCDGthS7CJMMScxVBKHy+xfnzlaSNbctySIP7A3u5w
         c+g19hC0DFHZL1U6zBIgFMa8PJqMH8Aihi7YYH54cLtgk+KdVU8nQjRsbyyfqPYYPFC0
         lRkQ==
X-Gm-Message-State: AOAM531VY8KJ2SpZwMpz2CSlkFgP0PtRSLjK1Eawr8i0cJ2w0J0UMNlY
        ebDOW/HkUZGgYyqnfAVcTpBYBw==
X-Google-Smtp-Source: ABdhPJxB7CZ8T8JeyOZ0SHjxvEaIs/2j4OzqTcw/ETrRmPgGNbYYCeb+BS5kNo/mIfFgPyuwQKloCQ==
X-Received: by 2002:a6b:4a0d:: with SMTP id w13mr675503iob.104.1605289609057;
        Fri, 13 Nov 2020 09:46:49 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id y14sm4772585ilb.66.2020.11.13.09.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 09:46:48 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, gregkh@linuxfoundation.org,
        keescook@chromium.org, peterz@infradead.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/13] security/integrity/ima: converts stats to seqnum_ops
Date:   Fri, 13 Nov 2020 10:46:15 -0700
Message-Id: <581db581b900a01887ecfc3ec6b92e19d54cd2d9.1605287778.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1605287778.git.skhan@linuxfoundation.org>
References: <cover.1605287778.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sequence Number api provides interfaces for unsigned atomic up counters
leveraging atomic_t and atomic64_t ops underneath. Convert it to use
seqnum_ops.

atomic_t variables used for ima_htable.violations and number of stored
measurements and ios_threshold are atomic counters. Convert them to
seqnum_ops.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 security/integrity/ima/ima.h       | 5 +++--
 security/integrity/ima/ima_api.c   | 3 ++-
 security/integrity/ima/ima_fs.c    | 5 +++--
 security/integrity/ima/ima_queue.c | 7 ++++---
 4 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 6ebefec616e4..55fe1d14c67a 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -21,6 +21,7 @@
 #include <linux/tpm.h>
 #include <linux/audit.h>
 #include <crypto/hash_info.h>
+#include <linux/seqnum_ops.h>
 
 #include "../integrity.h"
 
@@ -174,8 +175,8 @@ int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
 extern spinlock_t ima_queue_lock;
 
 struct ima_h_table {
-	atomic_long_t len;	/* number of stored measurements in the list */
-	atomic_long_t violations;
+	struct seqnum64 len;	/* number of stored measurements in the list */
+	struct seqnum64 violations;
 	struct hlist_head queue[IMA_MEASURE_HTABLE_SIZE];
 };
 extern struct ima_h_table ima_htable;
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 4f39fb93f278..c6c442b93ce3 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -14,6 +14,7 @@
 #include <linux/xattr.h>
 #include <linux/evm.h>
 #include <linux/iversion.h>
+#include <linux/seqnum_ops.h>
 
 #include "ima.h"
 
@@ -144,7 +145,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
 	int result;
 
 	/* can overflow, only indicator */
-	atomic_long_inc(&ima_htable.violations);
+	seqnum64_inc_return(&ima_htable.violations);
 
 	result = ima_alloc_init_template(&event_data, &entry, NULL);
 	if (result < 0) {
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index ea8ff8a07b36..83a0d33e6f70 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -21,6 +21,7 @@
 #include <linux/rcupdate.h>
 #include <linux/parser.h>
 #include <linux/vmalloc.h>
+#include <linux/seqnum_ops.h>
 
 #include "ima.h"
 
@@ -39,12 +40,12 @@ __setup("ima_canonical_fmt", default_canonical_fmt_setup);
 static int valid_policy = 1;
 
 static ssize_t ima_show_htable_value(char __user *buf, size_t count,
-				     loff_t *ppos, atomic_long_t *val)
+				     loff_t *ppos, struct seqnum64 *val)
 {
 	char tmpbuf[32];	/* greater than largest 'long' string value */
 	ssize_t len;
 
-	len = scnprintf(tmpbuf, sizeof(tmpbuf), "%li\n", atomic_long_read(val));
+	len = scnprintf(tmpbuf, sizeof(tmpbuf), "%llu\n", seqnum64_fetch(val));
 	return simple_read_from_buffer(buf, count, ppos, tmpbuf, len);
 }
 
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index c096ef8945c7..38c31bc62358 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -17,6 +17,7 @@
 
 #include <linux/rculist.h>
 #include <linux/slab.h>
+#include <linux/seqnum_ops.h>
 #include "ima.h"
 
 #define AUDIT_CAUSE_LEN_MAX 32
@@ -33,8 +34,8 @@ static unsigned long binary_runtime_size = ULONG_MAX;
 
 /* key: inode (before secure-hashing a file) */
 struct ima_h_table ima_htable = {
-	.len = ATOMIC_LONG_INIT(0),
-	.violations = ATOMIC_LONG_INIT(0),
+	.len = SEQNUM_INIT(0),
+	.violations = SEQNUM_INIT(0),
 	.queue[0 ... IMA_MEASURE_HTABLE_SIZE - 1] = HLIST_HEAD_INIT
 };
 
@@ -106,7 +107,7 @@ static int ima_add_digest_entry(struct ima_template_entry *entry,
 	INIT_LIST_HEAD(&qe->later);
 	list_add_tail_rcu(&qe->later, &ima_measurements);
 
-	atomic_long_inc(&ima_htable.len);
+	seqnum64_inc_return(&ima_htable.len);
 	if (update_htable) {
 		key = ima_hash_key(entry->digests[ima_hash_algo_idx].digest);
 		hlist_add_head_rcu(&qe->hnext, &ima_htable.queue[key]);
-- 
2.27.0

