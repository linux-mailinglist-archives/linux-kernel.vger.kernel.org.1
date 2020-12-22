Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0822E0E13
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 19:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbgLVSBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 13:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728138AbgLVSA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 13:00:58 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A00FC06179C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 10:00:18 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id w17so6113326ilj.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 10:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X9vpT9HP+T68ID/sfzmEYx652yUR/SG2I6ViTerD2lk=;
        b=ChyVeNDiVBOQvYIrrBXZaHw5Cuajv/Io2nJlEgzp43ppcE0lvyMBltZdDWZrDHcuXt
         eWhveSXSTjOjso+jCpS58vuiJuzcMVXoiiQpfbV3dBIc42iXX9AabXkVO/5LRas6DX4h
         XkLhA5VhEFkglsiURfapN2VnlXD4lpO+IogNWutN4ryCT6tRa0KrlrEMelqXFE6H6NK8
         vWkVUaG3FDIjY4EhPN1cyd7yqzJ+1BLW+Swzkr8lYnMriKKVv3ASTvqre9+D164xwpof
         MkO9FUlGg3yxXCNFnhqLvcfkSwgvG0RJfmqp5F+51W2x0NBJHMG8EDu0Z5ke0tkoQEgr
         05Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X9vpT9HP+T68ID/sfzmEYx652yUR/SG2I6ViTerD2lk=;
        b=aUtMRPmK7bRQ0bpN2BcAEz1NznXT7/1vLFvMOVu9gQXpCk74tpSPzOrH4pPAEjWEvV
         O/UAmDgFz8stkZIh1qSxOc03ywjcYgKisT+VukmJAJGgkUAtZ65UnbvKLGs2onCVqER1
         R0xbGNN2K0bsQAtqlMyrrslBeFXUvhMAPpgIQySDzNRlDbN2ieGbYieygium70GS1lsG
         gNPzjTp3EPpmIyBc11vsPMSHT18y+rBNdQvAT48tDWy4FsVRLnzBb+jLoQU9ofCFgiqh
         1/yshahxLvdlt32znQhjvQM2S5pUPITs4oniN3adaDknKgeDxkhF28M+5sjV4n4lP80u
         UL3Q==
X-Gm-Message-State: AOAM5325b6N19UdV6Db3QCKZ/Zg/x46iP65akvxtB1wFUyQfkksIFCvE
        /hfEMApOBgf7ZEJPYJqTfBpXoQ==
X-Google-Smtp-Source: ABdhPJwf9k+EGBXvvozvppnvJUQj0BLY6EiXuGKelYEk8M8NAqORgLzPjOHCRWqPdBibsaBj6TK2AQ==
X-Received: by 2002:a05:6e02:1a6b:: with SMTP id w11mr22572947ilv.112.1608660017131;
        Tue, 22 Dec 2020 10:00:17 -0800 (PST)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id f29sm16328385ilg.3.2020.12.22.10.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 10:00:16 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, cpratapa@codeaurora.org,
        bjorn.andersson@linaro.org, subashab@codeaurora.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net 1/3] net: ipa: clear pending interrupts before enabling
Date:   Tue, 22 Dec 2020 12:00:10 -0600
Message-Id: <20201222180012.22489-2-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201222180012.22489-1-elder@linaro.org>
References: <20201222180012.22489-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We enable the completion interrupt for channel or event ring
commands only when we issue them.  The interrupt is disabled after
the interrupt has fired, or after we have timed out waiting for it.

If we time out, the command could complete after the interrupt has
been disabled, causing a state change in the channel or event ring.
The interrupt associated with that state change would be delivered
the next time the completion interrupt is enabled.

To avoid previous command completions interfering with new commands,
clear all pending completion interrupts before re-enabling them for
a new command.

Fixes: b4175f8731f78 ("net: ipa: only enable GSI event control IRQs when needed")
Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/gsi.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ipa/gsi.c b/drivers/net/ipa/gsi.c
index c4795249719d4..4aee60d62ab09 100644
--- a/drivers/net/ipa/gsi.c
+++ b/drivers/net/ipa/gsi.c
@@ -340,7 +340,13 @@ static int evt_ring_command(struct gsi *gsi, u32 evt_ring_id,
 	 * is issued here.  Only permit *this* event ring to trigger
 	 * an interrupt, and only enable the event control IRQ type
 	 * when we expect it to occur.
+	 *
+	 * There's a small chance that a previous command completed
+	 * after the interrupt was disabled, so make sure we have no
+	 * pending interrupts before we enable them.
 	 */
+	iowrite32(~0, gsi->virt + GSI_CNTXT_SRC_EV_CH_IRQ_CLR_OFFSET);
+
 	val = BIT(evt_ring_id);
 	iowrite32(val, gsi->virt + GSI_CNTXT_SRC_EV_CH_IRQ_MSK_OFFSET);
 	gsi_irq_type_enable(gsi, GSI_EV_CTRL);
@@ -453,7 +459,13 @@ gsi_channel_command(struct gsi_channel *channel, enum gsi_ch_cmd_opcode opcode)
 	 * issued here.  So we only permit *this* channel to trigger
 	 * an interrupt and only enable the channel control IRQ type
 	 * when we expect it to occur.
+	 *
+	 * There's a small chance that a previous command completed
+	 * after the interrupt was disabled, so make sure we have no
+	 * pending interrupts before we enable them.
 	 */
+	iowrite32(~0, gsi->virt + GSI_CNTXT_SRC_CH_IRQ_CLR_OFFSET);
+
 	val = BIT(channel_id);
 	iowrite32(val, gsi->virt + GSI_CNTXT_SRC_CH_IRQ_MSK_OFFSET);
 	gsi_irq_type_enable(gsi, GSI_CH_CTRL);
-- 
2.20.1

