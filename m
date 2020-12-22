Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D83D2E1048
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 23:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbgLVW3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 17:29:40 -0500
Received: from mx-rz-2.rrze.uni-erlangen.de ([131.188.11.21]:41641 "EHLO
        mx-rz-2.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728115AbgLVW3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 17:29:38 -0500
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4D0rRL6SgzzPkmt;
        Tue, 22 Dec 2020 23:21:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1608675710; bh=0IdrnwQFC63KIZaU78qQV2FT/h51beqJx7nm64c0UNE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
         Subject;
        b=UoEeMufVN74NK3jNMar2Tm82Q+GolxeXIjOzd+nTsdxx6Y/723hDfTW/dSv9jGnDX
         PCN3pztJXDzuawt2kBE+VdfvlTmFZcQKHRR/4GAA9JPgLUOA15uLiWKRChK3pEuDN4
         yb08QV31lFMZk/kbQ9nDqXuBtMrMRQfT2x5mvVzsktrOoCEpRuHHoJQj+vxoxwKOw3
         sSvic/qV0pnHQwacnvGtzuWDBtnIvVUlQWTNdrdCjKOWUBzOiaZNu4gWiK2NjjTJm/
         zMg+igwpMcFOD6WQj6NeyUDJ59uPntIAosDmN+YbF724JxPw8lBH7zJEoepWpbpZUA
         r2kx7p+xVlp4g==
X-Virus-Scanned: amavisd-new at boeck1.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:a62:19fa:6f01:10d5:3d50:1797:6266
Received: from shaun-PC.fritz.box (unknown [IPv6:2001:a62:19fa:6f01:10d5:3d50:1797:6266])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX1/T8W2RgX1pUvqHJCOTNXR2wR78Mfe+MSU=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4D0rRH6YLPzPkYV;
        Tue, 22 Dec 2020 23:21:47 +0100 (CET)
From:   Johannes Czekay <johannes.czekay@fau.de>
To:     linux-kernel@vger.kernel.org
Cc:     johannes.czekay@fau.de, nicolai.fischer@fau.de,
        gustavo@embeddedor.com, hannes@cmpxchg.org, longman@redhat.com,
        mhocko@suse.com, adawesomeguy222@gmail.com,
        igormtorrente@gmail.com, sylphrenadin@gmail.com,
        izabela.bakollari@gmail.com, colin.king@canonical.com,
        steff.richards.the.third@gmail.com
Subject: [PATCH 3/6] wlan-ng: rename macros
Date:   Tue, 22 Dec 2020 23:20:14 +0100
Message-Id: <20201222222015.20558-4-johannes.czekay@fau.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201222222015.20558-1-johannes.czekay@fau.de>
References: <20201222222015.20558-1-johannes.czekay@fau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch renames some of the macros defined in "p80211metadef.h" in
order to fix some of the line length related warnings from checkpatch.
Since these macros are very long, fitting them within the given line
length would be really hard otherwise.

Signed-off-by: Johannes Czekay <johannes.czekay@fau.de>
Co-developed-by: Nicolai Fischer <nicolai.fischer@fau.de>
Signed-off-by: Nicolai Fischer <nicolai.fischer@fau.de>
---
 drivers/staging/wlan-ng/cfg80211.c      | 18 +++++++++---------
 drivers/staging/wlan-ng/p80211metadef.h | 24 ++++++++++++------------
 drivers/staging/wlan-ng/p80211netdev.c  |  2 +-
 drivers/staging/wlan-ng/p80211req.c     |  6 +++---
 drivers/staging/wlan-ng/prism2mib.c     | 18 +++++++++---------
 5 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/drivers/staging/wlan-ng/cfg80211.c b/drivers/staging/wlan-ng/cfg80211.c
index eda5b5a4e089..bdb1e6677cc7 100644
--- a/drivers/staging/wlan-ng/cfg80211.c
+++ b/drivers/staging/wlan-ng/cfg80211.c
@@ -159,7 +159,7 @@ static int prism2_add_key(struct wiphy *wiphy, struct net_device *dev,
 	}
 
 	if (prism2_domibset_uint32(wlandev,
-				   DIDMIB_DOT11SMT_PRIVACYTABLE_WEPDEFAULTKEYID,
+				   DIDMIB_DOT11SMT_PRIVACYTBL_WEPDEFAULTKEYID,
 				   key_index))
 		return -EFAULT;
 
@@ -232,7 +232,7 @@ static int prism2_set_default_key(struct wiphy *wiphy, struct net_device *dev,
 	struct wlandevice *wlandev = dev->ml_priv;
 
 	return  prism2_domibset_uint32(wlandev,
-				       DIDMIB_DOT11SMT_PRIVACYTABLE_WEPDEFAULTKEYID,
+				       DIDMIB_DOT11SMT_PRIVACYTBL_WEPDEFAULTKEYID,
 				       key_index);
 }
 
@@ -401,7 +401,7 @@ static int prism2_set_wiphy_params(struct wiphy *wiphy, u32 changed)
 			data = wiphy->rts_threshold;
 
 		result = prism2_domibset_uint32(wlandev,
-						DIDMIB_DOT11MAC_OPERATIONTABLE_RTSTHRESHOLD,
+						DIDMIB_DOT11MAC_OPERATIONTBL_RTSTHRESHOLD,
 						data);
 		if (result) {
 			err = -EFAULT;
@@ -416,7 +416,7 @@ static int prism2_set_wiphy_params(struct wiphy *wiphy, u32 changed)
 			data = wiphy->frag_threshold;
 
 		result = prism2_domibset_uint32(wlandev,
-						DIDMIB_DOT11MAC_OPERATIONTABLE_FRAGMENTATIONTHRESHOLD,
+						DIDMIB_DOT11MAC_OPERATIONTBL_FRAGMENTATIONTHRESHOLD,
 						data);
 		if (result) {
 			err = -EFAULT;
@@ -471,7 +471,7 @@ static int prism2_connect(struct wiphy *wiphy, struct net_device *dev,
 				return -EINVAL;
 
 			result = prism2_domibset_uint32(wlandev,
-				DIDMIB_DOT11SMT_PRIVACYTABLE_WEPDEFAULTKEYID,
+				DIDMIB_DOT11SMT_PRIVACYTBL_WEPDEFAULTKEYID,
 				sme->key_idx);
 			if (result)
 				goto exit;
@@ -490,13 +490,13 @@ static int prism2_connect(struct wiphy *wiphy, struct net_device *dev,
 		 * seems reasonable anyways
 		 */
 		result = prism2_domibset_uint32(wlandev,
-						DIDMIB_DOT11SMT_PRIVACYTABLE_PRIVACYINVOKED,
+						DIDMIB_DOT11SMT_PRIVACYTBL_PRIVACYINVOKED,
 						P80211ENUM_truth_true);
 		if (result)
 			goto exit;
 
 		result = prism2_domibset_uint32(wlandev,
-						DIDMIB_DOT11SMT_PRIVACYTABLE_EXCLUDEUNENCRYPTED,
+						DIDMIB_DOT11SMT_PRIVACYTBL_EXCLUDEUNENCRYPTED,
 						P80211ENUM_truth_true);
 		if (result)
 			goto exit;
@@ -506,13 +506,13 @@ static int prism2_connect(struct wiphy *wiphy, struct net_device *dev,
 		 * and exclude unencrypted
 		 */
 		result = prism2_domibset_uint32(wlandev,
-						DIDMIB_DOT11SMT_PRIVACYTABLE_PRIVACYINVOKED,
+						DIDMIB_DOT11SMT_PRIVACYTBL_PRIVACYINVOKED,
 						P80211ENUM_truth_false);
 		if (result)
 			goto exit;
 
 		result = prism2_domibset_uint32(wlandev,
-						DIDMIB_DOT11SMT_PRIVACYTABLE_EXCLUDEUNENCRYPTED,
+						DIDMIB_DOT11SMT_PRIVACYTBL_EXCLUDEUNENCRYPTED,
 						P80211ENUM_truth_false);
 		if (result)
 			goto exit;
diff --git a/drivers/staging/wlan-ng/p80211metadef.h b/drivers/staging/wlan-ng/p80211metadef.h
index 1b91b64c12ed..68c17c85279a 100644
--- a/drivers/staging/wlan-ng/p80211metadef.h
+++ b/drivers/staging/wlan-ng/p80211metadef.h
@@ -158,51 +158,51 @@
 #define didmib_dot11smt_wepdefaultkeystable_key(_i) \
 			(DIDMIB_DOT11SMT_WEPDEFAULTKEYSTABLE | \
 			P80211DID_MKITEM(_i) | 0x0c000000)
-#define DIDMIB_DOT11SMT_PRIVACYTABLE \
+#define DIDMIB_DOT11SMT_PRIVACYTBL \
 			(P80211DID_MKSECTION(1) | \
 			P80211DID_MKGROUP(6))
-#define DIDMIB_DOT11SMT_PRIVACYTABLE_PRIVACYINVOKED \
+#define DIDMIB_DOT11SMT_PRIVACYTBL_PRIVACYINVOKED \
 			(P80211DID_MKSECTION(1) | \
 			P80211DID_MKGROUP(6) | \
 			P80211DID_MKITEM(1) | 0x18000000)
-#define DIDMIB_DOT11SMT_PRIVACYTABLE_WEPDEFAULTKEYID \
+#define DIDMIB_DOT11SMT_PRIVACYTBL_WEPDEFAULTKEYID \
 			(P80211DID_MKSECTION(1) | \
 			P80211DID_MKGROUP(6) | \
 			P80211DID_MKITEM(2) | 0x18000000)
-#define DIDMIB_DOT11SMT_PRIVACYTABLE_EXCLUDEUNENCRYPTED \
+#define DIDMIB_DOT11SMT_PRIVACYTBL_EXCLUDEUNENCRYPTED \
 			(P80211DID_MKSECTION(1) | \
 			P80211DID_MKGROUP(6) | \
 			P80211DID_MKITEM(4) | 0x18000000)
-#define DIDMIB_DOT11MAC_OPERATIONTABLE \
+#define DIDMIB_DOT11MAC_OPERATIONTBL \
 			(P80211DID_MKSECTION(2) | \
 			P80211DID_MKGROUP(1))
-#define DIDMIB_DOT11MAC_OPERATIONTABLE_MACADDRESS \
+#define DIDMIB_DOT11MAC_OPERATIONTBL_MACADDRESS \
 			(P80211DID_MKSECTION(2) | \
 			P80211DID_MKGROUP(1) | \
 			P80211DID_MKITEM(1) | 0x18000000)
-#define DIDMIB_DOT11MAC_OPERATIONTABLE_RTSTHRESHOLD \
+#define DIDMIB_DOT11MAC_OPERATIONTBL_RTSTHRESHOLD \
 			(P80211DID_MKSECTION(2) | \
 			P80211DID_MKGROUP(1) | \
 			P80211DID_MKITEM(2) | 0x18000000)
-#define DIDMIB_DOT11MAC_OPERATIONTABLE_SHORTRETRYLIMIT \
+#define DIDMIB_DOT11MAC_OPERATIONTBL_SHORTRETRYLIMIT \
 			(P80211DID_MKSECTION(2) | \
 			P80211DID_MKGROUP(1) | \
 			P80211DID_MKITEM(3) | 0x10000000)
-#define DIDMIB_DOT11MAC_OPERATIONTABLE_LONGRETRYLIMIT \
+#define DIDMIB_DOT11MAC_OPERATIONTBL_LONGRETRYLIMIT \
 			(P80211DID_MKSECTION(2) | \
 			P80211DID_MKGROUP(1) | \
 			P80211DID_MKITEM(4) | 0x10000000)
-#define DIDMIB_DOT11MAC_OPERATIONTABLE_FRAGMENTATIONTHRESHOLD \
+#define DIDMIB_DOT11MAC_OPERATIONTBL_FRAGMENTATIONTHRESHOLD \
 			(P80211DID_MKSECTION(2) | \
 			P80211DID_MKGROUP(1) | \
 			P80211DID_MKITEM(5) | 0x18000000)
-#define DIDMIB_DOT11MAC_OPERATIONTABLE_MAXTRANSMITMSDULIFETIME \
+#define DIDMIB_DOT11MAC_OPERATIONTBL_MAXTRANSMITMSDULIFETIME \
 			(P80211DID_MKSECTION(2) | \
 			P80211DID_MKGROUP(1) | \
 			P80211DID_MKITEM(6) | 0x10000000)
 #define DIDMIB_CAT_DOT11PHY \
 			P80211DID_MKSECTION(3)
-#define DIDMIB_DOT11PHY_OPERATIONTABLE \
+#define DIDMIB_DOT11PHY_OPERATIONTBL \
 			(P80211DID_MKSECTION(3) | \
 			P80211DID_MKGROUP(1))
 #define DIDMIB_DOT11PHY_TXPOWERTABLE_CURRENTTXPOWERLEVEL \
diff --git a/drivers/staging/wlan-ng/p80211netdev.c b/drivers/staging/wlan-ng/p80211netdev.c
index a15abb2c8f54..36db73c38846 100644
--- a/drivers/staging/wlan-ng/p80211netdev.c
+++ b/drivers/staging/wlan-ng/p80211netdev.c
@@ -649,7 +649,7 @@ static int p80211knetdev_set_mac_address(struct net_device *dev, void *addr)
 	mibattr->status = P80211ENUM_msgitem_status_data_ok;
 	mibattr->len = sizeof(mibattr->data);
 
-	macaddr->did = DIDMIB_DOT11MAC_OPERATIONTABLE_MACADDRESS;
+	macaddr->did = DIDMIB_DOT11MAC_OPERATIONTBL_MACADDRESS;
 	macaddr->status = P80211ENUM_msgitem_status_data_ok;
 	macaddr->len = sizeof(macaddr->data);
 	macaddr->data.len = ETH_ALEN;
diff --git a/drivers/staging/wlan-ng/p80211req.c b/drivers/staging/wlan-ng/p80211req.c
index 9f5c1267d829..2c079e593e37 100644
--- a/drivers/staging/wlan-ng/p80211req.c
+++ b/drivers/staging/wlan-ng/p80211req.c
@@ -215,7 +215,7 @@ static void p80211req_mibset_mibget(struct wlandevice *wlandev,
 				       key, pstr->len);
 		break;
 
-	case DIDMIB_DOT11SMT_PRIVACYTABLE_WEPDEFAULTKEYID: {
+	case DIDMIB_DOT11SMT_PRIVACYTBL_WEPDEFAULTKEYID: {
 		u32 *data = (u32 *)mibitem->data;
 
 		if (isget) {
@@ -226,14 +226,14 @@ static void p80211req_mibset_mibget(struct wlandevice *wlandev,
 		}
 		break;
 	}
-	case DIDMIB_DOT11SMT_PRIVACYTABLE_PRIVACYINVOKED: {
+	case DIDMIB_DOT11SMT_PRIVACYTBL_PRIVACYINVOKED: {
 		u32 *data = (u32 *)mibitem->data;
 
 		p80211req_handle_action(wlandev, data, isget,
 					HOSTWEP_PRIVACYINVOKED);
 		break;
 	}
-	case DIDMIB_DOT11SMT_PRIVACYTABLE_EXCLUDEUNENCRYPTED: {
+	case DIDMIB_DOT11SMT_PRIVACYTBL_EXCLUDEUNENCRYPTED: {
 		u32 *data = (u32 *)mibitem->data;
 
 		p80211req_handle_action(wlandev, data, isget,
diff --git a/drivers/staging/wlan-ng/prism2mib.c b/drivers/staging/wlan-ng/prism2mib.c
index 875812a391c9..16107612acdc 100644
--- a/drivers/staging/wlan-ng/prism2mib.c
+++ b/drivers/staging/wlan-ng/prism2mib.c
@@ -158,42 +158,42 @@ static struct mibrec mibtab[] = {
 	 F_STA | F_WRITE,
 	 HFA384x_RID_CNFWEPDEFAULTKEY3, 0, 0,
 	 prism2mib_wepdefaultkey},
-	{DIDMIB_DOT11SMT_PRIVACYTABLE_PRIVACYINVOKED,
+	{DIDMIB_DOT11SMT_PRIVACYTBL_PRIVACYINVOKED,
 	 F_STA | F_READ | F_WRITE,
 	 HFA384x_RID_CNFWEPFLAGS, HFA384x_WEPFLAGS_PRIVINVOKED, 0,
 	 prism2mib_privacyinvoked},
-	{DIDMIB_DOT11SMT_PRIVACYTABLE_WEPDEFAULTKEYID,
+	{DIDMIB_DOT11SMT_PRIVACYTBL_WEPDEFAULTKEYID,
 	 F_STA | F_READ | F_WRITE,
 	 HFA384x_RID_CNFWEPDEFAULTKEYID, 0, 0,
 	 prism2mib_uint32},
-	{DIDMIB_DOT11SMT_PRIVACYTABLE_EXCLUDEUNENCRYPTED,
+	{DIDMIB_DOT11SMT_PRIVACYTBL_EXCLUDEUNENCRYPTED,
 	 F_STA | F_READ | F_WRITE,
 	 HFA384x_RID_CNFWEPFLAGS, HFA384x_WEPFLAGS_EXCLUDE, 0,
 	 prism2mib_flag},
 
 	/* dot11mac MIB's */
 
-	{DIDMIB_DOT11MAC_OPERATIONTABLE_MACADDRESS,
+	{DIDMIB_DOT11MAC_OPERATIONTBL_MACADDRESS,
 	 F_STA | F_READ | F_WRITE,
 	 HFA384x_RID_CNFOWNMACADDR, HFA384x_RID_CNFOWNMACADDR_LEN, 0,
 	 prism2mib_bytearea2pstr},
-	{DIDMIB_DOT11MAC_OPERATIONTABLE_RTSTHRESHOLD,
+	{DIDMIB_DOT11MAC_OPERATIONTBL_RTSTHRESHOLD,
 	 F_STA | F_READ | F_WRITE,
 	 HFA384x_RID_RTSTHRESH, 0, 0,
 	 prism2mib_uint32},
-	{DIDMIB_DOT11MAC_OPERATIONTABLE_SHORTRETRYLIMIT,
+	{DIDMIB_DOT11MAC_OPERATIONTBL_SHORTRETRYLIMIT,
 	 F_STA | F_READ,
 	 HFA384x_RID_SHORTRETRYLIMIT, 0, 0,
 	 prism2mib_uint32},
-	{DIDMIB_DOT11MAC_OPERATIONTABLE_LONGRETRYLIMIT,
+	{DIDMIB_DOT11MAC_OPERATIONTBL_LONGRETRYLIMIT,
 	 F_STA | F_READ,
 	 HFA384x_RID_LONGRETRYLIMIT, 0, 0,
 	 prism2mib_uint32},
-	{DIDMIB_DOT11MAC_OPERATIONTABLE_FRAGMENTATIONTHRESHOLD,
+	{DIDMIB_DOT11MAC_OPERATIONTBL_FRAGMENTATIONTHRESHOLD,
 	 F_STA | F_READ | F_WRITE,
 	 HFA384x_RID_FRAGTHRESH, 0, 0,
 	 prism2mib_fragmentationthreshold},
-	{DIDMIB_DOT11MAC_OPERATIONTABLE_MAXTRANSMITMSDULIFETIME,
+	{DIDMIB_DOT11MAC_OPERATIONTBL_MAXTRANSMITMSDULIFETIME,
 	 F_STA | F_READ,
 	 HFA384x_RID_MAXTXLIFETIME, 0, 0,
 	 prism2mib_uint32},
-- 
2.25.1

