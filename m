Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBD328F8FD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 20:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391264AbgJOS5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 14:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391254AbgJOS5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 14:57:31 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3510C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 11:57:30 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id k6so59606ior.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 11:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9nExquhmq7kGqXXiQ6rl8I+YnsVGmQrxmSu6wu+CdSY=;
        b=o32eOiTLUpQjvo7bKgLVs/aTlpTDYJb88imA44mZUSqFug24Q7Je3OKLNCNpClDpq8
         +9R5QV+7bTZf+x7fNVcv2+oKhFHMCUOydnpRxLroCJlrznUKbzU/b0QiMZdSAFEgwLFM
         Kt+61wfLjS3UrEXkZaCjNWceVvSn/MZhs8YbkEI+C7if6gSNuXty9I+viyUlIEyNqw+S
         uSM7KiTF42NhxAddG5n2NaUs8fVWfgI1UF6CCvZAB5416EWmg+UrsYmsP+bK4p1ViA77
         G0uo10oEnopa6VQ5oVJYZWnpwgJitr6Y46EygXjc9H5yud0oQaxUyzV66YbTU/2vPz0Z
         5T+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9nExquhmq7kGqXXiQ6rl8I+YnsVGmQrxmSu6wu+CdSY=;
        b=PQK1qPQb0iYAolZ37OhCbP9OxQGbTKLgwtCg5iQ0aIIsyUAwmnJ8eiL5MstBQcO0cn
         6dpY81RjpnXBC5wB6onuCCAFWdXG3IY65v4tsLT83DDwmGv6NoNCfafWtHpgZ0hT7mKn
         jBaliX1+5H0oFzAz6fBR96WvBt6Gcp7o7IXfGF3jhHiceBU4P21lQlpf4gEuzzQU7o3W
         bZuMgE+sqOXce5joPHbVDyaZG7mxjqnkvMWEL9PREFt2XEAWhogJTOBg1SznpVCOZcql
         i7nxOYyALmZ+XF65MII807Hl7fpHOyXChhp6TOtTZRwv6Msk+k9wNwPOtTzpG/7k5c+n
         kgLg==
X-Gm-Message-State: AOAM532WvKYHvxHZYnLBsB9WCB+rI9cnMT2LIfOmz3g43cGKfuMhQ6wJ
        Orq8WUd/fd50rs+HrB8FDzzAo2j5ZXw=
X-Google-Smtp-Source: ABdhPJzVA1OJRtE4NmjObQcfg424OGVm3z3+JHJhf4v9pzqwB2Y8QGtlKnyGJkUapXJLF9ll2meYtg==
X-Received: by 2002:a02:7817:: with SMTP id p23mr4609239jac.57.1602788250019;
        Thu, 15 Oct 2020 11:57:30 -0700 (PDT)
Received: from willemb.nyc.corp.google.com ([2620:0:1003:312:f693:9fff:fef4:3e8a])
        by smtp.gmail.com with ESMTPSA id s77sm4311450ilk.8.2020.10.15.11.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 11:57:29 -0700 (PDT)
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, tj@kernel.org,
        Willem de Bruijn <willemb@google.com>
Subject: [PATCH] kernfs: bring names in comments in line with code
Date:   Thu, 15 Oct 2020 14:57:26 -0400
Message-Id: <20201015185726.1386868-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Willem de Bruijn <willemb@google.com>

Fix two stragglers in the comments of the below rename operation.

Fixes: adc5e8b58f48 ("kernfs: drop s_ prefix from kernfs_node members")
Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 fs/kernfs/dir.c        | 2 +-
 include/linux/kernfs.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 9aec80b9d7c6..ea3c95125bf1 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -1599,7 +1599,7 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
 	return error;
 }
 
-/* Relationship between s_mode and the DT_xxx types */
+/* Relationship between mode and the DT_xxx types */
 static inline unsigned char dt_type(struct kernfs_node *kn)
 {
 	return (kn->mode >> 12) & 15;
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 89f6a4214a70..9e8ca8743c26 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -116,7 +116,7 @@ struct kernfs_elem_attr {
  * kernfs node is represented by single kernfs_node.  Most fields are
  * private to kernfs and shouldn't be accessed directly by kernfs users.
  *
- * As long as s_count reference is held, the kernfs_node itself is
+ * As long as count reference is held, the kernfs_node itself is
  * accessible.  Dereferencing elem or any other outer entity requires
  * active reference.
  */
-- 
2.29.0.rc1.297.gfa9743e501-goog

