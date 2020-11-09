Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A878B2AC5E5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 21:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730191AbgKIUWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 15:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729913AbgKIUWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 15:22:16 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9245FC0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 12:22:16 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id dk16so14137045ejb.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 12:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LCMgJ7dbbZt1+HrR8oLWGeAravAmNrbCj4m+3YIlKbA=;
        b=OVd0gMwifdU3MsAuI3RT3IVO9V4PDqu1M0mAjCzVGoW12ft8hRyFYCePJhCZgG7tYd
         /P/umBD8yiK57aR6HlCylFs3J2NtIIitsnEVIjLr5H8rAK93UYFFG8eCLXxB57ilxYY7
         ENodMENAG5OsinGjSOBTOuZfrdXK4fg/rO7DYY7XRNFK/Sptaxg9UMs2UD2e7TyYBmVu
         bgim+1SylsrpHi2MMloi5Lqy5OugH2UViVWeGq4QkIlQHTIJrH1E9It27gFf0n+IJKdW
         fkHtCmpEkaxUk/k1lAtbPlP/nVQwUgQVUyZguhEnaGAE8rYRRgF+GAr2QpkweIRBh9jh
         ziIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LCMgJ7dbbZt1+HrR8oLWGeAravAmNrbCj4m+3YIlKbA=;
        b=HJRKWzko0txtbRvhQQJ+ZktumTzmxjXEP1KAFUGxElOOWwvG0uSuYFUKELmOKZ2jOU
         zpDmfm6ppEd/o4qiATU0PXqRgPZs0PpNS0e0IWclR/Fw/dBTsvFhoaWK+pVYz/syPhRG
         syF1EC+an5NvSSsWRMF36AtBcsqdr3ELt7J6CHob1NLzbIgQ9vZf9rTrei+q7mcqIHDY
         5WHoxIObbW5zhgbRILeZQ8fLj9+ie5Clj4w/m3V1lE762zRnzSCP5ZYlYSn/uw56/XGk
         qKcvzgt38oLnRhPSgnClhft2eBCoF48FK5vgUtgg/TYjNEhvLPFKUe49ghN37KofZ5Hy
         udzg==
X-Gm-Message-State: AOAM531xf7n7IvNHqTPl26JBb0d8yIt0Xo/+AAvJvO6AFPaxUsGiZ+r/
        UsJF4+pK9oLqgZQwiih1TgE=
X-Google-Smtp-Source: ABdhPJzm321fE545DRgKC/dFiA7rRHiqKZVk0qkVLNYGRUixRINE3FxNHffMBoyPdsgyg0N5FIVZqg==
X-Received: by 2002:a17:906:860b:: with SMTP id o11mr4928310ejx.252.1604953335339;
        Mon, 09 Nov 2020 12:22:15 -0800 (PST)
Received: from localhost.localdomain ([86.121.208.33])
        by smtp.gmail.com with ESMTPSA id cn8sm9304308edb.18.2020.11.09.12.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 12:22:14 -0800 (PST)
From:   Eduard Vintila <eduard.vintila47@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     robsonde@gmail.com, john.oldman@polehill.co.uk,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        eduard.vintila47@gmail.com
Subject: [PATCH] staging: rtl8192e: Braces should be used on all arms of statement
Date:   Mon,  9 Nov 2020 22:20:16 +0200
Message-Id: <20201109202016.79329-1-eduard.vintila47@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a coding style issue by adding braces on all arms of an "if"
statement.

Signed-off-by: Eduard Vintila <eduard.vintila47@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 27 ++++++++++++-----------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 8abc921ecb3e..9377e48c3f32 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -177,33 +177,34 @@ static void HTIOTPeerDetermine(struct rtllib_device *ieee)
 			pHTInfo->IOTPeer = HT_IOT_PEER_REALTEK_92SE;
 		if (net->bssht.RT2RT_HT_Mode & RT_HT_CAP_USE_SOFTAP)
 			pHTInfo->IOTPeer = HT_IOT_PEER_92U_SOFTAP;
-	} else if (net->broadcom_cap_exist)
+	} else if (net->broadcom_cap_exist) {
 		pHTInfo->IOTPeer = HT_IOT_PEER_BROADCOM;
-	else if (!memcmp(net->bssid, UNKNOWN_BORADCOM, 3) ||
+	} else if (!memcmp(net->bssid, UNKNOWN_BORADCOM, 3) ||
 		 !memcmp(net->bssid, LINKSYSWRT330_LINKSYSWRT300_BROADCOM, 3) ||
-		 !memcmp(net->bssid, LINKSYSWRT350_LINKSYSWRT150_BROADCOM, 3))
+		 !memcmp(net->bssid, LINKSYSWRT350_LINKSYSWRT150_BROADCOM, 3)) {
 		pHTInfo->IOTPeer = HT_IOT_PEER_BROADCOM;
-	else if ((memcmp(net->bssid, BELKINF5D8233V1_RALINK, 3) == 0) ||
+	} else if ((memcmp(net->bssid, BELKINF5D8233V1_RALINK, 3) == 0) ||
 		 (memcmp(net->bssid, BELKINF5D82334V3_RALINK, 3) == 0) ||
 		 (memcmp(net->bssid, PCI_RALINK, 3) == 0) ||
 		 (memcmp(net->bssid, EDIMAX_RALINK, 3) == 0) ||
 		 (memcmp(net->bssid, AIRLINK_RALINK, 3) == 0) ||
-		  net->ralink_cap_exist)
+		  net->ralink_cap_exist) {
 		pHTInfo->IOTPeer = HT_IOT_PEER_RALINK;
-	else if ((net->atheros_cap_exist) ||
+	} else if ((net->atheros_cap_exist) ||
 		(memcmp(net->bssid, DLINK_ATHEROS_1, 3) == 0) ||
-		(memcmp(net->bssid, DLINK_ATHEROS_2, 3) == 0))
+		(memcmp(net->bssid, DLINK_ATHEROS_2, 3) == 0)) {
 		pHTInfo->IOTPeer = HT_IOT_PEER_ATHEROS;
-	else if ((memcmp(net->bssid, CISCO_BROADCOM, 3) == 0) ||
-		  net->cisco_cap_exist)
+	} else if ((memcmp(net->bssid, CISCO_BROADCOM, 3) == 0) ||
+		  net->cisco_cap_exist) {
 		pHTInfo->IOTPeer = HT_IOT_PEER_CISCO;
-	else if ((memcmp(net->bssid, LINKSYS_MARVELL_4400N, 3) == 0) ||
-		  net->marvell_cap_exist)
+	} else if ((memcmp(net->bssid, LINKSYS_MARVELL_4400N, 3) == 0) ||
+		  net->marvell_cap_exist) {
 		pHTInfo->IOTPeer = HT_IOT_PEER_MARVELL;
-	else if (net->airgo_cap_exist)
+	} else if (net->airgo_cap_exist) {
 		pHTInfo->IOTPeer = HT_IOT_PEER_AIRGO;
-	else
+	} else {
 		pHTInfo->IOTPeer = HT_IOT_PEER_UNKNOWN;
+	}
 
 	netdev_dbg(ieee->dev, "IOTPEER: %x\n", pHTInfo->IOTPeer);
 }
-- 
2.29.2

