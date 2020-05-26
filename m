Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57F661C4C53
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 04:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbgEECox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 May 2020 22:44:53 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:44379 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728451AbgEECou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 22:44:50 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588646690; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=/XTRZZ2bPayY8twzyHVrPJbdXMuj9hYt1lUtr6/5Fs8=; b=HyWjc7kodhLKMi6NXoeHxwiPqLyZzSOLzFgs5KKh24pkPEohdiqfGL8td4Il4rQHuJSafLeS
 19PHw7S/pczeT+mpy3r9xHoR9bqpuzI1RV6ZtlUzfVedSNJKAzFLOalOvhFvgky0JFDU2aBk
 2fL1V0zCsIrPlZdtL4y89ZJybbo=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb0d316.7fdb70018308-smtp-out-n02;
 Tue, 05 May 2020 02:44:38 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 902CDC433F2; Tue,  5 May 2020 02:44:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from bbhatt-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bbhatt)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BF14AC433CB;
        Tue,  5 May 2020 02:44:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BF14AC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=bbhatt@codeaurora.org
From:   Bhaumik Bhatt <bbhatt@codeaurora.org>
To:     mani@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        hemantk@codeaurora.org, jhugo@codeaurora.org,
        Bhaumik Bhatt <bbhatt@codeaurora.org>
Subject: [PATCH v5 8/8] bus: mhi: core: Ensure non-zero session or sequence ID values are used
Date:   Mon,  4 May 2020 19:44:22 -0700
Message-Id: <1588646662-25785-9-git-send-email-bbhatt@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1588646662-25785-1-git-send-email-bbhatt@codeaurora.org>
References: <1588646662-25785-1-git-send-email-bbhatt@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While writing any sequence or session identifiers, it is possible that
the host could write a zero value, whereas only non-zero values should
be supported writes to those registers. Ensure that the host does not
write a non-zero value for them and also log them in debug messages.

Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
---
 drivers/bus/mhi/core/boot.c     | 15 +++++++--------
 drivers/bus/mhi/core/internal.h |  2 ++
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/bus/mhi/core/boot.c b/drivers/bus/mhi/core/boot.c
index e5fcde1..7b9b561 100644
--- a/drivers/bus/mhi/core/boot.c
+++ b/drivers/bus/mhi/core/boot.c
@@ -43,10 +43,7 @@ void mhi_rddm_prepare(struct mhi_controller *mhi_cntrl,
 		      lower_32_bits(mhi_buf->dma_addr));
 
 	mhi_write_reg(mhi_cntrl, base, BHIE_RXVECSIZE_OFFS, mhi_buf->len);
-	sequence_id = prandom_u32() & BHIE_RXVECSTATUS_SEQNUM_BMSK;
-
-	if (unlikely(!sequence_id))
-		sequence_id = 1;
+	sequence_id = MHI_RANDOM_U32_NONZERO(BHIE_RXVECSTATUS_SEQNUM_BMSK);
 
 	mhi_write_reg_field(mhi_cntrl, base, BHIE_RXVECDB_OFFS,
 			    BHIE_RXVECDB_SEQNUM_BMSK, BHIE_RXVECDB_SEQNUM_SHFT,
@@ -189,7 +186,9 @@ static int mhi_fw_load_amss(struct mhi_controller *mhi_cntrl,
 		return -EIO;
 	}
 
-	dev_dbg(dev, "Starting AMSS download via BHIe\n");
+	sequence_id = MHI_RANDOM_U32_NONZERO(BHIE_TXVECSTATUS_SEQNUM_BMSK);
+	dev_dbg(dev, "Starting AMSS download via BHIe. Sequence ID:%u\n",
+		sequence_id);
 	mhi_write_reg(mhi_cntrl, base, BHIE_TXVECADDR_HIGH_OFFS,
 		      upper_32_bits(mhi_buf->dma_addr));
 
@@ -198,7 +197,6 @@ static int mhi_fw_load_amss(struct mhi_controller *mhi_cntrl,
 
 	mhi_write_reg(mhi_cntrl, base, BHIE_TXVECSIZE_OFFS, mhi_buf->len);
 
-	sequence_id = prandom_u32() & BHIE_TXVECSTATUS_SEQNUM_BMSK;
 	mhi_write_reg_field(mhi_cntrl, base, BHIE_TXVECDB_OFFS,
 			    BHIE_TXVECDB_SEQNUM_BMSK, BHIE_TXVECDB_SEQNUM_SHFT,
 			    sequence_id);
@@ -246,14 +244,15 @@ static int mhi_fw_load_sbl(struct mhi_controller *mhi_cntrl,
 		goto invalid_pm_state;
 	}
 
-	dev_dbg(dev, "Starting SBL download via BHI\n");
+	session_id = MHI_RANDOM_U32_NONZERO(BHI_TXDB_SEQNUM_BMSK);
+	dev_dbg(dev, "Starting SBL download via BHI. Session ID:%u\n",
+		session_id);
 	mhi_write_reg(mhi_cntrl, base, BHI_STATUS, 0);
 	mhi_write_reg(mhi_cntrl, base, BHI_IMGADDR_HIGH,
 		      upper_32_bits(dma_addr));
 	mhi_write_reg(mhi_cntrl, base, BHI_IMGADDR_LOW,
 		      lower_32_bits(dma_addr));
 	mhi_write_reg(mhi_cntrl, base, BHI_IMGSIZE, size);
-	session_id = prandom_u32() & BHI_TXDB_SEQNUM_BMSK;
 	mhi_write_reg(mhi_cntrl, base, BHI_IMGTXDB, session_id);
 	read_unlock_bh(pm_lock);
 
diff --git a/drivers/bus/mhi/core/internal.h b/drivers/bus/mhi/core/internal.h
index 0965ca3..3205a92 100644
--- a/drivers/bus/mhi/core/internal.h
+++ b/drivers/bus/mhi/core/internal.h
@@ -452,6 +452,8 @@ enum mhi_pm_state {
 #define PRIMARY_CMD_RING		0
 #define MHI_DEV_WAKE_DB			127
 #define MHI_MAX_MTU			0xffff
+#define MHI_RANDOM_U32_NONZERO(bmsk)	((prandom_u32_max(U32_MAX - 1) & \
+					 (bmsk)) + 1)
 
 enum mhi_er_type {
 	MHI_ER_TYPE_INVALID = 0x0,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
