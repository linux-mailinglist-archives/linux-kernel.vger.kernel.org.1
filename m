Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE9B27BD2D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 08:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725915AbgI2Gci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 02:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbgI2Gcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 02:32:35 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689D3C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 23:32:35 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id l24so31820edj.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 23:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o+oMInjT3TSvaINmgS8ZiHhcqDdzTBuNQa1FFKqPE8A=;
        b=PLFfuZ8BPnjGsK3jSX5DTXl/VkcjS7gQej3vA1Z2eEX1Vdd/RvPd8eFjJ9iGRKSyUl
         y5AfeDsKaAMGf8v1fmi9ETHUS8QrvJNcASRpOQWcKQgvyp8OBR7JK53cUy25Xt/RGpZu
         bCYXaJDi+8QVlMuAdLVB0ptEE2SJvxAabIxjxpWyHoEieDAybdE3yZXooUXMl+bG1y/7
         sU5wRsZ/ErpzQhRtCM+ezLK7dnXK4vl0OJAiCPbwz/WMwP/iDG1gpAH2UvhgFpLYIClA
         qi0qruEQDmQAjA8MH7WZh4uLEF9adafBfe1x2cvFQSoURYCt8uMc3WvptB4+v87S6acV
         kFTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o+oMInjT3TSvaINmgS8ZiHhcqDdzTBuNQa1FFKqPE8A=;
        b=au0IRrQAhk9mPq+F7QmmT0F9SvZ+Om6+OijFA9dfrEIpSFGbAMD3O1hZ+YvR89NuYP
         d3G0l+ZKgdrEeRtFrovS8lml5C97q7WnJ0h1PGyv0oMyZwji5ZQ8lKeeqbVVbLI/EmsO
         yXLjfTcW7LwqnRoDOjm1pu7saF6AHNaKCTWE1dpapG/DeDgwhj0crXEvB6bJYrHRRaD2
         oJGymt62NgmaFOumQUhDZzJskbiVzLLFtg5uSxosVPlgBsLbMtT+JV9WCv38dcG8DMMx
         i/0QHP4yIkF1h71cEIavYY1a7LlSQ+BBAU3RdBbxYk9WESBZkA4FlhuF01OZT5J/oxjr
         Ob2A==
X-Gm-Message-State: AOAM533z31f+NE5tt3XA7F6kLX4wFovcW6gDWPMSssSSiNC3W7AzfIwO
        Ekm6szP6/2zuMG79iMXzzFo=
X-Google-Smtp-Source: ABdhPJzHuldJJP/U0lCchrQvvolPG+PDE7VR7UDkJae0O9VVJsO7mtkmMugGWAElrnRVrDAmrwentQ==
X-Received: by 2002:a05:6402:1254:: with SMTP id l20mr1582473edw.312.1601361154136;
        Mon, 28 Sep 2020 23:32:34 -0700 (PDT)
Received: from localhost.localdomain (ipservice-092-219-207-039.092.219.pools.vodafone-ip.de. [92.219.207.39])
        by smtp.gmail.com with ESMTPSA id r8sm4730915edy.87.2020.09.28.23.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 23:32:33 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/8] staging: rtl8188eu: rename struct field Bssid -> bssid
Date:   Tue, 29 Sep 2020 08:28:42 +0200
Message-Id: <20200929062847.23985-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200929062847.23985-1-straube.linux@gmail.com>
References: <20200929062847.23985-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename field of struct rt_pmkid_list to avoid camel case.

Bssid -> bssid

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_mlme.c        | 2 +-
 drivers/staging/rtl8188eu/include/rtw_security.h | 2 +-
 drivers/staging/rtl8188eu/os_dep/ioctl_linux.c   | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme.c b/drivers/staging/rtl8188eu/core/rtw_mlme.c
index 5256817ee12a..d34d46506b50 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme.c
@@ -1673,7 +1673,7 @@ static int SecIsInPMKIDList(struct adapter *Adapter, u8 *bssid)
 
 	do {
 		if ((psecuritypriv->PMKIDList[i].bUsed) &&
-		    (!memcmp(psecuritypriv->PMKIDList[i].Bssid, bssid, ETH_ALEN)))
+		    (!memcmp(psecuritypriv->PMKIDList[i].bssid, bssid, ETH_ALEN)))
 			break;
 	} while (++i < NUM_PMKID_CACHE);
 
diff --git a/drivers/staging/rtl8188eu/include/rtw_security.h b/drivers/staging/rtl8188eu/include/rtw_security.h
index 5f418003647b..bfa080d6a1a9 100644
--- a/drivers/staging/rtl8188eu/include/rtw_security.h
+++ b/drivers/staging/rtl8188eu/include/rtw_security.h
@@ -82,7 +82,7 @@ union Keytype {
 
 struct rt_pmkid_list {
 	u8	bUsed;
-	u8	Bssid[6];
+	u8	bssid[6];
 	u8	PMKID[16];
 	u8	SsidBuf[33];
 	u8	*ssid_octet;
diff --git a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
index 7fd8582ba353..9919413b6f7e 100644
--- a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
@@ -778,7 +778,7 @@ static int rtw_wx_set_pmkid(struct net_device *dev,
 
 		/* overwrite PMKID */
 		for (j = 0; j < NUM_PMKID_CACHE; j++) {
-			if (!memcmp(psecuritypriv->PMKIDList[j].Bssid, strIssueBssid, ETH_ALEN)) {
+			if (!memcmp(psecuritypriv->PMKIDList[j].bssid, strIssueBssid, ETH_ALEN)) {
 				/*  BSSID is matched, the same AP => rewrite with new PMKID. */
 				DBG_88E("[%s] BSSID exists in the PMKList.\n", __func__);
 				memcpy(psecuritypriv->PMKIDList[j].PMKID, pPMK->pmkid, IW_PMKID_LEN);
@@ -794,7 +794,7 @@ static int rtw_wx_set_pmkid(struct net_device *dev,
 			DBG_88E("[%s] Use the new entry index = %d for this PMKID.\n",
 				__func__, psecuritypriv->PMKIDIndex);
 
-			memcpy(psecuritypriv->PMKIDList[psecuritypriv->PMKIDIndex].Bssid, strIssueBssid, ETH_ALEN);
+			memcpy(psecuritypriv->PMKIDList[psecuritypriv->PMKIDIndex].bssid, strIssueBssid, ETH_ALEN);
 			memcpy(psecuritypriv->PMKIDList[psecuritypriv->PMKIDIndex].PMKID, pPMK->pmkid, IW_PMKID_LEN);
 
 			psecuritypriv->PMKIDList[psecuritypriv->PMKIDIndex].bUsed = true;
@@ -806,9 +806,9 @@ static int rtw_wx_set_pmkid(struct net_device *dev,
 		DBG_88E("[%s] IW_PMKSA_REMOVE!\n", __func__);
 		ret = true;
 		for (j = 0; j < NUM_PMKID_CACHE; j++) {
-			if (!memcmp(psecuritypriv->PMKIDList[j].Bssid, strIssueBssid, ETH_ALEN)) {
+			if (!memcmp(psecuritypriv->PMKIDList[j].bssid, strIssueBssid, ETH_ALEN)) {
 				/*  BSSID is matched, the same AP => Remove this PMKID information and reset it. */
-				eth_zero_addr(psecuritypriv->PMKIDList[j].Bssid);
+				eth_zero_addr(psecuritypriv->PMKIDList[j].bssid);
 				psecuritypriv->PMKIDList[j].bUsed = false;
 				break;
 			}
-- 
2.28.0

