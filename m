Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58AC926C9BF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 21:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgIPTVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 15:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727301AbgIPTTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 15:19:30 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA81C06178C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 12:17:45 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id q4so2099071pjh.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 12:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JtOdjzk2AjLKKx8fR1wiVnJLztwSFAhfdF2zzVQT4WQ=;
        b=bArPy8Nlme0HHLA+psQxCWzsczi82wThoDcWgLRGfYdXivtIGIe6HXIlWyeGHfsGgn
         R/YYPSm1m1UV+z7W7EThJm96k/+RYf6MGr0x3EYMcLA/yXFvUn5kucWYY1cSwdbq82QW
         nmom4rug9qS6T0mEtEZdv4YTASbpMSHt0KAnVekuvGFr0z4YqtxcpFXMLss8k9CKBf+l
         aHGdvyaddYcQBfdhpe9Gi/Al+UjRyUFD7RCCSzZonzy7Ow1R1JeM2PzJBbTkMuZeebrC
         SLNpCKeC4j14ffjhcQF3oC+PGoS6Iejecvwdhaqzip11uReuPVdFENNFY6aDOLD7ywmE
         rurw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JtOdjzk2AjLKKx8fR1wiVnJLztwSFAhfdF2zzVQT4WQ=;
        b=RzEyoXF/0dr7FDgFEiqhbHrk8udQgYjxQbQS7Z08X6MrDiPF8gUM3pEKWBdAAGd7WU
         0el7BpudRYuO8DuDDUxMzjAjTyH2wwIc3z8uAyfcv4OZEuFwTM9KvCfsNgzyMhB9260k
         aeOG+rZOGZn+IAQyFD20jVUpR0PmRgIkkquI9ZW0eETkk2p3RJau62Xoa1Ul9bb9M/XO
         IJN9focO1wqAJc7TnezMxAKDt6CYjKqA5jlYKDnz3/xpCVrqSKTzS8dwhTLvfafJtAlW
         avNEoPCb1W96kuGY0fodJjfKZOtjbq/xIYrXn9fS2oagQMmd08Hv8e/Ui5kfG9yN250B
         HUxQ==
X-Gm-Message-State: AOAM5337hBZBbdyDOWyI/sBTBjfih/fj3figZ+YqS6QzZd1oMufmfciV
        SG6ijORIgQ7Qd5gU3hts3tg26Q==
X-Google-Smtp-Source: ABdhPJxtYWXM55bbRMdbJcs1S4l9lg8eh9p4tiUeKPoE0W9ygP3Q8NplZVDmsrgrvwbSXxe8nRr7qQ==
X-Received: by 2002:a17:90a:fc6:: with SMTP id 64mr5487062pjz.194.1600283865126;
        Wed, 16 Sep 2020 12:17:45 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id b2sm11373688pfp.3.2020.09.16.12.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 12:17:44 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/16] coresight: cti: disclaim device only when it's claimed
Date:   Wed, 16 Sep 2020 13:17:26 -0600
Message-Id: <20200916191737.4001561-6-mathieu.poirier@linaro.org>
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

Coresight_claim_device() is called in cti_starting_cpu() only
when CTI is enabled while coresight_disclaim_device() is called
uncontionally in cti_dying_cpu(). This triggered below WARNING.
Only call disclaim device when CTI device is enabled to fix it.

[   75.989643] WARNING: CPU: 1 PID: 14 at
kernel/drivers/hwtracing/coresight/coresight.c:209
coresight_disclaim_device_unlocked+0x10/0x24
[   75.989697] CPU: 1 PID: 14 Comm: migration/1 Not tainted
5.9.0-rc1-gff1304be0a05-dirty #21
[   75.989709] Hardware name: Thundercomm Dragonboard 845c (DT)
[   75.989737] pstate: 80c00085 (Nzcv daIf +PAN +UAO BTYPE=--)
[   75.989758] pc : coresight_disclaim_device_unlocked+0x10/0x24
[   75.989775] lr : coresight_disclaim_device+0x24/0x38
[   75.989783] sp : ffff800011cd3c90
.
[   75.990018] Call trace:
[   75.990041]  coresight_disclaim_device_unlocked+0x10/0x24
[   75.990066]  cti_dying_cpu+0x34/0x4c
[   75.990101]  cpuhp_invoke_callback+0x84/0x1e0
[   75.990121]  take_cpu_down+0x90/0xe0
[   75.990154]  multi_cpu_stop+0x134/0x160
[   75.990171]  cpu_stopper_thread+0xb0/0x13c
[   75.990196]  smpboot_thread_fn+0x1c4/0x270
[   75.990222]  kthread+0x128/0x154
[   75.990251]  ret_from_fork+0x10/0x18

Fixes: e9b880581d55 ("coresight: cti: Add CPU Hotplug handling to CTI driver")
Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
Reviewed-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-cti.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-cti.c b/drivers/hwtracing/coresight/coresight-cti.c
index 3ccc703dc940..d6fea6efec71 100644
--- a/drivers/hwtracing/coresight/coresight-cti.c
+++ b/drivers/hwtracing/coresight/coresight-cti.c
@@ -742,7 +742,8 @@ static int cti_dying_cpu(unsigned int cpu)
 
 	spin_lock(&drvdata->spinlock);
 	drvdata->config.hw_powered = false;
-	coresight_disclaim_device(drvdata->base);
+	if (drvdata->config.hw_enabled)
+		coresight_disclaim_device(drvdata->base);
 	spin_unlock(&drvdata->spinlock);
 	return 0;
 }
-- 
2.25.1

