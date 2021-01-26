Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0401304F3A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 03:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405287AbhA0Bow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 20:44:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731807AbhAZS5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 13:57:50 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235FBC0613ED
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 10:57:10 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id u8so22659873ior.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 10:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JpZv+T7F3bf/GFAbswYSEjxp4C4JU0WA8H2GZ/JQhn0=;
        b=S8gh6JjwnkIt4hEKTVwbdAvFLYkQsLiG2G7Hx9nAz8Cg+/0FottfVYSu6F2mju2eTK
         FNWeI/hjac9R+wFPa/K14hUxl2HJXtnRtUNsKUPFCiwoj8Z7sRDABYSxdvdxduacFbQ4
         Ae54zsGSgORxvaNu/ijyC+qvVLSCEmzqEEjhIHuNByC0fThw5vJedyfXLG+Z5LhRK56K
         nM9JxhbmT4eAp4qWAjTj0GJ7McCTF23nPg3Vj9TksyUtPP4IUb5L3JZ5w765Ssx3prlY
         1I/FnmkBfDySplKgZHkurGy0C+4JDPqWV8Kg5Yd7DExeTaJCbsNb0/hlYP82+i+FHJFj
         ST4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JpZv+T7F3bf/GFAbswYSEjxp4C4JU0WA8H2GZ/JQhn0=;
        b=eslZTeUR9trn2a92Z5q2Un7R304G7wVmKdXIJSj5+32WrwjVvHZK7GbXKTBW1KB0zD
         jTyIAGkeyRGefeVA7la8+p7XfMJpFrjN1WqVIISe+6AcEzrykVM0W6ZKyJSAfYg1+QmI
         BDHkRfK/NJ+2uPzSG68ryzXf0LpiDwKqTGfwaWqmhjMTX4nmU5RdoNiswwXpF4ISRur9
         0aZuiV5T6loUqzXT6zOqThgvPSaqbZ6kDuwA8ISQibLwVRxuI1JVHbA5S8JEmMjNbaxS
         y9+CMLybju+u/m99GokO2BsUHs6HC073tkGUSkbJ3+rPgdze4NwiFHL/m8fltUIAA4if
         hj9g==
X-Gm-Message-State: AOAM533HdSG6zBSDOY0Mi5hjsbBd5eLGtCtH433flFpdimB/s4wITJyG
        AmoCcRn1qKKxiaRua2RnI9fdVw==
X-Google-Smtp-Source: ABdhPJx2nBMjyTm+bwLmTpsse4QdZCtIjNHL/IA797uyM79TNQu+ZX1Zgwg29dM3A1IPguXf3iHOtA==
X-Received: by 2002:a05:6e02:1c2a:: with SMTP id m10mr5953238ilh.17.1611687429447;
        Tue, 26 Jan 2021 10:57:09 -0800 (PST)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id l14sm13060681ilh.58.2021.01.26.10.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 10:57:08 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     elder@kernel.org, evgreen@chromium.org, bjorn.andersson@linaro.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 2/6] net: ipa: minor update to handling of packet with status
Date:   Tue, 26 Jan 2021 12:56:59 -0600
Message-Id: <20210126185703.29087-3-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210126185703.29087-1-elder@linaro.org>
References: <20210126185703.29087-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rearrange some comments and assignments made when handling a packet
that is received with status, aiming to improve understandability.

Use DIV_ROUND_CLOSEST() to get a better per-packet true size estimate.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_endpoint.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ipa/ipa_endpoint.c b/drivers/net/ipa/ipa_endpoint.c
index 39ae0dd4e0471..c5524215054c8 100644
--- a/drivers/net/ipa/ipa_endpoint.c
+++ b/drivers/net/ipa/ipa_endpoint.c
@@ -1213,12 +1213,11 @@ static void ipa_endpoint_status_parse(struct ipa_endpoint *endpoint,
 			continue;
 		}
 
-		/* Compute the amount of buffer space consumed by the
-		 * packet, including the status element.  If the hardware
-		 * is configured to pad packet data to an aligned boundary,
-		 * account for that.  And if checksum offload is is enabled
-		 * a trailer containing computed checksum information will
-		 * be appended.
+		/* Compute the amount of buffer space consumed by the packet,
+		 * including the status element.  If the hardware is configured
+		 * to pad packet data to an aligned boundary, account for that.
+		 * And if checksum offload is enabled a trailer containing
+		 * computed checksum information will be appended.
 		 */
 		align = endpoint->data->rx.pad_align ? : 1;
 		len = le16_to_cpu(status->pkt_len);
@@ -1226,16 +1225,21 @@ static void ipa_endpoint_status_parse(struct ipa_endpoint *endpoint,
 		if (endpoint->data->checksum)
 			len += sizeof(struct rmnet_map_dl_csum_trailer);
 
-		/* Charge the new packet with a proportional fraction of
-		 * the unused space in the original receive buffer.
-		 * XXX Charge a proportion of the *whole* receive buffer?
-		 */
 		if (!ipa_status_drop_packet(status)) {
-			u32 extra = unused * len / total_len;
-			void *data2 = data + sizeof(*status);
-			u32 len2 = le16_to_cpu(status->pkt_len);
+			void *data2;
+			u32 extra;
+			u32 len2;
 
 			/* Client receives only packet data (no status) */
+			data2 = data + sizeof(*status);
+			len2 = le16_to_cpu(status->pkt_len);
+
+			/* Have the true size reflect the extra unused space in
+			 * the original receive buffer.  Distribute the "cost"
+			 * proportionately across all aggregated packets in the
+			 * buffer.
+			 */
+			extra = DIV_ROUND_CLOSEST(unused * len, total_len);
 			ipa_endpoint_skb_copy(endpoint, data2, len2, extra);
 		}
 
-- 
2.20.1

