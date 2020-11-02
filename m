Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCF172A296D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728973AbgKBL2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:28:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbgKBLYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:24:31 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67115C061A47
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 03:24:31 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id 23so823722wmg.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 03:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pe1vvImQ7xpypNGQYr/8kYE+GlHAALRJwr38y3BS0kA=;
        b=rK8Q/Uw4o4vzZuZdZ4a12AEzk+lH+7EMxb54ZjsaAzO2IyN8XQEqgOTbJNrVYWL1L5
         ZkmoSKvRdZjYgs1bVoUA+X27NSr/6z87bnkv+D58Y5RuHVFmgEUlXj00C7pfl1pgphUu
         cnYgt02K8T05rU3Z5Ya7jJ3ll+owAkkvavLKgUOi3+YWOcM1uqaMqDqpIsgzt6muQBgT
         VyAAa6axy4+Z66UDH9TqnxBdULJDxxEPuAzTkOvKIh1pF6T+EbCD4tvuom+pmOwNMbJX
         gyzqGuVLLFqK87T+sivKlZ+PNxP/2Oe5kkAOWMytK/XAOLqqKvq/amZzhBjHo/v65v+d
         8j8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pe1vvImQ7xpypNGQYr/8kYE+GlHAALRJwr38y3BS0kA=;
        b=SbaE0IEDiczk1X6kQxOr418llh/WelY3OlFLPR8Pw88SAjUQmplmgfV7vDzDZe8I9i
         udO6FWHI45q+nenKww1iyJxnG7PDXTRp30UxfPIDfkoZbxhj3tgDGsOJQFDcMYiND/Tt
         dlkWDpHZmOv+PDlV+t1uPneCjlvyATBF1wZ8z39S9S3LwemWGvwnirrAZn1iWpAcqtf9
         oOe7qsMzR4ETLXrcXYwJyfBQRIDSWQHsL5Bccu9UK5o7hEPAvbkUjfPYA3j+dBlDSN84
         X90732yiSdwMGkmW3IjgWPd+UXEne1nht9P8A7NytToX3u6y/3iPSFXdE5kTUeiSWslc
         77qg==
X-Gm-Message-State: AOAM530C7hmoF0uz0Uk/Wwel99up2ldHOylVQc04s+WR2xN+HSgi4E4U
        IIUyjz6fARaJvQ7ojESlENYkmA==
X-Google-Smtp-Source: ABdhPJwA91tKEgsgkd8SoO0bfyTHukOwzFNhDYUGhZwKs8yhHtgnKh2ZKkGWfJBeLjvEurPjz+sxPw==
X-Received: by 2002:a1c:ed0b:: with SMTP id l11mr16833456wmh.46.1604316270170;
        Mon, 02 Nov 2020 03:24:30 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id m14sm21867354wro.43.2020.11.02.03.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:24:29 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 10/41] ath9k: ar9330_1p1_initvals: Remove unused const variable 'ar9331_common_tx_gain_offset1_1'
Date:   Mon,  2 Nov 2020 11:23:39 +0000
Message-Id: <20201102112410.1049272-11-lee.jones@linaro.org>
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

 drivers/net/wireless/ath/ath9k/ar9330_1p1_initvals.h:1013:18: warning: ‘ar9331_common_tx_gain_offset1_1’ defined but not used [-Wunused-const-variable=]

Cc: QCA ath9k Development <ath9k-devel@qca.qualcomm.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/ath/ath9k/ar9330_1p1_initvals.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ar9330_1p1_initvals.h b/drivers/net/wireless/ath/ath9k/ar9330_1p1_initvals.h
index 29479afbc4f10..3e783fc13553b 100644
--- a/drivers/net/wireless/ath/ath9k/ar9330_1p1_initvals.h
+++ b/drivers/net/wireless/ath/ath9k/ar9330_1p1_initvals.h
@@ -1010,11 +1010,4 @@ static const u32 ar9331_common_rx_gain_1p1[][2] = {
 	{0x0000a1fc, 0x00000296},
 };
 
-static const u32 ar9331_common_tx_gain_offset1_1[][1] = {
-	{0x00000000},
-	{0x00000003},
-	{0x00000000},
-	{0x00000000},
-};
-
 #endif /* INITVALS_9330_1P1_H */
-- 
2.25.1

