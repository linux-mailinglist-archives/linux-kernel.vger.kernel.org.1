Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6032A8CC5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 03:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgKFC2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 21:28:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbgKFC2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 21:28:17 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40362C0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 18:28:16 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id t14so2790439pgg.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 18:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kNtXnwKCsgjnlMDm3C3sL4M5crM/sRzajvYLm7BnyWI=;
        b=ooA1pST3WCb9ca/isQjXCxdBpxqer2SfhDXzYQCcf9XEf6JNRYzZBku1HVjfwGRQvO
         iQuW6hey4urO33lUeeUH27o0c/ENEhW4740fCLE8SXJfPqbc5iDJR/bdTPmjnS2ir8KG
         6IZ20Uv6XWvcrJOagMpovBeyVBI7MympuvfgpujR/UszxlwTvJuXQxDhsZJSHIH7Dkqr
         pr7xXJA/WJrp7jPsd/TkKXkruDUay4J+WRHOyxNqXC6rAuqo27f/E3UnKAz0mwdQi7cr
         eosEtqX1spdXReQ+O6oD5Us6ZIUWyHfg+EToIG56ZcUsgSaOQmyhZuYK/7JeXWXMznbG
         Aurg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kNtXnwKCsgjnlMDm3C3sL4M5crM/sRzajvYLm7BnyWI=;
        b=TmMBW6TsjYoi+QsLq1O9sF32pOhr3u1g3D7QQBgfaUCzv7zrGwd7Eg/WJfTfxmsDKv
         EPAdIyu5NgIeR0JeZM3X2Uu7K4wx+m2HHoW1M8kFkC82yZi3pPe5oLFfgvxOcRlWjLTD
         JSSL+l9qlcbpUizVp5uEbBaWuA656Qy0Ag0DNwwqqH3Du7+nKfAihAsfnAMvJEE8jjQz
         Mbw+ozQmWcqttQRBpHjvj8quD4wrynCdoHJrBc05RtRVi+zaoE0cruN7fh31BCaAB2LU
         NNzQ7p5honbo9vktSukYila8G67qGcBDfSFGc4IA+twYCQsd02vEcmkycXPCq3Gh7lSX
         dlUQ==
X-Gm-Message-State: AOAM532MIxLt3bYxFlUCFGF8+dmw8UvarXVngSv0XJlZNXh9cAYAAb8m
        9Wn+TLPN4d8z2+uTl729+mOhvJakzgixJg==
X-Google-Smtp-Source: ABdhPJwiT+iUaQzdOp2J1B5Z7gvZzHPMj7ENBj4gEjhFEqJ1MgAdCBmuwLo+EkJ5wWfYa5sq4YpMSA==
X-Received: by 2002:a63:cb51:: with SMTP id m17mr5025097pgi.337.1604629695765;
        Thu, 05 Nov 2020 18:28:15 -0800 (PST)
Received: from localhost.localdomain (p784a66b9.tkyea130.ap.so-net.ne.jp. [120.74.102.185])
        by smtp.gmail.com with ESMTPSA id m13sm3703040pjr.30.2020.11.05.18.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 18:28:15 -0800 (PST)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC PATCH v3.1 06/27] mmc: core: UHS-II support, generate UHS-II SD command packet
