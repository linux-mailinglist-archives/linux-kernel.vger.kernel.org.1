Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA99C2F50D6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 18:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbhAMRQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 12:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727866AbhAMRQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 12:16:18 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCA2C06179F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 09:15:38 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id q2so3975649iow.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 09:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aRwGdFI2JNmHcGPkamTAcTzIYOj5ZfZH0cIxNdbAZHY=;
        b=uXJNMHGXscrnSoI79efLaUuFvE7/ABS22pvoY3+9K/k0B68J1lt39suBR/zXUoR2Fc
         FEgfrqHtIJQFokAqr+GmaXSU/AJ+ZEnexW94vAyF4AsofEZDQp0R0EHH6hqVIfRWnvfg
         2ddrJa+jaOM9QHG0KrRKM6E8E3GZGlqCCAAgqi8cBNsgHDWyfdBJzNM3svvQ57Gb5dB9
         xa1peFwhj3myH7zMiNAgEOi8lwaWvMmfD/7HFD2USuoA794qXM/FTavf/Fe3+7oNKXvj
         qYAuZT1yfRkCPR1/7y4/fgkP2BFOO2880XJgeja3bp2DuTppNOILc7w4BnCUMNwfzl4o
         P1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aRwGdFI2JNmHcGPkamTAcTzIYOj5ZfZH0cIxNdbAZHY=;
        b=A3aSM1Ae/lJmnQnZf9US/smvi16ntbEVTFeQE1E4quCKtaSOaad6oh3MjjM/J4pEZH
         Jg+bZKbTObAh3gG+NZFgRGCYLe+i8hfJ4YKDupp7/bafPk4y1OjLqDKE/VxSQ1fjHufg
         6VM/avPKbQHDTYvFoUXeqaKGemdtDNNx0273bGTNvLUMEnsSTuOvcdLkQbAR3pCnGQRs
         RM8Ve4B3yHx6sQeL/oyqHsRfszrFPLYXw70f4jcjL3jLviGzZMqA9fXjFrnwOtnEJ6Nf
         yIacsgXmhc1GtUbdvaeLlvXJP3P0ShTtmvIgfb+7PCRh/de4up7+zMMvQZX3EyuzfEYl
         TCEg==
X-Gm-Message-State: AOAM533w21Wei38rbRp4+4KLnhAEijDMjSgBXMCr/0FnzgCPSJ0VbFeb
        pk2RZehuLwsU3h1u83bNgYIGhQ==
X-Google-Smtp-Source: ABdhPJxmKQZYLN3X8LSa7lHDsX4cc7G5qtNntqZZmsJ6VN6TwXinxmIs8EQXy6WrwgnZDkOYyOanyA==
X-Received: by 2002:a92:9ada:: with SMTP id c87mr3336323ill.5.1610558137845;
        Wed, 13 Jan 2021 09:15:37 -0800 (PST)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id h9sm1120579ili.43.2021.01.13.09.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 09:15:37 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, bjorn.andersson@linaro.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/6] net: ipa: a few simple renames
Date:   Wed, 13 Jan 2021 11:15:27 -0600
Message-Id: <20210113171532.19248-2-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210113171532.19248-1-elder@linaro.org>
References: <20210113171532.19248-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of gsi_command() is true if successful or false if
we time out waiting for a completion interrupt.

Rename the variables in the three callers of gsi_command() to be
"timeout", to make it more obvious that's the only reason for
failure.

In addition, add a "gsi_" prefix to evt_ring_command() so its name
is consistent with the convention used for GSI channel and generic
commands.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/gsi.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ipa/gsi.c b/drivers/net/ipa/gsi.c
index 14d9a791924bf..b5913ce0bc943 100644
--- a/drivers/net/ipa/gsi.c
+++ b/drivers/net/ipa/gsi.c
@@ -326,13 +326,13 @@ gsi_evt_ring_state(struct gsi *gsi, u32 evt_ring_id)
 }
 
 /* Issue an event ring command and wait for it to complete */
