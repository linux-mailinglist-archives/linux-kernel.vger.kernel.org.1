Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC8E2C0351
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 11:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbgKWKaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 05:30:00 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:19298 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728182AbgKWK37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 05:29:59 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606127398; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=sad96RgdXSyv4MJgrYZrOtk0wlJjAbhYHgzdbqIQP2E=; b=XqCaBITOBjo8tcBOYvemZcqRWF9dyXQBoGm8Xwhr6ysd86IDlN0QZTkAk4fhuIaV10PjmbmX
 NCFOuZECUx7q836TgLNhX+WRLxMHxYQSXGBUcz06l7Y3iiHdX8Zst1NdBpiKCorpROhaUSbj
 zgywgbBAvYz4Ru33NTlTkde9aFs=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5fbb8f1c22377520eeab493e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 23 Nov 2020 10:29:48
 GMT
Sender: pkondeti=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 16441C43462; Mon, 23 Nov 2020 10:29:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from codeaurora.org (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CEA6CC433C6;
        Mon, 23 Nov 2020 10:29:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CEA6CC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=pkondeti@codeaurora.org
From:   Pavankumar Kondeti <pkondeti@codeaurora.org>
To:     linux-kernel@vger.kernel.org
Cc:     Pavankumar Kondeti <pkondeti@codeaurora.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Quentin Perret <qperret@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH V2] PM / EM: Micro optimization in em_cpu_energy
Date:   Mon, 23 Nov 2020 15:59:30 +0530
Message-Id: <1606127371-13828-1-git-send-email-pkondeti@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1606126679-11799-1-git-send-email-pkondeti@codeaurora.org>
References: <1606126679-11799-1-git-send-email-pkondeti@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the sum of the utilization of CPUs in a power domain is zero,
return the energy as 0 without doing any computations.

Signed-off-by: Pavankumar Kondeti <pkondeti@codeaurora.org>
---
V2: Fixed the function name in the commit message.

 include/linux/energy_model.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index b67a51c..8810f1f 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -103,6 +103,9 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 	struct em_perf_state *ps;
 	int i, cpu;
 
+	if (!sum_util)
+		return 0;
+
 	/*
 	 * In order to predict the performance state, map the utilization of
 	 * the most utilized CPU of the performance domain to a requested
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

