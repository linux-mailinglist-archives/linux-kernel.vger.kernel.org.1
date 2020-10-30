Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6596C2A00C6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 10:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgJ3JIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 05:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgJ3JIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 05:08:51 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF473C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 02:08:49 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id z28so746877qkj.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 02:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=KtbE6nMcNhkFfnYmXD75bl9cz6XAUMFXbaKaYlZrCSA=;
        b=u5NV+RO3nBPcFMe9o0qbyiXFfM1VRxjZKzHEaSzLPQpgP+K1dYhdIewW+KncAVJ+e7
         IFBvULH/5I3APa0uNg84QaeZ1+Tit0YNcPlG7S6XPjIeK8H6KaixKEkLTAu9e2Qz8VSb
         xOiu18VFDnEvhzcfhO1uvUv/ii/UEVF3UP+7ttIvy7C/thYbFThcuOloYoFWf5wkLhKK
         dgUaqpq4pI/+kAs8LDCxZMIlCNbUkwIqpwWVy1MHfgD+0B97vuffxOR8MeLOMUJiZLc9
         HdCg9k4AM8q8gLe7RsGNxDnjj3hEtysQt7Nl9E5r2mY7ZcEPdCmJXlBPD4D1KIf8JyUi
         nRUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KtbE6nMcNhkFfnYmXD75bl9cz6XAUMFXbaKaYlZrCSA=;
        b=Q2diYUcf9v3po5ggTIk16qgqPtv4cLDHHja9LS9V5nkQF64XFpyRiJ/GbmktR0dQYW
         /EW4DHszpkCICbTrX3+V/oNK4h3Jynf1J3E1h7aCG24a76z8Yb64247c8piiewfhRP8B
         d2j2KG7Z1UXfJpKsTFhhIh199DxTF3T8Ql1zM/WUuAm6CIKWVk5MRpHP9aCCM6uhCy1c
         cW7OLs87y76HoXjb1ws72znR4f2nIuSzKrJfJ9YGMNwlj4UI+J5P+cFpqBWzidXfz9Cu
         7PONAIhfR80DaZ4Cwr4OZfO/+8DQMb/kLnR/FDbd6vFOFHT1eSd30wC+N+QfPWeKj+YS
         hD8g==
X-Gm-Message-State: AOAM533AEr5KQRTpiJ+2L5EXIgfl4fL5l9NXxWQyreZUj/ALRSahu2Nw
        11TzzDk75qI+vFUJHJ1ruHLwG3AmAEBHSl11KA==
X-Google-Smtp-Source: ABdhPJzANVjapTvjg69+DD+VcuDXXWNcwgPBJl62CSVt6W19pQkgY0SnWeinalPoJW1be1Fbn0nPv/KteXaGcKQH4g==
Sender: "howardchung via sendgmr" 
        <howardchung@howardchung-p920.tpe.corp.google.com>
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:ad4:40c6:: with SMTP id
 x6mr8378031qvp.20.1604048928877; Fri, 30 Oct 2020 02:08:48 -0700 (PDT)
Date:   Fri, 30 Oct 2020 17:08:26 +0800
In-Reply-To: <20201030163529.v6.1.Ib75f58e90c477f9b82c5598f00c59f0e95a1a352@changeid>
Message-Id: <20201030163529.v6.4.I9231b35b0be815c32c3a3ec48dcd1d68fa65daf4@changeid>
Mime-Version: 1.0
References: <20201030163529.v6.1.Ib75f58e90c477f9b82c5598f00c59f0e95a1a352@changeid>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v6 4/5] mgmt: Add supports of variable length parameter in mgmt_config
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com
Cc:     alainm@chromium.org, mmandlik@chromium.orgi, mcchou@chromium.org,
        Howard Chung <howardchung@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support of variable length parameter in mgmt_config.

Signed-off-by: Howard Chung <howardchung@google.com>
---

(no changes since v1)

 net/bluetooth/mgmt_config.c | 140 +++++++++++++++++++++---------------
 1 file changed, 84 insertions(+), 56 deletions(-)

diff --git a/net/bluetooth/mgmt_config.c b/net/bluetooth/mgmt_config.c
index 2d3ad288c78ac..b735e59c7fd51 100644
--- a/net/bluetooth/mgmt_config.c
+++ b/net/bluetooth/mgmt_config.c
@@ -11,72 +11,100 @@
 #include "mgmt_util.h"
 #include "mgmt_config.h"
 
