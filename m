Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E69D92A85DB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 19:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732197AbgKESOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 13:14:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732081AbgKESO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 13:14:28 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5B7C0613D4
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 10:14:28 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id x20so2204120ilj.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 10:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g6hqCj0tMKM1EuB0m76cT3vI06GLzDxohCD5yuyuwLw=;
        b=B59okf/n9Ls0Wdu8ltBD/DJnBqNEs4ppbxg7628Ru7FSm6W7rJIAcyNWWfUAODuuEg
         Z430rsxDNLTtap7BlQc0rmyJurfl+Vul23DOZp9UUtTnj8PSN2/RYXHnaRYSdI6ZMcq8
         HlSQEtjmyOv31atxwEUAD9h6/+uWzSNClBejBVqVuEXswMxFt2RH65KxlLTt8NxYTcJb
         ZVPBiCMAf3l8stOd5SlYSgUUN5nwM9YLLgrpRuMJIMZ9IM9IlhbXqPUYF6lthrZeRWTZ
         u4oQd35847Z694U7ueWV/fLn2fe1x3aZG6ND1w+e1LlzG/S8T0Qymopc+b4OpghvvtvO
         OZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g6hqCj0tMKM1EuB0m76cT3vI06GLzDxohCD5yuyuwLw=;
        b=OmWtqkXxr361dQgeUlROpl2YyCUfaqwiadVR1DtK2vDMf3ichAF/I24u7iwd3P20jV
         v4sSp+FiiSuVVQ7g0BX7Ma/DI07WvX33YtKRGn312k/bCniXXKDaZgceEQ6ex7juwOTp
         SwarrPVmf9Rx8Sm2BL51LO2472PlQsJYxAEGN7pGL+PYY/UntlpFKp4dE5GL/WonzwBw
         gpzcpWjnGb7mVneFvKx09CwV8AUo8mW9JqsJG9D7ZwAxHK4yAApTQPcD1ZBtjlUoP8EI
         TLjihQ+iHEWrg6GQm88k94A9BY9+s1xkTCMOWXOOthIRuclAx7ccgSCIYdM9g3r1dP5O
         f1+Q==
X-Gm-Message-State: AOAM530qzhRcv1tL8jvg2M2hzj8Dl/4ol/UOdCTAZQE1gPQNkmS3L9ga
        38RdaBwys3sdwzqPOA8JAGh3TA==
X-Google-Smtp-Source: ABdhPJw+4DHtJN+UzL8orcCVgBrajxtK2tnXexbFSsnNW2MR+HQCAoGRMaIKKDMeWI3EjmWZnSp4Vg==
X-Received: by 2002:a92:ac0e:: with SMTP id r14mr2991363ilh.197.1604600067550;
        Thu, 05 Nov 2020 10:14:27 -0800 (PST)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id o19sm1554136ilt.24.2020.11.05.10.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 10:14:26 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 11/13] net: ipa: explicitly disallow inter-EE interrupts
Date:   Thu,  5 Nov 2020 12:14:05 -0600
Message-Id: <20201105181407.8006-12-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201105181407.8006-1-elder@linaro.org>
References: <20201105181407.8006-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible for other execution environments (EEs, like the modem)
to request changes to local (AP) channel or event ring state.  We do
not support this feature.

In gsi_irq_setup(), explicitly zero the mask that defines which
channels are permitted to generate inter-EE channel state change
interrupts.  Do the same for the event ring mask.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/gsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ipa/gsi.c b/drivers/net/ipa/gsi.c
index aae8ea852349d..5e10e5c1713b1 100644
--- a/drivers/net/ipa/gsi.c
+++ b/drivers/net/ipa/gsi.c
@@ -259,6 +259,8 @@ static void gsi_irq_setup(struct gsi *gsi)
 	iowrite32(0, gsi->virt + GSI_CNTXT_SRC_EV_CH_IRQ_MSK_OFFSET);
 	iowrite32(0, gsi->virt + GSI_CNTXT_GLOB_IRQ_EN_OFFSET);
 	iowrite32(0, gsi->virt + GSI_CNTXT_SRC_IEOB_IRQ_MSK_OFFSET);
+	iowrite32(0, gsi->virt + GSI_INTER_EE_SRC_CH_IRQ_OFFSET);
+	iowrite32(0, gsi->virt + GSI_INTER_EE_SRC_EV_CH_IRQ_OFFSET);
 }
 
 /* Turn off all GSI interrupts when we're all done */
@@ -307,8 +309,6 @@ static void gsi_irq_enable(struct gsi *gsi)
 	iowrite32(ERROR_INT_FMASK, gsi->virt + GSI_CNTXT_GLOB_IRQ_EN_OFFSET);
 	gsi->type_enabled_bitmap |= BIT(GSI_GLOB_EE);
 
-	/* We don't use inter-EE channel or event interrupts */
-
 	/* Never enable GSI_BREAK_POINT */
 	val = GSI_CNTXT_GSI_IRQ_ALL & ~BREAK_POINT_FMASK;
 	iowrite32(val, gsi->virt + GSI_CNTXT_GSI_IRQ_EN_OFFSET);
-- 
2.20.1

