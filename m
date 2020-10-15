Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1297228FA76
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 23:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405051AbgJOVMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 17:12:45 -0400
Received: from aer-iport-3.cisco.com ([173.38.203.53]:15304 "EHLO
        aer-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405034AbgJOVMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 17:12:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=5064; q=dns/txt; s=iport;
  t=1602796358; x=1604005958;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S9JFG+pXU3qysCS8fzYAxICvX4H97jHSV8wCwcU+n3U=;
  b=gWRNqXkZVArGj366w/pOEP5HGZu4Csn7y4kvU+sg+IaO2GdOTr6Dzhbl
   jUF6OXfPkB8Igs6UgW99VdJt7q4CUmSPcQBebB027AVW/UQ7fCjZPwOQ1
   kgBJwUVlMfh0nZGbja608CPHSXA9QvE6VPt2iFEFsTNTG/dbC+Vz5stP8
   I=;
X-IPAS-Result: =?us-ascii?q?A0DkBADcuohf/xbLJq1ghFOBdAEgEiyNP4gXnCYLAQEBD?=
 =?us-ascii?q?y8EAQGESgKCCSY4EwIDAQEBAwIDAQEBAQUBAQECAQYEbYVohXIBAQICAScLA?=
 =?us-ascii?q?UYFCyAxVxmCW0uCXSCsT4F1M4pbgTiIN4RhATIGgUE/gRGCYmyKNASQJQSnT?=
 =?us-ascii?q?4J0ml8PIoMWj06OZo5JpTiBayOBV00jFTuCaVAZDY4rF44mPwMwAjYCBgoBA?=
 =?us-ascii?q?QMJjkgBAQ?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.77,380,1596499200"; 
   d="scan'208";a="27953086"
Received: from aer-iport-nat.cisco.com (HELO aer-core-1.cisco.com) ([173.38.203.22])
  by aer-iport-3.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 15 Oct 2020 21:12:32 +0000
Received: from hce-anki.rd.cisco.com ([10.47.78.239])
        by aer-core-1.cisco.com (8.15.2/8.15.2) with ESMTP id 09FLCTWU020769;
        Thu, 15 Oct 2020 21:12:30 GMT
From:   Hans-Christian Noren Egtvedt <hegtvedt@cisco.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>, stable@vger.kernel.org
Subject: [v4.4/bluetooth PATCH 3/3] Bluetooth: Disconnect if E0 is used for Level 4
Date:   Thu, 15 Oct 2020 23:12:25 +0200
Message-Id: <20201015211225.1188104-3-hegtvedt@cisco.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201015211225.1188104-1-hegtvedt@cisco.com>
References: <20201015211225.1188104-1-hegtvedt@cisco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.47.78.239, [10.47.78.239]
X-Outbound-Node: aer-core-1.cisco.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

E0 is not allowed with Level 4:

BLUETOOTH CORE SPECIFICATION Version 5.2 | Vol 3, Part C page 1319:

  '128-bit equivalent strength for link and encryption keys
   required using FIPS approved algorithms (E0 not allowed,
   SAFER+ not allowed, and P-192 not allowed; encryption key
   not shortened'

SC enabled:

> HCI Event: Read Remote Extended Features (0x23) plen 13
        Status: Success (0x00)
        Handle: 256
        Page: 1/2
        Features: 0x0b 0x00 0x00 0x00 0x00 0x00 0x00 0x00
          Secure Simple Pairing (Host Support)
          LE Supported (Host)
          Secure Connections (Host Support)
> HCI Event: Encryption Change (0x08) plen 4
        Status: Success (0x00)
        Handle: 256
        Encryption: Enabled with AES-CCM (0x02)

SC disabled:

> HCI Event: Read Remote Extended Features (0x23) plen 13
        Status: Success (0x00)
        Handle: 256
        Page: 1/2
        Features: 0x03 0x00 0x00 0x00 0x00 0x00 0x00 0x00
          Secure Simple Pairing (Host Support)
          LE Supported (Host)
> HCI Event: Encryption Change (0x08) plen 4
        Status: Success (0x00)
        Handle: 256
        Encryption: Enabled with E0 (0x01)
[May 8 20:23] Bluetooth: hci0: Invalid security: expect AES but E0 was used
< HCI Command: Disconnect (0x01|0x0006) plen 3
        Handle: 256
        Reason: Authentication Failure (0x05)

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
(cherry picked from commit 8746f135bb01872ff412d408ea1aa9ebd328c1f5,
adjusted to match linux-4.4.y sources.)
Cc: stable@vger.kernel.org # 4.4
---
 include/net/bluetooth/hci_core.h | 10 ++++++----
 net/bluetooth/hci_conn.c         | 17 +++++++++++++++++
 net/bluetooth/hci_event.c        | 20 ++++++++------------
 3 files changed, 31 insertions(+), 16 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index dfa672b6f89d..5aaf6cdb121a 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1256,11 +1256,13 @@ static inline void hci_encrypt_cfm(struct hci_conn *conn, __u8 status)
 	else
 		encrypt = 0x01;
 
-	if (conn->sec_level == BT_SECURITY_SDP)
-		conn->sec_level = BT_SECURITY_LOW;
+	if (!status) {
+		if (conn->sec_level == BT_SECURITY_SDP)
+			conn->sec_level = BT_SECURITY_LOW;
 
-	if (conn->pending_sec_level > conn->sec_level)
-		conn->sec_level = conn->pending_sec_level;
+		if (conn->pending_sec_level > conn->sec_level)
+			conn->sec_level = conn->pending_sec_level;
+	}
 
 	mutex_lock(&hci_cb_list_lock);
 	list_for_each_entry(cb, &hci_cb_list, list) {
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 114bcf6ea916..2c94e3cd3545 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1173,6 +1173,23 @@ int hci_conn_check_link_mode(struct hci_conn *conn)
 			return 0;
 	}
 
+	 /* AES encryption is required for Level 4:
+	  *
+	  * BLUETOOTH CORE SPECIFICATION Version 5.2 | Vol 3, Part C
+	  * page 1319:
+	  *
+	  * 128-bit equivalent strength for link and encryption keys
+	  * required using FIPS approved algorithms (E0 not allowed,
+	  * SAFER+ not allowed, and P-192 not allowed; encryption key
+	  * not shortened)
+	  */
+	if (conn->sec_level == BT_SECURITY_FIPS &&
+	    !test_bit(HCI_CONN_AES_CCM, &conn->flags)) {
+		bt_dev_err(conn->hdev,
+			   "Invalid security: Missing AES-CCM usage");
+		return 0;
+	}
+
 	if (hci_conn_ssp_enabled(conn) &&
 	    !test_bit(HCI_CONN_ENCRYPT, &conn->flags))
 		return 0;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index bb9c13506bca..f0e6cce921d8 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2612,24 +2612,20 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	clear_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags);
 
+	/* Check link security requirements are met */
+	if (!hci_conn_check_link_mode(conn))
+		ev->status = HCI_ERROR_AUTH_FAILURE;
+
 	if (ev->status && conn->state == BT_CONNECTED) {
+		/* Notify upper layers so they can cleanup before
+		 * disconnecting.
+		 */
+		hci_encrypt_cfm(conn, ev->status);
 		hci_disconnect(conn, HCI_ERROR_AUTH_FAILURE);
 		hci_conn_drop(conn);
 		goto unlock;
 	}
 
-	/* In Secure Connections Only mode, do not allow any connections
-	 * that are not encrypted with AES-CCM using a P-256 authenticated
-	 * combination key.
-	 */
-	if (hci_dev_test_flag(hdev, HCI_SC_ONLY) &&
-	    (!test_bit(HCI_CONN_AES_CCM, &conn->flags) ||
-	     conn->key_type != HCI_LK_AUTH_COMBINATION_P256)) {
-		hci_connect_cfm(conn, HCI_ERROR_AUTH_FAILURE);
-		hci_conn_drop(conn);
-		goto unlock;
-	}
-
 	/* Try reading the encryption key size for encrypted ACL links */
 	if (!ev->status && ev->encrypt && conn->type == ACL_LINK) {
 		struct hci_cp_read_enc_key_size cp;
-- 
2.27.0