-static void evt_ring_command(struct gsi *gsi, u32 evt_ring_id,
-			     enum gsi_evt_cmd_opcode opcode)
+static void gsi_evt_ring_command(struct gsi *gsi, u32 evt_ring_id,
+				 enum gsi_evt_cmd_opcode opcode)
 {
 	struct gsi_evt_ring *evt_ring = &gsi->evt_ring[evt_ring_id];
 	struct completion *completion = &evt_ring->completion;
 	struct device *dev = gsi->dev;
-	bool success;
+	bool timeout;
 	u32 val;
 
 	/* We only perform one event ring command at a time, and event
@@ -354,13 +354,13 @@ static void evt_ring_command(struct gsi *gsi, u32 evt_ring_id,
 	val = u32_encode_bits(evt_ring_id, EV_CHID_FMASK);
 	val |= u32_encode_bits(opcode, EV_OPCODE_FMASK);
 
-	success = gsi_command(gsi, GSI_EV_CH_CMD_OFFSET, val, completion);
+	timeout = !gsi_command(gsi, GSI_EV_CH_CMD_OFFSET, val, completion);
 
 	/* Disable the interrupt again */
 	gsi_irq_type_disable(gsi, GSI_EV_CTRL);
 	iowrite32(0, gsi->virt + GSI_CNTXT_SRC_EV_CH_IRQ_MSK_OFFSET);
 
-	if (success)
+	if (!timeout)
 		return;
 
 	dev_err(dev, "GSI command %u for event ring %u timed out, state %u\n",
@@ -380,7 +380,7 @@ static int gsi_evt_ring_alloc_command(struct gsi *gsi, u32 evt_ring_id)
 		return -EINVAL;
 	}
 
-	evt_ring_command(gsi, evt_ring_id, GSI_EVT_ALLOCATE);
+	gsi_evt_ring_command(gsi, evt_ring_id, GSI_EVT_ALLOCATE);
 
 	/* If successful the event ring state will have changed */
 	if (evt_ring->state == GSI_EVT_RING_STATE_ALLOCATED)
@@ -405,7 +405,7 @@ static void gsi_evt_ring_reset_command(struct gsi *gsi, u32 evt_ring_id)
 		return;
 	}
 
-	evt_ring_command(gsi, evt_ring_id, GSI_EVT_RESET);
+	gsi_evt_ring_command(gsi, evt_ring_id, GSI_EVT_RESET);
 
 	/* If successful the event ring state will have changed */
 	if (evt_ring->state == GSI_EVT_RING_STATE_ALLOCATED)
@@ -426,7 +426,7 @@ static void gsi_evt_ring_de_alloc_command(struct gsi *gsi, u32 evt_ring_id)
 		return;
 	}
 
-	evt_ring_command(gsi, evt_ring_id, GSI_EVT_DE_ALLOC);
+	gsi_evt_ring_command(gsi, evt_ring_id, GSI_EVT_DE_ALLOC);
 
 	/* If successful the event ring state will have changed */
 	if (evt_ring->state == GSI_EVT_RING_STATE_NOT_ALLOCATED)
@@ -456,7 +456,7 @@ gsi_channel_command(struct gsi_channel *channel, enum gsi_ch_cmd_opcode opcode)
 	u32 channel_id = gsi_channel_id(channel);
 	struct gsi *gsi = channel->gsi;
 	struct device *dev = gsi->dev;
-	bool success;
+	bool timeout;
 	u32 val;
 
 	/* We only perform one channel command at a time, and channel
@@ -477,13 +477,13 @@ gsi_channel_command(struct gsi_channel *channel, enum gsi_ch_cmd_opcode opcode)
 
 	val = u32_encode_bits(channel_id, CH_CHID_FMASK);
 	val |= u32_encode_bits(opcode, CH_OPCODE_FMASK);
-	success = gsi_command(gsi, GSI_CH_CMD_OFFSET, val, completion);
+	timeout = !gsi_command(gsi, GSI_CH_CMD_OFFSET, val, completion);
 
 	/* Disable the interrupt again */
 	gsi_irq_type_disable(gsi, GSI_CH_CTRL);
 	iowrite32(0, gsi->virt + GSI_CNTXT_SRC_CH_IRQ_MSK_OFFSET);
 
-	if (success)
+	if (!timeout)
 		return;
 
 	dev_err(dev, "GSI command %u for channel %u timed out, state %u\n",
@@ -1627,7 +1627,7 @@ static int gsi_generic_command(struct gsi *gsi, u32 channel_id,
 			       enum gsi_generic_cmd_opcode opcode)
 {
 	struct completion *completion = &gsi->completion;
-	bool success;
+	bool timeout;
 	u32 val;
 
 	/* The error global interrupt type is always enabled (until we
@@ -1650,12 +1650,12 @@ static int gsi_generic_command(struct gsi *gsi, u32 channel_id,
 	val |= u32_encode_bits(channel_id, GENERIC_CHID_FMASK);
 	val |= u32_encode_bits(GSI_EE_MODEM, GENERIC_EE_FMASK);
 
-	success = gsi_command(gsi, GSI_GENERIC_CMD_OFFSET, val, completion);
+	timeout = !gsi_command(gsi, GSI_GENERIC_CMD_OFFSET, val, completion);
 
 	/* Disable the GP_INT1 IRQ type again */
 	iowrite32(BIT(ERROR_INT), gsi->virt + GSI_CNTXT_GLOB_IRQ_EN_OFFSET);
 
-	if (success)
+	if (!timeout)
 		return gsi->result;
 
 	dev_err(gsi->dev, "GSI generic command %u to channel %u timed out\n",
-- 
2.20.1

