Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0580B227F9B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 14:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729878AbgGUMHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 08:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbgGUMHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 08:07:42 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9FEC061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 05:07:41 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a14so6100231wra.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 05:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=npznphlDVv95ehRrHa25K6/37D7lyoH9vNDTfyrHV8o=;
        b=Ib1bZOSQY4liaBprcJTobQOsSM1ujiVEYXJWHQqVGnvE4yv0tHq72tpitVyrD3KM6D
         ZrTcl+yJEVDMxpdpHRtRa5pIC4GvuWfR+2+4Kkfc7Pkq+2cd/islUOLAEKsAXWuHuEXi
         qaf82L42Fbi1gMCgtsOZY7d1sw2NXVJRNaCK9TKvrHp4pwZcR0tGxl+AOqh8/7VKP2Z6
         o0fR69XozX1GzaPPQFayryxG/6uFGvKUPT4eXMAZZkdAp6Ur2EIztAXnsrAUYK9BNS43
         AiXaeHFqem370oI8xXpUlzQ+4KrVLNuwvbw+Cjw1QybNmoEp8QJ0LfyTqaihMQOcopU8
         tmCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=npznphlDVv95ehRrHa25K6/37D7lyoH9vNDTfyrHV8o=;
        b=mwMbjJV3421oZttkl+OCnJONL0QDjJhflt6I/b2/O0LhO4JdLKpG8hxb2fgW5MmTcs
         ae5EFGCc6c5p5lx1LQk81LlajFgy16XsfAGDZAxm3WHffDIgCkveQbCGnM19GDrOfQil
         VdkcP3OkdZ15tMHbC1KPEITrUsyxEjr+dmSfehjQ4Lgohdnv9XLLl3+RA8nvsoQKG/DW
         3QHFobTp1fyV4t7MQ8QCUhfKpnf4eQg8qpufg0R/TI9n73HHltqLkwvZr+nkP1ccAmTK
         2Stnr2zQOfp/svntwhk9MOdlEQCRVNr29qDRGM30XoA2AMmv1v219hns5vcvoEdfwoeY
         6bzA==
X-Gm-Message-State: AOAM531LQGCXFAUJMfeHHfkasIAk0XCzMTOUx9HoNf6pSLeIMKlAyWs8
        DxdUUVNl9skVrrN3RbwtZ1Bp3w==
X-Google-Smtp-Source: ABdhPJzxnd9kirmNWbPJEKL4Bfib1FwwANnT6N/xXtpyF1/9EyPJdf8YHG+4xM/09YW843CWbZiwSA==
X-Received: by 2002:adf:f488:: with SMTP id l8mr11938771wro.123.1595333260721;
        Tue, 21 Jul 2020 05:07:40 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id b10sm3057151wmj.30.2020.07.21.05.07.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jul 2020 05:07:40 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     adhudase@codeaurora.org, okukatla@codeaurora.org, mka@chromium.org,
        linux-kernel@vger.kernel.org,
        Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH] interconnect: Do not skip aggregation for disabled paths
Date:   Tue, 21 Jul 2020 15:07:40 +0300
Message-Id: <20200721120740.3436-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When an interconnect path is being disabled, currently we don't aggregate
the requests for it afterwards. But the re-aggregation step shouldn't be
skipped, as it may leave the nodes with outdated bandwidth data. This
outdated data may actually keep the path still enabled and prevent the
device from going into lower power states.

Reported-by: Atul Dhudase <adhudase@codeaurora.org>
Fixes: 7d374b209083 ("interconnect: Add helpers for enabling/disabling a path")
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/core.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 37d5ec970cc1..5174dcb31ab7 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -243,6 +243,7 @@ static int aggregate_requests(struct icc_node *node)
 {
 	struct icc_provider *p = node->provider;
 	struct icc_req *r;
+	u32 avg_bw, peak_bw;
 
 	node->avg_bw = 0;
 	node->peak_bw = 0;
@@ -251,9 +252,14 @@ static int aggregate_requests(struct icc_node *node)
 		p->pre_aggregate(node);
 
 	hlist_for_each_entry(r, &node->req_list, req_node) {
-		if (!r->enabled)
-			continue;
-		p->aggregate(node, r->tag, r->avg_bw, r->peak_bw,
+		if (r->enabled) {
+			avg_bw = r->avg_bw;
+			peak_bw = r->peak_bw;
+		} else {
+			avg_bw = 0;
+			peak_bw = 0;
+		}
+		p->aggregate(node, r->tag, avg_bw, peak_bw,
 			     &node->avg_bw, &node->peak_bw);
 	}
 
