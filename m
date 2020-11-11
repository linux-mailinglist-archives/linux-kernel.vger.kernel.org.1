Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A323C2AE971
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 08:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbgKKHMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 02:12:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbgKKHMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 02:12:39 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49496C0613D4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 23:12:39 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id s35so224748pjd.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 23:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=naJx7L5dVhnIJUTXsH59C3jAeMHe1RfwjImfd5ZlDuE=;
        b=e3eZMUsvleUyeAIyjLNcLJrmaIyRBthaonYzr6MKkhx5DdCk4JdcyHDhct8yvhKnOj
         11Yi56zdVnRXk0zuYFv+MBPq1NF8oWPxsHsns/OWWKJO8nGIaemofz0LJSgcK3neO8tI
         eYBwDFhjKPFJIgmfR70Gb6GSWovbW8y6ftiVeN9keXUnSE2hEkdfUPULWvkiYVgkp4hT
         XPt1QyxdvnI89QGrXf7oxm2qM/Gm3TAYtrmZSQ8Ca71zWGF3xG+pIjcoXoxg8nym8+0o
         /fcbXNbTGLIW/ZwCXKfoFwn2kvM1qQ/y8PmylYHH0yhRY4xQ1jHHJRcwq5mFoilS28QG
         6xFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=naJx7L5dVhnIJUTXsH59C3jAeMHe1RfwjImfd5ZlDuE=;
        b=gCCNng1On7L73+p1INWobaWzQUnigyLg7c+Qv/pakBqZ44jmOS+cqiVYRqMn3OZ8eO
         2GGO0snUf8MkSy704DaHyMbWY4Wv1U7RcKC0dW07CoB1Znc9NHtN0qzRmx1JhVVzGNgz
         S7/T4RlLwmxbohkEAFrnFuURtoCuSF+Z8T5xHuuC+wQm0JCcX/G6zZ0WO5RxAv3Zi13x
         y/oi0wPCuX+jyPiTEwpQ+FDOeTb50C7TCe6CoIwGpIswZWRl5DGHBsNIJZ7cPmMAboZg
         qWr+uXmOnasVS61goclLp7k7QXJT7bNOcwzCyIl8fuqHvODKh0atUQgOQqvq9etdu3dL
         eW0A==
X-Gm-Message-State: AOAM532mA+sDw4QPiROzsW2XHznBIsmNgA5488FptlA32+p3BBbj9VBl
        giwr3xpfoMqU5C9KFbsNIhLTDA==
X-Google-Smtp-Source: ABdhPJyb6LWgrBlbv1QFVssvbrLS+7S8kZhA5eouyahj1wiNhfmccqKieG9FKVRC2r2CfEZ/aZp7Xg==
X-Received: by 2002:a17:902:7606:b029:d3:d2dd:2b3b with SMTP id k6-20020a1709027606b02900d3d2dd2b3bmr20400514pll.67.1605078758833;
        Tue, 10 Nov 2020 23:12:38 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id ce19sm1413829pjb.53.2020.11.10.23.12.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Nov 2020 23:12:38 -0800 (PST)
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
Subject: [PATCH v8 05/22] perf arm-spe: Fix packet length handling
Date:   Wed, 11 Nov 2020 15:11:32 +0800
Message-Id: <20201111071149.815-6-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201111071149.815-1-leo.yan@linaro.org>
References: <20201111071149.815-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When processing address packet and counter packet, if the packet
contains extended header, it misses to account the extra one byte for
header length calculation, thus returns the wrong packet length.

To correct the packet length calculation, one possible fixing is simply
to plus extra 1 for extended header, but will spread some duplicate code
in the flows for processing address packet and counter packet.
Alternatively, we can refine the function arm_spe_get_payload() to not
only support short header and allow it to support extended header, and
rely on it for the packet length calculation.

