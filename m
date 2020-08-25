Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 033EE251DBC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 19:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgHYRCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 13:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbgHYRB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 13:01:59 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BFDC061757
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 10:01:59 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id t14so2788693wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 10:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QV/ePTGwly0PbuCxUdBYC9fwASHXwx8pOAXdY4hkxSk=;
        b=w6fLWxnzdnmnnXwVZMk3NMnzMDQI/s5/Sd0s5QnL7uZt4yk9BbTM0UauO2iHQMPchX
         j1YQGKFqB72CTy7+YBK1ukBydPhtP2nsnOAR61T8QnnqTC2PFdJQKXmLRU+LkNx09bgM
         fwxpVU5bekWJsrlGboysgLFzprUsXKUw8aibKC/p2qghW8jgZvjdXojcD78t1FbKyn2B
         7rDSkydZejaaedVnlDmp4sSrZL15YRLFdRu6KuEs2w4kXU4THMAkZIxtiX2P3mA1f1GL
         /Ka64J+Ytz1TY5wY9IXLKCm0b92iKlQCZtyMCQnH1rl77Ce7foZ12BaRClKuQq+5zPhg
         29yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QV/ePTGwly0PbuCxUdBYC9fwASHXwx8pOAXdY4hkxSk=;
        b=J6UrOouVbyXtYOWtWvXUTMVb916K0pSuJHRc4u1vma4DW6C5M32wK44j4hNN6txBFY
         I3MIN6Vtl3qdmQsL85AV1cQnSowJzm+37UUnnn1x1yTOOtm7+xqo0tyAe8jNBY3InS+Z
         0oOtnDaUzb8z3nBZl8DIaII+bO7nDuhEX7eqQvScRaaFnDh8JagiK5mJtFucr/nB2egh
         1qt0vCN88rpiob2d1wXNGVM02HPziuxg2fus/5dXPQjVj4BYUqdknfV44J5bb1kjPN+Y
         P7nrvkVMjlT1OplabOau6HfN/xM93jK2cRcCAQ5fQImfrNLlvZleeWK23y/FNh9hLyVp
         6skg==
X-Gm-Message-State: AOAM530vEyuySDXALo34AZ3lpMW9/lc6DJ9oGIf0r5/kpCLblhMcd75c
        9UuhhaePu/6EjGNtO8gCKGnFlw==
X-Google-Smtp-Source: ABdhPJz6SGQKUWpezGmwk3pInh4KEjtCXIoaZSTSgkQZZ9UzMSysDbUPGFWDWLXvfkWmLwVT/oXtDA==
X-Received: by 2002:a1c:f70a:: with SMTP id v10mr2926290wmh.39.1598374917760;
        Tue, 25 Aug 2020 10:01:57 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id y17sm6669008wma.17.2020.08.25.10.01.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Aug 2020 10:01:57 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     saravanak@google.com, mdtipton@codeaurora.org,
        okukatla@codeaurora.org, bjorn.andersson@linaro.org,
        vincent.guittot@linaro.org, akashast@codeaurora.org,
        georgi.djakov@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] interconnect: qcom: Use icc_sync_state
Date:   Tue, 25 Aug 2020 20:01:52 +0300
Message-Id: <20200825170152.6434-4-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200825170152.6434-1-georgi.djakov@linaro.org>
References: <20200825170152.6434-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lowering the bandwidth on the bus might have negative consequences if
it's done before all consumers had a chance to cast their vote. Now by
default the framework sets the bandwidth to maximum during boot. We need
to use the icc_sync_state callback to notify the framework when all
consumers are probed and there is no need to keep the bandwidth set to
maximum anymore.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/qcom/osm-l3.c | 1 +
 drivers/interconnect/qcom/sc7180.c | 1 +
 drivers/interconnect/qcom/sdm845.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/interconnect/qcom/osm-l3.c b/drivers/interconnect/qcom/osm-l3.c
index 96fb9ff5ff2e..ae955f164442 100644
--- a/drivers/interconnect/qcom/osm-l3.c
+++ b/drivers/interconnect/qcom/osm-l3.c
@@ -268,6 +268,7 @@ static struct platform_driver osm_l3_driver = {
 	.driver = {
 		.name = "osm-l3",
 		.of_match_table = osm_l3_of_match,
+		.sync_state = icc_sync_state,
 	},
 };
 module_platform_driver(osm_l3_driver);
diff --git a/drivers/interconnect/qcom/sc7180.c b/drivers/interconnect/qcom/sc7180.c
index dcf493d07928..4c5d38649220 100644
--- a/drivers/interconnect/qcom/sc7180.c
+++ b/drivers/interconnect/qcom/sc7180.c
@@ -633,6 +633,7 @@ static struct platform_driver qnoc_driver = {
 	.driver = {
 		.name = "qnoc-sc7180",
 		.of_match_table = qnoc_of_match,
+		.sync_state = icc_sync_state,
 	},
 };
 module_platform_driver(qnoc_driver);
diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
index f6c7b969520d..6aa39aad2555 100644
--- a/drivers/interconnect/qcom/sdm845.c
+++ b/drivers/interconnect/qcom/sdm845.c
@@ -559,6 +559,7 @@ static struct platform_driver qnoc_driver = {
 	.driver = {
 		.name = "qnoc-sdm845",
 		.of_match_table = qnoc_of_match,
+		.sync_state = icc_sync_state,
 	},
 };
 module_platform_driver(qnoc_driver);
