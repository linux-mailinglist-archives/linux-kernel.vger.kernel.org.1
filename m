Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB272678F0
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 10:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725805AbgILIte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 04:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbgILIt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 04:49:27 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C167C061573
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 01:49:26 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id o8so16584140ejb.10
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 01:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+ljUzMs8hxOXKcFecnEmF5YKOxx89w9DLQIqWCR+XFY=;
        b=DFTo6aEK2WUdfjkVbQRQ3/lSdn+hB1O61rbQcZ3aLxT8v5mTDx2aZh7aRicyojuTEP
         /sl5REGbHoZ1OdHH4RDOfIQ1Tz/ov1JqsA7Z7VpP60k0q6VjjyA+67pxDm/XmVj55JZh
         OxwPOSbq/zCRO9ZRnoa0+jiusn99TRy7NAy9W1/2fM1wQIXA4isyUsiikAhXqke0NB3k
         JY8LF4MLZNcnQHjf0HW36QYPkOo7LqZSC+P+u+t9bD2m2wz8kskLiHr/NjwvFG1glTAs
         JWmfh1l5PoUz/24u4g3Lr2dT3ur39CsDaKxj+7ha5hhiuV+wgWjtQm5Ss8ochZsHZX/E
         /AnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+ljUzMs8hxOXKcFecnEmF5YKOxx89w9DLQIqWCR+XFY=;
        b=HGedyPq5qgB6LtbqTW+ygQtw7dW1HoTurTc81ECDP39XXmnd29lEX/d2AlQLh/xQAB
         oxVkWtpbiOW6yUPy+Zk9CeOxSjs2gqEM4V9v4aspj57A3Xhp9YvLUXNsgm8Oii92GwSm
         hHSxNMXaxaCdzJCqnW4HgQkJXPcm9KZz1qyOXy7Oe6HOIwCIHsB7+dARMAF5EmvRVXkk
         vBDU9XhIyjPl3vmtv/bRhsIWSOndxoiT69pfLXQN3QsnmaV2kqHcmaCpiXiQeMSrd53a
         25fCGREk8BhM0JJjpSX1LvULT/020YiP4bwmO9nlDm1/plNixigKMegM7lk9DFNHcxZ1
         2Ljg==
X-Gm-Message-State: AOAM530ym1lrzZpM5JL+DDrQ6hinBXiJpezOHwDNoa2+53IGbihAXFVE
        4/E/j2bHMDAlj7Fzyo7QBoc=
X-Google-Smtp-Source: ABdhPJzFtLkIWlH9oU/3K1AGg0yB9buSI2pqabwNT9Fk+0mrF0ELl2FDuzFdJU2q+CLbiQQBNSBVbg==
X-Received: by 2002:a17:906:3bca:: with SMTP id v10mr5240607ejf.57.1599900565258;
        Sat, 12 Sep 2020 01:49:25 -0700 (PDT)
Received: from localhost.localdomain (ipservice-092-219-207-039.092.219.pools.vodafone-ip.de. [92.219.207.39])
        by smtp.gmail.com with ESMTPSA id s23sm4009598edt.10.2020.09.12.01.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2020 01:49:24 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/5] staging: rtl8723bs: refactor cckrates{only}_included
Date:   Sat, 12 Sep 2020 10:45:16 +0200
Message-Id: <20200912084520.8383-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor cckrates_included() and cckratesonly_included() to simplify
the code and improve readability.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index a5790a648a5b..4e0d86b2e2e0 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -56,11 +56,12 @@ static u8 rtw_basic_rate_ofdm[3] = {
 
 int cckrates_included(unsigned char *rate, int ratelen)
 {
-	int	i;
+	int i;
 
 	for (i = 0; i < ratelen; i++) {
-		if  ((((rate[i]) & 0x7f) == 2)	|| (((rate[i]) & 0x7f) == 4) ||
-		     (((rate[i]) & 0x7f) == 11)  || (((rate[i]) & 0x7f) == 22))
+		u8 r = rate[i] & 0x7f;
+
+		if (r == 2 || r == 4 || r == 11 || r == 22)
 			return true;
 	}
 
@@ -69,11 +70,12 @@ int cckrates_included(unsigned char *rate, int ratelen)
 
 int cckratesonly_included(unsigned char *rate, int ratelen)
 {
-	int	i;
+	int i;
 
 	for (i = 0; i < ratelen; i++) {
-		if  ((((rate[i]) & 0x7f) != 2) && (((rate[i]) & 0x7f) != 4) &&
-		     (((rate[i]) & 0x7f) != 11)  && (((rate[i]) & 0x7f) != 22))
+		u8 r = rate[i] & 0x7f;
+
+		if (r != 2 && r != 4 && r != 11 && r != 22)
 			return false;
 	}
 
-- 
2.28.0

