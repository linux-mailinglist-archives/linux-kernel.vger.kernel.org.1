Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811832676F1
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 02:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725931AbgILAsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 20:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbgILApu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 20:45:50 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566FBC061757
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 17:45:42 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id x2so10638488ilm.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 17:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C+4RJZne7XWnSNpMScCQkiPgvon7cqSHe4LlitFTkv0=;
        b=Utdyhr0awvpZ4vaNinnSkBVq+NxEV2KtEH8XKorI6SzfWRyFbXDyDDnoOJ0MfOHAC/
         GvRo63Wh/VPA6AYsaxhy+JtpeNDOeBESCr7mfAlEs1gr6nbzXIGIJR/r7Ayo32uX4VV/
         1q8xePfX+/LksdK3TxwbgCgzC4KPQTZqLp5JTUWL11RJEUYO+Tx6Rl3XRyFRvjQyrciE
         ulRBtTTThTvnpmLRGBsnWQbIDEKofGKj6KB4G1sSpK13UiwnT5EtStawGLs4kO1UUe1F
         xrgiOva3GHk5u/RZ/vHcrJcpl8ePYWP9jPpRJz22RpCNpIMK7XcCaIxl27bCWIYbxp0V
         IiPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C+4RJZne7XWnSNpMScCQkiPgvon7cqSHe4LlitFTkv0=;
        b=gJ8VcUg7mFaTIszMna5Hvgws2+JR3VmOptsvkwSr3MFtqzk9oTy3MSD4+ntUAujsFp
         aSGG+7Z+foy9vS/Zj5p6kIBuhI9m/BDiBwkP9wjFt7yOKGe15uxX+0JvGC/GO+NiWwsu
         Qapufv0rSqRc0yuMyF0U3ympwlLeePOHd+RwddPAFBfkkfLiDkUMkhdoh0GGyy/EQJsG
         DtUrSTWawA6jKPXreCSVGQ0mgMpxJ+UJpMMn6Yb4T/U3tByaUQ0oN7si/L2jblYlRjTj
         n+dcyPI/cUruoVTZ/20J2pjVlEiHdyCoEMWQwY+9NvG7eGJ4/e+wrkQX24iazFXd80gf
         BsDw==
X-Gm-Message-State: AOAM533tWl1L4kGrHf1l4+j9CO8BEpZ+7+0u5LQ3j41zdjlwcAXIGKRa
        QL8YOtxVDyEYywxe4RzqjxEqOg==
X-Google-Smtp-Source: ABdhPJx7u7VsZZkYAyharEZdiuhnNIROw9VrczecEse5SU4TNweAuMVs6kcORUmh98/s0tpHduI0RA==
X-Received: by 2002:a92:9ac7:: with SMTP id c68mr3815204ill.221.1599871541685;
        Fri, 11 Sep 2020 17:45:41 -0700 (PDT)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id z4sm2107807ilh.45.2020.09.11.17.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 17:45:41 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 6/7] net: ipa: enable wakeup on IPA interrupt
Date:   Fri, 11 Sep 2020 19:45:31 -0500
Message-Id: <20200912004532.1386-7-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200912004532.1386-1-elder@linaro.org>
References: <20200912004532.1386-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we handle wakeup interrupts properly, arrange for the IPA
interrupt to be treated as a wakeup interrupt.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_interrupt.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/ipa/ipa_interrupt.c b/drivers/net/ipa/ipa_interrupt.c
index 90353987c45fc..cc1ea28f7bc2e 100644
--- a/drivers/net/ipa/ipa_interrupt.c
+++ b/drivers/net/ipa/ipa_interrupt.c
@@ -237,8 +237,16 @@ struct ipa_interrupt *ipa_interrupt_setup(struct ipa *ipa)
 		goto err_kfree;
 	}
 
+	ret = enable_irq_wake(irq);
+	if (ret) {
+		dev_err(dev, "error %d enabling wakeup for \"ipa\" IRQ\n", ret);
+		goto err_free_irq;
+	}
+
 	return interrupt;
 
+err_free_irq:
+	free_irq(interrupt->irq, interrupt);
 err_kfree:
 	kfree(interrupt);
 
@@ -248,6 +256,12 @@ struct ipa_interrupt *ipa_interrupt_setup(struct ipa *ipa)
 /* Tear down the IPA interrupt framework */
 void ipa_interrupt_teardown(struct ipa_interrupt *interrupt)
 {
+	struct device *dev = &interrupt->ipa->pdev->dev;
+	int ret;
+
+	ret = disable_irq_wake(interrupt->irq);
+	if (ret)
+		dev_err(dev, "error %d disabling \"ipa\" IRQ wakeup\n", ret);
 	free_irq(interrupt->irq, interrupt);
 	kfree(interrupt);
 }
-- 
2.20.1

