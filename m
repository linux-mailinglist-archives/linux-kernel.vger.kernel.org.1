Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD44027CF8B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 15:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730747AbgI2Nl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 09:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730635AbgI2NlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 09:41:04 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372B4C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:41:03 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id j2so5450410wrx.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xY18na4GovIke1vjrA11NfaSmLUMEt3XsnVk4ALrIw4=;
        b=sfSVXlQw2Xbtxvzn+W5Cqa1zXyjXUiOsPHSHklbu/7GeMplfTg2lpbZKdh3UirSQMi
         p26CrdUEQg+hSJXrJHoYwmGffw9SsfqurxLaneVj1GxivNSgKYdzPVKoLNv+FfUDQPBx
         ply84cPRq2qPJLZ848gBwavsLvTQdHbFclmSooQdgDDiu2nfxosbzCrH7iqgYXNHo3fH
         lwAd4+A6T+HGjB3/vKfU2hK72A/zNrSrtFZSsI1DnM8b0vXOlpDbG7TSmENQJaSsxeKK
         c2ROlKDNsjCce6JAyhesmdf83JEQWlKmCt4ADCEnGpi30k+EVd3YkZl90eIrHnwiC0jH
         GRfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xY18na4GovIke1vjrA11NfaSmLUMEt3XsnVk4ALrIw4=;
        b=mu/Sia0Senv0VxgxeVfPcVGs3owu2askTbZDsOiA73aWs4dCdgYxGMzW3TnkQwiYGU
         woHE0U8GJB2UIup0fFobwQfs+PpVmCRSQUgDz86PfaSRJlm+AfiFbsTcVuik6alwhNGV
         QeOjvcZWkWP83DMu5TnF0uoeCBPp5VE8Y8YSBjrOtYJtHhTR5KrYRrH9iC+fF0OnCzRe
         b2CRFbauwzNfRUEg2pHAyX8ssndeRdHYaynPMq3aSyPDLUd7It2VNIjRXLsPOJg5Hvss
         0Qnt/KUfk+vPD7vfEnsDWXhuAW7XDyGUagxiSpdSp3DE7rH8b2owpkcMCFiqJiaTmmGx
         VM2g==
X-Gm-Message-State: AOAM533je3mDXLZORhGC/WRM9alumJfQFA5pb3EfzTDJqjvfea1YkfPX
        5Eh4C4m5NznCNmfZdq0qFSTB9A==
X-Google-Smtp-Source: ABdhPJy1Mi+1OahmsFoBSgcpxvZx0mdiTGrmsrWSuQogI+onmXRkx4sm9M4SOJl9UBancT8oDPLCrQ==
X-Received: by 2002:a5d:50c3:: with SMTP id f3mr4346230wrt.125.1601386861856;
        Tue, 29 Sep 2020 06:41:01 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id q15sm5955314wrr.8.2020.09.29.06.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 06:41:01 -0700 (PDT)
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
        Dave Martin <Dave.Martin@arm.com>,
        linux-kernel@vger.kernel.org, Al Grant <Al.Grant@arm.com>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 12/14] perf arm-spe: Add more sub classes for operation packet
Date:   Tue, 29 Sep 2020 14:39:15 +0100
Message-Id: <20200929133917.9224-13-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929133917.9224-1-leo.yan@linaro.org>
References: <20200929133917.9224-1-leo.yan@linaro.org>
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
---
 .../util/arm-spe-decoder/arm-spe-pkt-decoder.c    | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index a848c784f4cf..57a2d5494838 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -378,6 +378,21 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 				ret = arm_spe_pkt_snprintf(&buf, &blen, " SIMD-FP");
 				if (ret < 0)
 					return ret;
+			} else if ((payload & SPE_OP_PKT_LDST_SUBCLASS_MASK) ==
+					SPE_OP_PKT_LDST_SUBCLASS_GP_REG) {
+				ret = arm_spe_pkt_snprintf(&buf, &blen, " GP-REG");
+				if (ret < 0)
+					return ret;
+			} else if ((payload & SPE_OP_PKT_LDST_SUBCLASS_MASK) ==
+					SPE_OP_PKT_LDST_SUBCLASS_UNSPEC_REG) {
+				ret = arm_spe_pkt_snprintf(&buf, &blen, " UNSPEC-REG");
+				if (ret < 0)
+					return ret;
+			} else if ((payload & SPE_OP_PKT_LDST_SUBCLASS_MASK) ==
+					SPE_OP_PKT_LDST_SUBCLASS_NV_SYSREG) {
+				ret = arm_spe_pkt_snprintf(&buf, &blen, " NV-SYSREG");
+				if (ret < 0)
+					return ret;
 			}
 
 			return buf_len - blen;
-- 
2.20.1

