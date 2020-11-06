Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5632C2A8C45
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 02:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387443AbgKFBoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 20:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730895AbgKFBoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 20:44:04 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09236C0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 17:44:04 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id u4so2688201pgr.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 17:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yfZe1VryxrWwK6zHOsAfldL44Q+Rm+m7nxAltWXI9pc=;
        b=uZpKC39ziYeR3Se1JYLoZOsjPbsVn06I0LudfKt1PpWvIzOSzXhHkW+gDxtXedQvsn
         q4X1jTqGbZ+yMTRIsDk4xMYvR/fZ6OJmGJOpv3IB9gnh6VtCbNLBl92/EXqZQ5ZDh8Ul
         LNZ+XM0r98a4NUAJUz3MxDBxgKkteYJg0lRkAA/fthBqdyIwJuj+8Qpei5l7oxOAQ7WD
         T4TR6n6NcebCs0yqDofoQfy3WEqZRWXsFM27PEcqBZXGMEgsPHpm1xBSxEWk40y575zv
         CAeUvk7DIlFYnpHTLFUNdfX9iAqhX0t0oZ/fDEkjmvCUxWUrkyV9zYbwdxOrWtdqhwUW
         k3IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yfZe1VryxrWwK6zHOsAfldL44Q+Rm+m7nxAltWXI9pc=;
        b=JL6BCiU2J/UhNXuTob0C/GMlk/XYtlHEPQaH2NCt07eo9LuLIHP73AS0Y3cuL0OsQA
         QfS/GRB0eaAT9V+1HSg2LKvqttfx+3w0DW8YkApShDtBfRaE+v2MTOY1HBNhFAsSQuyv
         RXIQVdHg7KQ7A27x9eUIEjjaAuKJtRKxFpeSPo9mFyEYoLZKS2Xzr1w6e9h9lOPYcvsT
         P7Yu1+6c0afQor+MNDsEMfgvAjAAxmX9BwwZoKQTnaM8uu2PAh5ZFNNnQA+rJWjweqkD
         Ju2B6sc9PAB2mRdlZT7wUUN7Oq/+8KnWmcXHveneKiGbj9VXSQLSd0DhY4+EBcLMl/bL
         q3sw==
X-Gm-Message-State: AOAM531GO39mBKh6sjrc3JZYUT4z7310r1cIsd2fn+nUiBLBiJbvo//P
        LoLsScG31SMFik2rS+Iho4IH2A==
X-Google-Smtp-Source: ABdhPJzVnCsqMNQhSaMAi8GrzsfReiTQCGwEmJwL5ipqaWJSPd+AuRMSElQ5fWj7H1X+SQBT03BDDQ==
X-Received: by 2002:aa7:9095:0:b029:164:75c4:5d15 with SMTP id i21-20020aa790950000b029016475c45d15mr5078275pfa.49.1604627043573;
        Thu, 05 Nov 2020 17:44:03 -0800 (PST)
Received: from localhost ([2400:8904::f03c:91ff:fe8a:adf7])
        by smtp.gmail.com with ESMTPSA id d7sm3959728pgh.17.2020.11.05.17.44.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Nov 2020 17:44:03 -0800 (PST)
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
Subject: [PATCH v7 20/22] perf arm-spe: Add more sub classes for operation packet
Date:   Fri,  6 Nov 2020 09:41:34 +0800
Message-Id: <20201106014136.14103-21-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201106014136.14103-1-leo.yan@linaro.org>
References: <20201106014136.14103-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the operation type packet payload with load/store class, it misses
to support these sub classes:

  - A load/store targeting the general-purpose registers;
  - A load/store targeting unspecified registers;
  - The ARMv8.4 nested virtualisation extension can redirect system
    register accesses to a memory page controlled by the hypervisor.
    The SPE profiling feature in newer implementations can tag those
    memory accesses accordingly.

Add the bit pattern describing load/store sub classes, so that the perf
tool can decode it properly.

Inspired by Andre Przywara, refined the commit log and code for more
clear description.

Co-developed-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
---
 .../util/arm-spe-decoder/arm-spe-pkt-decoder.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index ea0bbf7c5aa1..ec962a9bff78 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -343,9 +343,23 @@ static int arm_spe_pkt_desc_op_type(const struct arm_spe_pkt *packet,
 				arm_spe_pkt_snprintf(&err, &buf, &buf_len, " EXCL");
 			if (payload & SPE_OP_PKT_AR)
 				arm_spe_pkt_snprintf(&err, &buf, &buf_len, " AR");
-		} else if (SPE_OP_PKT_LDST_SUBCLASS_GET(payload) ==
-					SPE_OP_PKT_LDST_SUBCLASS_SIMD_FP) {
+		}
+
+		switch (SPE_OP_PKT_LDST_SUBCLASS_GET(payload)) {
+		case SPE_OP_PKT_LDST_SUBCLASS_SIMD_FP:
 			arm_spe_pkt_snprintf(&err, &buf, &buf_len, " SIMD-FP");
+			break;
+		case SPE_OP_PKT_LDST_SUBCLASS_GP_REG:
+			arm_spe_pkt_snprintf(&err, &buf, &buf_len, " GP-REG");
+			break;
+		case SPE_OP_PKT_LDST_SUBCLASS_UNSPEC_REG:
+			arm_spe_pkt_snprintf(&err, &buf, &buf_len, " UNSPEC-REG");
+			break;
+		case SPE_OP_PKT_LDST_SUBCLASS_NV_SYSREG:
+			arm_spe_pkt_snprintf(&err, &buf, &buf_len, " NV-SYSREG");
+			break;
+		default:
+			break;
 		}
 		break;
 	case SPE_OP_PKT_HDR_CLASS_BR_ERET:
-- 
2.17.1

