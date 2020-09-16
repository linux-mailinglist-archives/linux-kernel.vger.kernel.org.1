Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88D1426CA11
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 21:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbgIPTpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 15:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727422AbgIPTS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 15:18:26 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C35DC061788
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 12:17:43 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id gf14so2007015pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 12:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zx/tRahkEP1ZuMIl3SnwL71U4RtbDAoiNGLgupaBarI=;
        b=U626TRHmq+dValxTL/wxQGez4XilqyapSenwhZd08kDwFTFiUjAv297n7tj3r+Wj3l
         kONbPUFOnlqEE81iPzu1w1aIVA5pH+FHhI/CKOmpC4Z1xPeQLqV/nXHIppqli7bcQYma
         Eknf+HeeKvZqAn0AOV9cPMni+JWnHAN+HlwOr07XYJILofpviCyF/NCOiD/v+yTCpZr1
         L3h1XYk62XIXSgFTedflfw2Rk9apbzIbyTBes1YaqK//ENPKh1jdIXgswZbYD+LQa6Pq
         UMtw0edbobNVD4BlfuG3JX3ShOnM9Ce9R5Hj+QdV9WNhY1I3isw64vJeb7iaN415hLHe
         WYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zx/tRahkEP1ZuMIl3SnwL71U4RtbDAoiNGLgupaBarI=;
        b=Hoyq8e/rRNai+HPiU130CjeHRR2NEF4ebz2SDBwmNuYgv1qVnfVrQAUPBkgaM6wO+w
         iVg8FqNMfJPr+crLxWVM5bO2nCSUlUqG/Cdlb9L7o+S3KZPFXW4k3zCBDS9O8tvKIr1H
         fsbvX0scr2smp4nccdtJxwjKDI3FR9TyD3R7ejv9lO/salTuyilFf+U4WsimIAZBK9IX
         rg4cC5US+AqZoCFPsWz0bBZjhwH8ZCab7DCiw4Nwv1gIZyElvPCiZ3dDfpEQwbBhb9qh
         GlEbAmve5oUDmqSkiexVs6MJrdQTGV01NxdYyzqcYwUjBMW1IxfZzgmxBP3u1j9d2R3b
         iFRA==
X-Gm-Message-State: AOAM5304d7Dsz/Poj+hYR9V/HmPAMFdIp0JgSfAAar0C1PH+FGwRUVgY
        0JssZbussrQNkMeO+TC0+uxQKw==
X-Google-Smtp-Source: ABdhPJwwyxa6q5cJWUmAVgT0vuDVnsHuBPjDmEaxttGpGRNdARKtaR8d32GydHCyu5cf97Qw6sEpFA==
X-Received: by 2002:a17:902:8602:b029:d1:e5e7:be65 with SMTP id f2-20020a1709028602b02900d1e5e7be65mr7578928plo.63.1600283862043;
        Wed, 16 Sep 2020 12:17:42 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id b2sm11373688pfp.3.2020.09.16.12.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 12:17:41 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/16] coresight: stm: Support marked packet
Date:   Wed, 16 Sep 2020 13:17:23 -0600
Message-Id: <20200916191737.4001561-3-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200916191737.4001561-1-mathieu.poirier@linaro.org>
References: <20200916191737.4001561-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tingwei Zhang <tingwei@codeaurora.org>

STP_PACKET_MARKED is not supported by STM currently.
Add STM_FLAG_MARKED to support marked packet in STM.

Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-stm.c | 11 +++++++----
 include/uapi/linux/coresight-stm.h          |  1 +
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index 673d2f56ed1e..2ba819a47cf6 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -412,6 +412,7 @@ static ssize_t notrace stm_generic_packet(struct stm_data *stm_data,
 	void __iomem *ch_addr;
 	struct stm_drvdata *drvdata = container_of(stm_data,
 						   struct stm_drvdata, stm);
+	unsigned int stm_flags;
 
 	if (!(drvdata && local_read(&drvdata->mode)))
 		return -EACCES;
@@ -421,8 +422,9 @@ static ssize_t notrace stm_generic_packet(struct stm_data *stm_data,
 
 	ch_addr = stm_channel_addr(drvdata, channel);
 
-	flags = (flags == STP_PACKET_TIMESTAMPED) ? STM_FLAG_TIMESTAMPED : 0;
-	flags |= test_bit(channel, drvdata->chs.guaranteed) ?
+	stm_flags = (flags & STP_PACKET_TIMESTAMPED) ?
+			STM_FLAG_TIMESTAMPED : 0;
+	stm_flags |= test_bit(channel, drvdata->chs.guaranteed) ?
 			   STM_FLAG_GUARANTEED : 0;
 
 	if (size > drvdata->write_bytes)
@@ -432,7 +434,7 @@ static ssize_t notrace stm_generic_packet(struct stm_data *stm_data,
 
 	switch (packet) {
 	case STP_PACKET_FLAG:
-		ch_addr += stm_channel_off(STM_PKT_TYPE_FLAG, flags);
+		ch_addr += stm_channel_off(STM_PKT_TYPE_FLAG, stm_flags);
 
 		/*
 		 * The generic STM core sets a size of '0' on flag packets.
@@ -444,7 +446,8 @@ static ssize_t notrace stm_generic_packet(struct stm_data *stm_data,
 		break;
 
 	case STP_PACKET_DATA:
-		ch_addr += stm_channel_off(STM_PKT_TYPE_DATA, flags);
+		stm_flags |= (flags & STP_PACKET_MARKED) ? STM_FLAG_MARKED : 0;
+		ch_addr += stm_channel_off(STM_PKT_TYPE_DATA, stm_flags);
 		stm_send(ch_addr, payload, size,
 				drvdata->write_bytes);
 		break;
diff --git a/include/uapi/linux/coresight-stm.h b/include/uapi/linux/coresight-stm.h
index 8847dbf24151..7ff3709c01b8 100644
--- a/include/uapi/linux/coresight-stm.h
+++ b/include/uapi/linux/coresight-stm.h
@@ -5,6 +5,7 @@
 #include <linux/const.h>
 
 #define STM_FLAG_TIMESTAMPED   _BITUL(3)
+#define STM_FLAG_MARKED        _BITUL(4)
 #define STM_FLAG_GUARANTEED    _BITUL(7)
 
 /*
-- 
2.25.1

