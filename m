Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4C5A2D21C9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 05:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbgLHEI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 23:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgLHEI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 23:08:59 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C51FC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 20:07:44 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id z5so15626537iob.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 20:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7nZfJo4AhsmkiAbDV7RJy5PY1ud6WNkl7G/hQUCfN8o=;
        b=mJ8AwGvxv1UmTKLidpSCYN8BUKosVJZJ4tXeNzBWCGbSYmFP73ofXgkkVSRcHYe6LB
         1FbmavTNkDEF7vZRJL11bTsVIGTx6I9/0MYGW3oWlYXH6sA7nHJZcrDkc2zN7KYZ1Rbc
         kr4uF946mTokY5clOCv2sDcHVJGZtGW5fkpiZorryjhu+WgRltoixv28MBX8FB7S/Yqn
         Mwh2s8zXkzchCxISamTNr/F2BNcX2PwBauxPb42hzSkT2dl/cyqQxZtESRb9B1dArFW2
         YtVBC8ZNZLn7qFKn+5La04xylK5mKMMvP/E5zApGq1zjnb7oOAr08vyFAsFGY/Qm4S7E
         +S4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7nZfJo4AhsmkiAbDV7RJy5PY1ud6WNkl7G/hQUCfN8o=;
        b=SXlehIQx4e1E96e5C3vXIN6U2fdM3lz5pTqjSZ0s+c/X5yrO/KNQU7enauykjz+4fy
         9SdN4tAGLlwUiuNbnrkepn5K4DPbzCsBQ8aECMcXRnJP8o+Gw2LNgsy4lCwKdOBpQfTo
         blJURr4/hiKCRHpMHWy0PDPHL8A4qX77YMnzE29D/jx8TgxNttU0QZpaziswXQeOkKYy
         4ZW1v3mRX6YXZ0eDA2+1/5N9giLedT+Ol5lwEeHh5m86xY2PwH6kZHTj9HVPlrkVetT8
         yDy9fHwgy6tTYHvleAJhPLQkm0Njp5HtGi/G8eP4cigTEvD7XBMyuu12qXlLqVxcx0MB
         DJ8g==
X-Gm-Message-State: AOAM532hujFW3gVPN5ZfFBbhF52FI9wswkod5w+PaMX0hNVTR0v7i4bw
        hEzKUCvMsP1+/Ue1SNUruuA=
X-Google-Smtp-Source: ABdhPJytX2nqi+EVlXVzYGHMWxf2J5EX7r7I0vqEiR5kx4cWU1twP/Hz73kqN/s1uhnoRnu6qKl1cA==
X-Received: by 2002:a02:a582:: with SMTP id b2mr24684981jam.77.1607400463884;
        Mon, 07 Dec 2020 20:07:43 -0800 (PST)
Received: from localhost.localdomain (c-73-242-81-227.hsd1.mn.comcast.net. [73.242.81.227])
        by smtp.gmail.com with ESMTPSA id g2sm8630390ilh.41.2020.12.07.20.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 20:07:43 -0800 (PST)
From:   Ross Schmidt <ross.schm.dev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ross Schmidt <ross.schm.dev@gmail.com>
Subject: [PATCH v2 05/21] staging: rtl8723bs: replace WLAN_EID_VHT_OP_MODE_NOTIFY
Date:   Mon,  7 Dec 2020 22:07:17 -0600
Message-Id: <20201208040733.379197-6-ross.schm.dev@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201208040733.379197-1-ross.schm.dev@gmail.com>
References: <20201208040733.379197-1-ross.schm.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace unique WLAN_EID_VHT_OP_MODE_NOFITY macro with kernel provided
WLAN_EID_OPMODE_NOTIF from linux/ieee80211.h.

Signed-off-by: Ross Schmidt <ross.schm.dev@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 2 +-
 drivers/staging/rtl8723bs/include/ieee80211.h  | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index ff4f493e8dcd..182cc8c0b7d3 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -1072,7 +1072,7 @@ ParseRes rtw_ieee802_11_parse_elems(u8 *start, uint len,
 			elems->vht_operation = pos;
 			elems->vht_operation_len = elen;
 			break;
-		case WLAN_EID_VHT_OP_MODE_NOTIFY:
+		case WLAN_EID_OPMODE_NOTIF:
 			elems->vht_op_mode_notify = pos;
 			elems->vht_op_mode_notify_len = elen;
 			break;
diff --git a/drivers/staging/rtl8723bs/include/ieee80211.h b/drivers/staging/rtl8723bs/include/ieee80211.h
index 880d3f0a32fa..20c53c290aa1 100644
--- a/drivers/staging/rtl8723bs/include/ieee80211.h
+++ b/drivers/staging/rtl8723bs/include/ieee80211.h
@@ -352,7 +352,6 @@ struct ieee80211_snap_hdr {
 #define WLAN_EID_20_40_BSS_COEXISTENCE 72
 #define WLAN_EID_20_40_BSS_INTOLERANT 73
 #define WLAN_EID_OVERLAPPING_BSS_SCAN_PARAMS 74
-#define WLAN_EID_VHT_OP_MODE_NOTIFY 199
 
 #define IEEE80211_MGMT_HDR_LEN 24
 #define IEEE80211_DATA_HDR3_LEN 24
-- 
2.25.1

