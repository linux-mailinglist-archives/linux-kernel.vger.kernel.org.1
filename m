Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4F829E3B5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725844AbgJ2HUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgJ2HUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:20:20 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F15C08EAE0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:20:19 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id o7so1611769pgv.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h0DFQNCOHa4iU8ShZ/bt+tNII0fzkUMtOXWBYGPwf7k=;
        b=DKTUdOVZ1UpMLUaAW3E0d10Pa93gniyN7+0M10mEPDT10XJD7+J93SePAV+gU2+3Au
         jNmVVomj8/TGjqpFLPu/GJGbijpj+gMTZohxjpAj59wzFZ7OhtqzZQ7hy/sfNFd2hIoS
         vnrWhpVLrCuBXFHmh9HTcGLkxSHsJV08ezDHwx5Yy/EZWoeyJLV1WvLoJsKDyBFbD3NU
         HxLSch9I9yoNL17tgWSvxfVqDICGJiAhNPFmLM+1hoGJ4dymjoAPf1TpOcQDOCVhv/pr
         /7SD8kbQxzYs5hD12Htqt4UbC2TFaPCXHP+SS2Ffyy0B8Wo1RZjV8hbE6XxHyxjYxmsl
         pHBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h0DFQNCOHa4iU8ShZ/bt+tNII0fzkUMtOXWBYGPwf7k=;
        b=NOGpzyguIk0Wr77R0oMurly9FdTAWk9GDygIVL2vydeITQBwEPjfmLu2bNdi7ACvQ7
         LTxZM/7hDsJonfYsKFaqda/dVq3KLc7A5+uZi96nXcZJMCmne25HBJMK/E1SawBhMwO7
         Nqsp0o+clTNMost3lIrU/+TMo5WlivPJpLEA9VxhsF/M/wZZAuj2MovMy8+B9YoPsiai
         1Lx2XdpW1Zrw3uSEbsNGfjHIPjyuqJPl7eQSA1lj4AK8p6qEaWQS/tk6qi0cc6iYLt1B
         dWSAJDCsNA1a7VModkc474u/StFJQ7yN90ou69LNRnxuPZgJkDwufXOhl6UfAbEO3eM5
         eTJg==
X-Gm-Message-State: AOAM530Nws7vIg5phlwsEgWTDldrPLVfEotTBW0gYIIHkcT9J1ZDB3Ok
        WbOPIOVRcW0AxYXuSuBjR7iDCQ==
X-Google-Smtp-Source: ABdhPJxPUd3Fyy0GetH4K0lKHt6CpgZ1HMT9OA+KdTATG1BMtV3Ioo1RBQgOclb5TqunG0As1cx2FA==
X-Received: by 2002:a17:90a:ab87:: with SMTP id n7mr3022161pjq.201.1603956019522;
        Thu, 29 Oct 2020 00:20:19 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id md11sm1786495pjb.18.2020.10.29.00.20.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Oct 2020 00:20:19 -0700 (PDT)
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
Subject: [PATCH v5 08/21] perf arm-spe: Add new function arm_spe_pkt_desc_addr()
Date:   Thu, 29 Oct 2020 15:19:14 +0800
Message-Id: <20201029071927.9308-9-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201029071927.9308-1-leo.yan@linaro.org>
References: <20201029071927.9308-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves out the address parsing code from arm_spe_pkt_desc()
and uses the new introduced function arm_spe_pkt_desc_addr() to process
address packet.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
---
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 50 ++++++++++++-------
 1 file changed, 31 insertions(+), 19 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 34cc46385cf7..9db26e30d028 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -270,10 +270,39 @@ static int arm_spe_pkt_snprintf(int *err, char **buf_p, size_t *blen,
 	return ret;
 }
 
+static int arm_spe_pkt_desc_addr(const struct arm_spe_pkt *packet,
+				 char *buf, size_t buf_len)
+{
+	int ns, el, idx = packet->index;
+	u64 payload = packet->payload;
+	int err = 0;
+
+	switch (idx) {
+	case 0:
+	case 1:
+		ns = !!(packet->payload & NS_FLAG);
+		el = (packet->payload & EL_FLAG) >> 61;
+		payload &= ~(0xffULL << 56);
+		return arm_spe_pkt_snprintf(&err, &buf, &buf_len,
+				"%s 0x%llx el%d ns=%d",
+				(idx == 1) ? "TGT" : "PC", payload, el, ns);
+	case 2:
+		return arm_spe_pkt_snprintf(&err, &buf, &buf_len,
+					    "VA 0x%llx", payload);
+	case 3:
+		ns = !!(packet->payload & NS_FLAG);
+		payload &= ~(0xffULL << 56);
+		return arm_spe_pkt_snprintf(&err, &buf, &buf_len,
+					    "PA 0x%llx ns=%d", payload, ns);
+	default:
+		return 0;
+	}
+}
+
 int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 		     size_t buf_len)
 {
-	int ns, el, idx = packet->index;
+	int idx = packet->index;
 	unsigned long long payload = packet->payload;
 	const char *name = arm_spe_pkt_name(packet->type);
 	size_t blen = buf_len;
@@ -352,24 +381,7 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 	case ARM_SPE_TIMESTAMP:
 		return arm_spe_pkt_snprintf(&err, &buf, &blen, "%s %lld", name, payload);
 	case ARM_SPE_ADDRESS:
-		switch (idx) {
-		case 0:
-		case 1: ns = !!(packet->payload & NS_FLAG);
-			el = (packet->payload & EL_FLAG) >> 61;
-			payload &= ~(0xffULL << 56);
-			return arm_spe_pkt_snprintf(&err, &buf, &blen,
-					"%s 0x%llx el%d ns=%d",
-				        (idx == 1) ? "TGT" : "PC", payload, el, ns);
-		case 2:
-			return arm_spe_pkt_snprintf(&err, &buf, &blen,
-						    "VA 0x%llx", payload);
-		case 3:	ns = !!(packet->payload & NS_FLAG);
-			payload &= ~(0xffULL << 56);
-			return arm_spe_pkt_snprintf(&err, &buf, &blen,
-						    "PA 0x%llx ns=%d", payload, ns);
-		default:
-			return 0;
-		}
+		return arm_spe_pkt_desc_addr(packet, buf, buf_len);
 	case ARM_SPE_CONTEXT:
 		return arm_spe_pkt_snprintf(&err, &buf, &blen, "%s 0x%lx el%d",
 					    name, (unsigned long)payload, idx + 1);
-- 
2.17.1

