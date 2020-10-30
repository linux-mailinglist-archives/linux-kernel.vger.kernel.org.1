Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6ED29FBE8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 04:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgJ3C7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 22:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbgJ3C70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 22:59:26 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A13CC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 19:59:26 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id z24so3992081pgk.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 19:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZCoTmyt6DHQQhoh4Stq4dygqvwig77ySljAbspHHLkk=;
        b=GGKzr1Sii/f5SeSIZRH/uvYwnaRtxy429rHgPSpKtOKy/CsK36bsMkZevLfQAzQztE
         yw2VebzRra1aXPaAdPnfT1vS/4G9Nc3BkAEw5MywZke4ISTfDPgqH7cFW78SE9s08arY
         lMSopIRGDIPCmY/EapaCZzMPKc45i3YsuCtZsIjzOeT5wEDmxsRalvx2HDWa07WbSVcN
         Z4BFvQzsKYtkbybTasuGH1g2j2guUHPKDtqMzmVtPtZDXR4kexLopje8wR1Ju1ESCbwu
         v+LBmILtQA7alx+ysVI1jkj93u49yXkUcdgyqliHqpuKRCB5toJWg1W8/e6EmrIcmFFU
         WAYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZCoTmyt6DHQQhoh4Stq4dygqvwig77ySljAbspHHLkk=;
        b=GS/CEklEXnA0cJQyuHSOLY8nfu/8O7PYmCwp+9oISZf5U9c7q7EFLecRtrrwrG5p+Z
         Ia6PgR1dCC0Rs7nABEICAGejHT0buL3xey+otpUnsgtRZ++j24rhRG6Z1qa+HHOYclbL
         Om5fkLMzTxgVBeYIhLnRchRjosgQDBWq9WayMoMKNkCPu+tCejBJO8FdFC+GScAvBkW/
         lJ8TUXbI20DlsBIzNf93eshEArLdB2OgRSmmigaIVK9I2cpFPBYZwTIQZa/0qYng5eq8
         apZXVcod18ol9qGRIlt+khQqpzBITqFE0TkaBsh/PpFYb+sjVYu/19HgWcop9N8lmuak
         Q2bQ==
X-Gm-Message-State: AOAM530MSCT9t4yJx3DcjgCBUudVeRifxDaGFvI1h9oGeBF/loq8YyS8
        Bb4l+jVBRxKRtqsRjxAcp0vDZQ==
X-Google-Smtp-Source: ABdhPJy1NCTF/756+XJ+rplOz33O6/6mzjsmgjXsZF5hOdBWdcJFpZ73Zdrate0TbpEz36YSJdaRhg==
X-Received: by 2002:a63:ea0b:: with SMTP id c11mr296735pgi.213.1604026765808;
        Thu, 29 Oct 2020 19:59:25 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id t15sm407865pji.0.2020.10.29.19.59.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Oct 2020 19:59:25 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        James Clark <james.clark@arm.com>,
        Dave Martin <Dave.Martin@arm.com>, Al Grant <Al.Grant@arm.com>,
        Wei Li <liwei391@huawei.com>, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v6 19/21] perf arm-spe: Add more sub classes for operation packet
Date:   Fri, 30 Oct 2020 10:57:22 +0800
Message-Id: <20201030025724.19157-20-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201030025724.19157-1-leo.yan@linaro.org>
References: <20201030025724.19157-1-leo.yan@linaro.org>
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
index 0e39ba48ea07..3fca65e9cbbf 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -330,9 +330,23 @@ static int arm_spe_pkt_desc_op_type(const struct arm_spe_pkt *packet,
 				arm_spe_pkt_snprintf(&err, &buf, &blen, " EXCL");
 			if (payload & SPE_OP_PKT_AR)
 				arm_spe_pkt_snprintf(&err, &buf, &blen, " AR");
-		} else if (SPE_OP_PKT_LDST_SUBCLASS_GET(payload) ==
-					SPE_OP_PKT_LDST_SUBCLASS_SIMD_FP) {
+		}
+
+		switch (SPE_OP_PKT_LDST_SUBCLASS_GET(payload)) {
+		case SPE_OP_PKT_LDST_SUBCLASS_SIMD_FP:
 			arm_spe_pkt_snprintf(&err, &buf, &blen, " SIMD-FP");
+			break;
+		case SPE_OP_PKT_LDST_SUBCLASS_GP_REG:
+			arm_spe_pkt_snprintf(&err, &buf, &blen, " GP-REG");
+			break;
+		case SPE_OP_PKT_LDST_SUBCLASS_UNSPEC_REG:
+			arm_spe_pkt_snprintf(&err, &buf, &blen, " UNSPEC-REG");
+			break;
+		case SPE_OP_PKT_LDST_SUBCLASS_NV_SYSREG:
+			arm_spe_pkt_snprintf(&err, &buf, &blen, " NV-SYSREG");
+			break;
+		default:
+			break;
 		}
 
 		return err ?: (int)(buf_len - blen);
-- 
2.17.1

