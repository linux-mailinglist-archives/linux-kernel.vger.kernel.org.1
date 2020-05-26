Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6AA1BB44C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 04:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgD1C7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 22:59:52 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:54065 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726312AbgD1C7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 22:59:49 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588042789; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=HhP+C3GU4KjhC/yarghD4ar7UzNQxLJvXnzaTXkt3no=; b=ioKeh7P7QJpssSlMtBuyQvTiuk/o5Drr0PuKPhzqLayGgVpYQlCPUvpLpm7Tojlplwi43jGs
 84j3DkCMlgyUA/g16XDUhSnKxS5R2/hoBLp4+pgBF+RMRTx5Y6alvlSyvUesb95XG7Hx5ghi
 3U3lWpGW2Jh9ZR0gxb/kDTOru+s=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea79c1e.7fd1ccaf0d88-smtp-out-n05;
 Tue, 28 Apr 2020 02:59:42 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C2F15C433CB; Tue, 28 Apr 2020 02:59:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from bbhatt-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 39FAAC433D2;
        Tue, 28 Apr 2020 02:59:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 39FAAC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=bbhatt@codeaurora.org
From:   Bhaumik Bhatt <bbhatt@codeaurora.org>
To:     mani@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        hemantk@codeaurora.org, Bhaumik Bhatt <bbhatt@codeaurora.org>
Subject: [PATCH v2 5/8] bus: mhi: core: WARN_ON for malformed vector table
Date:   Mon, 27 Apr 2020 19:59:23 -0700
Message-Id: <1588042766-17496-6-git-send-email-bbhatt@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1588042766-17496-1-git-send-email-bbhatt@codeaurora.org>
References: <1588042766-17496-1-git-send-email-bbhatt@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a bounds check in the firmware copy routine to exit if a malformed
vector table is found while attempting to load the firmware in to the
BHIe vector table.

Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
Signed-off-by: Hemant Kumar <hemantk@codeaurora.org>
---
 drivers/bus/mhi/core/boot.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/bus/mhi/core/boot.c b/drivers/bus/mhi/core/boot.c
index 17c636b..bc70edc 100644
--- a/drivers/bus/mhi/core/boot.c
+++ b/drivers/bus/mhi/core/boot.c
@@ -362,8 +362,14 @@ static void mhi_firmware_copy(struct mhi_controller *mhi_cntrl,
 	int i = 0;
 	struct mhi_buf *mhi_buf = img_info->mhi_buf;
 	struct bhi_vec_entry *bhi_vec = img_info->bhi_vec;
+	struct device *dev = &mhi_cntrl->mhi_dev->dev;
 
 	while (remainder) {
+		if (WARN_ON(i >= img_info->entries)) {
+			dev_err(dev, "Malformed vector table\n");
+			return;
+		}
+
 		to_cpy = min(remainder, mhi_buf->len);
 		memcpy(mhi_buf->buf, buf, to_cpy);
 		bhi_vec->dma_addr = mhi_buf->dma_addr;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
