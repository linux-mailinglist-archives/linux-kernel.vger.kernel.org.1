Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBD927BD2F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 08:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbgI2Gcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 02:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgI2Gch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 02:32:37 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9140BC061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 23:32:37 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id i26so13336436ejb.12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 23:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3oJmcECA/aWg2+W0uCsnzjhTRbsQ9LfkA10CFN31d7U=;
        b=cIhlxUKSEG+LHkEc1wdy85mJUSOGhnAQRAp5RSjjSvwNsVXnOMhKjrD/tsq8R5CV4F
         ErHNZC585JdBOFFvdj7eW42y7bAc/fB8lHgQQik4var+Jrd0jFbTqoECt20t/bTM5B95
         5YSuXLb/mD0gcR0wLIjgz9DJQrUjMtf2NZ0kuLIRTw8WUTlNFbvqn9Lg7ALzlvJ06gGd
         5oKSQu7C9lKr3lB65OOsEyk2zwoIuzO5vlEhKPQLSk/4e6qJMJsdKtdmbFGf2hV6x7wn
         JbYDR/Y4vzbHUP4rvSrW1yMxJEg1dVgAr1tdphvO5AbLPHhcXRiIP+VedR8y9eD9EiL3
         D3vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3oJmcECA/aWg2+W0uCsnzjhTRbsQ9LfkA10CFN31d7U=;
        b=ltau92vGpiEfClm2fNCykYm9RWUD5luf840otGUpMRL1+zJ60ixstPbnGSiVWVvPLA
         4jNmuTEnDSJt2ynKRxZ0ofUKVQXEADovIp2ZY3pv1ff/YYCa0aQrP8VOmUd5wzqCW7j3
         Tws17Fsc012EQzJdqglQHEyJpp3imTkn9yOLAe0ZNc3zVD7tJWbBz/LDC2dbAs5ppk3D
         opLsaOFztwHfMejoeB0T7ZfdIhPIVqqz8iHkTqFR36iJc6E4TYYua/Em+Zn0xymI0/3D
         nrlJyt8QEhdWHmQT+ULX9lwcWyzdunJTUspvZKN7+d8RRgE+LhpKIgRu0pGhMUSamASf
         LnHQ==
X-Gm-Message-State: AOAM530kURkxOagJ8TuYib/dmtJsheAoVF3hKgCEs+jkKBGyvjLarRvD
        RhfmozDPdfHM8gwuzQ5ede0=
X-Google-Smtp-Source: ABdhPJww4RFJkRuW8bSpYOKBWEddh0CuKbPrMdppQm2/gbtfQCNsMCS0jBzwU+0bTPdQAtqJvnY+Fw==
X-Received: by 2002:a17:906:3c47:: with SMTP id i7mr2278093ejg.554.1601361156303;
        Mon, 28 Sep 2020 23:32:36 -0700 (PDT)
Received: from localhost.localdomain (ipservice-092-219-207-039.092.219.pools.vodafone-ip.de. [92.219.207.39])
        by smtp.gmail.com with ESMTPSA id r8sm4730915edy.87.2020.09.28.23.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 23:32:35 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 5/8] staging: rtl8188eu: rename struct field bUsed -> used
Date:   Tue, 29 Sep 2020 08:28:44 +0200
Message-Id: <20200929062847.23985-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200929062847.23985-1-straube.linux@gmail.com>
References: <20200929062847.23985-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename field of struct rt_pmkid_list to avoid camel case.

bUsed -> used

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_mlme.c        | 2 +-
 drivers/staging/rtl8188eu/include/rtw_security.h | 2 +-
 drivers/staging/rtl8188eu/os_dep/ioctl_linux.c   | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme.c b/drivers/staging/rtl8188eu/core/rtw_mlme.c
index d34d46506b50..668a24f25fce 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme.c
@@ -1672,7 +1672,7 @@ static int SecIsInPMKIDList(struct adapter *Adapter, u8 *bssid)
 	int i = 0;
 
 	do {
-		if ((psecuritypriv->PMKIDList[i].bUsed) &&
+		if ((psecuritypriv->PMKIDList[i].used) &&
 		    (!memcmp(psecuritypriv->PMKIDList[i].bssid, bssid, ETH_ALEN)))
 			break;
 	} while (++i < NUM_PMKID_CACHE);
diff --git a/drivers/staging/rtl8188eu/include/rtw_security.h b/drivers/staging/rtl8188eu/include/rtw_security.h
index 737f1da81f6b..d08a8d8adccf 100644
--- a/drivers/staging/rtl8188eu/include/rtw_security.h
+++ b/drivers/staging/rtl8188eu/include/rtw_security.h
@@ -81,7 +81,7 @@ union Keytype {
 };
 
 struct rt_pmkid_list {
-	u8	bUsed;
+	u8	used;
 	u8	bssid[ETH_ALEN];
 	u8	PMKID[16];
 	u8	SsidBuf[33];
diff --git a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
index 9919413b6f7e..8e10462f1fbe 100644
--- a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
@@ -782,7 +782,7 @@ static int rtw_wx_set_pmkid(struct net_device *dev,
 				/*  BSSID is matched, the same AP => rewrite with new PMKID. */
 				DBG_88E("[%s] BSSID exists in the PMKList.\n", __func__);
 				memcpy(psecuritypriv->PMKIDList[j].PMKID, pPMK->pmkid, IW_PMKID_LEN);
-				psecuritypriv->PMKIDList[j].bUsed = true;
+				psecuritypriv->PMKIDList[j].used = true;
 				psecuritypriv->PMKIDIndex = j + 1;
 				blInserted = true;
 				break;
@@ -797,7 +797,7 @@ static int rtw_wx_set_pmkid(struct net_device *dev,
 			memcpy(psecuritypriv->PMKIDList[psecuritypriv->PMKIDIndex].bssid, strIssueBssid, ETH_ALEN);
 			memcpy(psecuritypriv->PMKIDList[psecuritypriv->PMKIDIndex].PMKID, pPMK->pmkid, IW_PMKID_LEN);
 
-			psecuritypriv->PMKIDList[psecuritypriv->PMKIDIndex].bUsed = true;
+			psecuritypriv->PMKIDList[psecuritypriv->PMKIDIndex].used = true;
 			psecuritypriv->PMKIDIndex++;
 			if (psecuritypriv->PMKIDIndex == 16)
 				psecuritypriv->PMKIDIndex = 0;
@@ -809,7 +809,7 @@ static int rtw_wx_set_pmkid(struct net_device *dev,
 			if (!memcmp(psecuritypriv->PMKIDList[j].bssid, strIssueBssid, ETH_ALEN)) {
 				/*  BSSID is matched, the same AP => Remove this PMKID information and reset it. */
 				eth_zero_addr(psecuritypriv->PMKIDList[j].bssid);
-				psecuritypriv->PMKIDList[j].bUsed = false;
+				psecuritypriv->PMKIDList[j].used = false;
 				break;
 			}
 		}
-- 
2.28.0

