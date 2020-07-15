Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC0A522117B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 17:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgGOPrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 11:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbgGOPrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 11:47:06 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C088C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 08:47:06 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id b92so3157996pjc.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 08:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sLH6sJiQXmgSukJgX8/DO69X96LYF+NzNLc7t6L2/Sg=;
        b=uAmWLwE/X7tejts48oDLWu0N6J93qGudNux6Py3WgedC2uNFNKbkxWa4xcuJj8DSNJ
         WCmMZk7dNnRWhN8uwqZsSYcpSXoq2ffwYgs1/2uwBDpmB2OM3EWvKDeS/CGdwcwd/qkN
         2y9RqYoC3ANMVx2b4g20hxXBH/jgNBuiZ3oQOljHnsWA7JF3/m2eMeA4hDCq71NYJtY7
         zw4on+IR8Rs9jUyRk+NpBkFyjF/iZawih3U0wO8Z/VpTlk8LfeBsfOP0gyfQJGfxvqvm
         88uude+3Opu9bwq/gsHcN0Z5KYVj/rBh4zq0sjSiWMQkZWsCPo2KYdkBF4lctkwU4JIi
         xIVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sLH6sJiQXmgSukJgX8/DO69X96LYF+NzNLc7t6L2/Sg=;
        b=iIFujEreSwQAVJCmG2gSdbj2YX/4JVrKVD8B4iRW35PO2eQ9iLemoRu9tiZqNbhq+v
         u1nXrFKj7iDc1LKxGvltDzuMfY7Q4XZOzNk9qpU9aTJj2TKgIQMEMAu1lBOqSfRL1rU4
         j6y2CbOy3l7s9VpcokioIq9XDebp/4lkDIH2ppzP6v0zNg9nNFl/rzEbY5BtGFreR50B
         UxOjuFnBwFdZr5lhFvMDIe8NgGAiekmUE2egPK/AR574Bpbr5ygm4RcdyQbC6IVbjALv
         U17oNzJ3Mgws+iRmk5ejhrh/tTrnda8quiY/NeGvHw2SSSaSdgG8MXBeYgkMKMzhuxqY
         dL+Q==
X-Gm-Message-State: AOAM530UljkTwYkEzuGjGgI09UlrdpL+/kYSmLaBfV4frKkUsvvaV/0G
        kk69BXIzmnplF2NbzG7JLm8RDmRU+cCEXQ==
X-Google-Smtp-Source: ABdhPJxxYu7No5w89yfleDz0iprY6cdSbOIG/ccb39GlpAwOINaCRTj9MkoTwMfKq+GPxG/gu1MM0g==
X-Received: by 2002:a17:902:680c:: with SMTP id h12mr99767plk.142.1594828026116;
        Wed, 15 Jul 2020 08:47:06 -0700 (PDT)
Received: from arpitha-Inspiron-7570.lan ([49.206.11.188])
        by smtp.gmail.com with ESMTPSA id g26sm2446064pfq.205.2020.07.15.08.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 08:47:05 -0700 (PDT)
From:   Arpitha Raghunandan <98.arpi@gmail.com>
To:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        puranjay12@gmail.com, yepeilin.cs@gmail.com
Cc:     Arpitha Raghunandan <98.arpi@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] staging: rtl8188eu: core: fix coding style issues
Date:   Wed, 15 Jul 2020 21:16:23 +0530
Message-Id: <20200715154623.78315-1-98.arpi@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixing WARNING: Prefer using '"%s...", __func__' to using 'function_name'
in a string in rtw_ioctl_set.c

Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>
---
Changes v2->v3:
- Added information about what changed from previous versions
Changes v1->v2:
- Added full name in From and Signed-off-by

 drivers/staging/rtl8188eu/core/rtw_ioctl_set.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ioctl_set.c b/drivers/staging/rtl8188eu/core/rtw_ioctl_set.c
index 9cc77ab4fd6b..fa88e8b2852d 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ioctl_set.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ioctl_set.c
@@ -44,12 +44,12 @@ u8 rtw_do_join(struct adapter *padapter)
 
 		if (!pmlmepriv->LinkDetectInfo.bBusyTraffic ||
 		    pmlmepriv->to_roaming > 0) {
-			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("rtw_do_join(): site survey if scanned_queue is empty\n."));
+			RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, ("%s: site survey if scanned_queue is empty\n.", __func__));
 			/*  submit site_survey_cmd */
 			ret = rtw_sitesurvey_cmd(padapter, &pmlmepriv->assoc_ssid, 1, NULL, 0);
 			if (ret != _SUCCESS) {
 				pmlmepriv->to_join = false;
-				RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("rtw_do_join(): site survey return error\n."));
+				RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_err_, ("%s: site survey return error\n.", __func__));
 			}
 		} else {
 			pmlmepriv->to_join = false;
@@ -313,7 +313,7 @@ u8 rtw_set_802_11_infrastructure_mode(struct adapter *padapter,
 	enum ndis_802_11_network_infra *pold_state = &cur_network->network.InfrastructureMode;
 
 	RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_notice_,
-		 ("+rtw_set_802_11_infrastructure_mode: old =%d new =%d fw_state = 0x%08x\n",
+		 ("+%s: old =%d new =%d fw_state = 0x%08x\n", __func__,
 		  *pold_state, networktype, get_fwstate(pmlmepriv)));
 
 	if (*pold_state != networktype) {
@@ -496,7 +496,7 @@ u8 rtw_set_802_11_add_wep(struct adapter *padapter, struct ndis_802_11_wep *wep)
 		break;
 	}
 	RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_,
-		 ("rtw_set_802_11_add_wep:before memcpy, wep->KeyLength = 0x%x wep->KeyIndex = 0x%x  keyid =%x\n",
+		 ("%s:before memcpy, wep->KeyLength = 0x%x wep->KeyIndex = 0x%x  keyid =%x\n", __func__,
 		 wep->KeyLength, wep->KeyIndex, keyid));
 
 	memcpy(&psecuritypriv->dot11DefKey[keyid].skey[0],
@@ -507,7 +507,7 @@ u8 rtw_set_802_11_add_wep(struct adapter *padapter, struct ndis_802_11_wep *wep)
 	psecuritypriv->dot11PrivacyKeyIndex = keyid;
 
 	RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_,
-		 ("rtw_set_802_11_add_wep:security key material : %x %x %x %x %x %x %x %x %x %x %x %x %x\n",
+		 ("%s:security key material : %x %x %x %x %x %x %x %x %x %x %x %x %x\n", __func__,
 		 psecuritypriv->dot11DefKey[keyid].skey[0],
 		 psecuritypriv->dot11DefKey[keyid].skey[1],
 		 psecuritypriv->dot11DefKey[keyid].skey[2],
-- 
2.25.1

