Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4C7D27CF87
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 15:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbgI2NlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 09:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729425AbgI2Nky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 09:40:54 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB00C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:40:53 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id a9so4876165wmm.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GNYYaRmWVYDbJwOUvvqrCzO4hlzFbDaURK6wieO21Ds=;
        b=Ld2ARWBC0cK8trPnYuAK9h8kyMmgYYzhdbkS7RNx2skijJKQ0J39aZFigMLMdGBGSC
         hXScg0fE1mJX8jkWvswpSM6ToaISLz9SVOxHYBpDHmXG7FqI47nht44DcFTvowUILxLN
         Mx4Nisn0xAUPmiWhIu6prZl7VL9SFUp92hr+UG7FRySBjaTrv/8VvH23tySGNMwPWgPY
         J66P8rkn1KBNT1UATqnNjJYsIsFjxku0vBXE7wv3TwWnV7EnjtDAfrhXS2qWJZtXAa33
         AM/infXYVlTr95moOZwt+td6WJKlLhYc6qfZUTQH0iOQRtt6jmsvvPz9tBQpqam61E06
         onRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GNYYaRmWVYDbJwOUvvqrCzO4hlzFbDaURK6wieO21Ds=;
        b=GLJK0awkrxgHC22zp66/v/KXB7xx16hztzXhe1fylRlwwHgF4hsEacHFTxPW+tvRqZ
         xIshfDRZFupYgdCOZxLNNqo6Dpiz5xlJSO0aAnYikU5tt4Xb/F4KpLuyvtNmDdHIfwf5
         ItH2qTl/M74BPyzF/fvho0OlB6E30qAJ+g1yUU1iZ4cQJMjh+bavZfqh5qxxNVvcxNhp
         NYytP3q5wDyJco2dR8fCFyKACv66KwPHAIFL4Z68Olo+Ro+X4cjH7D0xjtf04B3TmUb+
         P2rL5eB9t9ocjQ/m77kiOGb+89JtoOJ8peOTlv8ibKtbJDeAraEOvs5NdiBCKCFFvtc+
         03NQ==
X-Gm-Message-State: AOAM531+QjIsZH8SSukvM2QgsV6+hqzaFmJMNT/EWWPMBw9N2kQEAwlE
        NY4TVnJdVx2p2TfCzgqYqG6rWw==
X-Google-Smtp-Source: ABdhPJxDFNy1Zc46d8qPnFIjaLe5xfnSTyqbL5E4IVIaooXmnTM7iAVQruJGS/EyecA9QOKR472CrA==
X-Received: by 2002:a7b:ca56:: with SMTP id m22mr4455045wml.12.1601386852123;
        Tue, 29 Sep 2020 06:40:52 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id q15sm5955314wrr.8.2020.09.29.06.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 06:40:51 -0700 (PDT)
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
Subject: [PATCH v2 04/14] perf arm-spe: Fix packet length handling
Date:   Tue, 29 Sep 2020 14:39:07 +0100
Message-Id: <20200929133917.9224-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929133917.9224-1-leo.yan@linaro.org>
References: <20200929133917.9224-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When process address packet and counter packet, if the packet contains
extended header, it misses to account the extra one byte for header
length calculation, thus returns the wrong packet length.

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
---
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 34 +++++++------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 5a8696031e16..4f0aeb62e97b 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -80,14 +80,15 @@ const char *arm_spe_pkt_name(enum arm_spe_pkt_type type)
 	(1 << (((val) & SPE_HEADER_SZ_MASK) >> SPE_HEADER_SZ_SHIFT))
 
 static int arm_spe_get_payload(const unsigned char *buf, size_t len,
+			       unsigned char ext_hdr,
 			       struct arm_spe_pkt *packet)
 {
-	size_t payload_len = PAYLOAD_LEN(buf[0]);
+	size_t payload_len = PAYLOAD_LEN(buf[ext_hdr]);
 
-	if (len < 1 + payload_len)
+	if (len < 1 + ext_hdr + payload_len)
 		return ARM_SPE_NEED_MORE_BYTES;
 
-	buf++;
+	buf += 1 + ext_hdr;
 
 	switch (payload_len) {
 	case 1: packet->payload = *(uint8_t *)buf; break;
@@ -97,7 +98,7 @@ static int arm_spe_get_payload(const unsigned char *buf, size_t len,
 	default: return ARM_SPE_BAD_PACKET;
 	}
 
-	return 1 + payload_len;
+	return 1 + ext_hdr + payload_len;
 }
 
 static int arm_spe_get_pad(struct arm_spe_pkt *packet)
@@ -128,7 +129,7 @@ static int arm_spe_get_timestamp(const unsigned char *buf, size_t len,
 				 struct arm_spe_pkt *packet)
 {
 	packet->type = ARM_SPE_TIMESTAMP;
-	return arm_spe_get_payload(buf, len, packet);
+	return arm_spe_get_payload(buf, len, 0, packet);
 }
 
 static int arm_spe_get_events(const unsigned char *buf, size_t len,
@@ -143,14 +144,14 @@ static int arm_spe_get_events(const unsigned char *buf, size_t len,
 	 */
 	packet->index = PAYLOAD_LEN(buf[0]);
 
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
@@ -158,8 +159,7 @@ static int arm_spe_get_context(const unsigned char *buf, size_t len,
 {
 	packet->type = ARM_SPE_CONTEXT;
 	packet->index = buf[0] & 0x3;
-
-	return arm_spe_get_payload(buf, len, packet);
+	return arm_spe_get_payload(buf, len, 0, packet);
 }
 
 static int arm_spe_get_op_type(const unsigned char *buf, size_t len,
@@ -167,41 +167,31 @@ static int arm_spe_get_op_type(const unsigned char *buf, size_t len,
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
2.20.1

