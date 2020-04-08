Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A659F1A2B3A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Apr 2020 23:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730744AbgDHVeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Apr 2020 17:34:05 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36803 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730725AbgDHVeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 17:34:04 -0400
Received: by mail-lf1-f66.google.com with SMTP id w145so6327370lff.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 14:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m0H+TjYWwXJL6hiVHCn9qdA94+TCG5AQ9tgfxlqydng=;
        b=ZVsytK8oepa/xsA0sM8t3gMRagHJuW5Qs0EVWvZ7J1bdzExT/XHV6k5yG+Er1smbpE
         zP/G7J3t98FuREH7B3bviEHc+AVvKwsnh2sKGF2QbbhNkjsiU7YtGMxQex2bDeQnQ3W1
         HJiAywwY/trHlixyjU0xgyyIOyCGkJwsxeBYtx+UCzYuj7V96ZujQd92tms66/dkKvVh
         DBq+na8TDe4hLVPANGgzqPMHpyJ/l1SLA64P50yo45ya4W9YcAhX6GMbLpXEkhL8Vrla
         kC5PTPrpHrrwqiu9lrjoov4lp+gBRR7Bf7Za8+dQ19q4eCyFHHQWGIWa2BDEqovsQzlZ
         2zcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m0H+TjYWwXJL6hiVHCn9qdA94+TCG5AQ9tgfxlqydng=;
        b=ZXJIo7IbWM0Q44CQBAFHwHkOgJMcxAlyeUPSip1LYmM28F/qxDQ3P9qVpTTJUOAbwZ
         YP3s+KhbHsijqpaUsIZFBVBWqHF29f7GMVcrW9tuN70WvD7/gMf40I+L5SkNQzxRypDd
         9U6G6qyXo/YM2qNYstmx1CUoZljRVQ3CuNdAsJV4WQG2IX1XUv+oVwYvzGUyIaJDrQoS
         kg7GcyLt/eU3nyICAtIJHX1YOROfncuTQeGYOrbJLpoMzooI+Z96YRQyEW1YCqv36FLn
         zrpFvs8EREe/pe7oIvdufmhdUIj02giltOO5ti6Dl8ABgdqucrtECttCh6fklAgSwHQq
         zX4w==
X-Gm-Message-State: AGi0PuZnR5sznKl2fJnTegJCn5RTWYVFeHpubbEN6WnVe8Jzadrof3kP
        xu2PCPh7JEdH3WMPsI/idlptsnB+YRA=
X-Google-Smtp-Source: APiQypLo2KsnOD3IP8EornlujL2uN5qo/QX3SVWS4aKcbrkUnfD9UjEAD2+xFgq0GNZnpZovYZc74A==
X-Received: by 2002:ac2:4116:: with SMTP id b22mr877544lfi.172.1586381641914;
        Wed, 08 Apr 2020 14:34:01 -0700 (PDT)
Received: from localhost.localdomain (212-5-158-138.ip.btc-net.bg. [212.5.158.138])
        by smtp.gmail.com with ESMTPSA id t6sm15746688lfb.55.2020.04.08.14.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 14:34:01 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Vikash Garodia <vgarodia@codeaurora.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH 2/7] venus: core: Fix mutex destroy in remove
Date:   Thu,  9 Apr 2020 00:33:25 +0300
Message-Id: <20200408213330.27665-3-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200408213330.27665-1-stanimir.varbanov@linaro.org>
References: <20200408213330.27665-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hfi_destroy function is called too early in remove method. It
destroys a mutex which is used later in the .remove from pmruntime.
Solve the issue by moving hfi_destroy after last usage of the mutex.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index f8b9a732bc65..afd76bcd9978 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -318,7 +318,6 @@ static int venus_remove(struct platform_device *pdev)
 	ret = hfi_core_deinit(core, true);
 	WARN_ON(ret);
 
-	hfi_destroy(core);
 	venus_shutdown(core);
 	of_platform_depopulate(dev);
 
@@ -330,6 +329,8 @@ static int venus_remove(struct platform_device *pdev)
 	if (pm_ops->core_put)
 		pm_ops->core_put(dev);
 
+	hfi_destroy(core);
+
 	icc_put(core->video_path);
 	icc_put(core->cpucfg_path);
 
-- 
2.17.1

