Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61BB02A85DC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 19:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732142AbgKESOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 13:14:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732120AbgKESOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 13:14:32 -0500
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3C7C0613D3
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 10:14:30 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id n5so2204818ile.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 10:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jRU6mSA95Wi4BgV4jo9lJENZ2GCicC+Qoh9Kf0nhgUE=;
        b=F1Nw6rWleEbmLCPQgismR6x3DbV236gCg56XMJDyq7qY6d3ER9hMgF6XZIMrpHRaYJ
         GjIXinYiFSZMwzm9P1m80ZLQUTz1lFNZxLML0s/wCNHFtVoCJbIEhjnOMK0jBgdbPLn7
         a1oge6JIai4T1VZEzytSyK0sMh/04U422ulNYikvWil7S7t8KoXgcXl32bX5KLQAKnPO
         UWk81UC7vA8Gjq1MUojvyx/7LofTDbNjJ0roBK5jCRNuxZLTKx704dxrb29d8hYg3rFG
         RaepwQZL+iRdMYm9RLqOhd0kvDl/h61Fb6FSJ3II5aKlyLd5LrxsadLwdzZqNW200Z83
         aKng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jRU6mSA95Wi4BgV4jo9lJENZ2GCicC+Qoh9Kf0nhgUE=;
        b=Clu8ifU43JfAj2EzgalAjK1SNQHx3bpaVVuwIxKhC00TMYrzmTtkqa+qGncroGdbD3
         ZT6nfM1OOLi3d8kovBpkiHDXIcuDFw6T3XCXvjTJJ1XCt5MOstBBojbGA/iYtgu6Fq8Q
         5pcdTimBQLbD1t2ANcnrVjoygw7SqA/I9FyE4KSGRyiDkPx+lmCFz7GHkBlNALr7jJJq
         9x1K1w+UbXaRgAvb1Ikot23PyR0GxQWFZyd0KSPsyUXtvoBCRxTCmocWtLZq6Ib/wMfP
         rgKaMlGIiI+oZlF9kfAFwCN3KQAFe3GyFlPdSH0Txm1W8Z7EMaOnX5Hx6OeJNSBoiYu0
         JY9Q==
X-Gm-Message-State: AOAM531QelOatfSFpT9QD1V5JrQkundAKPsXCkCU7ikNMILuiP1QeP6N
        P5BhOFnRE84bO1U5wSdDElpR7A==
X-Google-Smtp-Source: ABdhPJytwmho44Ka43B4ocUMLuSrombb/bwsrflOa26EHaUKM5Qld6ag+SgUHKoHeaO9jqXtHJbW6A==
X-Received: by 2002:a92:5f1a:: with SMTP id t26mr3020390ilb.0.1604600070276;
        Thu, 05 Nov 2020 10:14:30 -0800 (PST)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id o19sm1554136ilt.24.2020.11.05.10.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 10:14:29 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 13/13] net: ipa: pass a value to gsi_irq_type_update()
Date:   Thu,  5 Nov 2020 12:14:07 -0600
Message-Id: <20201105181407.8006-14-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201105181407.8006-1-elder@linaro.org>
References: <20201105181407.8006-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all of the GSI interrupts are handled uniformly,
change gsi_irq_type_update() so it takes a value.  Have the
function assign that value to the cached mask of enabled GSI
IRQ types before writing it to hardware.

Note that gsi_irq_teardown() will only be called after
gsi_irq_disable(), so it's not necessary for the former
to disable all IRQ types.  Get rid of that.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/gsi.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ipa/gsi.c b/drivers/net/ipa/gsi.c
index aa3983649bc30..961a11d4fb270 100644
--- a/drivers/net/ipa/gsi.c
+++ b/drivers/net/ipa/gsi.c
@@ -231,30 +231,29 @@ static u32 gsi_channel_id(struct gsi_channel *channel)
 }
 
 /* Update the GSI IRQ type register with the cached value */
