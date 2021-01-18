Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B91F2F973A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 02:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730746AbhARBRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 20:17:21 -0500
Received: from mx-rz-1.rrze.uni-erlangen.de ([131.188.11.20]:33267 "EHLO
        mx-rz-1.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730744AbhARBLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 20:11:31 -0500
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4DJtyK223Bz8t5G;
        Mon, 18 Jan 2021 02:10:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1610932249; bh=4q8FTxUDRrtcILtOuN5I+bzRqdLjLl9pn+gqWJE91Hc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
         Subject;
        b=mLpYzIfIRB4adMJQjlbY9ZU1uLOiyeN2j6wJ2qUVkgQ3muz0cjzvkjyhPO1xxNmkB
         IxFzpgmsmKsCUebxEzUC8RdsJcrJBAcLB18mMGXgdZ5sysccKM0xFzcYYYoiDf4vAW
         uY6JWk7NPeGsqo3fYwc/5WUvmCsjW4yrqlJjS+wUGO28GUIFpXd5fMSNCDoHrCmhuz
         FgxzJp2kAqeIabM85hOCiJ6MXJ7JNdhXsMbjgaBeo+nk60BlZORfWiyDxpnKMokIej
         8SqbnZ1Of6LUmghcujbv4pSvYifG8lr0oZjhPbLXVQIB/DndfYLWo8PUdCtZh1cAfQ
         3QwTyy/QHUy1A==
X-Virus-Scanned: amavisd-new at boeck1.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:a62:19b2:a701:a9ea:94f8:dbd1:5695
Received: from shaun-PC.fritz.box (unknown [IPv6:2001:a62:19b2:a701:a9ea:94f8:dbd1:5695])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX1+iulsiPjEwpIJAb4Q1fECMgeOy/5MJM/4=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4DJtyG5Hgxz8t3M;
        Mon, 18 Jan 2021 02:10:46 +0100 (CET)
From:   Johannes Czekay <johannes.czekay@fau.de>
To:     gregkh@linuxfoundation.org
Cc:     nicolai.fischer@fau.de, johannes.czekay@fau.de, jbwyatt4@gmail.com,
        rkovhaev@gmail.com, hqjagain@gmail.com, gustavo@embeddedor.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-kernel@i4.cs.fau.de
Subject: [PATCH 5/6] wlan-ng: clean up alignment
Date:   Mon, 18 Jan 2021 02:09:55 +0100
Message-Id: <20210118010955.48663-6-johannes.czekay@fau.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118010955.48663-1-johannes.czekay@fau.de>
References: <20210118010955.48663-1-johannes.czekay@fau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cleans up all the alignment related warnings from checkpatch.

Signed-off-by: Johannes Czekay <johannes.czekay@fau.de>
Co-developed-by: Nicolai Fischer <nicolai.fischer@fau.de>
Signed-off-by: Nicolai Fischer <nicolai.fischer@fau.de>
---
 drivers/staging/wlan-ng/cfg80211.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/wlan-ng/cfg80211.c b/drivers/staging/wlan-ng/cfg80211.c
index 0e44a0f73a6a..ac62746cf92e 100644
--- a/drivers/staging/wlan-ng/cfg80211.c
+++ b/drivers/staging/wlan-ng/cfg80211.c
@@ -472,8 +472,8 @@ static int prism2_connect(struct wiphy *wiphy, struct net_device *dev,
 				return -EINVAL;
 
 			result = prism2_domibset_uint32(wlandev,
-				DIDMIB_DOT11SMT_PRIVACYTBL_WEPDEFAULTKEYID,
-				sme->key_idx);
+							DIDMIB_DOT11SMT_PRIVACYTBL_WEPDEFAULTKEYID,
+							sme->key_idx);
 			if (result)
 				goto exit;
 
@@ -584,8 +584,8 @@ static int prism2_set_tx_power(struct wiphy *wiphy, struct wireless_dev *wdev,
 		data = MBM_TO_DBM(mbm);
 
 	result = prism2_domibset_uint32(wlandev,
-		DIDMIB_DOT11PHY_TXPOWERTABLE_CURRENTTXPOWERLEVEL,
-		data);
+					DIDMIB_DOT11PHY_TXPOWERTABLE_CURRENTTXPOWERLEVEL,
+					data);
 
 	if (result) {
 		err = -EFAULT;
-- 
2.25.1

