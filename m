Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B87362AE981
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 08:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgKKHSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 02:18:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbgKKHPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 02:15:03 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFA8C061A4D
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 23:13:35 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id oc3so262188pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 23:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3ucoYIWnfXMR4kJEztjUb/NPRnfC3552OCLDYo5AMI8=;
        b=Moe+k1e/Htewp+me46McmHMhHJPPYtop4TdYtUM8uJvD5VtwOHDmsmrCLjF/ezdlTY
         eqirMv55x84ChIt2SfpbtA8f/q9WRr+cdi3ERdQhu3VyRvgMoZk9Enzi6K+ZssAxTfmp
         dzv9uWygkGl47jxciXU2SuQTtO0cfvJN4C5AxOPyyAQR2fxKB47W/ddCauFM71dqN7a/
         8yZlMwh1T0JyzIQP8u00Y7P02VdnYQU9r7DtCeMONFRYpxfrgspjvoCKJmI5msh+kCLd
         W8m3jVpNo7dOIJ8QJhlMKUA50938fo6OVjFt8TDWD3UH7rtVGVoMd7Tx+6QJzRsecc0s
         ftMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3ucoYIWnfXMR4kJEztjUb/NPRnfC3552OCLDYo5AMI8=;
        b=KqFXsMvsbk8VAWgEEHtp14UZQ6xRrWkCktra+C3wkGFyC1bjF7Zx5V9/OYV67Mxea6
         +jQbw8yuj5hyEhN/ePD64Z67KNSAm33O1ZX6/sVxMMM8UX+50POJz9s5lHttiGkksOLN
         doXp+6ntoO6QpZG30KzsOqfBn9ibnuYNp6JPBpUtmqOHeV6Z8/nigDuDVJlKYei/PjwE
         GNLBEaHlutOeatRW2ZqbymiWiqK6GjoUlP/LHLfPsn/empALGXMxuD090h1ZXrrZIKsz
         v+uoiXa0skGUkPCyizUY8Pq7wy2K3BE6tUu7z7HFANbfDrqqJpEE/D4uUeacy2ixGWpL
         /j0Q==
X-Gm-Message-State: AOAM532JsbtWg/gn4M8jOXkHh1C2M4+/Hq/wC6AG0ilSt3wYqeBQC86f
        2ad9s4NfyNxmw7pQmTUjxbFTfw==
X-Google-Smtp-Source: ABdhPJz+POwbSpGuUf3B0eGkiZ9JWQtM1pbEBKxnrEif8Wb9KqWw8N0NWAhy8y2vIzu5pCVcN4qBUg==
X-Received: by 2002:a17:90b:1c0e:: with SMTP id oc14mr2562751pjb.142.1605078814575;
        Tue, 10 Nov 2020 23:13:34 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id b80sm1342039pfb.40.2020.11.10.23.13.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Nov 2020 23:13:33 -0800 (PST)
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
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v8 20/22] perf arm-spe: Add more sub classes for operation packet
Date:   Wed, 11 Nov 2020 15:11:47 +0800
Message-Id: <20201111071149.815-21-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201111071149.815-1-leo.yan@linaro.org>
References: <20201111071149.815-1-leo.yan@linaro.org>
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
index 5fe1c5e8094d..55c4bf330b96 100644
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