-static void gsi_irq_type_update(struct gsi *gsi)
+static void gsi_irq_type_update(struct gsi *gsi, u32 val)
 {
-	iowrite32(gsi->type_enabled_bitmap,
-		  gsi->virt + GSI_CNTXT_TYPE_IRQ_MSK_OFFSET);
+	gsi->type_enabled_bitmap = val;
+	iowrite32(val, gsi->virt + GSI_CNTXT_TYPE_IRQ_MSK_OFFSET);
 }
 
 static void gsi_irq_type_enable(struct gsi *gsi, enum gsi_irq_type_id type_id)
 {
-	gsi->type_enabled_bitmap |= BIT(type_id);
-	gsi_irq_type_update(gsi);
+	gsi_irq_type_update(gsi, gsi->type_enabled_bitmap | BIT(type_id));
 }
 
 static void gsi_irq_type_disable(struct gsi *gsi, enum gsi_irq_type_id type_id)
 {
-	gsi->type_enabled_bitmap &= ~BIT(type_id);
-	gsi_irq_type_update(gsi);
+	gsi_irq_type_update(gsi, gsi->type_enabled_bitmap & ~BIT(type_id));
 }
 
 /* Turn off all GSI interrupts initially */
 static void gsi_irq_setup(struct gsi *gsi)
 {
-	gsi->type_enabled_bitmap = 0;
-	gsi_irq_type_update(gsi);
+	/* Disable all interrupt types */
+	gsi_irq_type_update(gsi, 0);
 
+	/* Clear all type-specific interrupt masks */
 	iowrite32(0, gsi->virt + GSI_CNTXT_SRC_CH_IRQ_MSK_OFFSET);
 	iowrite32(0, gsi->virt + GSI_CNTXT_SRC_EV_CH_IRQ_MSK_OFFSET);
 	iowrite32(0, gsi->virt + GSI_CNTXT_GLOB_IRQ_EN_OFFSET);
@@ -267,8 +266,7 @@ static void gsi_irq_setup(struct gsi *gsi)
 /* Turn off all GSI interrupts when we're all done */
 static void gsi_irq_teardown(struct gsi *gsi)
 {
-	gsi->type_enabled_bitmap = 0;
-	gsi_irq_type_update(gsi);
+	/* Nothing to do */
 }
 
 static void gsi_irq_ieob_enable(struct gsi *gsi, u32 evt_ring_id)
@@ -308,7 +306,7 @@ static void gsi_irq_enable(struct gsi *gsi)
 	 * that so we can at least report the error should it occur.
 	 */
 	iowrite32(ERROR_INT_FMASK, gsi->virt + GSI_CNTXT_GLOB_IRQ_EN_OFFSET);
-	gsi->type_enabled_bitmap |= BIT(GSI_GLOB_EE);
+	gsi_irq_type_update(gsi, gsi->type_enabled_bitmap | BIT(GSI_GLOB_EE));
 
 	/* General GSI interrupts are reported to all EEs; if they occur
 	 * they are unrecoverable (without reset).  A breakpoint interrupt
@@ -319,18 +317,15 @@ static void gsi_irq_enable(struct gsi *gsi)
 	val |= CMD_FIFO_OVRFLOW_FMASK;
 	val |= MCS_STACK_OVRFLOW_FMASK;
 	iowrite32(val, gsi->virt + GSI_CNTXT_GSI_IRQ_EN_OFFSET);
-	gsi->type_enabled_bitmap |= BIT(GSI_GENERAL);
-
-	/* Finally update the interrupt types we want enabled */
-	gsi_irq_type_update(gsi);
+	gsi_irq_type_update(gsi, gsi->type_enabled_bitmap | BIT(GSI_GENERAL));
 }
 
 /* Disable all GSI interrupt types */
 static void gsi_irq_disable(struct gsi *gsi)
 {
-	gsi->type_enabled_bitmap = 0;
-	gsi_irq_type_update(gsi);
+	gsi_irq_type_update(gsi, 0);
 
+	/* Clear the type-specific interrupt masks set by gsi_irq_enable() */
 	iowrite32(0, gsi->virt + GSI_CNTXT_GSI_IRQ_EN_OFFSET);
 	iowrite32(0, gsi->virt + GSI_CNTXT_GLOB_IRQ_EN_OFFSET);
 }
-- 
2.20.1

