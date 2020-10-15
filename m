Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C1C28EDE8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 09:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729734AbgJOHvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 03:51:17 -0400
Received: from aer-iport-3.cisco.com ([173.38.203.53]:38422 "EHLO
        aer-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbgJOHvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 03:51:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=5320; q=dns/txt; s=iport;
  t=1602748275; x=1603957875;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F6+NdXdOw2iTjpt0eSp+jg3HUmHwLA7BjRmHztJK+FY=;
  b=eBX5kuhbtJmQwq/rzv6Y1orQcbSRJzHPBv2rAHSghbLQf0i9FNA+xoWt
   iVdACkn5w6UmCbepAG9J/RuTHOGAzqot72OGPkWA7TaJ5IVeX+nWEvwwp
   QYtCQFvEpPwackA1zgVNfu/dNGirt6OqOz3pM2gCek0O4qNrgic76m7RY
   I=;
X-IPAS-Result: =?us-ascii?q?A0DsBACK/Ydf/xbLJq1ghFOBdAEgEiyNP4gXnCYLAQEBD?=
 =?us-ascii?q?y8EAQGESgKCByY4EwIDAQEBAwIDAQEBAQUBAQECAQYEbYVohXIBAQQBJwsBR?=
 =?us-ascii?q?gULIDFXGYJbS4JdIKp8gXUziliBOIg3hGEBMgaBQT+BEYJibIo0BJAlBKdIg?=
 =?us-ascii?q?nSaXw8igxWKCASFQo5jjkilNIFrI4FXTSMVO4JpUBkNjisXjiY/AzACNgIGC?=
 =?us-ascii?q?gEBAwmOSAEB?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.77,378,1596499200"; 
   d="scan'208";a="27935472"
Received: from aer-iport-nat.cisco.com (HELO aer-core-1.cisco.com) ([173.38.203.22])
  by aer-iport-3.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 15 Oct 2020 07:43:47 +0000
Received: from hce-anki.rd.cisco.com ([10.47.78.239])
        by aer-core-1.cisco.com (8.15.2/8.15.2) with ESMTP id 09F7he91020030;
        Thu, 15 Oct 2020 07:43:46 GMT
From:   Hans-Christian Noren Egtvedt <hegtvedt@cisco.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH v4.4/bluetooth 2/2] Bluetooth: Disconnect if E0 is used for Level 4
Date:   Thu, 15 Oct 2020 09:43:33 +0200
Message-Id: <20201015074333.445510-2-hegtvedt@cisco.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201015074333.445510-1-hegtvedt@cisco.com>
References: <20201015074333.445510-1-hegtvedt@cisco.com>
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
(cherry picked from commit 8746f135bb01872ff412d408ea1aa9ebd328c1f5)
(cherry picked from commit f263237a1709a6dbf1dc9945187f1e64c53a4b73)
---
AFAICT, fixing CVE 2020-10135 Bluetooth impersonation attacks have been
left out for the 4.4 stable kernel. I cherry picked what I assume are
the appropriate two patches missing from the 4.9 stable kernel. Please
add them to upcoming 4.4 stable releases.

 include/net/bluetooth/hci_core.h | 10 ++++++----
 net/bluetooth/hci_conn.c         | 17 +++++++++++++++++
 net/bluetooth/hci_event.c        | 20 ++++++++------------
 3 files changed, 31 insertions(+), 16 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 0269a772bfe1..d07730be8d5a 100644
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
index 2ff5950e9712..2567249b5bce 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1175,6 +1175,23 @@ int hci_conn_check_link_mode(struct hci_conn *conn)
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

