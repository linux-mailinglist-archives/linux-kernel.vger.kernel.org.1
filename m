Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF6E5287C3C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 21:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729689AbgJHTPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 15:15:08 -0400
Received: from foss.arm.com ([217.140.110.172]:45348 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729651AbgJHTPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 15:15:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CEF6B153B;
        Thu,  8 Oct 2020 12:15:04 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3F8B63F70D;
        Thu,  8 Oct 2020 12:15:03 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        ALKML <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh@kernel.org>, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 3/4] mailbox: arm_mhu: Match only if compatible is "arm,mhu"
Date:   Thu,  8 Oct 2020 20:14:51 +0100
Message-Id: <20201008191452.38672-4-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201008191452.38672-1-sudeep.holla@arm.com>
References: <20201008191452.38672-1-sudeep.holla@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we will be soon adding a separate driver based on this ARM MHU
driver to support doorbell mode, let us add explicit check to match
the default compatible for this driver. This is needed as the probe
and match reuses the AMBA device ids currently and don't have any
explicit compatible check.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/mailbox/arm_mhu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mailbox/arm_mhu.c b/drivers/mailbox/arm_mhu.c
index 9da236552bd7..b7fbf276eb62 100644
--- a/drivers/mailbox/arm_mhu.c
+++ b/drivers/mailbox/arm_mhu.c
@@ -113,6 +113,9 @@ static int mhu_probe(struct amba_device *adev, const struct amba_id *id)
 	struct device *dev = &adev->dev;
 	int mhu_reg[MHU_CHANS] = {MHU_LP_OFFSET, MHU_HP_OFFSET, MHU_SEC_OFFSET};
 
+	if (!of_device_is_compatible(dev->of_node, "arm,mhu"))
+		return -ENODEV;
+
 	/* Allocate memory for device */
 	mhu = devm_kzalloc(dev, sizeof(*mhu), GFP_KERNEL);
 	if (!mhu)
-- 
2.17.1

