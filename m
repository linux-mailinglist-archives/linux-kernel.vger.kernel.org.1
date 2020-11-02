Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8142A2931
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728858AbgKBL0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:26:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728859AbgKBLZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:25:02 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A07AC061A47
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 03:25:02 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id e2so9133078wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 03:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xeSA2mlsN3ZwFX+jKncibbMs9rhzwDQUIegRTfjnveQ=;
        b=VVEaf7Y3SMh5enKI6sSPYS8qBdEmniXBDjhnPr0ooccJuHZYNLZ4XYsVQ29Lz1HWbr
         mD1A9erhbVayOVS8PFa4vfgnc1g/odoQ/HQfHaCLJfCSwt9uAt+5EaCuw3vHkPQZwGUY
         PPq6PHFZl3sCfe1oy5Zxm0pdXlUgtk7AHmepYV14X/JQjha4+sHEi9AdQzeDlrGFyrls
         C5dFcfwXqcHy6fNTYb5iKGcpez5621C10J1ZTHasWWEvWpxP1XSOoL+WaMcNptm8IHkb
         fpn0n0ewRvXQaEaF/RSbC9bLWYM3+2umG2T54UHfFFGM4naI4aUtfk1KXQhB1Si8Zu/Q
         /PBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xeSA2mlsN3ZwFX+jKncibbMs9rhzwDQUIegRTfjnveQ=;
        b=NpLVXwvEay5RDr0YmS5141sbxZQum/2OZQl9C4OH7/cQMzCht+8XdOaYIw8eujRedy
         BTRNcIpxiDrbtwB8sJGAXIsUwTYtnBMgkZyMvvEARPhubLA2B/9et6kRgK8CPpNnexkd
         LrQeGBqs8UAzRk+zSIWEd1S+DwVmoGV1IAcBxytkM8sgSOtEUxDXOLqghmcJuj0OV3qj
         sHxY6Ou6jrTNxt1WG66gk7eQ4AebEKLdgbV2zvrR2Wt9XjtZO5lw1NytASsNjnZuCByA
         K6IeV0v9y+9DLHm9JGZu0tUcqU1WnBWRK/1PvppiKzK83810SOIdzPbZz+IM6hh+DnWv
         gydA==
X-Gm-Message-State: AOAM531QKALJMS36FEqnxyezGhAIVN1nNJXQ2anYyzcR+brfnBRPxTly
        sNJFJsV9mpZo67nvZSrsMLvCYg==
X-Google-Smtp-Source: ABdhPJzpCZVoorPU3KqL0JE9wAQ9ZCiP3HJw+gpSeWPJvYEzWJc+/8YbC6/BBQkv8KBFvI1nGt8VgQ==
X-Received: by 2002:a7b:c109:: with SMTP id w9mr11271120wmi.34.1604316301079;
        Mon, 02 Nov 2020 03:25:01 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id m14sm21867354wro.43.2020.11.02.03.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:25:00 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 32/41] rtl8723be: trx: Remove set but unused variable 'cck_highpwr'
Date:   Mon,  2 Nov 2020 11:24:01 +0000
Message-Id: <20201102112410.1049272-33-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102112410.1049272-1-lee.jones@linaro.org>
References: <20201102112410.1049272-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/realtek/rtlwifi/rtl8723be/trx.c: In function ‘_rtl8723be_query_rxphystatus’:
 drivers/net/wireless/realtek/rtlwifi/rtl8723be/trx.c:53:6: warning: variable ‘cck_highpwr’ set but not used [-Wunused-but-set-variable]

Cc: Ping-Ke Shih <pkshih@realtek.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8723be/trx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/trx.c
index 559ab78687c37..5a7cd270575a2 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/trx.c
@@ -50,7 +50,6 @@ static void _rtl8723be_query_rxphystatus(struct ieee80211_hw *hw,
 	pstatus->rx_mimo_signalquality[1] = -1;
 
 	if (is_cck) {
-		u8 cck_highpwr;
 		u8 cck_agc_rpt;
 
 		cck_agc_rpt = p_phystrpt->cck_agc_rpt_ofdm_cfosho_a;
@@ -59,8 +58,7 @@ static void _rtl8723be_query_rxphystatus(struct ieee80211_hw *hw,
 		/* (2)PWDB, Average PWDB cacluated by
 		 * hardware (for rate adaptive)
 		 */
-		cck_highpwr = (u8)rtl_get_bbreg(hw, RFPGA0_XA_HSSIPARAMETER2,
-						 BIT(9));
+		rtl_get_bbreg(hw, RFPGA0_XA_HSSIPARAMETER2, BIT(9));
 
 		lan_idx = ((cck_agc_rpt & 0xE0) >> 5);
 		vga_idx = (cck_agc_rpt & 0x1f);
-- 
2.25.1

