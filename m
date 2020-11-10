Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC2F62ACE6A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 05:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732961AbgKJEKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 23:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732092AbgKJEK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 23:10:27 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D7EC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 20:10:27 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id u21so12312518iol.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 20:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/9o/uLwXwpriyz2hEdpSoPJHB5qVBBNPqLsNjiOdgac=;
        b=oROsUTXR3irXR7CwhPLQW1q62wOvswP+8Entjgqv/4a6UQ15YA8S640S6OOpBEszT9
         tZJpIFy0D5zujqASQyPJwTmAFR7d9w0MytaBxTPao1VAdMxJuINZOb3IpRf95XuA+IgF
         /L0jezO0WmdSc4OKJLROs7Ny9h2XRhn2XwoRQPJAfh46CXlwTYwmsYe33b+hc5PijEn2
         492Is1/HFvFJBxm39sN1xPToqjsuuQ+daeII95uXXy4B+poMBIbfMMwPJCPeLK/RxEf4
         0vMFeWfD2z7l0USAjNqCZPVrbE/w/Fven1oDhkQkVQzaObxEVB9loWr6lp8aMJFJxpuU
         BSLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/9o/uLwXwpriyz2hEdpSoPJHB5qVBBNPqLsNjiOdgac=;
        b=NIbB0zE7Gtkdvd6c2+yhFOP2hIqjSKFUp3Bq6MmB5cIUyQnzf+RboURETO5lo7opES
         5jxVe2EwRkYVvFUrHTn7jEtIvlG2pkeEuSXLlGx5qhgYsQgCy4X3Z2jULv9z7v9R3GVi
         H3abgsF18ZHdlBj+IaJ9JodnaZ/8QPeEUv97lIM3GYQWS64TDGKWLcM2IptKn0dvKpPQ
         iSChH6jL5DrAGji8KYu9CtC8MHQU90+18Y3Df4id5W3EQGyLlHALyJ/cRTzS6tJCzEN4
         Ms2qtLPnKmW+Ft3Gggt7nQF0ye/GcFpbYI3vJUkcGqNhlt0GdJRcruW5fCz4ePc5t2gB
         Tjzg==
X-Gm-Message-State: AOAM533c8IBbuYrxabwDx4YEDPPCdz9CR0xiueTZOjsd+GawFRJHxel6
        o0z2RIrMIqNh9302BpBFGsLNlB93V0E=
X-Google-Smtp-Source: ABdhPJxoWzja8osei2u2dZqugnRf4cP/m87ScMxnueBrH5kLOnCUsAkF1sbUv9V3316DeHbHKtJe/Q==
X-Received: by 2002:a5d:9683:: with SMTP id m3mr6725781ion.192.1604981426960;
        Mon, 09 Nov 2020 20:10:26 -0800 (PST)
Received: from localhost.localdomain (c-73-242-81-227.hsd1.mn.comcast.net. [73.242.81.227])
        by smtp.gmail.com with ESMTPSA id e21sm6658842ioc.0.2020.11.09.20.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 20:10:26 -0800 (PST)
From:   Ross Schmidt <ross.schm.dev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ross Schmidt <ross.schm.dev@gmail.com>
Subject: [PATCH 07/10] staging: rtl8723bs: clean up trailing statements
Date:   Mon,  9 Nov 2020 22:10:05 -0600
Message-Id: <20201110041008.15847-7-ross.schm.dev@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201110041008.15847-1-ross.schm.dev@gmail.com>
References: <20201110041008.15847-1-ross.schm.dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move trailing statements to the next line to fix coding style issues and
clear checkpatch errors.

ERROR: trailing statements should be on next line

Signed-off-by: Ross Schmidt <ross.schm.dev@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 3 ++-
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c    | 9 ++++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 385705aafa5c..7676056913d8 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -2870,7 +2870,8 @@ static struct sta_info *rtw_sta_info_get_by_idx(const int idx, struct sta_priv *
 
 	/* check asoc_queue */
 	while (phead != plist) {
-		if (idx == i) psta = LIST_CONTAINOR(plist, struct sta_info, asoc_list);
+		if (idx == i)
+			psta = LIST_CONTAINOR(plist, struct sta_info, asoc_list);
 		plist = get_next(plist);
 		i++;
 	}
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 773e4816fbc4..9c00469deeab 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -3151,7 +3151,8 @@ static int rtw_dbg_port(struct net_device *dev,
 #endif
 				case 0xaa:
 					{
-						if ((extra_arg & 0x7F) > 0x3F) extra_arg = 0xFF;
+						if ((extra_arg & 0x7F) > 0x3F)
+							extra_arg = 0xFF;
 						DBG_871X("chang data rate to :0x%02x\n", extra_arg);
 						padapter->fix_rate = extra_arg;
 					}
@@ -4934,7 +4935,8 @@ static int rtw_ioctl_wext_private(struct net_device *dev, union iwreq_data *wrq_
 			count = 0;
 			do {
 				str = strsep(&ptr, delim);
-				if (NULL == str) break;
+				if (NULL == str)
+					break;
 				sscanf(str, "%i", &temp);
 				buffer[count++] = (u8)temp;
 			} while (1);
@@ -4952,7 +4954,8 @@ static int rtw_ioctl_wext_private(struct net_device *dev, union iwreq_data *wrq_
 			count = 0;
 			do {
 				str = strsep(&ptr, delim);
-				if (NULL == str) break;
+				if (NULL == str)
+					break;
 				sscanf(str, "%i", &temp);
 				((s32 *)buffer)[count++] = (s32)temp;
 			} while (1);
-- 
2.25.1

