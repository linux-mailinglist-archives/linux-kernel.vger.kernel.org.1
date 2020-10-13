Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9748128CFA5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 15:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388163AbgJMN7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 09:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387613AbgJMN7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 09:59:14 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C843FC0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 06:59:13 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id e2so50624wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 06:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xYqWuTW/0Vb6gGlVF7Mqhv2moxO3xlTQ1hwvFz7tpn0=;
        b=T0Lbzn5xsQq5ohWfhjLZa15Y2tTnWUX4qvT414oZujmvMxJo0+sBsDhdPtjbxgPZ9W
         wz0JOI3pw+Z3affCaTtFQvUQvEtByaCYO8yuH/nfIGKpioMewNxKLWrQwtokcaUyGC6G
         8L2NKfLyN0J8Q5JITaulmvha9GwPTCPqkKizm42ET85yAes2eo3+7/F8XzYcOoSYjqxQ
         MTa/FQmT9gB0Dn6CNedEDebc6QFPc7nqQcFCSUeQr2OLi8qL391+dlVpOHpqHbulKAWh
         I6CGA21MWIHW6P31zpAzghqvcjAaqMlFDV4R8F2DdcJUmlXdOLT4wrnxht3qhb2EPSYl
         NU3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xYqWuTW/0Vb6gGlVF7Mqhv2moxO3xlTQ1hwvFz7tpn0=;
        b=mt2NeO4FthbuNASYY/yPETLusweV9Iefz1Twgkju4Zw29OthD5LRBdB81zlYTxWdRG
         nHvQDKTm/f2X61oS7WibMktav/MlFhBV2TKCddvNGwfrWKe5ACu10f8DxS+yijfEEhOc
         f4DU4K14lKZWfnHQygmeSPgbCcTMIhuLCNBsrts0FbO50o0Y0AKw6mhq/ta4ADgvJvz+
         +9w4Ea6TLYuTOiYtCzenFUva66ztrUbK5mgKwg9LFdbprT6p8BJNNZI0ad6nCEHUf6bZ
         wrxUY64PQStoyYX712u1N0iNe6M19oXwDsDui9cdZ24eGI7xrFkePzosJRLZlFShE/yD
         YDsQ==
X-Gm-Message-State: AOAM532zyrFhNuWs2iE+EI9C73TS9K/VTnWVB1o6r8sTzlLOuthFGr00
        NDSCxCx92Onmo47uoLVa6B/ndQ==
X-Google-Smtp-Source: ABdhPJxhjDWYCCReMk52XDj/uJUpC3UL0DI10mjq49N44EKAuYAhZl162evpZLmnK9N44Jw+wXmgwg==
X-Received: by 2002:a7b:cc17:: with SMTP id f23mr58713wmh.166.1602597552536;
        Tue, 13 Oct 2020 06:59:12 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id a199sm17785wmd.8.2020.10.13.06.59.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Oct 2020 06:59:11 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     mdtipton@codeaurora.org, okukatla@codeaurora.org,
        sibis@codeaurora.org, saravanak@google.com,
        bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org,
        Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH 1/3] interconnect: Aggregate before setting initial bandwidth
Date:   Tue, 13 Oct 2020 16:59:11 +0300
Message-Id: <20201013135913.29059-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When setting the initial bandwidth, make sure to call the aggregate()
function (if such is implemented for the current provider), to handle
cases when data needs to be aggregated first.

Fixes: b1d681d8d324 ("interconnect: Add sync state support")
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index eea47b4c84aa..974a66725d09 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -971,6 +971,9 @@ void icc_node_add(struct icc_node *node, struct icc_provider *provider)
 	}
 	node->avg_bw = node->init_avg;
 	node->peak_bw = node->init_peak;
+	if (provider->aggregate)
+		provider->aggregate(node, 0, node->init_avg, node->init_peak,
+				    &node->avg_bw, &node->peak_bw);
 	provider->set(node, node);
 	node->avg_bw = 0;
 	node->peak_bw = 0;
