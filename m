Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB8AB296152
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 16:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368438AbgJVO7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 10:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S368372AbgJVO6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 10:58:53 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59541C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 07:58:52 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id y12so2836793wrp.6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 07:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HP0yem2/pbPxTraBnyEoAOVePxBRk4UaWg5TENDbElY=;
        b=S/DWPV7j+tZt46pYIr9smmBRpxn2Rz3c4bRxGzjRjXjJe4B69Q4ScAOJacCBnU6wmh
         ABpNlW8LArUuGcA0AzCdxXwaKEj/LDbnLlDP9hwTM8lOi/dlRoDXoDvvZWDOKCtkqK9/
         QFYOUpEj9zxmM0+uPjQEQi8cq46KbwnD5E1aioGKJZ4x/JIBfEhorIJUh5F6KgFuDyqW
         TC5nLO1xaQrqYOoBg7ZulOSBwVYSYDpexOVJtX48t4tWxD4l4JeKWL803f2M8hTpnuns
         OI8cTGzBn9rX3/HPdel8F33HdWuEYuaAFspX+WzwO4Np9dbd4b/R+KgV64Uw+K0F7yKI
         tlMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HP0yem2/pbPxTraBnyEoAOVePxBRk4UaWg5TENDbElY=;
        b=os6Kbvm827TOdyPobxIq9yH8L8Gu9/eJtmXeFKIScpXDQHeMip356ShUQZEk0HrJVo
         1F0WzrOK2Fp4uPMGZXyw5W1WjFk9lwZxkzP8AKrd3Azsq2mJFI863tSdMJjEj+gp8F3Q
         wnZ2O2fSyxcy8sGhHWTI2ix7aS7QxK4y9C63kzAhdv+n3iX9SKbO+e9al8EARgmG874E
         s8KP8/Jg+B00mFAyJPF7XhBIDfe3dsVVeXFbfQhHwXzp7ifB0wDZ0Gwp5p/e4e0+cWvN
         oPZT+wGZe6m2kjULxndDjtm1Jjgrh1FuB1oemAgqa6x5z78JXoUxKCkFpWVU48ozvEeJ
         nkBA==
X-Gm-Message-State: AOAM530J9nOTAfXm04C0+uNO6ENAu52eMsOoqGUgFawdc+qQRaD51HWL
        4hUIKhoksesQYMEaGdGhNVnQlQ==
X-Google-Smtp-Source: ABdhPJy4J7SVHb+8EJM1u710+pulCvV9421vAdKlI0xF0OENx1IJHLbgiTDwVrI9Y1Vr1RcArq9c7g==
X-Received: by 2002:adf:e50b:: with SMTP id j11mr3219226wrm.263.1603378730993;
        Thu, 22 Oct 2020 07:58:50 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id 130sm4348021wmd.18.2020.10.22.07.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 07:58:50 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Wei Li <liwei391@huawei.com>,
        James Clark <james.clark@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Al Grant <Al.Grant@arm.com>, Dave Martin <Dave.Martin@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 17/20] perf arm-spe: Refactor operation packet handling
Date:   Thu, 22 Oct 2020 15:58:13 +0100
Message-Id: <20201022145816.14069-18-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201022145816.14069-1-leo.yan@linaro.org>
References: <20201022145816.14069-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Defines macros for operation packet header and formats (support sub
classes for 'other', 'branch', 'load and store', etc).  Uses these
macros for operation packet decoding and dumping.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 34 +++++++++++--------
 .../arm-spe-decoder/arm-spe-pkt-decoder.h     | 26 ++++++++++++++
 2 files changed, 45 insertions(+), 15 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 19d05d9734ab..59b538563d31 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -144,7 +144,7 @@ static int arm_spe_get_op_type(const unsigned char *buf, size_t len,
 			       struct arm_spe_pkt *packet)
 {
 	packet->type = ARM_SPE_OP_TYPE;
-	packet->index = buf[0] & 0x3;
+	packet->index = SPE_OP_PKT_HDR_CLASS(buf[0]);
 	return arm_spe_get_payload(buf, len, 0, packet);
 }
 
