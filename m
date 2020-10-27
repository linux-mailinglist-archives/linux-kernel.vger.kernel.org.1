Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA42F29A2FB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 04:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439607AbgJ0DKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 23:10:34 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41112 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439451AbgJ0DKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 23:10:34 -0400
Received: by mail-pl1-f196.google.com with SMTP id w11so13998pll.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 20:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=naJx7L5dVhnIJUTXsH59C3jAeMHe1RfwjImfd5ZlDuE=;
        b=H0DST/cKFE3jeKQxgE7IeGZ93o1BLT5UYjMOeVsbvlfuB9ofmLqkzA7qEGwp8h+iXA
         pvGhxfdiiydqEaUHXqjKUEU/w7EP2ij7W6xMlYfrSD5GyOTFge7w36s8+qRCzE1zhk24
         HY9mb0eZcj6qrvUcFDt/2Synjeach4IfVCLvm59GY2GcE923mCAED1/SA8epmsyn6/hz
         CQUPffIazrTP5Ab4jyRQRTFkk831w6MNIRTyYfWV0eHwe4kl6RlB0BGFM1ZxDBqZW+yv
         EhhaIEix5SNHTO8fn7JhAJxvBpCxIK4wEziKmO2t9EujSYB4R/AXl1oEEoyTzN0YKsv1
         /7mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=naJx7L5dVhnIJUTXsH59C3jAeMHe1RfwjImfd5ZlDuE=;
        b=KBlTzUfDTvserbZjilsN8nUS9JiZoe6DaLP70mFyPhHOMR9xLou5y/HUk442+w7JYg
         Qz0GiVCSoh5uaT3FxZRotjakcHFzJMRZplIrs6qrjURKwEUwnWOCJBr4t4Q1oNmUayxd
         0wQTVzJDuT6SXBW6ZE5KOvSv1UgvKy4sQ1N1avaxB84m+aRhmPvZxL2g8zKV+SuXsdrR
         lneMYQHUhFKqxl2OTVoh7iPGO7oSCBvf41MsZ5nAzxCWirGwjH3ztJ5Odo0El9uLMjAp
         rKSmIdmnzRA2B0yOfHuRy8vSBEsp9J4CgpahkELnVRaJgXPpYIXAPMdy/dX1SHi66jE+
         FTTA==
X-Gm-Message-State: AOAM531w8UBNkSDCDETy8vgHMs5JwrfjBRKjJvuB5xLYZZt+U0burIIg
        4BAyyBF2M9cFp8Xw3KoQQKA9TA==
X-Google-Smtp-Source: ABdhPJyRmTxrvkrvPgZlFeF4DGJcmBYlG3Ji8fIijPm2MgTtwKZmeTCaYT23A3Wk7YkyCU45K/3BzQ==
X-Received: by 2002:a17:90a:1b6e:: with SMTP id q101mr63729pjq.79.1603768233148;
        Mon, 26 Oct 2020 20:10:33 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id y22sm173663pfr.62.2020.10.26.20.10.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Oct 2020 20:10:30 -0700 (PDT)
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
Subject: [PATCH v4 05/21] perf arm-spe: Fix packet length handling
Date:   Tue, 27 Oct 2020 11:09:01 +0800
Message-Id: <20201027030917.15404-6-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027030917.15404-1-leo.yan@linaro.org>
References: <20201027030917.15404-1-leo.yan@linaro.org>
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

