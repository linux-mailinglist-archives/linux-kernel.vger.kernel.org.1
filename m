Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C37C27B1FD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 18:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgI1QfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 12:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbgI1QfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 12:35:20 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CCFC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:35:19 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id kk9so949824pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 09:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gSNI4aKIAgjaa3IWnWs5bKpT6ackNFBWDJoRKS0EH98=;
        b=kLqhFN7/bIhd9wUGI78A0ktoH07XgmRZDjrVQAc8bdiSY5sbjRd0KQ5BcMDjNJn4YH
         E25q2of6p9zDRYlVsaN3x7Iq4GKJn2areWyQRdDOI4i4HDxDZ4CtNoyCCZvkvmyTJ9a9
         zDy7W1IYNUQB+pETxN7DFxnKfre/pTE38Q6ZJSqf12rteCxF5CXKbacx2khW9wVo1RbN
         gTGJYdSqXShTzo2N8Zk8jN54Jitx1bYyqXDM/IMvACoGbmoslDcpUUHCFloGPOu8gXP0
         +QU4ZhuiJn2ANRF68wg3fvw3bESzHZpOB6BfycD4j4Iqu6+OMtpywnrU9FiN8wtxzMh2
         ruxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gSNI4aKIAgjaa3IWnWs5bKpT6ackNFBWDJoRKS0EH98=;
        b=Oarz4rMYppCPUtbyQ1c++PecD6k4s98spIT5sc+bsuUPi22l3+tlrcQA9w0JQioBuI
         LjFfSSqxWvmhNEu7F4fD4euyJ1R5hjR9loy+cOqTGYnKrQHBFNHM9YRUoEDKSKIxxHQw
         pw9aozKLTKJfcn2NgdCe5W6laF2CRXBQf6slXuMjt0l2nxBu0e5UVx0ffKaVqNeEp2qJ
         d4PWruRkQS0cTAFA63u6/tslz88/1KUuZ+jRqhKIS+OwRAs0xEcaW0A5hOuNimdN/LYp
         H/ObfpWjs++VJlasFvxuL4W6Rey5zusE51oZnOQhNXPA44wLr6VlpmGSdF2lz01mTeta
         JnYg==
X-Gm-Message-State: AOAM532eNLd1+/90kLLg8GC10Rd/h45JkBLeLkq/WxSL0AfWIJT0fwDe
        87NH20khERyL6ATW86DpQaChsueU9tB7xw==
X-Google-Smtp-Source: ABdhPJz+6aMCbhN+gVLQgyJolgCX8SUrFCFZ1ruiPcZVR/nvFJJyzSfEYpCpkzTChA2TCT7+0vUdyA==
X-Received: by 2002:a17:90a:d914:: with SMTP id c20mr167794pjv.34.1601310918968;
        Mon, 28 Sep 2020 09:35:18 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id f19sm2345640pfd.45.2020.09.28.09.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 09:35:18 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/25] coresight: Add coresight prefix to barrier_pkt
Date:   Mon, 28 Sep 2020 10:34:52 -0600
Message-Id: <20200928163513.70169-5-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200928163513.70169-1-mathieu.poirier@linaro.org>
References: <20200928163513.70169-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tingwei Zhang <tingwei@codeaurora.org>

Add coresight prefix to make it specific. It will be a export symbol.

Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etb10.c   | 2 +-
 drivers/hwtracing/coresight/coresight-priv.h    | 7 +++----
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 2 +-
 drivers/hwtracing/coresight/coresight.c         | 2 +-
 4 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 03e3f2590191..04ee9cda988d 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -525,7 +525,7 @@ static unsigned long etb_update_buffer(struct coresight_device *csdev,
 
 	cur = buf->cur;
 	offset = buf->offset;
-	barrier = barrier_pkt;
+	barrier = coresight_barrier_pkt;
 
 	for (i = 0; i < to_read; i += 4) {
 		buf_ptr = buf->data_pages[cur] + offset;
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index 28695e26e5c6..d638c7d48815 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -66,8 +66,8 @@ static DEVICE_ATTR_RO(name)
 #define coresight_simple_reg64(type, name, lo_off, hi_off)		\
 	__coresight_simple_func(type, NULL, name, lo_off, hi_off)
 
-extern const u32 barrier_pkt[4];
-#define CORESIGHT_BARRIER_PKT_SIZE (sizeof(barrier_pkt))
+extern const u32 coresight_barrier_pkt[4];
+#define CORESIGHT_BARRIER_PKT_SIZE (sizeof(coresight_barrier_pkt))
 
 enum etm_addr_type {
 	ETM_ADDR_TYPE_NONE,
@@ -104,10 +104,9 @@ struct cs_buffers {
 static inline void coresight_insert_barrier_packet(void *buf)
 {
 	if (buf)
-		memcpy(buf, barrier_pkt, CORESIGHT_BARRIER_PKT_SIZE);
+		memcpy(buf, coresight_barrier_pkt, CORESIGHT_BARRIER_PKT_SIZE);
 }
 
-
 static inline void CS_LOCK(void __iomem *addr)
 {
 	do {
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 6375504ba8b0..44402d413ebb 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -519,7 +519,7 @@ static unsigned long tmc_update_etf_buffer(struct coresight_device *csdev,
 
 	cur = buf->cur;
 	offset = buf->offset;
-	barrier = barrier_pkt;
+	barrier = coresight_barrier_pkt;
 
 	/* for every byte to read */
 	for (i = 0; i < to_read; i += 4) {
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index bb4f9e0a5438..ae40bb0539fd 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -53,7 +53,7 @@ static struct list_head *stm_path;
  * beginning of the data collected in a buffer.  That way the decoder knows that
  * it needs to look for another sync sequence.
  */
-const u32 barrier_pkt[4] = {0x7fffffff, 0x7fffffff, 0x7fffffff, 0x7fffffff};
+const u32 coresight_barrier_pkt[4] = {0x7fffffff, 0x7fffffff, 0x7fffffff, 0x7fffffff};
 
 static int coresight_id_match(struct device *dev, void *data)
 {
-- 
2.25.1

