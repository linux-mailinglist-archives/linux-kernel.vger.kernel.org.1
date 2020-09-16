Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F263826CD83
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 23:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbgIPVAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 17:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbgIPQaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 12:30:24 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1268C0086D5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 06:43:38 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z1so7005055wrt.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 06:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=XQmdopnzWqOmDvS+g/Rq3jbhOZjrWPWcomCMlsaruYc=;
        b=rBqjeM5vLBuqFUcAWJFNyLu+JxvrwxrSVutGz4fWN454xdDybsqEEnl0GsdWC125i7
         RJuOZv+3/4M5CeZGjT8fND/QY9UzV53RDlBYKfWDI1GVoBVdR4c4IoD5fvjGujo27ScE
         YfiXrxLUY1v9VREGC1kQYazdyHzpQWsqgXzCHOvsg3PdPYZsh9Jpdcx2D0GubAhfOVRJ
         Xa1WM90/7w9QqxWhYlt8kgwJJQz7r+X9hE2X+LsJeIIYwjRjO0RPfqrkrRWpxzmvh79E
         /pJQ8x9ZCqF7tiyu5NQ/f5FXdAFRsMv5TUlGiZdydup7qQTOQx3sor0Ols2smwzuM6WT
         qFVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XQmdopnzWqOmDvS+g/Rq3jbhOZjrWPWcomCMlsaruYc=;
        b=U/JCShL8gjtBbXnFZjSxlG3tWSQ/1SBdnmmCD8MFuapf5xHAedrmYlBEEeWxnFvAlN
         Un+PSPNzn8Q5EUma5QEJf1dYqqBUa0m2hnrWIEYKekVANqq6e1H2Jko1A5nsZujExDZs
         7bzKu8OXbk8RisEPzdVG0UKDRS29iqkvJcOaRw8qnejAGBPD2U305yjPoEhzFJNUJ6Q2
         FOjtVNfnjBRJCzRwZqRjYuX3pheAWulxYJHa/qSH1fNQmDeSk5PgZT6eeFT7u30LYyyC
         imC465NqLy242PSdRml5P6WO++SRlXDjRe9O9pwJz35dN9BfFa/UePmp9YtPhSZopdEm
         RDbg==
X-Gm-Message-State: AOAM531VDbrzk1/F9mMu8ciNSewJjK9Hkdp2Y/xV/t25nklH3c1CVEqi
        LV08vYPDaRGNs7dnYxopXii7FJBjPeU=
X-Google-Smtp-Source: ABdhPJy2pgDiuyKeQNxUByIwc9IcmutI7Odry9dHKd4Hbc4BeInDhUuG17aQE/Y0GPInY1dbtGtyJw==
X-Received: by 2002:a5d:56c1:: with SMTP id m1mr25805287wrw.87.1600263816197;
        Wed, 16 Sep 2020 06:43:36 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id w81sm5658664wmg.47.2020.09.16.06.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 06:43:34 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai
Subject: [PATCH 1/3] habanalabs/gaudi: remove axi drain support
Date:   Wed, 16 Sep 2020 16:43:31 +0300
Message-Id: <20200916134333.4029-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AXI drain is broken in GAUDI so remove support for enabling it.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 6f7f6ad7a358..2c10e3f92c86 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -2885,22 +2885,6 @@ static void gaudi_pre_hw_init(struct hl_device *hdev)
 	 */
 	RREG32(mmPCIE_WRAP_LBW_PROT_OVR);
 
-	if (hdev->axi_drain) {
-		WREG32(mmPCIE_WRAP_LBW_DRAIN_CFG,
-			1 << PCIE_WRAP_LBW_DRAIN_CFG_EN_SHIFT);
-		WREG32(mmPCIE_WRAP_HBW_DRAIN_CFG,
-			1 << PCIE_WRAP_HBW_DRAIN_CFG_EN_SHIFT);
-
-		/* Perform read to flush the DRAIN cfg */
-		RREG32(mmPCIE_WRAP_HBW_DRAIN_CFG);
-	} else {
-		WREG32(mmPCIE_WRAP_LBW_DRAIN_CFG, 0);
-		WREG32(mmPCIE_WRAP_HBW_DRAIN_CFG, 0);
-
-		/* Perform read to flush the DRAIN cfg */
-		RREG32(mmPCIE_WRAP_HBW_DRAIN_CFG);
-	}
-
 	/* Configure the reset registers. Must be done as early as possible
 	 * in case we fail during H/W initialization
 	 */
-- 
2.17.1

