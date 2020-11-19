Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB9A52B962C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 16:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbgKSPZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 10:25:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbgKSPZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:25:51 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32FA4C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 07:25:51 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id j19so4491654pgg.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 07:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c1el8lOaBG1H8A2PDl1EJfoVhIMJxa/97iv9OMwi/xg=;
        b=fR5aalcEDPdTroJHt5vbfCXRDUzx7+jHQ+kYCjt5Te3ne3xiuZRTMEOFsm2P89C84O
         omXKi0xeDipru9gLi3T8fon5JUWoNEEJeHdMEOLpiMDLwMAGNq8J94YXrjDdsZQVN9T/
         h7Z1r8MXjGGUztw56KgL9M2vPGAfZNU/HJJBzNBm5+Qf1Ye0ZwMmLM0F0dsxPCl03ty8
         sBhKtvG9/9y5MT2mDuWt0NlUAZtniZdTijbKy/PFpCWQRU531CmeIZ62ZUeX3DPnYgsc
         07VbDQFrnaRxsNm9EoRH1tzZoo0ZnhGZO/luM5QDXlMcFU4EQ6bervHSucI6jK8hgJwH
         ImBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=c1el8lOaBG1H8A2PDl1EJfoVhIMJxa/97iv9OMwi/xg=;
        b=MjDjHrcfnN31TxO9j6a0CasG18D01aq1ij0/6Zt4Lep7qb9qakwx8pL0b3mxH1kuyO
         u+04SZB8t0TqAoydu9XUj0kkCR2Oey+/MpFhWtgZbjKhNa1spse+dDhlz1x9Guy4u4nr
         S9bN4M4Fe58hEKEeZfwcZRT0UXW1eQ8vf+vMAlJazDTExdf3kcPAMuuwHf7Rba7TcLB3
         p9x8KwT+XZ8W6Hbh9xGSuoYPzuKYhGftB6Yxb7KU0QbpoaOcIYspAillM4K9JYshjAOE
         N2IcKxbjza2WyjtYcG4S1yfdl43UUC86b6lvEn3Fh7heC7Cwdmr7pzn43SbUFZnhe5C+
         ZN+w==
X-Gm-Message-State: AOAM531olsx6vHDgFgkzQdyXrVhkcLqXcQnBA2qi3A/Nmop/6yv+0WKL
        aenRkx4n8IfuiJx8kXYeioaEKQ==
X-Google-Smtp-Source: ABdhPJw1TACkNQvNY9Ip1txqkNK/XfgN9SiQgea9i7dkSONwKzAwcKk1aoKbyMvXbBh43rQO5gZYWQ==
X-Received: by 2002:aa7:8e87:0:b029:18b:cfd8:261c with SMTP id a7-20020aa78e870000b029018bcfd8261cmr9524494pfr.61.1605799550731;
        Thu, 19 Nov 2020 07:25:50 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id e22sm6993410pjh.45.2020.11.19.07.25.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Nov 2020 07:25:50 -0800 (PST)
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
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v9 14/16] perf arm-spe: Add more sub classes for operation packet
Date:   Thu, 19 Nov 2020 23:24:39 +0800
Message-Id: <20201119152441.6972-15-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201119152441.6972-1-leo.yan@linaro.org>
References: <20201119152441.6972-1-leo.yan@linaro.org>
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
index 1d1354a0eef4..84d661aab54f 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -343,9 +343,23 @@ static int arm_spe_pkt_desc_op_type(const struct arm_spe_pkt *packet,
 				arm_spe_pkt_out_string(&err, &buf, &buf_len, " EXCL");
 			if (payload & SPE_OP_PKT_AR)
 				arm_spe_pkt_out_string(&err, &buf, &buf_len, " AR");
-		} else if (SPE_OP_PKT_LDST_SUBCLASS_GET(payload) ==
-					SPE_OP_PKT_LDST_SUBCLASS_SIMD_FP) {
+		}
+
+		switch (SPE_OP_PKT_LDST_SUBCLASS_GET(payload)) {
+		case SPE_OP_PKT_LDST_SUBCLASS_SIMD_FP:
 			arm_spe_pkt_out_string(&err, &buf, &buf_len, " SIMD-FP");
+			break;
+		case SPE_OP_PKT_LDST_SUBCLASS_GP_REG:
+			arm_spe_pkt_out_string(&err, &buf, &buf_len, " GP-REG");
+			break;
+		case SPE_OP_PKT_LDST_SUBCLASS_UNSPEC_REG:
+			arm_spe_pkt_out_string(&err, &buf, &buf_len, " UNSPEC-REG");
+			break;
+		case SPE_OP_PKT_LDST_SUBCLASS_NV_SYSREG:
+			arm_spe_pkt_out_string(&err, &buf, &buf_len, " NV-SYSREG");
+			break;
+		default:
+			break;
 		}
 		break;
 	case SPE_OP_PKT_HDR_CLASS_BR_ERET:
-- 
2.17.1

