Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5D929E3D1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbgJ2HVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgJ2HUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:20:41 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEBE7C08EAE0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:20:39 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id o7so1612373pgv.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NLYY4zgAKF8Hm45fllgMPjXdInsBET9VYd0T1SItHP8=;
        b=m4Y1J5f7vorQKM8BTQ/W1ozc5A5QXPciOLZqj9MJ2dtAZ9Btm98t4zRb75yq7cPraR
         6BSHMcf/MUejM5Y+CVPiEIdZXsc7GzGy7kAYizWbWbHiTjBtPsYUALjXXh/zxv5I2wPM
         +4Bp+CEzQneYAq6zFfykv1thjmKBS6aAvgTt3dk3FmlRmUU2YZFFmjgE1RO2Gv3+Ceht
         +n5fFfzEEuthGMfMKkBqJi4OpHB47swn9yP/SQ8CqWIYh/VrQRqpf84G6ElKUcBVENXh
         B0fnEcvKS18kW50eU5dsGQu7gehecNcqrJRV6YhhmCSLJjxE47X4d0x256eqjEKKN6fh
         HOBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NLYY4zgAKF8Hm45fllgMPjXdInsBET9VYd0T1SItHP8=;
        b=kOT7ZEgYKejvFEydHiIXynh9U85DqFLkT2bHKPgk+9hTwMCvfYk+VzEwW2PyS+KF48
         ik+lwpsJwv9SqH8vwkqXsHmQC3rwtMbpYn79X/3b75ytnVNhfFqUx4SwZF2sjPfJttt3
         5cqk5icePcf+0/WRiQQR5yLJUuZhRguekDzAp2VFDgL4FIZ2PicEouVEJRQY6Jw/FID8
         gqbjKPi/XhUBpx9soGw1UuxyFZqUoN4A9iWGEzeV3NPuomfc+ofVCLVwzVKH014dWSV4
         SiVP2JybLmQmfkI+5mu8kfcL6pBno6Y0pTs/qBV4PK+YZozshr6zMsYtxwbuolm1wzEA
         puxA==
X-Gm-Message-State: AOAM532EIVgIn8zy1B9nV6ggZN2hvXKhW547yi3xgR5b/ZakjRiPBMtX
        wef/X1HL9lvPRq4y5TOE7ptWHQ==
X-Google-Smtp-Source: ABdhPJxbz4gsPd+mMQSLvSs8c3zti5t/f9bqakqDHeh83/uoeu9leLe5WuOEEw03sbREv9I0JIqlVw==
X-Received: by 2002:a63:1906:: with SMTP id z6mr2946488pgl.286.1603956039486;
        Thu, 29 Oct 2020 00:20:39 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id x9sm1490206pgr.22.2020.10.29.00.20.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Oct 2020 00:20:38 -0700 (PDT)
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
Subject: [PATCH v5 12/21] perf arm-spe: Add new function arm_spe_pkt_desc_counter()
Date:   Thu, 29 Oct 2020 15:19:18 +0800
Message-Id: <20201029071927.9308-13-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201029071927.9308-1-leo.yan@linaro.org>
References: <20201029071927.9308-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves out the counter packet parsing code from
arm_spe_pkt_desc() to the new function arm_spe_pkt_desc_counter().

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
---
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 48 +++++++++++--------
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 93799bf3d1ac..4e2f7bbd9d35 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -297,6 +297,34 @@ static int arm_spe_pkt_desc_addr(const struct arm_spe_pkt *packet,
 	}
 }
 
+static int arm_spe_pkt_desc_counter(const struct arm_spe_pkt *packet,
+				    char *buf, size_t buf_len)
+{
+	u64 payload = packet->payload;
+	const char *name = arm_spe_pkt_name(packet->type);
+	size_t blen = buf_len;
+	int err = 0;
+
+	arm_spe_pkt_snprintf(&err, &buf, &blen, "%s %d ", name,
+			     (unsigned short)payload);
+
+	switch (packet->index) {
+	case 0:
+		arm_spe_pkt_snprintf(&err, &buf, &blen, "TOT");
+		break;
+	case 1:
+		arm_spe_pkt_snprintf(&err, &buf, &blen, "ISSUE");
+		break;
+	case 2:
+		arm_spe_pkt_snprintf(&err, &buf, &blen, "XLAT");
+		break;
+	default:
+		break;
+	}
+
+	return err ?: (int)(buf_len - blen);
+}
+
 int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 		     size_t buf_len)
 {
@@ -384,25 +412,7 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 		return arm_spe_pkt_snprintf(&err, &buf, &blen, "%s 0x%lx el%d",
 					    name, (unsigned long)payload, idx + 1);
 	case ARM_SPE_COUNTER:
-		arm_spe_pkt_snprintf(&err, &buf, &blen, "%s %d ", name,
-				     (unsigned short)payload);
-
-		switch (idx) {
-		case 0:
-			arm_spe_pkt_snprintf(&err, &buf, &blen, "TOT");
-			break;
-		case 1:
-			arm_spe_pkt_snprintf(&err, &buf, &blen, "ISSUE");
-			break;
-		case 2:
-			arm_spe_pkt_snprintf(&err, &buf, &blen, "XLAT");
-			break;
-		default:
-			break;
-		}
-
-		return err ?: (int)(buf_len - blen);
-
+		return arm_spe_pkt_desc_counter(packet, buf, buf_len);
 	default:
 		break;
 	}
-- 
2.17.1

