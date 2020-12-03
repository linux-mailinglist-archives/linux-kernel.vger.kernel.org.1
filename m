Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88C842CE1C0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 23:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731855AbgLCWdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 17:33:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730482AbgLCWdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 17:33:52 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14AEC08E863
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 14:32:28 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id q22so2278524pfk.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 14:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=Fuz2jWCqrF9IAKxP8k6Nya5ZGJecRF+RgzAZtQ1aguQ=;
        b=mSKvNAn9sesScbpX87lSUu0mBqVCj8OIMbu7lykvRwzx5LshH7w3owEkRpyGpDXNcQ
         DxM4WmkNEEvxJZxM9Go3uBMBj8ABlHamANuZOo15qRHaDbHylqGBDQEpLvYQoPF+GGGu
         MfVvqgDftvy6DQaojUi43tAtX8XhMeId24Dy401VZ+WpA03KsgCjOCYjSWY8qu1yi584
         q1jsmVzYfI82cYCJP0qMEL5XH2HIfyMvZE2hC1ajHGstl7xzn0iwfuwuLuRgariPBInW
         YHktGRnAeDdeRREQp4P7QLY1f5FnfMuSUFRH0AXtLUet9I71rOEFUqNp/W6qXEfQPeEc
         6lfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=Fuz2jWCqrF9IAKxP8k6Nya5ZGJecRF+RgzAZtQ1aguQ=;
        b=nrw7wKPuy1PCMeCl0TaPd4SNoLx/d0DyKvh6jiyB5H8cXz3WP/ZTMgEogQO6qT9xYs
         ETzzeH10tlMV0RFWTiWL1Q7Za5/0d/n2X1xlS2n0ubPsPgpBCL1iJXX7YM8XJWxtNy0P
         VjITpVhegGlRBbKPkWpxofsOVavjp7s7pK4jK60mbkm7c0vc5jOS6JfLN/JQqDGBKTCp
         QS1JJ38JlMGstpfEmWNwg459igypiZrsn17MpZ+NeAXRcQT+8K1i4/WKABtdI4h1twjL
         Lo8hAbzJ3Gx3EQraED0GWBeFRU20BRmSJGPFQPiLbyLCFtEpwkJ9nwxtVrbcgT1stYBW
         EFjw==
X-Gm-Message-State: AOAM530pzTmngBycAI/SfIO3qtO6n/ftCk+78GSG+Zxk2nfF7IXfa7c9
        +PzNgSrUPHzGVgPDQgbB54ybQQ==
X-Google-Smtp-Source: ABdhPJx2WNV5k33+iBsSIbI9umTnQLWqfWRaWsln1Jxc6zjGtr+fhirdSbDdprGD/O3QhEedC5oQ8Q==
X-Received: by 2002:a62:8f4e:0:b029:18b:bd18:75b7 with SMTP id n75-20020a628f4e0000b029018bbd1875b7mr970569pfd.48.1607034748209;
        Thu, 03 Dec 2020 14:32:28 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id cq15sm332045pjb.27.2020.12.03.14.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 14:32:27 -0800 (PST)
Subject: [PATCH v1 2/5] uapi: Add dm-user structure definition
Date:   Thu,  3 Dec 2020 13:58:56 -0800
Message-Id: <20201203215859.2719888-3-palmer@dabbelt.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
In-Reply-To: <20201203215859.2719888-1-palmer@dabbelt.com>
References: <20201203215859.2719888-1-palmer@dabbelt.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     corbet@lwn.net, song@kernel.org,
        Palmer Dabbelt <palmerdabbelt@google.com>, shuah@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     dm-devel@redhat.com, agk@redhat.com, snitzer@redhat.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmerdabbelt@google.com>

dm-user is a device mapper target that allows a userspace process to
handle each incoming BIO.  Communication with userspace consists of a
stream of messages proxied over a misc device, the structure of each
message is defined in this header.

Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>

---

