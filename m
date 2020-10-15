Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C7628EDE6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 09:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729605AbgJOHux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 03:50:53 -0400
Received: from aer-iport-2.cisco.com ([173.38.203.52]:34938 "EHLO
        aer-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbgJOHux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 03:50:53 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Oct 2020 03:50:52 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=3364; q=dns/txt; s=iport;
  t=1602748252; x=1603957852;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bENcFV7HShz2/1Erdh4ZaV1FftkaV0pHdsikfNJ7OZM=;
  b=iTwTBUru2fuZxnJyqfYgyXTATCFR+2+URM5Z0v0JEUWmN/5IZpncORDf
   YegGFqdvGZ3ohWBCMU8lWtowW9FOK/TePO66iVAUgVEeUYWkpf4opP6o6
   Mm4SxFmE1d1bhega7fO16ODdDK8h2N/31MD4XVsah+9NIup1Ca0dSb+B1
   M=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0DcBABm/Ydf/xbLJq1ghkcBIBIsjT+?=
 =?us-ascii?q?kPQsBAQEPLwQBAYRKggkmOBMCAwEBCwEBBQEBAQIBBgRthWiGIAsBRjCBIYM?=
 =?us-ascii?q?mgn2qfIF1M4pYgTiIN4RhMwaBQT+EX4o0BJApp0iCdJpfDyKDFYoIBJQlLbN?=
 =?us-ascii?q?PgWsjgVdNIxWDJFAZDY4rFxSOEj8DMAI2AgYKAQEDCY5IAQE?=
X-IronPort-AV: E=Sophos;i="5.77,378,1596499200"; 
   d="scan'208";a="30372734"
Received: from aer-iport-nat.cisco.com (HELO aer-core-1.cisco.com) ([173.38.203.22])
  by aer-iport-2.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 15 Oct 2020 07:43:40 +0000
Received: from hce-anki.rd.cisco.com ([10.47.78.239])
        by aer-core-1.cisco.com (8.15.2/8.15.2) with ESMTP id 09F7he90020030;
        Thu, 15 Oct 2020 07:43:40 GMT
From:   Hans-Christian Noren Egtvedt <hegtvedt@cisco.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH v4.4/bluetooth 1/2] Bluetooth: Consolidate encryption handling in hci_encrypt_cfm
Date:   Thu, 15 Oct 2020 09:43:32 +0200
Message-Id: <20201015074333.445510-1-hegtvedt@cisco.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.47.78.239, [10.47.78.239]
X-Outbound-Node: aer-core-1.cisco.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes hci_encrypt_cfm calls hci_connect_cfm in case the connection
state is BT_CONFIG so callers don't have to check the state.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
(cherry picked from commit 3ca44c16b0dcc764b641ee4ac226909f5c421aa3)
(cherry picked from commit 0a60996c7fa7010ea00d9b62fb6996d908a01ead)
---
AFAICT, fixing CVE 2020-10135 Bluetooth impersonation attacks have been
left out for the 4.4 stable kernel. I cherry picked what I assume are
the appropriate two patches missing from the 4.9 stable kernel. Please
add them to upcoming 4.4 stable releases.

 include/net/bluetooth/hci_core.h | 20 ++++++++++++++++++--
 net/bluetooth/hci_event.c        | 28 +++-------------------------
 2 files changed, 21 insertions(+), 27 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 7c0c83dfe86e..0269a772bfe1 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1235,10 +1235,26 @@ static inline void hci_auth_cfm(struct hci_conn *conn, __u8 status)
 		conn->security_cfm_cb(conn, status);
 }
 
-static inline void hci_encrypt_cfm(struct hci_conn *conn, __u8 status,
-								__u8 encrypt)
+static inline void hci_encrypt_cfm(struct hci_conn *conn, __u8 status)
 {
 	struct hci_cb *cb;
+	__u8 encrypt;
+
+	if (conn->state == BT_CONFIG) {
+		if (status)
+			conn->state = BT_CONNECTED;
+
+		hci_connect_cfm(conn, status);
+		hci_conn_drop(conn);
+		return;
+	}
+
+	if (!test_bit(HCI_CONN_ENCRYPT, &conn->flags))
+		encrypt = 0x00;
+	else if (test_bit(HCI_CONN_AES_CCM, &conn->flags))
+		encrypt = 0x02;
+	else
+		encrypt = 0x01;
 
 	if (conn->sec_level == BT_SECURITY_SDP)
 		conn->sec_level = BT_SECURITY_LOW;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 03319ab8a7c6..bb9c13506bca 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2479,7 +2479,7 @@ static void hci_auth_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 				     &cp);
 		} else {
 			clear_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags);
-			hci_encrypt_cfm(conn, ev->status, 0x00);
+			hci_encrypt_cfm(conn, ev->status);
 		}
 	}
 
@@ -2565,22 +2565,7 @@ static void read_enc_key_size_complete(struct hci_dev *hdev, u8 status,
 		conn->enc_key_size = rp->key_size;
 	}
 
-	if (conn->state == BT_CONFIG) {
-		conn->state = BT_CONNECTED;
-		hci_connect_cfm(conn, 0);
-		hci_conn_drop(conn);
-	} else {
-		u8 encrypt;
-
-		if (!test_bit(HCI_CONN_ENCRYPT, &conn->flags))
-			encrypt = 0x00;
-		else if (test_bit(HCI_CONN_AES_CCM, &conn->flags))
-			encrypt = 0x02;
-		else
-			encrypt = 0x01;
-
-		hci_encrypt_cfm(conn, 0, encrypt);
-	}
+	hci_encrypt_cfm(conn, 0);
 
 unlock:
 	hci_dev_unlock(hdev);
@@ -2674,14 +2659,7 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	}
 
 notify:
-	if (conn->state == BT_CONFIG) {
-		if (!ev->status)
-			conn->state = BT_CONNECTED;
-
-		hci_connect_cfm(conn, ev->status);
-		hci_conn_drop(conn);
-	} else
-		hci_encrypt_cfm(conn, ev->status, ev->encrypt);
+	hci_encrypt_cfm(conn, ev->status);
 
 unlock:
 	hci_dev_unlock(hdev);
-- 
2.27.0

