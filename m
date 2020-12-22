Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E58BE2E1047
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 23:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbgLVW3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 17:29:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728103AbgLVW3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 17:29:37 -0500
X-Greylist: delayed 431 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Dec 2020 14:28:57 PST
Received: from mx-rz-2.rrze.uni-erlangen.de (mx-rz-2.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589BBC0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 14:28:57 -0800 (PST)
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4D0rRV63r4zPkWd;
        Tue, 22 Dec 2020 23:21:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1608675718; bh=OHt9TpRCia/phItTsOgtpk7eBGKywdOoLJ5h33EkzDo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
         Subject;
        b=MlYEhOMXtvIHQkE9a+DnAyblY/tVCGx5CJ7p9yeINbTM0zQ/7pP2ucLZPh0qMWfOU
         yw6DUnVNRDF7kJ5pOYnT25BZsc8ZAQMq3atwm15NOOaCfAEVngb845pMprbtfkz/dl
         RTfegFRb3GMAPEUc4mq+AmXABF0dyM2zxnHTrEhIpw3QRAcAgHhIGHF6VgOdEKlcc0
         22I7DKBSCF6OB54kO88YW+XcEaOOGVQkI51jCTPfcuWL2Ed6nNU40NC3GZ3Yw7mhza
         TshQxq6YkIM0d6EpfrbQLgQwvuEPm0udhCCHOdSSVVFSU1AqE88JvYI/TXefqSKP7L
         bhDvZWtWsDySw==
X-Virus-Scanned: amavisd-new at boeck1.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:a62:19fa:6f01:10d5:3d50:1797:6266
Received: from shaun-PC.fritz.box (unknown [IPv6:2001:a62:19fa:6f01:10d5:3d50:1797:6266])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX19ISDaKZS3RfVmKMY605MWWXgTogt88QBo=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4D0rRS0wHxzPkgy;
        Tue, 22 Dec 2020 23:21:56 +0100 (CET)
From:   Johannes Czekay <johannes.czekay@fau.de>
To:     linux-kernel@vger.kernel.org
Cc:     johannes.czekay@fau.de, nicolai.fischer@fau.de,
        gustavo@embeddedor.com, hannes@cmpxchg.org, longman@redhat.com,
        mhocko@suse.com, adawesomeguy222@gmail.com,
        igormtorrente@gmail.com, sylphrenadin@gmail.com,
        izabela.bakollari@gmail.com, colin.king@canonical.com,
        steff.richards.the.third@gmail.com
Subject: [PATCH 6/6] wlan-ng: clean up reused macros
Date:   Tue, 22 Dec 2020 23:20:17 +0100
Message-Id: <20201222222015.20558-7-johannes.czekay@fau.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201222222015.20558-1-johannes.czekay@fau.de>
References: <20201222222015.20558-1-johannes.czekay@fau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cleans up two "macro argument reuse" warnings by checkpatch.
This should also make the code much more readable.

Signed-off-by: Johannes Czekay <johannes.czekay@fau.de>
Co-developed-by: Nicolai Fischer <nicolai.fischer@fau.de>
Signed-off-by: Nicolai Fischer <nicolai.fischer@fau.de>
---
 drivers/staging/wlan-ng/p80211metastruct.h | 18 +-------
 drivers/staging/wlan-ng/prism2mgmt.c       | 48 ++++++----------------
 2 files changed, 14 insertions(+), 52 deletions(-)

diff --git a/drivers/staging/wlan-ng/p80211metastruct.h b/drivers/staging/wlan-ng/p80211metastruct.h
index 4adc64580185..e963227f797c 100644
--- a/drivers/staging/wlan-ng/p80211metastruct.h
+++ b/drivers/staging/wlan-ng/p80211metastruct.h
@@ -114,22 +114,8 @@ struct p80211msg_dot11req_scan_results {
 	struct p80211item_uint32 cfpollreq;
 	struct p80211item_uint32 privacy;
 	struct p80211item_uint32 capinfo;
-	struct p80211item_uint32 basicrate1;
-	struct p80211item_uint32 basicrate2;
-	struct p80211item_uint32 basicrate3;
-	struct p80211item_uint32 basicrate4;
-	struct p80211item_uint32 basicrate5;
-	struct p80211item_uint32 basicrate6;
-	struct p80211item_uint32 basicrate7;
-	struct p80211item_uint32 basicrate8;
-	struct p80211item_uint32 supprate1;
-	struct p80211item_uint32 supprate2;
-	struct p80211item_uint32 supprate3;
-	struct p80211item_uint32 supprate4;
-	struct p80211item_uint32 supprate5;
-	struct p80211item_uint32 supprate6;
-	struct p80211item_uint32 supprate7;
-	struct p80211item_uint32 supprate8;
+	struct p80211item_uint32 basicrate[8];
+	struct p80211item_uint32 supprate[8];
 } __packed;
 
 struct p80211msg_dot11req_start {
diff --git a/drivers/staging/wlan-ng/prism2mgmt.c b/drivers/staging/wlan-ng/prism2mgmt.c
index 1bd36dc2b7ff..8540c3336907 100644
--- a/drivers/staging/wlan-ng/prism2mgmt.c
+++ b/drivers/staging/wlan-ng/prism2mgmt.c
@@ -388,6 +388,7 @@ int prism2mgmt_scan_results(struct wlandevice *wlandev, void *msgp)
 	struct hfa384x_hscan_result_sub *item = NULL;
 
 	int count;
+	int i;
 
 	req = msgp;
 
@@ -437,42 +438,17 @@ int prism2mgmt_scan_results(struct wlandevice *wlandev, void *msgp)
 		if (item->supprates[count] == 0)
 			break;
 
-#define REQBASICRATE(N) \
-	do { \
-		if ((count >= (N)) && DOT11_RATE5_ISBASIC_GET(	\
-			item->supprates[(N) - 1])) { \
-			req->basicrate ## N .data = item->supprates[(N) - 1]; \
-			req->basicrate ## N .status = \
-				P80211ENUM_msgitem_status_data_ok; \
-		} \
-	} while (0)
-
-	REQBASICRATE(1);
-	REQBASICRATE(2);
-	REQBASICRATE(3);
-	REQBASICRATE(4);
-	REQBASICRATE(5);
-	REQBASICRATE(6);
-	REQBASICRATE(7);
-	REQBASICRATE(8);
-
-#define REQSUPPRATE(N) \
-	do { \
-		if (count >= (N)) {					\
-			req->supprate ## N .data = item->supprates[(N) - 1]; \
-			req->supprate ## N .status = \
-				P80211ENUM_msgitem_status_data_ok; \
-		} \
-	} while (0)
-
-	REQSUPPRATE(1);
-	REQSUPPRATE(2);
-	REQSUPPRATE(3);
-	REQSUPPRATE(4);
-	REQSUPPRATE(5);
-	REQSUPPRATE(6);
-	REQSUPPRATE(7);
-	REQSUPPRATE(8);
+	for (i = 0; i < 8; i++) {
+		if (count > 1) {
+			if (DOT11_RATE5_ISBASIC_GET(item->supprates[i])) {
+				req->basicrate[i].data = item->supprates[i];
+				req->basicrate[i].status = P80211ENUM_msgitem_status_data_ok;
+			}
+
+			req->supprate[i].data = item->supprates[i];
+			req->supprate[i].status = P80211ENUM_msgitem_status_data_ok;
+		}
+	}
 
 	/* beacon period */
 	req->beaconperiod.status = P80211ENUM_msgitem_status_data_ok;
-- 
2.25.1

