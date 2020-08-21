Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24FA724CEDE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 09:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgHUHTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 03:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728240AbgHUHS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 03:18:28 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96202C0612F6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 00:17:25 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id c15so981815wrs.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 00:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ikJrPqLtaYXNecWR7DLDG7Iz5IzAnzmdF64bzAd6wno=;
        b=Uy9ndG1aCoadDrvykF3vodVZv3Ha9iFVjXPsA3i8oYjvo0l8Gq7q0QToEG4+lZNVYx
         RUCevn4X3h3KJEjQ4YdlV4Jn+Zoqq1uICmH/b3JBH7BxsNWidjVJZaNvUB0p6Tkes5uq
         SW9vkChKipu+8P2b1jWgiTAPvXpPywelv9eetzolSy8okZup6sQT6JqndoAhR5SFnLsE
         skm5LX8p6nnSvPbte4PiGc2OtJgEppTZlAUVIldNxnxhmeIlH/oJXaUT39maHiqdtVB0
         z88cjcengpbyYlt3NnV12Xiz68I7iUmdsBqHQli9ehfRc+t2UHAUOx+LQ9BFsDG4jDd+
         JfGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ikJrPqLtaYXNecWR7DLDG7Iz5IzAnzmdF64bzAd6wno=;
        b=bPRvk3IkyPTGmLZncqLGDeBMmEcTx/i4owxKurPvkfghnAGAq5IEtN2MDqht/UcSMk
         /obF75N+GoypWQ5vOgo6BEgovou/H6H3wGlylQ81KAWOEPwiNZGzB+FHfP1890VbzkQM
         5TmvsvawCjtJFGuSWXFFhpXNGSaigv8fDywF9b/OSFQLKjzd0mrj2Rb5HZnZ2fqAUgQs
         sLzisMaX7bjTsIcWIUqK9pV1S1Y40YY4pmkQzUQ4AaqmxvI5ubG9xI/t8NLSZi8MT/Ny
         l8WplRBwUbP4EPahuLSKV+vHVHrvrVMTno8g1mOTmKINSmAEtob1sGKnTaQ69tNYqstK
         PO3w==
X-Gm-Message-State: AOAM5319Tfg89mJZb1MKbMQqwwOKtG93EW544GdAn0djlVdSJUma+4Q5
        zJbo1rYEnwXzW0LSSy3RqgF0ZA==
X-Google-Smtp-Source: ABdhPJzk/E+GxnhTpj4IxYEkR/RBbYesDLOTF2cF6bkxcCYQCm8TFkuxP3b/YnXUju6Mh+c+JMO2Vw==
X-Received: by 2002:adf:9ec5:: with SMTP id b5mr1336455wrf.190.1597994244313;
        Fri, 21 Aug 2020 00:17:24 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id y24sm2667957wmi.17.2020.08.21.00.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 00:17:23 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        zhengbin <zhengbin13@huawei.com>
Subject: [PATCH 29/32] wireless: realtek: rtl8192c: phy_common: Remove unused variable 'bbvalue'
Date:   Fri, 21 Aug 2020 08:16:41 +0100
Message-Id: <20200821071644.109970-30-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821071644.109970-1-lee.jones@linaro.org>
References: <20200821071644.109970-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/realtek/rtlwifi/rtl8192c/phy_common.c: In function ‘_rtl92c_phy_iq_calibrate’:
 drivers/net/wireless/realtek/rtlwifi/rtl8192c/phy_common.c:1223:6: warning: variable ‘bbvalue’ set but not used [-Wunused-but-set-variable]

Cc: Ping-Ke Shih <pkshih@realtek.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: zhengbin <zhengbin13@huawei.com>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8192c/phy_common.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192c/phy_common.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192c/phy_common.c
index 661249d618c09..70706d51805da 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192c/phy_common.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192c/phy_common.c
@@ -1220,10 +1220,9 @@ static void _rtl92c_phy_iq_calibrate(struct ieee80211_hw *hw,
 		0x522, 0x550, 0x551, 0x040
 	};
 	const u32 retrycount = 2;
-	u32 bbvalue;
 
 	if (t == 0) {
-		bbvalue = rtl_get_bbreg(hw, 0x800, MASKDWORD);
+		rtl_get_bbreg(hw, 0x800, MASKDWORD);
 
 		_rtl92c_phy_save_adda_registers(hw, adda_reg,
 						rtlphy->adda_backup, 16);
-- 
2.25.1

