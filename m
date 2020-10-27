Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C789429A309
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 04:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443621AbgJ0DLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 23:11:52 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37317 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440576AbgJ0DLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 23:11:51 -0400
Received: by mail-pg1-f194.google.com with SMTP id h6so7221671pgk.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 20:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fzNEzsqEYCwEdW7BpMzL1UKTh+9ckBvKin4dwQ6G4LY=;
        b=g8XNci109TPSbuMvAo9Y0W/ieNxLcnZJTQ1whud3B4TKTyjAs8b/qNefgM820718S4
         gaX+5TFrSL/PLTYclPkAfR9N/dSJlMuIV9yYCgp3mcySoubanVomqN4YeJeEB2zvTB+d
         uTcTaniAfMI7B8bO5cfgl5qHL1vdJB/9xQWMUlYXbBTfkaUfrU/PXJsvZbzDS8m0l7Z9
         qOdPQIcyR6mRZ5olE2u5NbtdS+wZ2Af80rAzw6PweBgt8J/scEm/MTXnAwxSKrv/pI2e
         qcxdi4QU3buyyXmeXHijA5jvFSqjsnNhTHz0Io2VwONtA2OEOhQm+1V0rZH203gcema8
         Cvxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fzNEzsqEYCwEdW7BpMzL1UKTh+9ckBvKin4dwQ6G4LY=;
        b=inv4XmxbpoHvEILYH43jBod6NeXwE67yBdVMbf6zFB2/yY6YuqpAlbUINAFb8jJKOl
         EVClP0DwNNWaa2Qrqr0liEHZ14IX0gSVQUq/tAMEQSa9bCbn9ma8SxBmJJQdFtZoSuu5
         CaG5v2No7qnJrO/eZjC197KfAp3YIJL0l4/6Kv1PtTBi/jcQWZKXs+uhgg1A4MROosHm
         tjXU0ov3Zm33yDAoAeGSV7FuO/PyFP81VLQ6lrG7eSYMFAmkyYd5pve7/Fu0CiX/wZet
         2rRwbxQEmQhQk/C6eXm/PK6CL+QD0ArxHj+rf0h3VomuNwB9Iyj6I/pVFRiNx7SB/x5a
         FjlQ==
X-Gm-Message-State: AOAM530pVEPeKrRXZ+0Tb9r7fyCIrk6y9eZzMLZtlaoDjJgUhbWPIAhR
        DyNuiOWplZNeZYc9SL+ZF+HUiA==
X-Google-Smtp-Source: ABdhPJyE6bI7OFjitDV5VPMopRl8z00eyUgm8cSChLaShTGnLjKxwamnWXr+D98yR/UQ7uoVfh12+A==
X-Received: by 2002:a63:180f:: with SMTP id y15mr82620pgl.324.1603768309341;
        Mon, 26 Oct 2020 20:11:49 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id q24sm200731pfn.72.2020.10.26.20.11.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Oct 2020 20:11:48 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Wei Li <liwei391@huawei.com>,
        James Clark <james.clark@arm.com>, Al Grant <Al.Grant@arm.com>,
        Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 19/21] perf arm-spe: Add more sub classes for operation packet
Date:   Tue, 27 Oct 2020 11:09:15 +0800
Message-Id: <20201027030917.15404-20-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027030917.15404-1-leo.yan@linaro.org>
References: <20201027030917.15404-1-leo.yan@linaro.org>
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
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 28 +++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index e3b0d22743e8..d3925521d0f4 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -369,11 +369,35 @@ static int arm_spe_pkt_desc_op_type(const struct arm_spe_pkt *packet,
 				if (ret < 0)
 					return ret;
 			}
-		} else if (SPE_OP_PKT_LDST_SUBCLASS_GET(payload) ==
-					SPE_OP_PKT_LDST_SUBCLASS_SIMD_FP) {
+		}
+
+		switch (SPE_OP_PKT_LDST_SUBCLASS_GET(payload)) {
+		case SPE_OP_PKT_LDST_SUBCLASS_SIMD_FP:
 			ret = arm_spe_pkt_snprintf(&buf, &blen, " SIMD-FP");
 			if (ret < 0)
 				return ret;
+
+			break;
+		case SPE_OP_PKT_LDST_SUBCLASS_GP_REG:
+			ret = arm_spe_pkt_snprintf(&buf, &blen, " GP-REG");
+			if (ret < 0)
+				return ret;
+
+			break;
+		case SPE_OP_PKT_LDST_SUBCLASS_UNSPEC_REG:
+			ret = arm_spe_pkt_snprintf(&buf, &blen, " UNSPEC-REG");
+			if (ret < 0)
+				return ret;
+
+			break;
+		case SPE_OP_PKT_LDST_SUBCLASS_NV_SYSREG:
+			ret = arm_spe_pkt_snprintf(&buf, &blen, " NV-SYSREG");
+			if (ret < 0)
+				return ret;
+
+			break;
+		default:
+			break;
 		}
 
 		return buf_len - blen;
-- 
2.17.1

