Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3832B961D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 16:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbgKSPZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 10:25:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbgKSPZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:25:05 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48166C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 07:25:05 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id q5so4809815pfk.6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 07:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=57VOQYmjFyqU1m9tWBFVXY+vAjEsJLdRTKMqbKJtnj8=;
        b=pwl65I0W8gM6Kpwn360PSlLkfaRW1aGt5lmJcTty4Cu0ySegrQnE2p5Y92sSf3lHIw
         UzXvQDVoQJTnzEyLynafKfjfagSL/I73WJF1iiXFqDiUfO+LOLDLrael4SRA789vf0mH
         aC1B/+yWNk8LbcMq6OCzTOoauRxHhqjI1TSWrh9djhzWZkxMpX6usmNDQPBS6ZOZULOO
         cqUPxB75Uiln/Lh5Sl0DVn9uor1KCBoFYJ4fmEtHb4tROfqGTipvTWFQoAvuTORf6V9m
         ugeZ4vnr78i8092MmY+CqV1aP2PbmX1JW5Zc2O1FmCXDhZXziKSu6G9aj0FrXFkTIjgQ
         R6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=57VOQYmjFyqU1m9tWBFVXY+vAjEsJLdRTKMqbKJtnj8=;
        b=T2eM3F8U4uGpoo3PBGOWVrNSqQGGDsFqEQt81SuMlKPWGMdFHmwkdyXoxiSc5LMjYK
         tjqfBKwri0RN0YsmBwBYC05Anl1z0JYS01sMuiwA4nAuSEwZbLrnhBYvcDKHABjOxtuL
         wfFskW117T3d6mQtE4gZxw+n60spsTPPGr7QJRALr+hSbJYVjdAhwz8soJKxUBhwmQ0I
         1hJbgQ1egZc+wOILv9JOTbNhTdtnTPo+Ir4IjeiqAgYQ/8YKeCPGWc2j9CGcqs9YxCMD
         b8CjlkW2ltC1GWCvfGruB5Tnq+yhnufsf0ZM+RZGDgsFukn4+9XNtT8wMipaNrC5acdI
         DfeQ==
X-Gm-Message-State: AOAM532sibpD5FE4rgh+WaGxK333ffvYtFhx7NRGTa1uOmjqRL5upw/A
        6H/AaiyWczPiRbPV4MoauGpmpw==
X-Google-Smtp-Source: ABdhPJz3WJ15N1qBfR9sPGDEDlTnnElcjZm2xIMPa32nmVkfpLZn5Hsi4Y2mZkK7PmjSPxaaKtHwHQ==
X-Received: by 2002:a63:dc41:: with SMTP id f1mr5132026pgj.342.1605799504848;
        Thu, 19 Nov 2020 07:25:04 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id o16sm109424pfp.96.2020.11.19.07.25.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Nov 2020 07:25:04 -0800 (PST)
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
Subject: [PATCH v9 03/16] perf arm-spe: Add new function arm_spe_pkt_desc_addr()
Date:   Thu, 19 Nov 2020 23:24:28 +0800
Message-Id: <20201119152441.6972-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201119152441.6972-1-leo.yan@linaro.org>
References: <20201119152441.6972-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves out the address parsing code from arm_spe_pkt_desc()
and uses the new introduced function arm_spe_pkt_desc_addr() to process
address packet.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
---
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 64 +++++++++++--------
 1 file changed, 38 insertions(+), 26 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index a769fe5a4496..b16d68b40bbd 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -288,10 +288,46 @@ static int arm_spe_pkt_out_string(int *err, char **buf_p, size_t *blen,
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
+		arm_spe_pkt_out_string(&err, &buf, &buf_len,
+				"%s 0x%llx el%d ns=%d",
+				(idx == 1) ? "TGT" : "PC", payload, el, ns);
+		break;
+	case 2:
+		arm_spe_pkt_out_string(&err, &buf, &buf_len,
+				       "VA 0x%llx", payload);
+		break;
+	case 3:
+		ns = !!(packet->payload & NS_FLAG);
+		payload &= ~(0xffULL << 56);
+		arm_spe_pkt_out_string(&err, &buf, &buf_len,
+				       "PA 0x%llx ns=%d", payload, ns);
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
 int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 		     size_t buf_len)
 {
-	int ns, el, idx = packet->index;
+	int idx = packet->index;
 	unsigned long long payload = packet->payload;
 	const char *name = arm_spe_pkt_name(packet->type);
 	char *buf_orig = buf;
@@ -373,31 +409,7 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 		arm_spe_pkt_out_string(&err, &buf, &blen, "%s %lld", name, payload);
 		break;
 	case ARM_SPE_ADDRESS:
-		switch (idx) {
-		case 0:
-		case 1:
-			ns = !!(packet->payload & NS_FLAG);
-			el = (packet->payload & EL_FLAG) >> 61;
-			payload &= ~(0xffULL << 56);
-			arm_spe_pkt_out_string(&err, &buf, &blen,
-					"%s 0x%llx el%d ns=%d",
-				        (idx == 1) ? "TGT" : "PC", payload, el, ns);
-			break;
-		case 2:
-			arm_spe_pkt_out_string(&err, &buf, &blen,
-					       "VA 0x%llx", payload);
-			break;
-		case 3:
-			ns = !!(packet->payload & NS_FLAG);
-			payload &= ~(0xffULL << 56);
-			arm_spe_pkt_out_string(&err, &buf, &blen,
-					       "PA 0x%llx ns=%d", payload, ns);
-			break;
-		default:
-			/* Unknown index */
-			err = -1;
-			break;
-		}
+		err = arm_spe_pkt_desc_addr(packet, buf, buf_len);
 		break;
 	case ARM_SPE_CONTEXT:
 		arm_spe_pkt_out_string(&err, &buf, &blen, "%s 0x%lx el%d",
-- 
2.17.1

