Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69F0329E47F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730109AbgJ2Hii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbgJ2HYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:24:53 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E16EC08EADE
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:20:04 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id r3so885952plo.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=naJx7L5dVhnIJUTXsH59C3jAeMHe1RfwjImfd5ZlDuE=;
        b=cemReL0hHRtzzAHk5TX4lfTm5+s3HmAHcQIDxAQvA4HVtqAlY6gq3JN7yiDRh59E/H
         KiqBUgGXB4bRIwajsucMxyNbZzNXkl5DLyuqpVJWZFIw6InSXLGVZ/q6E1N/wxHOx75k
         9+/mpCL9herwYObe4HCVGGNqscf/xv7vzim2huEJ4M6R+ekRD5AzrM3VGa99MDytEe4N
         /b+pBIi5Z+FpFpAduSHqXpeIbfqfnipAI92q3qA1Lio1ydQcZtmUhpD3ctcwBqrhLFwK
         Ra9VkdFtHl59WSJMO96Iek5+omGsI5BtAq7YYwDzLtPN1iH7BxPwAyhSjWb5qAyMgad6
         LNGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=naJx7L5dVhnIJUTXsH59C3jAeMHe1RfwjImfd5ZlDuE=;
        b=bYG7g7Z7P9rAn1nhjY/iYeNYasYIDyUyQsPWVVQE5KFMau9Fp1jBwIXR0RoX03oqKj
         0caeeFXWGwTjN/4kTzZrTyi3ZCFTgInf/TuR6DcjCg2YCe4g/uLMVbxalx6z/mr5rpu8
         2WKGG+EsQUowVTQkgMlRoHNpFvYdMHOSAh6CqnuGppV2IwQtkZw6JwieQq6Rh+mVaeYH
         z+e3gd9dtwvskJFT4tcQuuUQ4SY0NxvA2l9nh5h2AREh/zSYzazjAbpVR9dDikU68MXk
         2GD1bJFFDJAA5SsGVLGRMqtjC6CUQmmTRfJUbhBep/estzObZSBDutJG0ZnnrTv6lYDG
         V8ng==
X-Gm-Message-State: AOAM533v5BW4pLVRWAeS+iRS1BsD2QmS3UQyouUPQElDWYGP3UaSp/GK
        O8eJ+sNI3zY194rR4eH+kvUG+mxCkrFY/8QD
X-Google-Smtp-Source: ABdhPJwRsqQcG/7uIdedR4jE4tE6LunWPfifeltIt9hWYKU2p0kqfuwTvkzYmMAZkaqPEuCh5Veh+w==
X-Received: by 2002:a17:902:a612:b029:d6:6ae:4d47 with SMTP id u18-20020a170902a612b02900d606ae4d47mr2662430plq.50.1603956003763;
        Thu, 29 Oct 2020 00:20:03 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id o4sm1738852pjj.38.2020.10.29.00.20.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Oct 2020 00:20:03 -0700 (PDT)
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
Subject: [PATCH v5 05/21] perf arm-spe: Fix packet length handling
Date:   Thu, 29 Oct 2020 15:19:11 +0800
Message-Id: <20201029071927.9308-6-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201029071927.9308-1-leo.yan@linaro.org>
References: <20201029071927.9308-1-leo.yan@linaro.org>
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

