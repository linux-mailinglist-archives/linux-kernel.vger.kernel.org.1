Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36D4A2FFC59
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 06:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbhAVFrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 00:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbhAVFrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 00:47:33 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC72C0613ED
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 21:46:53 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id m6so3008368pfk.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 21:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Axvfsgbj7EhHo3ybHt+3Pj5SrDQ7l1r5gUEOp+w2BQg=;
        b=ixFbv6BxVWo81sYGcQiVGVQgSrNwO04BPrWeqKIyRSM2oVcb6DcWjyVmaM/E0rEldQ
         DYiHT/AxjzHGkM3XGy0OZjWhuqGeTcU8DpdweBDmgikBHt3eW0W4u4zunr1LoCZgPS8X
         hzXNypVtZLC7EtDKMF+d9lozbk9ZdWCvtDZxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Axvfsgbj7EhHo3ybHt+3Pj5SrDQ7l1r5gUEOp+w2BQg=;
        b=e6iWdscDi/Q5SDf+2popVHxy5geBuMGs49XlfvTrRAhyMEaIWDHMyofarJ6Q0N8Xwa
         d89O+FzeY/SirFBdCsWrkUaz8xXVeodQxjIXWIt6YuVJ2SIWhHddwUp1vqM5HUuRrkuz
         1+OL/5PeEjoumWOly/6NdxME5mzQPAs7PLzFGARSwh2iCkhAjMUJp+eDV9fE+mUo78O3
         dA8VuzWbkEEh5MwCM4oEbpaezQb+pjJmUjqVo38xKo+OQwgleRw3y0mWgB8qKC9F9d09
         PQiSWtQi280Q/zckBGLO9lTPnmv0gJucnR9TaEjcZ5B4fBh1iWOyli6WoBKU+4sfUEgx
         mamg==
X-Gm-Message-State: AOAM533GNJ5L1x+VAe2PUULLFaRck63DtkH6OHTMV93RAEmYs44MPVwr
        F5OYk9lOHDL7Aqrxlgj0qwaEeg==
X-Google-Smtp-Source: ABdhPJzfTsOtFbtDEcO6BCVLRj4iJc6pLjoq/RdNP1IHIYn36z9nyd3R4qQrqHJbAJ55OgO5s21EMw==
X-Received: by 2002:a63:af05:: with SMTP id w5mr3107042pge.22.1611294412981;
        Thu, 21 Jan 2021 21:46:52 -0800 (PST)
Received: from localhost ([2620:15c:202:201:7220:84ff:fe09:94fe])
        by smtp.gmail.com with ESMTPSA id 68sm7285784pfe.33.2021.01.21.21.46.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jan 2021 21:46:52 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     rdunlap@infradead.org, groeck@chromium.org,
        enric.balletbo@collabora.com, bleung@chromium.org
Cc:     linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 2/2] platform: cros_ec: Call interrupt bottom half at probe time
Date:   Thu, 21 Jan 2021 21:46:37 -0800
Message-Id: <20210122054637.1422289-3-gwendal@chromium.org>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
In-Reply-To: <20210122054637.1422289-1-gwendal@chromium.org>
References: <20210122054637.1422289-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the AP was powered off, the EC may have send messages.
If the message is not serviced within 3s, the EC stops sending message.
Unlock the EC by purging stale messages at probe time.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
Changes since v1: None.

 drivers/platform/chrome/cros_ec.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index bf76a6c49c95..fc5aa1525d13 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -283,6 +283,13 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 
 	dev_info(dev, "Chrome EC device registered\n");
 
+	/*
+	 * Unlock EC that may be waiting for AP to process MKBP events.
+	 * If the AP takes to long to answer, the EC would stop sending events.
+	 */
+	if (ec_dev->mkbp_event_supported)
+		cros_ec_irq_thread(0, ec_dev);
+
 	return 0;
 }
 EXPORT_SYMBOL(cros_ec_register);
-- 
2.30.0.280.ga3ce27912f-goog

