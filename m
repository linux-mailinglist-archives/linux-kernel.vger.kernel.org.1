Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1B92AB209
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 08:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729815AbgKIH54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 02:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729802AbgKIH5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 02:57:53 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFE5C0613D6
        for <linux-kernel@vger.kernel.org>; Sun,  8 Nov 2020 23:57:51 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id r39so4070345ybd.10
        for <linux-kernel@vger.kernel.org>; Sun, 08 Nov 2020 23:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=mzPL36jUYccmuy3uUDUDamZKwDlz8VG/1Akljp216ug=;
        b=DSsSyRwJ7An+hAHQ1FozZlvz0sliHFKo45v06BwynZehQg3lhOhgzwlexw2BgY49mI
         IQem62rda/lNiV4JQma6JuYXIH/YsR8KJ5qF+0K4LDJVVEuKF3OhOhahETGU5ILvxMtn
         /MGS3nJVqZFFjjS8+Tvr1rjrs3Y9ip+4IknvOELFksJQHAqSwQJ6JVfLGD81+pnDa4+s
         QnQ4e2cIn75DseWzVGLQWT8f3e5TblBJf7XEKYj+IXdoG6FWeAaAY2pF/JdMEVzaNEPm
         WXuAh7QndfBTo6oVMLqxVJPlOQ5kLJPvsiTIfxIfk/EbkkL+7ExXVWN7dWfbatwMql7r
         4nLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mzPL36jUYccmuy3uUDUDamZKwDlz8VG/1Akljp216ug=;
        b=qO4/1OjytZv7DYcB9P1XQJDA0COq2By3AtO6TA/8/MdPCuTTuUQP9Gjs72OK58e7Qi
         iBz0O2VJd4cjs5QLkp7+sW2ooUzhplY9t1qGxBPJHQ4khqZb5a/q/fL8RCOnCjHnZ8bJ
         d59i9B/iXKcRfeYEzraGvRxEwmWFpduqzkRApUy2Hq8zY35iUBedMmQXO9+6M+o7fRXk
         uheXGBKb1uJOaKoBXIqaPWGVrdkEJwuhr3/LOiJXCLtt8mlOoPhNQHquu7afc+KufQuv
         cgQZSRGyixGRHwk0OeTywiGfu53c6oWFnFAkf/MtjJMRsF3pfpFwfWm5ELiy8NK3Y6nb
         NM0A==
X-Gm-Message-State: AOAM532eBfryGhYZmtUnNIlzKIZHD5FwP+h6tDn21N4h9bmcoHyL+YIh
        twg674TU76K39SOSVAuaPENt15pDHfeBsbSyBA==
X-Google-Smtp-Source: ABdhPJyLAMuC2pjYzipDevJKIWKM9mGTw75n1CMvn1lgViTf/WE72G+Jtkerg4MpqD/wKzTcn52wB5eU3H5Dh5M8cw==
Sender: "howardchung via sendgmr" 
        <howardchung@howardchung-p920.tpe.corp.google.com>
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a25:468a:: with SMTP id
 t132mr5491805yba.312.1604908670614; Sun, 08 Nov 2020 23:57:50 -0800 (PST)
Date:   Mon,  9 Nov 2020 15:57:26 +0800
In-Reply-To: <20201109155659.v7.1.Ib75f58e90c477f9b82c5598f00c59f0e95a1a352@changeid>
Message-Id: <20201109155659.v7.5.I756c1fecc03bcc0cd94400b4992cd7e743f4b3e2@changeid>
Mime-Version: 1.0
References: <20201109155659.v7.1.Ib75f58e90c477f9b82c5598f00c59f0e95a1a352@changeid>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH v7 5/5] Bluetooth: Add toggle to switch off interleave scan
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com
Cc:     mmandlik@chromium.org, alainm@chromium.org, mcchou@chromium.org,
        Howard Chung <howardchung@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add a configurable parameter to switch off the interleave
scan feature.

Reviewed-by: Alain Michaud <alainm@chromium.org>
Signed-off-by: Howard Chung <howardchung@google.com>
---

Changes in v7:
- Fix bt_dev_warn arguemnt type warning

Changes in v6:
- Set EnableAdvMonInterleaveScan to 1 byte long

Changes in v4:
- Set EnableAdvMonInterleaveScan default to Disable
- Fix 80 chars limit in mgmt_config.c

 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         |  1 +
 net/bluetooth/hci_request.c      |  3 ++-
 net/bluetooth/mgmt_config.c      | 41 +++++++++++++++++++++++++-------
 4 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index cfede18709d8f..63c6d656564a1 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -363,6 +363,7 @@ struct hci_dev {
 	__u32		clock;
 	__u16		advmon_allowlist_duration;
 	__u16		advmon_no_filter_duration;
+	__u8		enable_advmon_interleave_scan;
 
 	__u16		devid_source;
 	__u16		devid_vendor;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 65b7b74baba4c..b7cb7bfe250bd 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3595,6 +3595,7 @@ struct hci_dev *hci_alloc_dev(void)
 	/* The default values will be chosen in the future */
 	hdev->advmon_allowlist_duration = 300;
 	hdev->advmon_no_filter_duration = 500;
+	hdev->enable_advmon_interleave_scan = 0x00;	/* Default to disable */
 
 	hdev->sniff_max_interval = 800;
 	hdev->sniff_min_interval = 80;
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 396960ef54a13..85948c73c72b3 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1059,7 +1059,8 @@ void hci_req_add_le_passive_scan(struct hci_request *req)
 				      &own_addr_type))
 		return;
 
