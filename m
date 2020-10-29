Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 426F329E3D5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgJ2HVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbgJ2HVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:21:14 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD92EC0613B1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:21:13 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id f38so1622050pgm.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gb8W1h7SGvff5jSaYiQH332H5P74pGN/45rkGwlqp7I=;
        b=hfMsCFwAQdfDuLjo+Ui7dBZqVsbHG/jetagR8wx8OBrlM/1PbHauX12FHXTGU5YiPD
         kZSr24MVbUxtsThgqe2VlTZzLAAZYS7RqMwLO16bQoZFMRdJbp7gFDko6u/BQk9+VrpF
         qyjpYS20tFW1dbYd78w4ogTWEdrC7CMx6HqjxaBfPaStaezjdK2xt2m5Az1tS7nGCLUu
         bdy3MCWEo8xj7utaxhZN6KezNBzdz+8wGk8pxNvw25DUK6MIESNLUo5Q/4ZG6WneswBL
         CgXxOxNFYAZam6eH/PW4Nwv0FVk4p7T22zLoBsYFI/hlLaa0y0Jg4Jjpt+N5kKGDX+lA
         LI8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gb8W1h7SGvff5jSaYiQH332H5P74pGN/45rkGwlqp7I=;
        b=Dycaa0P/37iyCfDDUWm2vt0vGd3vKt3cM6kSmrU6/oVWvRDu8ebbl/WDLQpQZ12dpN
         jvd27evkGpPp5JG+kiimiSN28bKPaYGMGwSeGwHD995QmYSsh0L4egNEavSfhJTivci6
         1KiMIwzeH3+3dCDDJMBpBsQfy5gADv9bcf5XzCBJMiB1Zuu3fEvrw8HsD/7PrNgor8tO
         kUSNBmxYn2VNlZoIgvdHfBsk9CCYiYqxwebiJxJ/WLClBfJ9UP0RuuHsCJt2S+RF7FNP
         p2k9mNZeZgsgIhUcvsiRTp3suaZE966WzKuhnI/ETXhqh7PANpnyrO8fYNtBwhDxZOV1
         SBDg==
X-Gm-Message-State: AOAM531hc+ghuy4maGLe4F7nnMKQuReNXVkYvezhNQMukLeRH3Jr7p/I
        fAIegTwBabPiLbfakV2nWeuJcA==
X-Google-Smtp-Source: ABdhPJy9IiqQieqB/D06bO7Ti1FeJBIEs1oY69WLBD9Xq3D+lwNRgjv6Td3xc7gyWXRFWlcQ1quPKQ==
X-Received: by 2002:a17:90a:b30b:: with SMTP id d11mr2826106pjr.163.1603956073275;
        Thu, 29 Oct 2020 00:21:13 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id 3sm1818418pfv.92.2020.10.29.00.21.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Oct 2020 00:21:12 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Wei Li <liwei391@huawei.com>,
        James Clark <james.clark@arm.com>, Al Grant <Al.Grant@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v5 19/21] perf arm-spe: Add more sub classes for operation packet
Date:   Thu, 29 Oct 2020 15:19:25 +0800
Message-Id: <20201029071927.9308-20-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201029071927.9308-1-leo.yan@linaro.org>
References: <20201029071927.9308-1-leo.yan@linaro.org>
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
index 575635c54e48..70593a4e0aa5 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -326,9 +326,23 @@ static int arm_spe_pkt_desc_op_type(const struct arm_spe_pkt *packet,
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

