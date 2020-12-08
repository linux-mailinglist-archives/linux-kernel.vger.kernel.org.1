Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66C4C2D21D3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 05:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgLHEJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 23:09:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbgLHEJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 23:09:16 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0571C0611E4
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 20:07:59 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id p5so14358350iln.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 20:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B2kvsrP4A4w9Ll/8j0HYqPedZLnR0R37yVmOg87xaPQ=;
        b=WKCdaZbidtImG3GtcDYPK1cR3ReQS7JakYx9QXy3pR1y0BIVqyWTl1ijLYUnb+vpAW
         irZXTNSzo0t073Fe0BnUx7kvbF0uA+w7QT6uUw9eTkQbC+rhoJ+OTjpoTx8TShbnlfRk
         BxvnARs7qP1MFb4DlkKlsC6g5e5zU9m5ojzTDj69n0ZwILt7oeUZuh0y2DAA/Nz++60h
         rohZO8vkw9o/nyyKWN0iZCm2fCTDZgJc0CnMDI/sEYCL4IGTsSyPRp0bBY7Gx7V7dyWt
         jOCWpteiZO5WQtWi1WFYTssEe0J9SqE1R15gt1peXSaljTD8H0NovPbgGg/7C+g0pi3I
         gtUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B2kvsrP4A4w9Ll/8j0HYqPedZLnR0R37yVmOg87xaPQ=;
        b=iW+SkZ1Uddn49AvspYA3JSgePGrqI0H9HBdc6y3mW4ahj5VLQLdyM3E8LFxJ0ndU6P
         MjJmdZ0g4uwWdYwQEFGP6ODr/wiF9vkEHrz1DPXKzNrRayqP4LeCpR/CzYqIkbHgVMLt
         gBXWfLZj99UOSZDp4nN5XAtcCRaXZy1XMf3YMtXHd5znjoMfRyGQAGr8a/C+sfRFlNqI
         B3o0Ku7CMJNwsbPpRY8jsd0YE6kvUkRfr08jk7Wsi/EQeoZa1Mh8b8nqj+oHi29+xX/l
         g4ZAs0V+fwp6su/tP7G57jDm3hN815dPF8dyeFHAob6Pc26GWO9phjmEdMdu+EMTciP1
         zJXg==
X-Gm-Message-State: AOAM532rWQbfuO22NVA8kfIuJ/nzpvSLiwX1o8MsTkoxScIGiwqzeFmH
        vPCV73O3CbY0yoQ1pqd/2OU=
X-Google-Smtp-Source: ABdhPJyyfqz3bycaiHCfu0MYFS5x9VmP/0W4+iqlTCHKYxWFFsnHrTVkjIEii/y1wUoON6+alAyEwQ==
X-Received: by 2002:a92:4002:: with SMTP id n2mr23931383ila.293.1607400479231;
        Mon, 07 Dec 2020 20:07:59 -0800 (PST)
Received: from localhost.localdomain (c-73-242-81-227.hsd1.mn.comcast.net. [73.242.81.227])
        by smtp.gmail.com with ESMTPSA id g2sm8630390ilh.41.2020.12.07.20.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 20:07:58 -0800 (PST)
From:   Ross Schmidt <ross.schm.dev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ross Schmidt <ross.schm.dev@gmail.com>
Subject: [PATCH v2 19/21] staging: rtl8723bs: replace EID_EXTCapability
Date:   Mon,  7 Dec 2020 22:07:31 -0600
Message-Id: <20201208040733.379197-20-ross.schm.dev@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201208040733.379197-1-ross.schm.dev@gmail.com>
References: <20201208040733.379197-1-ross.schm.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace unique EID_EXTCapability constant with kernel provided
WLAN_EID_EXT_CAPABILITY from linux/ieee80211.h.

Signed-off-by: Ross Schmidt <ross.schm.dev@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c     | 2 +-
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index d05338015744..2c9425e2a1e9 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -2912,7 +2912,7 @@ void rtw_append_exented_cap(struct adapter *padapter, u8 *out_ie, uint *pout_len
 	if (phtpriv->bss_coexist)
 		SET_EXT_CAPABILITY_ELE_BSS_COEXIST(cap_content, 1);
 
-	rtw_set_ie(out_ie + *pout_len, EID_EXTCapability, 8, cap_content, pout_len);
+	rtw_set_ie(out_ie + *pout_len, WLAN_EID_EXT_CAPABILITY, 8, cap_content, pout_len);
 }
 
 inline void rtw_set_to_roam(struct adapter *adapter, u8 to_roam)
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 9d172bd23911..fa4b0259c5ae 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -3381,9 +3381,9 @@ void issue_assocreq(struct adapter *padapter)
 			}
 			break;
 
-		case EID_EXTCapability:
+		case WLAN_EID_EXT_CAPABILITY:
 			if (padapter->mlmepriv.htpriv.ht_option)
-				pframe = rtw_set_ie(pframe, EID_EXTCapability, pIE->Length, pIE->data, &(pattrib->pktlen));
+				pframe = rtw_set_ie(pframe, WLAN_EID_EXT_CAPABILITY, pIE->Length, pIE->data, &(pattrib->pktlen));
 			break;
 		default:
 			break;
-- 
2.25.1

