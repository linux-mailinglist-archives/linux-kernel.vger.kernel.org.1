Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 363562C5569
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390009AbgKZNcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390197AbgKZNcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:32:05 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CCCC0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:32:04 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id x22so2151622wmc.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=64CEfunw0Swc50bQt2+cwn7fqQh5uT3oHRs6EoyWU9E=;
        b=pOmWFkUHC7CzRoW6X95WZ7ZM6K89FTfon68au1KVLJvq43SYoT3PggrU+fCWC+BxVH
         joJHsp+kLds5GXyCIlQpDs/tY4cvnuUbK2ECYQbpUifxbJelCJPq/w//4Xq1JuObVNYb
         MdYyJpzW0GQ9FGIPPexJbsh/N208a2/aeozAj8MHCqT5TsrIMrxUGn1dgeandT/+xCSI
         l/P/bXaz6rU+bvXzM17w22rr9WJg+xhmZVixK+35pOMEDeoAAx23u7OQ3/T9w5tnSnYH
         VcC3D2I1mato16v/TV4NnMZ78yZy9TtnKHNwc6zS0O8bA1NWsBEp8kzFjxLezNmeiETj
         lx1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=64CEfunw0Swc50bQt2+cwn7fqQh5uT3oHRs6EoyWU9E=;
        b=Lq34IQZP0djcruVY1wUkhzck2cvYeJq70pfIsRU2eKA1/w0GVCVPc6kTYaAoi6ccK0
         dry4HJrwT2zh+J3V/OVLRRMd4u4B8S9FKRKZorD1c6uDP4LU4agWHEnHcxjfsrS3vqIm
         6mpYwihVwHaOSrOnaiz6P2UDLU95Hc0n6XhUPTytCqfGpO8Xmb+jPPsx9nNA6M8it/q4
         pycDa7FdjsHt2RFV7UuQfoCKj7xNjQ7WRdzhf8hc/HyfEbMENZ92LW+j3/D/kBPJoB9A
         xfUHVYblt2zB1b9K+Qk7fFV9LBqsuwYE+drxSroTB+hBe5Y15MUx4dvqxBVmND2NqIjv
         zoYQ==
X-Gm-Message-State: AOAM533VyGO0wBEM1Nh0kc6WSJG5cVPhqM8KIXZK8c2CcV7xHR6un1So
        4snHadqpUdkqiFpYw40IslYPlQ==
X-Google-Smtp-Source: ABdhPJyVRqv04VLkxlqsEA0K2I9YfA9rHfVGjOv/CXJMIAfm+/iU9Su9wEC8IGTawXz3owjyVgkMFg==
X-Received: by 2002:a1c:6382:: with SMTP id x124mr3408119wmb.46.1606397523570;
        Thu, 26 Nov 2020 05:32:03 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id n10sm8701001wrv.77.2020.11.26.05.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 05:32:02 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org, kvalo@codeaurora.org
Cc:     linux-kernel@vger.kernel.org,
        QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 06/17] ath9k: ar9003_2p2_initvals: Remove unused const variables
Date:   Thu, 26 Nov 2020 13:31:41 +0000
Message-Id: <20201126133152.3211309-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126133152.3211309-1-lee.jones@linaro.org>
References: <20201126133152.3211309-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/ath/ath9k/ar9003_2p2_initvals.h:1734:18: warning: ‘ar9300PciePhy_clkreq_disable_L1_2p2’ defined but not used [-Wunused-const-variable=]
 drivers/net/wireless/ath/ath9k/ar9003_2p2_initvals.h:1727:18: warning: ‘ar9300PciePhy_clkreq_enable_L1_2p2’ defined but not used [-Wunused-const-variable=]

Cc: QCA ath9k Development <ath9k-devel@qca.qualcomm.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../net/wireless/ath/ath9k/ar9003_2p2_initvals.h   | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ar9003_2p2_initvals.h b/drivers/net/wireless/ath/ath9k/ar9003_2p2_initvals.h
index c07866a2fdf96..16d5c0c5e2a8d 100644
--- a/drivers/net/wireless/ath/ath9k/ar9003_2p2_initvals.h
+++ b/drivers/net/wireless/ath/ath9k/ar9003_2p2_initvals.h
@@ -1724,20 +1724,6 @@ static const u32 ar9300PciePhy_pll_on_clkreq_disable_L1_2p2[][2] = {
 	{0x00004044, 0x00000000},
 };
 
-static const u32 ar9300PciePhy_clkreq_enable_L1_2p2[][2] = {
-	/* Addr      allmodes  */
-	{0x00004040, 0x0825365e},
-	{0x00004040, 0x0008003b},
-	{0x00004044, 0x00000000},
-};
-
-static const u32 ar9300PciePhy_clkreq_disable_L1_2p2[][2] = {
-	/* Addr      allmodes  */
-	{0x00004040, 0x0821365e},
-	{0x00004040, 0x0008003b},
-	{0x00004044, 0x00000000},
-};
-
 static const u32 ar9300_2p2_baseband_core_txfir_coeff_japan_2484[][2] = {
 	/* Addr      allmodes  */
 	{0x0000a398, 0x00000000},
-- 
2.25.1

