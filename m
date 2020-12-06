Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF53B2D05F4
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 17:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbgLFQaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 11:30:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:45508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbgLFQaB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 11:30:01 -0500
From:   Oded Gabbay <ogabbay@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai, Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 2/2] habanalabs: allow user to pass a staged submission seq
Date:   Sun,  6 Dec 2020 18:28:35 +0200
Message-Id: <20201206162835.4088-6-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201206162835.4088-1-ogabbay@kernel.org>
References: <20201206162835.4088-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

In order to support the staged submission feature, user must be
allowed to use the same CS sequence for all submissions in the
same staged submission.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../habanalabs/common/command_submission.c    | 16 +++++++----
 include/uapi/misc/habanalabs.h                | 28 +++++++++++++------
 2 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index ac527682cd8c..a22c2751eaa1 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -792,7 +792,7 @@ static int hl_cs_copy_chunk_array(struct hl_device *hdev,
 }
 
 static int cs_ioctl_default(struct hl_fpriv *hpriv, void __user *chunks,
-				u32 num_chunks, u64 *cs_seq, bool timestamp)
+				u32 num_chunks, u64 *cs_seq, u32 flags)
 {
 	bool int_queues_only = true;
 	struct hl_device *hdev = hpriv->hdev;
@@ -819,7 +819,7 @@ static int cs_ioctl_default(struct hl_fpriv *hpriv, void __user *chunks,
 		goto free_cs_chunk_array;
 	}
 
-	cs->timestamp = !!timestamp;
+	cs->timestamp = !!(flags & HL_CS_FLAGS_TIMESTAMP);
 	*cs_seq = cs->sequence;
 
 	hl_debugfs_add_cs(cs);
@@ -988,7 +988,7 @@ static int hl_cs_ctx_switch(struct hl_fpriv *hpriv, union hl_cs_args *args,
 			rc = 0;
 		} else {
 			rc = cs_ioctl_default(hpriv, chunks, num_chunks,
-						cs_seq, false);
+								cs_seq, 0);
 		}
 
 		mutex_unlock(&hpriv->restore_phase_mutex);
@@ -1308,7 +1308,7 @@ int hl_cs_ioctl(struct hl_fpriv *hpriv, void *data)
 	enum hl_cs_type cs_type;
 	u64 cs_seq = ULONG_MAX;
 	void __user *chunks;
-	u32 num_chunks;
+	u32 num_chunks, flags;
 	int rc;
 
 	rc = hl_cs_sanity_checks(hpriv, args);
@@ -1323,6 +1323,12 @@ int hl_cs_ioctl(struct hl_fpriv *hpriv, void *data)
 					~HL_CS_FLAGS_FORCE_RESTORE);
 	chunks = (void __user *) (uintptr_t) args->in.chunks_execute;
 	num_chunks = args->in.num_chunks_execute;
+	flags = args->in.cs_flags;
+
+	/* In case this is a staged CS, user should supply the CS sequence */
+	if ((flags & HL_CS_FLAGS_STAGED_SUBMISSION) &&
+			!(flags & HL_CS_FLAGS_STAGED_SUBMISSION_FIRST))
+		cs_seq = args->in.seq;
 
 	switch (cs_type) {
 	case CS_TYPE_SIGNAL:
@@ -1333,7 +1339,7 @@ int hl_cs_ioctl(struct hl_fpriv *hpriv, void *data)
 		break;
 	default:
 		rc = cs_ioctl_default(hpriv, chunks, num_chunks, &cs_seq,
-				args->in.cs_flags & HL_CS_FLAGS_TIMESTAMP);
+							args->in.cs_flags);
 		break;
 	}
 
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index dc8bcec195cc..8a5e60a6dae0 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -600,11 +600,14 @@ struct hl_cs_chunk {
 };
 
 /* SIGNAL and WAIT/COLLECTIVE_WAIT flags are mutually exclusive */
-#define HL_CS_FLAGS_FORCE_RESTORE	0x1
-#define HL_CS_FLAGS_SIGNAL		0x2
-#define HL_CS_FLAGS_WAIT		0x4
-#define HL_CS_FLAGS_COLLECTIVE_WAIT	0x8
-#define HL_CS_FLAGS_TIMESTAMP		0x20
+#define HL_CS_FLAGS_FORCE_RESTORE		0x1
+#define HL_CS_FLAGS_SIGNAL			0x2
+#define HL_CS_FLAGS_WAIT			0x4
+#define HL_CS_FLAGS_COLLECTIVE_WAIT		0x8
+#define HL_CS_FLAGS_TIMESTAMP			0x20
+#define HL_CS_FLAGS_STAGED_SUBMISSION		0x40
+#define HL_CS_FLAGS_STAGED_SUBMISSION_FIRST	0x80
+#define HL_CS_FLAGS_STAGED_SUBMISSION_LAST	0x100
 
 #define HL_CS_STATUS_SUCCESS		0
 
@@ -618,10 +621,17 @@ struct hl_cs_in {
 	/* holds address of array of hl_cs_chunk for execution phase */
 	__u64 chunks_execute;
 
-	/* this holds address of array of hl_cs_chunk for store phase -
-	 * Currently not in use
-	 */
-	__u64 chunks_store;
+	union {
+		/* this holds address of array of hl_cs_chunk for store phase -
+		 * Currently not in use
+		 */
+		__u64 chunks_store;
+
+		/* Sequence number of a staged submission CS
+		 * valid only if HL_CS_FLAGS_STAGED_SUBMISSION is set
+		 */
+		__u64 seq;
+	};
 
 	/* Number of chunks in restore phase array. Maximum number is
 	 * HL_MAX_JOBS_PER_CS
-- 
2.17.1