As it currently stands this isn't really sufficient to be a stable user
ABI.  These are probably best discussed in the context of the dm-user
implementation, though, where they're largely called out as FIXMEs.
---
 include/uapi/linux/dm-user.h | 67 ++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 include/uapi/linux/dm-user.h

diff --git a/include/uapi/linux/dm-user.h b/include/uapi/linux/dm-user.h
new file mode 100644
index 000000000000..1806109518f4
--- /dev/null
+++ b/include/uapi/linux/dm-user.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: LGPL-2.0+ WITH Linux-syscall-note */
+/*
+ * Copyright (C) 2020 Palmer Dabbelt <palmerdabbelt@google.com>
+ */
+
+#ifndef _LINUX_DM_USER_H
+#define _LINUX_DM_USER_H
+
+#include <linux/types.h>
+
+/*
+ * dm-user proxies device mapper ops between the kernel and userspace.  It's
+ * essentially just an RPC mechanism: all kernel calls create a request,
+ * userspace handles that with a response.  Userspace obtains requests via
+ * read() and provides responses via write().
+ *
+ * See Documentation/block/dm-user.rst for more information.
+ */
+
+#define DM_USER_REQ_MAP_READ 0
+#define DM_USER_REQ_MAP_WRITE 1
+#define DM_USER_REQ_MAP_FLUSH 2
+#define DM_USER_REQ_MAP_DISCARD 3
+#define DM_USER_REQ_MAP_SECURE_ERASE 4
+#define DM_USER_REQ_MAP_WRITE_SAME 5
+#define DM_USER_REQ_MAP_WRITE_ZEROES 6
+#define DM_USER_REQ_MAP_ZONE_OPEN 7
+#define DM_USER_REQ_MAP_ZONE_CLOSE 8
+#define DM_USER_REQ_MAP_ZONE_FINISH 9
+#define DM_USER_REQ_MAP_ZONE_APPEND 10
+#define DM_USER_REQ_MAP_ZONE_RESET 11
+#define DM_USER_REQ_MAP_ZONE_RESET_ALL 12
+
+#define DM_USER_REQ_MAP_FLAG_FAILFAST_DEV 0x00001
+#define DM_USER_REQ_MAP_FLAG_FAILFAST_TRANSPORT 0x00002
+#define DM_USER_REQ_MAP_FLAG_FAILFAST_DRIVER 0x00004
+#define DM_USER_REQ_MAP_FLAG_SYNC 0x00008
+#define DM_USER_REQ_MAP_FLAG_META 0x00010
+#define DM_USER_REQ_MAP_FLAG_PRIO 0x00020
+#define DM_USER_REQ_MAP_FLAG_NOMERGE 0x00040
+#define DM_USER_REQ_MAP_FLAG_IDLE 0x00080
+#define DM_USER_REQ_MAP_FLAG_INTEGRITY 0x00100
+#define DM_USER_REQ_MAP_FLAG_FUA 0x00200
+#define DM_USER_REQ_MAP_FLAG_PREFLUSH 0x00400
+#define DM_USER_REQ_MAP_FLAG_RAHEAD 0x00800
+#define DM_USER_REQ_MAP_FLAG_BACKGROUND 0x01000
+#define DM_USER_REQ_MAP_FLAG_NOWAIT 0x02000
+#define DM_USER_REQ_MAP_FLAG_CGROUP_PUNT 0x04000
+#define DM_USER_REQ_MAP_FLAG_NOUNMAP 0x08000
+#define DM_USER_REQ_MAP_FLAG_HIPRI 0x10000
+#define DM_USER_REQ_MAP_FLAG_DRV 0x20000
+#define DM_USER_REQ_MAP_FLAG_SWAP 0x40000
+
+#define DM_USER_RESP_SUCCESS 0
+#define DM_USER_RESP_ERROR 1
+#define DM_USER_RESP_UNSUPPORTED 2
+
+struct dm_user_message {
+	__u64 seq;
+	__u64 type;
+	__u64 flags;
+	__u64 sector;
+	__u64 len;
+	__u8 buf[];
+};
+
+#endif
-- 
2.29.2.454.gaff20da3a2-goog

