Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80C95287638
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 16:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730597AbgJHOio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 10:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729770AbgJHOio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 10:38:44 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D29AC061755
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 07:38:42 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id n18so6900721wrs.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 07:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=FB6oiqekxD6KQBOtL25AGTNlxj+owP0Z0d2XXT3CycU=;
        b=GidDfEuGMf0x3IVybYbsOdgEd2GBGFjOPiSoKOkDqPEEEswCD/uG4ZSPvdKOpsSRxh
         /I1cdDuDGudQhCVcqZO0KsXYDy4XELuJFg0702rdLRY+dtloRfVM0bZ9LikTfx4F7Eg0
         KAM+7KANP9Jp19igWILZAuLdvMQiyPAjpuXuJeODcCBHhjn3oC88bHPdMTrOq6uALtCE
         6EK0NyJedgiLZqVodlpMMb4h3ha+lncFJK0hav9SsYlBeD0QDW+w4+EIwHvZeH+digG+
         I3NuWcd9hCf3doEjXkMLCHNiD9AUixRIfPum2DvtH2dnCOqUVwN4j0dSTK+hEStqPCm2
         KuIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FB6oiqekxD6KQBOtL25AGTNlxj+owP0Z0d2XXT3CycU=;
        b=SPpXqiZYJxOUm8HSGmbBxUbOsxJEshFQvapwX47IXYfk3dUydwiZ3relPzN+F38AZY
         jXTJtookwcED10BqI/fuynmyLfG8YSFXHvK3H4mtPOiG85ig2YjQDid6mQ9l8ARF53xl
         zHnGV9kcQcqTULrkgeyl4Yx7yLlvOQsio+CtGQUpmuvjIezG4QNqziRr/zUQZt67MNrP
         kyZIlP5vGW2sI3/pgIO/zksV7BkrXZfbG3oQIaHFf77f7Z7DBYZhV4kNWPQ1eUOKV190
         VaeTUTT2azn6ZgL3tPyBDADs4oCziMYJfy6ro0GgfXB1S2dB+anffqmZC5a9ulaytLvR
         UXGw==
X-Gm-Message-State: AOAM533YYiUNaGtMLoRUnEAMVZVHqpPk5em1bnkf76kAMdTJ1EM57rjD
        DV6EPeErmvckqI58dvaM09oLC495PQ4SqVgoDYQ=
X-Google-Smtp-Source: ABdhPJwirUND1gx/xJWlOO2u3TXTwZvVIJX+XwyFjfELnyCZmUPsWbjhW2AU97TzEb6o9wp12Uv10A==
X-Received: by 2002:a5d:424e:: with SMTP id s14mr10597990wrr.149.1602167920912;
        Thu, 08 Oct 2020 07:38:40 -0700 (PDT)
Received: from lmecxl0524.lme.st.com ([2a04:cec0:11c8:908d:6533:9100:d943:8b22])
        by smtp.gmail.com with ESMTPSA id y14sm6926942wma.48.2020.10.08.07.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 07:38:40 -0700 (PDT)
From:   Etienne Carriere <etienne.carriere@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Etienne Carriere <etienne.carriere@linaro.org>
Subject: [PATCH 1/5] firmware: arm_scmi: always initialize protocols
Date:   Thu,  8 Oct 2020 16:37:18 +0200
Message-Id: <20201008143722.21888-1-etienne.carriere@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the IDR replacement that prevent initializing an SCMI protocol
when it has already been initialized. This is needed when there are
several SCMI agents that do implement a given SCMI protocol unless
what only the related SCMI protocol communication is initialized only
for first probed agent.

Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
---
 drivers/firmware/arm_scmi/bus.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
index 1377ec76a45d..8ea04b069129 100644
--- a/drivers/firmware/arm_scmi/bus.c
+++ b/drivers/firmware/arm_scmi/bus.c
@@ -60,11 +60,6 @@ static int scmi_protocol_init(int protocol_id, struct scmi_handle *handle)
 	return fn(handle);
 }
 
-static int scmi_protocol_dummy_init(struct scmi_handle *handle)
-{
-	return 0;
-}
-
 static int scmi_dev_probe(struct device *dev)
 {
 	struct scmi_driver *scmi_drv = to_scmi_driver(dev->driver);
@@ -83,10 +78,6 @@ static int scmi_dev_probe(struct device *dev)
 	if (ret)
 		return ret;
 
-	/* Skip protocol initialisation for additional devices */
-	idr_replace(&scmi_protocols, &scmi_protocol_dummy_init,
-		    scmi_dev->protocol_id);
-
 	return scmi_drv->probe(scmi_dev);
 }
 
-- 
2.17.1

