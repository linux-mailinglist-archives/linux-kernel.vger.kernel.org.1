Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4D122A91D3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 09:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgKFIxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 03:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbgKFIxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 03:53:41 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BB8C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 00:53:41 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id g11so347998pll.13
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 00:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=l1x+a2lkf5H6ss47Uc8nyc/YqwfbgarzABY3+gsf9Nk=;
        b=Np9buJpIrAg4wi7jeFtvA3asjWaCJ2oxk2YD9p6l05EQMaryzbhVs/aALn7LHF2tqr
         iOdMLWYYKdA4dS2eMhkeMz9x72Ci6lG0BnCEBH0JBMUl81Qy21BzpVSa3aPVHKD/rfB2
         G+5XojyA7YopUuBKBIjVz7WvksrkZSeWeQqD9z4j2rZK2PYRli4d+/uVG2gZR4JcttCR
         0EI+Zi8SEl3W6911w0E5zO3kxmYyAKxuezIFowDElFlUhvgtezJjFv2oxh8hnFmIbcKB
         QRBnYodrz9bbiRLZzLP5zFqJ5UlfI2OZCleT6SB/bVCio1n1Ijwi5TxoUmj6MEbt5g5C
         MvoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=l1x+a2lkf5H6ss47Uc8nyc/YqwfbgarzABY3+gsf9Nk=;
        b=aECoanE/YKUaWXpPPLdbrXGqp5RZgrstELI1nxo4YeOno+kI2lUqoRCizTupdPDuYj
         vH9iTd7xaER0BT+rJvceMhEb2pcgAPR8/7jiVBN14yCZ8SuofZrLni/DH3W+R1pw+abB
         0CAfnM0uId+/Fpe2zXe4wnK8Elybg1h/0GUMgkUGhOqDU7qCc5BtTMvVaOlWcxnfBsOV
         kkpAljIMB8iJPjxptCvtCn8TS4sgg1VC64DmgubuPOCewpsNR8ba0I4a3GViBptNrLMC
         8wyXI0rjRw0PB6OaeGnQF1MHq0at4VZCoPwIQfbGAC26HKG3z/8ySD818XZy2s/bkLwe
         5Ejg==
X-Gm-Message-State: AOAM530RrzxBnLGUt76Srvb5EjjZygBEDEV1xZVcjfNnQ60UDK8bLTjV
        g9udtzNQNuOxPGdhR7A6FQ==
X-Google-Smtp-Source: ABdhPJxNccQ9nJdu+zGhF30T3iznycFzYtzzNeCdQg0H/9tIUpsdFiS1oIoY/dZVPzFBi7p2leDptQ==
X-Received: by 2002:a17:902:ff06:b029:d6:9554:dd68 with SMTP id f6-20020a170902ff06b02900d69554dd68mr881778plj.19.1604652820977;
        Fri, 06 Nov 2020 00:53:40 -0800 (PST)
Received: from he-cluster.localdomain (67.216.221.250.16clouds.com. [67.216.221.250])
        by smtp.gmail.com with ESMTPSA id 5sm1239939pfx.63.2020.11.06.00.53.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Nov 2020 00:53:40 -0800 (PST)
From:   xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To:     broonie@kernel.org, srinivas.kandagatla@linaro.org
Cc:     linux-kernel@vger.kernel.org, Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH] ASoC: wcd9335: Remove unnecessary conversion to bool
Date:   Fri,  6 Nov 2020 16:53:36 +0800
Message-Id: <1604652816-1330-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kaixu Xia <kaixuxia@tencent.com>

The '>=' expression itself is bool, no need to convert it to bool.
Fix the following coccicheck warning:

./sound/soc/codecs/wcd9335.c:3982:25-30: WARNING: conversion to bool not needed here

Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 sound/soc/codecs/wcd9335.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index f2d9d52ee171..843c311ea79e 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -3979,7 +3979,7 @@ static irqreturn_t wcd9335_slimbus_irq(int irq, void *data)
 	}
 
 	for_each_set_bit(j, &status, 32) {
-		tx = (j >= 16 ? true : false);
+		tx = (j >= 16);
 		port_id = (tx ? j - 16 : j);
 		regmap_read(wcd->if_regmap,
 				WCD9335_SLIM_PGD_PORT_INT_RX_SOURCE0 + j, &val);
-- 
2.20.0

