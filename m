Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69B322A8C43
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 02:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387416AbgKFBnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 20:43:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732684AbgKFBnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 20:43:51 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B82C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 17:43:51 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id e21so2681646pgr.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 17:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jTbIOI0pkM3814iBn7T5cP1Jt+3DB34h4htx+j2zeNE=;
        b=p/UGDaQqyZtXDvokZI+EXoTcNw57t36305P7gS0Hk2GPe45FLotbVkiYo8DaXQY/h8
         VJYwKPAEeXpkyEYKf4XUv4gJTUtYPZ1lYXxCP25/M+NM/4u6UOH1XB+82VjxPIkBAxDz
         xdUu4qeeVaimHHdmIhv5PhZdf438rLb513eY9M/8mICvs9ZzVBa0mKxshDTR4GlLUBdK
         NZZ4cLz/UH3+OyaCBHskIjzt+wDav8m4WJWfZK7DCXLl/SW9hy2NQAQtu7XApYC6wwBi
         qS+U/l3CMaLOaXQn0J6ybwv7Xzcn4Ie+CdeXMUm7aSVIfJk2F5r2sXSmbdXuQVX8EdUO
         Y0gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jTbIOI0pkM3814iBn7T5cP1Jt+3DB34h4htx+j2zeNE=;
        b=G8WlsJzvuq1zTX//vc+47dh2CN6hk+bGswDugAEKpiJTmMMW0/e+CIs0xGxUpeXQuv
         l/h5+aJAGUcndQrzIeOIFckEnIL1+FdS0JJ/h/akNtGZdc/kOpaFoCqCvis9yqu4Cda3
         NabVeHJKlGCrtCGptbj9weDz5tUJj9EdHeQCcmP5dozrm8wHr85u01ktQ9Y2KqF46O1e
         oJuf5xUVSk3gbqaLISqiFWsj4Jp0T9iKrjcNBLtlLkxejpmTsmB6sijlVarCzfsG+4Sq
         nsZpfAXn6y0lUi2nfBG0Q7B6w01pff27ZxHD9LoWXeLCc4ztgbLuVfbvU+NjJGcmx4MR
         gVsw==
X-Gm-Message-State: AOAM531/2XL44XDDahVRlgNHAOG5xwehMjgWHQlH52H2k5Yq4Xo0QZuv
        jDi0howdfGOIfi920Td4Dp+wfRrTrtuSc9nILJo=
X-Google-Smtp-Source: ABdhPJy2/E5WdafuCKvW7v1NwlMoTd4VcvW3PkUi+MdG+E/sjTJalgLxL3OXFAXx0zFVx/7DKbO3FQ==
X-Received: by 2002:a62:7b14:0:b029:18b:3500:9b1c with SMTP id w20-20020a627b140000b029018b35009b1cmr5321618pfc.78.1604627030723;
        Thu, 05 Nov 2020 17:43:50 -0800 (PST)
Received: from localhost ([2400:8904::f03c:91ff:fe8a:adf7])
        by smtp.gmail.com with ESMTPSA id t74sm4048727pfc.47.2020.11.05.17.43.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Nov 2020 17:43:50 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Al Grant <Al.Grant@arm.com>, Wei Li <liwei391@huawei.com>,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v7 18/22] perf arm-spe: Add new function arm_spe_pkt_desc_op_type()
Date:   Fri,  6 Nov 2020 09:41:32 +0800
Message-Id: <20201106014136.14103-19-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201106014136.14103-1-leo.yan@linaro.org>
References: <20201106014136.14103-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The operation type packet is complex and contains subclass; the parsing
flow causes deep indentation; for more readable, this patch introduces
a new function arm_spe_pkt_desc_op_type() which is used for operation
type parsing.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
---
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 79 +++++++++++--------
 1 file changed, 45 insertions(+), 34 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 87ef8866221e..a8027819018a 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -321,6 +321,50 @@ static int arm_spe_pkt_desc_event(const struct arm_spe_pkt *packet,
 	return err;
 }
 
+static int arm_spe_pkt_desc_op_type(const struct arm_spe_pkt *packet,
+				    char *buf, size_t buf_len)
+{
+	u64 payload = packet->payload;
+	int err = 0;
+
+	switch (packet->index) {
+	case 0:
+		arm_spe_pkt_snprintf(&err, &buf, &buf_len,
+				payload & 0x1 ? "COND-SELECT" : "INSN-OTHER");
+		break;
+	case 1:
+		arm_spe_pkt_snprintf(&err, &buf, &buf_len,
+				     payload & 0x1 ? "ST" : "LD");
+
+		if (payload & 0x2) {
+			if (payload & 0x4)
+				arm_spe_pkt_snprintf(&err, &buf, &buf_len, " AT");
+			if (payload & 0x8)
+				arm_spe_pkt_snprintf(&err, &buf, &buf_len, " EXCL");
+			if (payload & 0x10)
+				arm_spe_pkt_snprintf(&err, &buf, &buf_len, " AR");
+		} else if (payload & 0x4) {
+			arm_spe_pkt_snprintf(&err, &buf, &buf_len, " SIMD-FP");
+		}
+		break;
+	case 2:
+		arm_spe_pkt_snprintf(&err, &buf, &buf_len, "B");
+
+		if (payload & 0x1)
+			arm_spe_pkt_snprintf(&err, &buf, &buf_len, " COND");
+		if (payload & 0x2)
+			arm_spe_pkt_snprintf(&err, &buf, &buf_len, " IND");
+
+		break;
+	default:
+		/* Unknown index */
+		err = -1;
+		break;
+	}
+
+	return err;
+}
+
 static int arm_spe_pkt_desc_addr(const struct arm_spe_pkt *packet,
 				 char *buf, size_t buf_len)
 {
@@ -404,40 +448,7 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 		err = arm_spe_pkt_desc_event(packet, buf, buf_len);
 		break;
 	case ARM_SPE_OP_TYPE:
-		switch (idx) {
-		case 0:
-			arm_spe_pkt_snprintf(&err, &buf, &blen,
-					payload & 0x1 ? "COND-SELECT" : "INSN-OTHER");
-			break;
-		case 1:
-			arm_spe_pkt_snprintf(&err, &buf, &blen,
-					     payload & 0x1 ? "ST" : "LD");
-
-			if (payload & 0x2) {
-				if (payload & 0x4)
-					arm_spe_pkt_snprintf(&err, &buf, &blen, " AT");
-				if (payload & 0x8)
-					arm_spe_pkt_snprintf(&err, &buf, &blen, " EXCL");
-				if (payload & 0x10)
-					arm_spe_pkt_snprintf(&err, &buf, &blen, " AR");
-			} else if (payload & 0x4) {
-				arm_spe_pkt_snprintf(&err, &buf, &blen, " SIMD-FP");
-			}
-			break;
-		case 2:
-			arm_spe_pkt_snprintf(&err, &buf, &blen, "B");
-
-			if (payload & 0x1)
-				arm_spe_pkt_snprintf(&err, &buf, &blen, " COND");
-			if (payload & 0x2)
-				arm_spe_pkt_snprintf(&err, &buf, &blen, " IND");
-
-			break;
-		default:
-			/* Unknown index */
-			err = -1;
-			break;
-		}
+		err = arm_spe_pkt_desc_op_type(packet, buf, buf_len);
 		break;
 	case ARM_SPE_DATA_SOURCE:
 	case ARM_SPE_TIMESTAMP:
-- 
2.17.1