Date:   Fri,  6 Nov 2020 11:27:05 +0900
Message-Id: <20201106022726.19831-7-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201106022726.19831-1-takahiro.akashi@linaro.org>
References: <20201106022726.19831-1-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In SD-TRAN protocol, legacy SD commands should be "encapsulated" in SD
packets as described in SD specification.
Please see section 7.1 and 7.2.1 in "UHS-II Simplified Addendum."

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/mmc/core/core.c | 18 +++++++++++
 drivers/mmc/core/uhs2.c | 70 +++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/core/uhs2.h |  1 +
 3 files changed, 89 insertions(+)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index a08cb1c0f6d2..ac43e93033e6 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -337,6 +337,8 @@ static int mmc_mrq_prep(struct mmc_host *host, struct mmc_request *mrq)
 
 int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 {
+	struct uhs2_command uhs2_cmd;
+	u32 payload[4]; /* for maximum size */
 	int err;
 
 	init_completion(&mrq->cmd_completion);
@@ -354,6 +356,13 @@ int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
 	if (err)
 		return err;
 
+	if (host->flags & MMC_UHS2_SUPPORT &&
+	    host->flags & MMC_UHS2_INITIALIZED) {
+		uhs2_cmd.payload = payload;
+		mrq->cmd->uhs2_cmd = &uhs2_cmd;
+		uhs2_prepare_sd_cmd(host, mrq);
+	}
+
 	led_trigger_event(host->led, LED_FULL);
 	__mmc_start_request(host, mrq);
 
@@ -433,6 +442,8 @@ EXPORT_SYMBOL(mmc_wait_for_req_done);
  */
 int mmc_cqe_start_req(struct mmc_host *host, struct mmc_request *mrq)
 {
+	struct uhs2_command uhs2_cmd;
+	u32 payload[4]; /* for maximum size */
 	int err;
 
 	/*
@@ -453,6 +464,13 @@ int mmc_cqe_start_req(struct mmc_host *host, struct mmc_request *mrq)
 	if (err)
 		goto out_err;
 
+	if (host->flags & MMC_UHS2_SUPPORT &&
+	    host->flags & MMC_UHS2_INITIALIZED) {
+		uhs2_cmd.payload = payload;
+		mrq->cmd->uhs2_cmd = &uhs2_cmd;
+		uhs2_prepare_sd_cmd(host, mrq);
+	}
+
 	err = host->cqe_ops->cqe_request(host, mrq);
 	if (err)
 		goto out_err;
diff --git a/drivers/mmc/core/uhs2.c b/drivers/mmc/core/uhs2.c
index acb46b5b57ef..1f6d0e0cf355 100644
--- a/drivers/mmc/core/uhs2.c
+++ b/drivers/mmc/core/uhs2.c
@@ -807,3 +807,73 @@ int mmc_uhs2_rescan_try_freq(struct mmc_host *host, unsigned int freq)
 	return err;
 }
 EXPORT_SYMBOL_GPL(mmc_uhs2_rescan_try_freq);
+
+/**
+ * uhs2_prepare_sd_cmd - prepare for SD command packet
+ * @host:	MMC host
+ * @mrq:	MMC request
+ *
+ * Initialize and fill in a header and a payload of SD command packet.
+ * The caller should allocate uhs2_command in host->cmd->uhs2_cmd in
+ * advance.
+ *
+ * Return:	0 on success, non-zero error on failure
+ */
+int uhs2_prepare_sd_cmd(struct mmc_host *host, struct mmc_request *mrq)
+{
+	struct mmc_command *cmd;
+	struct uhs2_command *uhs2_cmd;
+	u16 header = 0, arg = 0;
+	u32 *payload;
+	u8 plen = 0;
+
+	cmd = mrq->cmd;
+	header = host->uhs2_dev_prop.node_id;
+	if ((cmd->flags & MMC_CMD_MASK) == MMC_CMD_ADTC)
+		header |= UHS2_PACKET_TYPE_DCMD;
+	else
+		header |= UHS2_PACKET_TYPE_CCMD;
+
+	arg = cmd->opcode << UHS2_SD_CMD_INDEX_POS;
+
+	uhs2_cmd = cmd->uhs2_cmd;
+	payload = uhs2_cmd->payload;
+	plen = 2; /* at the maximum */
+
+	if ((cmd->flags & MMC_CMD_MASK) == MMC_CMD_ADTC &&
+	    !cmd->uhs2_tmode0_flag) {
+		if (host->flags & MMC_UHS2_2L_HD)
+			arg |= UHS2_DCMD_2L_HD_MODE;
+
+		arg |= UHS2_DCMD_LM_TLEN_EXIST;
+
+		if (cmd->data->blocks == 1 &&
+		    cmd->data->blksz != 512 &&
+		    cmd->opcode != MMC_READ_SINGLE_BLOCK &&
+		    cmd->opcode != MMC_WRITE_BLOCK) {
+			arg |= UHS2_DCMD_TLUM_BYTE_MODE;
+			payload[1] = uhs2_dcmd_convert_msb(cmd->data->blksz);
+		} else {
+			payload[1] = uhs2_dcmd_convert_msb(cmd->data->blocks);
+		}
+
+		if (cmd->opcode == SD_IO_RW_EXTENDED) {
+			arg &= ~(UHS2_DCMD_LM_TLEN_EXIST |
+				UHS2_DCMD_TLUM_BYTE_MODE |
+				UHS2_NATIVE_DCMD_DAM_IO);
+			payload[1] = 0;
+			plen = 1;
+		}
+	} else {
+		plen = 1;
+	}
+
+	payload[0] = uhs2_dcmd_convert_msb(cmd->arg);
+	pr_debug("%s: %s: sd_cmd->arg = 0x%x, payload[0]= 0x%x.\n",
+		 mmc_hostname(host), __func__, cmd->arg, payload[0]);
+
+	uhs2_cmd_assemble(cmd, uhs2_cmd, header, arg, payload, plen, NULL, 0);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(uhs2_prepare_sd_cmd);
diff --git a/drivers/mmc/core/uhs2.h b/drivers/mmc/core/uhs2.h
index e3389d4dda3b..48486ba21062 100644
--- a/drivers/mmc/core/uhs2.h
+++ b/drivers/mmc/core/uhs2.h
@@ -16,5 +16,6 @@
 #define UHS2_PHY_INIT_ERR	1
 
 int mmc_uhs2_rescan_try_freq(struct mmc_host *host, unsigned int freq);
+int uhs2_prepare_sd_cmd(struct mmc_host *host, struct mmc_request *mrq);
 
 #endif /* MMC_UHS2_H */
-- 
2.28.0