So this patch refactors function arm_spe_get_payload() with a new
argument 'ext_hdr' for support extended header; the packet processing
flows can invoke this function to unify the packet length calculation.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
---
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 34 +++++++------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index f1b4cb008837..04fd7fd7c15f 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -82,14 +82,15 @@ static unsigned int arm_spe_payload_len(unsigned char hdr)
 }
 
 static int arm_spe_get_payload(const unsigned char *buf, size_t len,
+			       unsigned char ext_hdr,
 			       struct arm_spe_pkt *packet)
 {
-	size_t payload_len = arm_spe_payload_len(buf[0]);
+	size_t payload_len = arm_spe_payload_len(buf[ext_hdr]);
 
-	if (len < 1 + payload_len)
+	if (len < 1 + ext_hdr + payload_len)
 		return ARM_SPE_NEED_MORE_BYTES;
 
-	buf++;
+	buf += 1 + ext_hdr;
 
 	switch (payload_len) {
 	case 1: packet->payload = *(uint8_t *)buf; break;
@@ -99,7 +100,7 @@ static int arm_spe_get_payload(const unsigned char *buf, size_t len,
 	default: return ARM_SPE_BAD_PACKET;
 	}
 
-	return 1 + payload_len;
+	return 1 + ext_hdr + payload_len;
 }
 
 static int arm_spe_get_pad(struct arm_spe_pkt *packet)
@@ -130,7 +131,7 @@ static int arm_spe_get_timestamp(const unsigned char *buf, size_t len,
 				 struct arm_spe_pkt *packet)
 {
 	packet->type = ARM_SPE_TIMESTAMP;
-	return arm_spe_get_payload(buf, len, packet);
+	return arm_spe_get_payload(buf, len, 0, packet);
 }
 
 static int arm_spe_get_events(const unsigned char *buf, size_t len,
@@ -145,14 +146,14 @@ static int arm_spe_get_events(const unsigned char *buf, size_t len,
 	 */
 	packet->index = arm_spe_payload_len(buf[0]);
 
-	return arm_spe_get_payload(buf, len, packet);
+	return arm_spe_get_payload(buf, len, 0, packet);
 }
 
 static int arm_spe_get_data_source(const unsigned char *buf, size_t len,
 				   struct arm_spe_pkt *packet)
 {
 	packet->type = ARM_SPE_DATA_SOURCE;
-	return arm_spe_get_payload(buf, len, packet);
+	return arm_spe_get_payload(buf, len, 0, packet);
 }
 
 static int arm_spe_get_context(const unsigned char *buf, size_t len,
@@ -160,8 +161,7 @@ static int arm_spe_get_context(const unsigned char *buf, size_t len,
 {
 	packet->type = ARM_SPE_CONTEXT;
 	packet->index = buf[0] & 0x3;
-
-	return arm_spe_get_payload(buf, len, packet);
+	return arm_spe_get_payload(buf, len, 0, packet);
 }
 
 static int arm_spe_get_op_type(const unsigned char *buf, size_t len,
@@ -169,41 +169,31 @@ static int arm_spe_get_op_type(const unsigned char *buf, size_t len,
 {
 	packet->type = ARM_SPE_OP_TYPE;
 	packet->index = buf[0] & 0x3;
-	return arm_spe_get_payload(buf, len, packet);
+	return arm_spe_get_payload(buf, len, 0, packet);
 }
 
 static int arm_spe_get_counter(const unsigned char *buf, size_t len,
 			       const unsigned char ext_hdr, struct arm_spe_pkt *packet)
 {
-	if (len < 2)
-		return ARM_SPE_NEED_MORE_BYTES;
-
 	packet->type = ARM_SPE_COUNTER;
 	if (ext_hdr)
 		packet->index = ((buf[0] & 0x3) << 3) | (buf[1] & 0x7);
 	else
 		packet->index = buf[0] & 0x7;
 
-	packet->payload = le16_to_cpu(*(uint16_t *)(buf + 1));
-
-	return 1 + ext_hdr + 2;
+	return arm_spe_get_payload(buf, len, ext_hdr, packet);
 }
 
 static int arm_spe_get_addr(const unsigned char *buf, size_t len,
 			    const unsigned char ext_hdr, struct arm_spe_pkt *packet)
 {
-	if (len < 8)
-		return ARM_SPE_NEED_MORE_BYTES;
-
 	packet->type = ARM_SPE_ADDRESS;
 	if (ext_hdr)
 		packet->index = ((buf[0] & 0x3) << 3) | (buf[1] & 0x7);
 	else
 		packet->index = buf[0] & 0x7;
 
-	memcpy_le64(&packet->payload, buf + 1, 8);
-
-	return 1 + ext_hdr + 8;
+	return arm_spe_get_payload(buf, len, ext_hdr, packet);
 }
 
 static int arm_spe_do_get_packet(const unsigned char *buf, size_t len,
-- 
2.17.1

