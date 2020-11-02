Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEE42A2966
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbgKBL2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728589AbgKBLYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:24:34 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174F3C061A04
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 03:24:34 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id k18so9122328wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 03:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+vFZOkUefLCl7nJCk+wo/i30e9zgv5BRI5+nbv5AY5Q=;
        b=jh5M4/eVkL4qUXbzxyTDfVQbSctGAJkOuYcE2+B69a5GkdvTs1K/HpCUkRdyBQQkIN
         vik380RxIRZmkFMgTB9Y8AfMjcwazWDchA8iwOoHE4OBSX8azjptqBqCAWkJSqi/Ij2T
         Dck/xj8IaAqgsU4DLaLdnHt5YI0vPH/zLCi7rXUupCmFMxBXOejLKW7HpvcJB3qGcgre
         c4jUmXLXPxQcUfnKlVFkbA/g+f+SPDWPQmqWznuF9qQvrQii8fJXhQmimK7oRctT7tZ0
         WerbmbfLA98TU7Fe44RvE47paZu0zZW8tIlEr+hF3sMSOQeXKmFJDmqRjV8ecoiDpkbP
         7csw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+vFZOkUefLCl7nJCk+wo/i30e9zgv5BRI5+nbv5AY5Q=;
        b=Fq3ZwGDNHz+UZJPViroNCYfXUCy1Si7cTpMlabDKvLaoN1D4UqOn6vaNQL9x3hqNxC
         plho4R4QKKPq1GsjkPh2ibttsjQtBpHig39zKQstlpIb/QFpqCzUiUwioUSpQrD5h5fD
         YB3IsSKtiguK3VVI5z4N8V+Za0E4Azl7AASEU3be9jpi0BZ2+9TV3wDojgElumOZST/f
         Qek1od7Y4wjVmhB0Ot//Q+X5lolvbgrv1O8igAEH1sl4Xf0fSZ0IWNRNk0exyF9NZkI8
         062sK2GqE6zFvJ+7mNA4doyfNJkxz7X5MIgbi/2aCLZdcbhShaKA7+lSvLfp/GjEQ3su
         Rfmg==
X-Gm-Message-State: AOAM533PLewvW8X7EneROoawq1DrvHO/cWTgRaDvH+wkIcC2GAar1q3v
        LmiQW5mHhTEQKhFwpJUCq/EbyA==
X-Google-Smtp-Source: ABdhPJx/Zgc5zu+e3N+wNyiQIKULo2j/4dmJenySyFa1r6AZ8uQt0LT6U7AB+dcQHweAypbHejYZVA==
X-Received: by 2002:a05:600c:2252:: with SMTP id a18mr15787022wmm.139.1604316272797;
        Mon, 02 Nov 2020 03:24:32 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id m14sm21867354wro.43.2020.11.02.03.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:24:32 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 12/41] ath9k: ar9485_initvals: Remove unused const variable 'ar9485_fast_clock_1_1_baseband_postamble'
Date:   Mon,  2 Nov 2020 11:23:41 +0000
Message-Id: <20201102112410.1049272-13-lee.jones@linaro.org>
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

 drivers/net/wireless/ath/ath9k/ar9485_initvals.h:1009:18: warning: ‘ar9485_fast_clock_1_1_baseband_postamble’ defined but not used [-Wunused-const-variable=]

Cc: QCA ath9k Development <ath9k-devel@qca.qualcomm.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/ath/ath9k/ar9485_initvals.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ar9485_initvals.h b/drivers/net/wireless/ath/ath9k/ar9485_initvals.h
index bdf6f107f6f1e..4afe52c0456e9 100644
--- a/drivers/net/wireless/ath/ath9k/ar9485_initvals.h
+++ b/drivers/net/wireless/ath/ath9k/ar9485_initvals.h
@@ -1006,13 +1006,6 @@ static const u32 ar9485_1_1_soc_preamble[][2] = {
 	{0x00007048, 0x00000002},
 };
 
-static const u32 ar9485_fast_clock_1_1_baseband_postamble[][3] = {
-	/* Addr      5G_HT20     5G_HT40   */
-	{0x00009e00, 0x03721821, 0x03721821},
-	{0x0000a230, 0x0000400b, 0x00004016},
-	{0x0000a254, 0x00000898, 0x00001130},
-};
-
 static const u32 ar9485_1_1_baseband_postamble[][5] = {
 	/* Addr      5G_HT20     5G_HT40     2G_HT40     2G_HT20   */
 	{0x00009810, 0xd00a8005, 0xd00a8005, 0xd00a8005, 0xd00a8005},
-- 
2.25.1

