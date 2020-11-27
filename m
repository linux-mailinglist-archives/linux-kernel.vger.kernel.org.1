Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2496E2C6B05
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 18:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732535AbgK0RxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 12:53:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732623AbgK0RxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 12:53:06 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BE6C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 09:53:06 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id w6so5203602pfu.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 09:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mAY+TGRlEm3o5MNxNMBpluzt/7qnoQjRNsib7isq2qs=;
        b=IAd75o9Ux+6pS2aaLWCFpx6OGBGhz2I9diMGgOTccmmFWzvA6/Wn3Cfmz7ZWBItpTX
         eTV1Nt8kNuJ9P4rHjFzXRwfvI5jyXEgNAZDARDEOhvQ8hvkatB6IiSePme88ve9ToMyD
         ShqaI25JhiSXCAoBzyqqzlRfuFw7OJeG0ifeLLLJmC0cSzV/lZgKjFMwTK5tPhVbl4+d
         dWV1YAnLTBBToFuzSWkMWYT7/ga0yiKMrA8if8I8nuxxjBo1JyTrRrLIzF/CPIHtJaRb
         IJWU4hGDT0Li5UjAa73nCIi9PELnX5tOBnutRvjt6gvrObmp9JLmFrJdQKhRkfkGOLPg
         6YvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mAY+TGRlEm3o5MNxNMBpluzt/7qnoQjRNsib7isq2qs=;
        b=Afy9V0kPnFlQMKYANB+15vTuL+n0utu+me6QlW2EbkrT0VggtHzQU9z4guaz3kpHGt
         N4MCJegllrpV6z66rt10e72amLVnSFvH8Pih+IBWhGDR8M01LcVEQ4wd87iKm5nMh/Kf
         nEkgtQlC9Abu57flt4vCrOKtpKGqXTpVg9+8XKB0BSmUtzdsSX98DWylKjHvWs373sEi
         aqM2CF0wR92T7tW0eSiTR5WWLjpex0GgIXjdc1c4RbXfQ4cLlrkL7gCbX6D8KEy6Ww7G
         MGBhQE5dPZxDhLHUXU1b/5EcTQdwgxGBg3nzxRufnUgwdxCm/k/H5jbOp9p4Fg2SBIwn
         iUQA==
X-Gm-Message-State: AOAM5314hdn/DeYowL0f9aXF6pVQrRIf5DeLtHCejWvwBtF9LlU+kbu9
        3ri+sHAgvwiKtITq531fSXtKs0ijkHtYmgsJ
X-Google-Smtp-Source: ABdhPJwGD8lRAta9UtPQEpq31OFRDBV+JVXGZR1ggD1fMy2jspcSXtxyBZ0tTPjthlAXWmaBg5G9Qw==
X-Received: by 2002:a63:d45:: with SMTP id 5mr7637428pgn.0.1606499586105;
        Fri, 27 Nov 2020 09:53:06 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id t18sm10536724pji.1.2020.11.27.09.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 09:53:05 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/15] coresight: Remove unnecessary THIS_MODULE of funnel and replicator driver
Date:   Fri, 27 Nov 2020 10:52:49 -0700
Message-Id: <20201127175256.1092685-9-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201127175256.1092685-1-mathieu.poirier@linaro.org>
References: <20201127175256.1092685-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qi Liu <liuqi115@huawei.com>

As THIS_MODULE has been set in platform_driver_register(), so remove it
from static funnel driver and static replicator driver to avoid set it
twice.

Signed-off-by: Qi Liu <liuqi115@huawei.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-funnel.c     | 2 +-
 drivers/hwtracing/coresight/coresight-replicator.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index af40814ce560..39be46b74dfe 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -356,7 +356,7 @@ static struct platform_driver static_funnel_driver = {
 	.remove          = static_funnel_remove,
 	.driver         = {
 		.name   = "coresight-static-funnel",
-		.owner	= THIS_MODULE,
+		/* THIS_MODULE is taken care of by platform_driver_register() */
 		.of_match_table = static_funnel_match,
 		.acpi_match_table = ACPI_PTR(static_funnel_ids),
 		.pm	= &funnel_dev_pm_ops,
diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index 62afdde0e5ea..6772f23e5c4b 100644
--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -374,7 +374,7 @@ static struct platform_driver static_replicator_driver = {
 	.remove         = static_replicator_remove,
 	.driver         = {
 		.name   = "coresight-static-replicator",
-		.owner	= THIS_MODULE,
+		/* THIS_MODULE is taken care of by platform_driver_register() */
 		.of_match_table = of_match_ptr(static_replicator_match),
 		.acpi_match_table = ACPI_PTR(static_replicator_acpi_ids),
 		.pm	= &replicator_dev_pm_ops,
-- 
2.25.1