@@ -339,37 +339,39 @@ static int arm_spe_pkt_desc_event(const struct arm_spe_pkt *packet,
 static int arm_spe_pkt_desc_op_type(const struct arm_spe_pkt *packet,
 				    char *buf, size_t buf_len)
 {
-	int ret, idx = packet->index;
+	int ret, class = packet->index;
 	unsigned long long payload = packet->payload;
 	size_t blen = buf_len;
 
-	switch (idx) {
-	case 0:
+	switch (class) {
+	case SPE_OP_PKT_HDR_CLASS_OTHER:
 		return arm_spe_pkt_snprintf(&buf, &blen,
-				payload & 0x1 ? "COND-SELECT" : "INSN-OTHER");
-	case 1:
+			payload & SPE_OP_PKT_COND ? "COND-SELECT" : "INSN-OTHER");
+	case SPE_OP_PKT_HDR_CLASS_LD_ST_ATOMIC:
 		ret = arm_spe_pkt_snprintf(&buf, &blen,
-					   payload & 0x1 ? "ST" : "LD");
+					   payload & SPE_OP_PKT_ST ? "ST" : "LD");
 		if (ret < 0)
 			return ret;
 
-		if (payload & 0x2) {
-			if (payload & 0x4) {
+		if (SPE_OP_PKT_LDST_SUBCLASS_ATOMIC_GET(payload) ==
+					SPE_OP_PKT_LDST_SUBCLASS_ATOMIC) {
+			if (payload & SPE_OP_PKT_AT) {
 				ret = arm_spe_pkt_snprintf(&buf, &blen, " AT");
 				if (ret < 0)
 					return ret;
 			}
-			if (payload & 0x8) {
+			if (payload & SPE_OP_PKT_EXCL) {
 				ret = arm_spe_pkt_snprintf(&buf, &blen, " EXCL");
 				if (ret < 0)
 					return ret;
 			}
-			if (payload & 0x10) {
+			if (payload & SPE_OP_PKT_AR) {
 				ret = arm_spe_pkt_snprintf(&buf, &blen, " AR");
 				if (ret < 0)
 					return ret;
 			}
-		} else if (payload & 0x4) {
+		} else if (SPE_OP_PKT_LDST_SUBCLASS_GET(payload) ==
+					SPE_OP_PKT_LDST_SUBCLASS_SIMD_FP) {
 			ret = arm_spe_pkt_snprintf(&buf, &blen, " SIMD-FP");
 			if (ret < 0)
 				return ret;
@@ -377,17 +379,19 @@ static int arm_spe_pkt_desc_op_type(const struct arm_spe_pkt *packet,
 
 		return buf_len - blen;
 
-	case 2:
+	case SPE_OP_PKT_HDR_CLASS_BR_ERET:
 		ret = arm_spe_pkt_snprintf(&buf, &blen, "B");
 		if (ret < 0)
 			return ret;
 
-		if (payload & 0x1) {
+		if (payload & SPE_OP_PKT_COND) {
 			ret = arm_spe_pkt_snprintf(&buf, &blen, " COND");
 			if (ret < 0)
 				return ret;
 		}
-		if (payload & 0x2) {
+
+		if (SPE_OP_PKT_BRANCH_SUBCLASS_GET(payload) ==
+				SPE_OP_PKT_BRANCH_SUBCLASS_INDIRECT) {
 			ret = arm_spe_pkt_snprintf(&buf, &blen, " IND");
 			if (ret < 0)
 				return ret;
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
index 12c344454cf1..31dbb8c0fde3 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
@@ -110,6 +110,32 @@ enum arm_spe_events {
 	EV_EMPTY_PREDICATE	= 18,
 };
 
+/* Operation packet header */
+#define SPE_OP_PKT_HDR_CLASS(h)			((h) & GENMASK_ULL(1, 0))
+#define SPE_OP_PKT_HDR_CLASS_OTHER		0x0
+#define SPE_OP_PKT_HDR_CLASS_LD_ST_ATOMIC	0x1
+#define SPE_OP_PKT_HDR_CLASS_BR_ERET		0x2
+
+#define SPE_OP_PKT_COND				BIT(0)
+
+#define SPE_OP_PKT_LDST_SUBCLASS_GET(v)		((v) & GENMASK_ULL(7, 1))
+#define SPE_OP_PKT_LDST_SUBCLASS_GP_REG		0x0
+#define SPE_OP_PKT_LDST_SUBCLASS_SIMD_FP	0x4
+#define SPE_OP_PKT_LDST_SUBCLASS_UNSPEC_REG	0x10
+#define SPE_OP_PKT_LDST_SUBCLASS_NV_SYSREG	0x30
+
+#define SPE_OP_PKT_LDST_SUBCLASS_ATOMIC_GET(v)	((v) & (GENMASK_ULL(7, 5) | GENMASK_ULL(1, 1)))
+#define SPE_OP_PKT_LDST_SUBCLASS_ATOMIC		0x2
+
+#define SPE_OP_PKT_AR				BIT(4)
+#define SPE_OP_PKT_EXCL				BIT(3)
+#define SPE_OP_PKT_AT				BIT(2)
+#define SPE_OP_PKT_ST				BIT(0)
+
+#define SPE_OP_PKT_BRANCH_SUBCLASS_GET(v)	((v) & GENMASK_ULL(7, 1))
+#define SPE_OP_PKT_BRANCH_SUBCLASS_DIRECT	0x0
+#define SPE_OP_PKT_BRANCH_SUBCLASS_INDIRECT	0x2
+
 const char *arm_spe_pkt_name(enum arm_spe_pkt_type);
 
 int arm_spe_get_packet(const unsigned char *buf, size_t len,
-- 
2.17.1