-	if (__hci_update_interleaved_scan(hdev))
+	if (hdev->enable_advmon_interleave_scan &&
+	    __hci_update_interleaved_scan(hdev))
 		return;
 
 	bt_dev_dbg(hdev, "interleave state %d", hdev->interleave_scan_state);
diff --git a/net/bluetooth/mgmt_config.c b/net/bluetooth/mgmt_config.c
index b735e59c7fd51..a3dfcdcb3b78d 100644
--- a/net/bluetooth/mgmt_config.c
+++ b/net/bluetooth/mgmt_config.c
@@ -17,12 +17,24 @@
 		__le16 value; \
 	} __packed _param_name_
 
+#define HDEV_PARAM_U8(_param_name_) \
+	struct {\
+		struct mgmt_tlv entry; \
+		__u8 value; \
+	} __packed _param_name_
+
 #define TLV_SET_U16(_param_code_, _param_name_) \
 	{ \
 		{ cpu_to_le16(_param_code_), sizeof(__u16) }, \
 		  cpu_to_le16(hdev->_param_name_) \
 	}
 
+#define TLV_SET_U8(_param_code_, _param_name_) \
+	{ \
+		{ cpu_to_le16(_param_code_), sizeof(__u8) }, \
+		  hdev->_param_name_ \
+	}
+
 #define TLV_SET_U16_JIFFIES_TO_MSECS(_param_code_, _param_name_) \
 	{ \
 		{ cpu_to_le16(_param_code_), sizeof(__u16) }, \
@@ -65,6 +77,7 @@ int read_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 		HDEV_PARAM_U16(def_le_autoconnect_timeout);
 		HDEV_PARAM_U16(advmon_allowlist_duration);
 		HDEV_PARAM_U16(advmon_no_filter_duration);
+		HDEV_PARAM_U8(enable_advmon_interleave_scan);
 	} __packed rp = {
 		TLV_SET_U16(0x0000, def_page_scan_type),
 		TLV_SET_U16(0x0001, def_page_scan_int),
@@ -97,6 +110,7 @@ int read_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 					     def_le_autoconnect_timeout),
 		TLV_SET_U16(0x001d, advmon_allowlist_duration),
 		TLV_SET_U16(0x001e, advmon_no_filter_duration),
+		TLV_SET_U8(0x001f, enable_advmon_interleave_scan),
 	};
 
 	bt_dev_dbg(hdev, "sock %p", sk);
@@ -109,6 +123,7 @@ int read_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 
 #define TO_TLV(x)		((struct mgmt_tlv *)(x))
 #define TLV_GET_LE16(tlv)	le16_to_cpu(*((__le16 *)(TO_TLV(tlv)->value)))
+#define TLV_GET_LE8(tlv)	le16_to_cpu(*((__u8 *)(TO_TLV(tlv)->value)))
 
 int set_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 			  u16 data_len)
@@ -125,6 +140,7 @@ int set_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 	/* First pass to validate the tlv */
 	while (buffer_left >= sizeof(struct mgmt_tlv)) {
 		const u8 len = TO_TLV(buffer)->length;
+		size_t exp_type_len;
 		const u16 exp_len = sizeof(struct mgmt_tlv) +
 				    len;
 		const u16 type = le16_to_cpu(TO_TLV(buffer)->type);
@@ -170,20 +186,26 @@ int set_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 		case 0x001b:
 		case 0x001d:
 		case 0x001e:
-			if (len != sizeof(u16)) {
-				bt_dev_warn(hdev, "invalid length %d, exp %zu for type %d",
-					    len, sizeof(u16), type);
-
-				return mgmt_cmd_status(sk, hdev->id,
-					MGMT_OP_SET_DEF_SYSTEM_CONFIG,
-					MGMT_STATUS_INVALID_PARAMS);
-			}
+			exp_type_len = sizeof(u16);
+			break;
+		case 0x001f:
+			exp_type_len = sizeof(u8);
 			break;
 		default:
+			exp_type_len = 0;
 			bt_dev_warn(hdev, "unsupported parameter %u", type);
 			break;
 		}
 
+		if (exp_type_len && len != exp_type_len) {
+			bt_dev_warn(hdev, "invalid length %d, exp %zu for type %d",
+				    len, exp_type_len, type);
+
+			return mgmt_cmd_status(sk, hdev->id,
+				MGMT_OP_SET_DEF_SYSTEM_CONFIG,
+				MGMT_STATUS_INVALID_PARAMS);
+		}
+
 		buffer_left -= exp_len;
 		buffer += exp_len;
 	}
@@ -289,6 +311,9 @@ int set_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 		case 0x0001e:
 			hdev->advmon_no_filter_duration = TLV_GET_LE16(buffer);
 			break;
+		case 0x0001f:
+			hdev->enable_advmon_interleave_scan = TLV_GET_LE8(buffer);
+			break;
 		default:
 			bt_dev_warn(hdev, "unsupported parameter %u", type);
 			break;
-- 
2.29.2.222.g5d2a92d10f8-goog