-#define HDEV_PARAM_U16(_param_code_, _param_name_) \
-{ \
-	{ cpu_to_le16(_param_code_), sizeof(__u16) }, \
-	{ cpu_to_le16(hdev->_param_name_) } \
-}
+#define HDEV_PARAM_U16(_param_name_) \
+	struct {\
+		struct mgmt_tlv entry; \
+		__le16 value; \
+	} __packed _param_name_
 
-#define HDEV_PARAM_U16_JIFFIES_TO_MSECS(_param_code_, _param_name_) \
-{ \
-	{ cpu_to_le16(_param_code_), sizeof(__u16) }, \
-	{ cpu_to_le16(jiffies_to_msecs(hdev->_param_name_)) } \
-}
+#define TLV_SET_U16(_param_code_, _param_name_) \
+	{ \
+		{ cpu_to_le16(_param_code_), sizeof(__u16) }, \
+		  cpu_to_le16(hdev->_param_name_) \
+	}
+
+#define TLV_SET_U16_JIFFIES_TO_MSECS(_param_code_, _param_name_) \
+	{ \
+		{ cpu_to_le16(_param_code_), sizeof(__u16) }, \
+		  cpu_to_le16(jiffies_to_msecs(hdev->_param_name_)) \
+	}
 
 int read_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 			   u16 data_len)
 {
-	struct {
-		struct mgmt_tlv entry;
-		union {
-			/* This is a simplification for now since all values
-			 * are 16 bits.  In the future, this code may need
-			 * refactoring to account for variable length values
-			 * and properly calculate the required buffer size.
-			 */
-			__le16 value;
-		};
-	} __packed params[] = {
+	int ret;
+	struct mgmt_rp_read_def_system_config {
 		/* Please see mgmt-api.txt for documentation of these values */
-		HDEV_PARAM_U16(0x0000, def_page_scan_type),
-		HDEV_PARAM_U16(0x0001, def_page_scan_int),
-		HDEV_PARAM_U16(0x0002, def_page_scan_window),
-		HDEV_PARAM_U16(0x0003, def_inq_scan_type),
-		HDEV_PARAM_U16(0x0004, def_inq_scan_int),
-		HDEV_PARAM_U16(0x0005, def_inq_scan_window),
-		HDEV_PARAM_U16(0x0006, def_br_lsto),
-		HDEV_PARAM_U16(0x0007, def_page_timeout),
-		HDEV_PARAM_U16(0x0008, sniff_min_interval),
-		HDEV_PARAM_U16(0x0009, sniff_max_interval),
-		HDEV_PARAM_U16(0x000a, le_adv_min_interval),
-		HDEV_PARAM_U16(0x000b, le_adv_max_interval),
-		HDEV_PARAM_U16(0x000c, def_multi_adv_rotation_duration),
-		HDEV_PARAM_U16(0x000d, le_scan_interval),
-		HDEV_PARAM_U16(0x000e, le_scan_window),
-		HDEV_PARAM_U16(0x000f, le_scan_int_suspend),
-		HDEV_PARAM_U16(0x0010, le_scan_window_suspend),
-		HDEV_PARAM_U16(0x0011, le_scan_int_discovery),
-		HDEV_PARAM_U16(0x0012, le_scan_window_discovery),
-		HDEV_PARAM_U16(0x0013, le_scan_int_adv_monitor),
-		HDEV_PARAM_U16(0x0014, le_scan_window_adv_monitor),
-		HDEV_PARAM_U16(0x0015, le_scan_int_connect),
-		HDEV_PARAM_U16(0x0016, le_scan_window_connect),
-		HDEV_PARAM_U16(0x0017, le_conn_min_interval),
-		HDEV_PARAM_U16(0x0018, le_conn_max_interval),
-		HDEV_PARAM_U16(0x0019, le_conn_latency),
-		HDEV_PARAM_U16(0x001a, le_supv_timeout),
-		HDEV_PARAM_U16_JIFFIES_TO_MSECS(0x001b,
-						def_le_autoconnect_timeout),
-		HDEV_PARAM_U16(0x001d, advmon_allowlist_duration),
-		HDEV_PARAM_U16(0x001e, advmon_no_filter_duration),
+		HDEV_PARAM_U16(def_page_scan_type);
+		HDEV_PARAM_U16(def_page_scan_int);
+		HDEV_PARAM_U16(def_page_scan_window);
+		HDEV_PARAM_U16(def_inq_scan_type);
+		HDEV_PARAM_U16(def_inq_scan_int);
+		HDEV_PARAM_U16(def_inq_scan_window);
+		HDEV_PARAM_U16(def_br_lsto);
+		HDEV_PARAM_U16(def_page_timeout);
+		HDEV_PARAM_U16(sniff_min_interval);
+		HDEV_PARAM_U16(sniff_max_interval);
+		HDEV_PARAM_U16(le_adv_min_interval);
+		HDEV_PARAM_U16(le_adv_max_interval);
+		HDEV_PARAM_U16(def_multi_adv_rotation_duration);
+		HDEV_PARAM_U16(le_scan_interval);
+		HDEV_PARAM_U16(le_scan_window);
+		HDEV_PARAM_U16(le_scan_int_suspend);
+		HDEV_PARAM_U16(le_scan_window_suspend);
+		HDEV_PARAM_U16(le_scan_int_discovery);
+		HDEV_PARAM_U16(le_scan_window_discovery);
+		HDEV_PARAM_U16(le_scan_int_adv_monitor);
+		HDEV_PARAM_U16(le_scan_window_adv_monitor);
+		HDEV_PARAM_U16(le_scan_int_connect);
+		HDEV_PARAM_U16(le_scan_window_connect);
+		HDEV_PARAM_U16(le_conn_min_interval);
+		HDEV_PARAM_U16(le_conn_max_interval);
+		HDEV_PARAM_U16(le_conn_latency);
+		HDEV_PARAM_U16(le_supv_timeout);
+		HDEV_PARAM_U16(def_le_autoconnect_timeout);
+		HDEV_PARAM_U16(advmon_allowlist_duration);
+		HDEV_PARAM_U16(advmon_no_filter_duration);
+	} __packed rp = {
+		TLV_SET_U16(0x0000, def_page_scan_type),
+		TLV_SET_U16(0x0001, def_page_scan_int),
+		TLV_SET_U16(0x0002, def_page_scan_window),
+		TLV_SET_U16(0x0003, def_inq_scan_type),
+		TLV_SET_U16(0x0004, def_inq_scan_int),
+		TLV_SET_U16(0x0005, def_inq_scan_window),
+		TLV_SET_U16(0x0006, def_br_lsto),
+		TLV_SET_U16(0x0007, def_page_timeout),
+		TLV_SET_U16(0x0008, sniff_min_interval),
+		TLV_SET_U16(0x0009, sniff_max_interval),
+		TLV_SET_U16(0x000a, le_adv_min_interval),
+		TLV_SET_U16(0x000b, le_adv_max_interval),
+		TLV_SET_U16(0x000c, def_multi_adv_rotation_duration),
+		TLV_SET_U16(0x000d, le_scan_interval),
+		TLV_SET_U16(0x000e, le_scan_window),
+		TLV_SET_U16(0x000f, le_scan_int_suspend),
+		TLV_SET_U16(0x0010, le_scan_window_suspend),
+		TLV_SET_U16(0x0011, le_scan_int_discovery),
+		TLV_SET_U16(0x0012, le_scan_window_discovery),
+		TLV_SET_U16(0x0013, le_scan_int_adv_monitor),
+		TLV_SET_U16(0x0014, le_scan_window_adv_monitor),
+		TLV_SET_U16(0x0015, le_scan_int_connect),
+		TLV_SET_U16(0x0016, le_scan_window_connect),
+		TLV_SET_U16(0x0017, le_conn_min_interval),
+		TLV_SET_U16(0x0018, le_conn_max_interval),
+		TLV_SET_U16(0x0019, le_conn_latency),
+		TLV_SET_U16(0x001a, le_supv_timeout),
+		TLV_SET_U16_JIFFIES_TO_MSECS(0x001b,
+					     def_le_autoconnect_timeout),
+		TLV_SET_U16(0x001d, advmon_allowlist_duration),
+		TLV_SET_U16(0x001e, advmon_no_filter_duration),
 	};
-	struct mgmt_rp_read_def_system_config *rp = (void *)params;
 
 	bt_dev_dbg(hdev, "sock %p", sk);
 
-	return mgmt_cmd_complete(sk, hdev->id,
-				 MGMT_OP_READ_DEF_SYSTEM_CONFIG,
-				 0, rp, sizeof(params));
+	ret = mgmt_cmd_complete(sk, hdev->id,
+				MGMT_OP_READ_DEF_SYSTEM_CONFIG,
+				0, &rp, sizeof(rp));
+	return ret;
 }
 
 #define TO_TLV(x)		((struct mgmt_tlv *)(x))
-- 
2.29.1.341.ge80a0c044ae-goog

