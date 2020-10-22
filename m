Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D825295F62
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 15:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899347AbgJVNIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 09:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2507469AbgJVNIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 09:08:14 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681DDC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 06:08:12 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id t25so2162718ejd.13
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 06:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YnVSHPtkEDV80qgIOohyTUBh5oj/YizZewvliA8voeQ=;
        b=ElU6qfg6v/wFR7SXZ6Er6eboZ3A5bx8GD5X9SAdsxJiJCfWp23+eyZMYpIedG3cN8r
         x5sktzejMQgBoVHggchF2yC1AWyxMCSOwP1paYXrqVRyfuaHcH2V3ZBMODUFHdbuXawD
         aQxNQQjlOeQtDUzS37KrK9YOA739hNydhJFmso8JoNXCkA+6Pm3ywynD0dO8VKEUjnnt
         R7CfzStF0bnPCD9SMpXZT7ON0pnhxNz6er8DHAopQPh8/9ZBTfeEP7QAYyOPHUDFHO9Z
         XqVfIdqYr0212gA5TOFUWjVPVyC59W7y0civxWmB00tGD/+HoiwzmRhBM08mQ7Mu+Dmj
         eeJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YnVSHPtkEDV80qgIOohyTUBh5oj/YizZewvliA8voeQ=;
        b=ugJOT84qVNZjPVJ/lfocpRCTBQcvVMrcBNu2w0aPSREP3ZtzhLG8DMzN9nDKdi8oIT
         nmx3H8bBV2rns4NuIJB2lMaTFZfzNPIOV/yAIwujDuqtwCtsacheOMOWHsOWyEjhs1Tc
         TWDO1FJvgd7SEHMWVr0kN2Q+BkyBHXCj1cbJUAaRkL4nitkpEaqmHpO0tQNmnH3Ble8p
         wdsZ1PWuqbmy6Sb3o/4/MIbbEns2OZCYp2k2JIhJOBPHNPlvHT0wDZO33mdZjYDbNFgY
         DrepdZBBik+eU1aahqM9JADZY2ilP/5707mRFtlx0Ea0+STj3PAd6VNWNF0YtOyiki62
         2ptw==
X-Gm-Message-State: AOAM530IAFX/bhk2+wkgdxfNo2/0IAHkAIK2jHBQ0qOM04xlNNUWv/Mo
        oNIk2vYatxRYHpJnrNfkgZE=
X-Google-Smtp-Source: ABdhPJx4ECTfVg2+U5QqUepNwCaPX5HLFTV3Vg2vij5qajpYovM5nIpA4+ayTbkTSKXjPU1mSbE4Xw==
X-Received: by 2002:a17:906:388d:: with SMTP id q13mr2101698ejd.92.1603372091196;
        Thu, 22 Oct 2020 06:08:11 -0700 (PDT)
Received: from localhost.localdomain ([185.200.214.168])
        by smtp.gmail.com with ESMTPSA id e4sm732723eds.50.2020.10.22.06.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 06:08:10 -0700 (PDT)
From:   izabela.bakollari@gmail.com
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com,
        Izabela Bakollari <izabela.bakollari@gmail.com>
Subject: [PATCH] staging/wlan-ng: Fix line that exceeds 100 columns
Date:   Thu, 22 Oct 2020 15:08:07 +0200
Message-Id: <20201022130807.212454-1-izabela.bakollari@gmail.com>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Izabela Bakollari <izabela.bakollari@gmail.com>

Rearrange comment that exceeds 100 columns length. Issue reported
by checkpatch.pl

Signed-off-by: Izabela Bakollari <izabela.bakollari@gmail.com>
---
 drivers/staging/wlan-ng/cfg80211.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/wlan-ng/cfg80211.c b/drivers/staging/wlan-ng/cfg80211.c
index 759e475e303c..5fad37a49aa5 100644
--- a/drivers/staging/wlan-ng/cfg80211.c
+++ b/drivers/staging/wlan-ng/cfg80211.c
@@ -366,7 +366,8 @@ static int prism2_scan(struct wiphy *wiphy,
 					  msg2.beaconperiod.data,
 					  ie_buf,
 					  ie_len,
-					  (msg2.signal.data - 65536) * 100, /* Conversion to signed type */
+					  (msg2.signal.data - 65536) * 100,
+					  /* Conversion to signed type */
 					  GFP_KERNEL);
 
 		if (!bss) {
-- 
2.18.4

