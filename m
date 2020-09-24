Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7852769F7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 09:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgIXHDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 03:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbgIXHDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 03:03:06 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6620AC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 00:03:06 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j2so2521424wrx.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 00:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6fUDDBclb8Pdaks1sJGAOi1wyDYHlSgOzyrSxCXhhsY=;
        b=LWlm5+OUnM3C3VfyIm4zTLFN76mK4PXnS5w5cRub1w/okxBXdW/49A5dkQk647mLC+
         3ThQDHr+yX4EMJmLw1KnCASbXJtzbGELrlLVQzr1GW41QmYGlFN1tPmxA3eu5IQechww
         xbFQXUbeThOq9Mjguy32PpUyQgcazorn7kxmu1gxkaJw6UH/ARZZoy3dtzvOLkpCyCBJ
         HSBsBe1nEcfzEkjtxVQQzVMC/qCmZKw2UYlg+pBwsL2eyQf1ihmYkila59ZwKTjHZcST
         HOPbrM3enonRmHBn36g5bmaRvbXQEYIDez+fOr7Eo/u2rsMEp/mdF+l6g2amctj+X/85
         dgEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6fUDDBclb8Pdaks1sJGAOi1wyDYHlSgOzyrSxCXhhsY=;
        b=LU2xPpTLp36b+vFIkBSEnTVYz/UIvaRSTPH+zX2YwyHuJ3jBjv+1ykx2ceuSnbXtz4
         Y5ezrDBobyzaAVtD50GC9eWa0Ts4eBJENCsVYVah5RRAe0XRMyKBWlhZDIQC8EbCv7hL
         1sc75IBf4QZHAYK/PKL0KjaqvItPEcqRhaH/tYK0VzXVGtepxw5uD0OtgAdJ0/nSxqX+
         flEJ57gznnqeJnYOwOoZoOFK1li/TXjTQMCcklKZdZXyUBTsf3FKT15v443ytVCRKXqx
         Sqv9XObBJi5GLENj2bxf7t3W7JXNpltEXLWlAxqM/pmq8KAFQm9rOLhpVFJV4GWpv3qU
         0EhQ==
X-Gm-Message-State: AOAM533N6EiHMtJdYgzyRGqr3poEhZ1tzhnyQZH/bo/IaB0tO8GE5Ma7
        xXrnF8pqvPVTtCWCZ21gQREF3KvdCFE=
X-Google-Smtp-Source: ABdhPJw22ufaAwjn5vQ8QqzdWLXJTu6WWP+KXyLAaAG1QwT7rz+W+utoS7Bfp6ehRIq2FcQV6HZ4PQ==
X-Received: by 2002:a5d:4709:: with SMTP id y9mr3407507wrq.59.1600930984426;
        Thu, 24 Sep 2020 00:03:04 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id n4sm2320628wrp.61.2020.09.24.00.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 00:03:03 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai
Subject: [PATCH 2/4] habanalabs: release kernel context after hw_fini
Date:   Thu, 24 Sep 2020 10:02:57 +0300
Message-Id: <20200924070259.19833-2-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200924070259.19833-1-oded.gabbay@gmail.com>
References: <20200924070259.19833-1-oded.gabbay@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some engines use resources that belong to the kernel context (e.g. MMU
mappings). In case the halt-engines doesn't work properly due to H/W
restriction, we need to make sure the kernel context lives on until after
the hw_fini. The hw_fini resets the ASIC after that no engine is alive and
we can safely close the kernel context.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/common/device.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 196e35d71118..20572224099a 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -967,14 +967,13 @@ int hl_device_reset(struct hl_device *hdev, bool hard_reset,
 		flush_workqueue(hdev->eq_wq);
 	}
 
-	/* Release kernel context */
-	if ((hard_reset) && (hl_ctx_put(hdev->kernel_ctx) == 1))
-		hdev->kernel_ctx = NULL;
-
 	/* Reset the H/W. It will be in idle state after this returns */
 	hdev->asic_funcs->hw_fini(hdev, hard_reset);
 
 	if (hard_reset) {
+		/* Release kernel context */
+		if (hl_ctx_put(hdev->kernel_ctx) == 1)
+			hdev->kernel_ctx = NULL;
 		hl_vm_fini(hdev);
 		hl_mmu_fini(hdev);
 		hl_eq_reset(hdev, &hdev->event_queue);
@@ -1465,13 +1464,13 @@ void hl_device_fini(struct hl_device *hdev)
 
 	hl_cb_pool_fini(hdev);
 
+	/* Reset the H/W. It will be in idle state after this returns */
+	hdev->asic_funcs->hw_fini(hdev, true);
+
 	/* Release kernel context */
 	if ((hdev->kernel_ctx) && (hl_ctx_put(hdev->kernel_ctx) != 1))
 		dev_err(hdev->dev, "kernel ctx is still alive\n");
 
-	/* Reset the H/W. It will be in idle state after this returns */
-	hdev->asic_funcs->hw_fini(hdev, true);
-
 	hl_vm_fini(hdev);
 
 	hl_mmu_fini(hdev);
-- 
2.17.1

