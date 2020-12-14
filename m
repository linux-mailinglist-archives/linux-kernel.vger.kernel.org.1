Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A794F2D93A3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 08:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438937AbgLNHaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 02:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbgLNHaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 02:30:13 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3661C0613D3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 23:29:27 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id e2so11895861pgi.5
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 23:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1UnPe12dT6b6iT2C3p6i0jSOevvJBWZfKVGfvi3n+4A=;
        b=eT+GqU2qoeWuLBldveCoVslUSrxOIVa2IZjrtcr6Q7RerPM7rFWrOhUpGPkf0xGN6c
         j/nPFAgGri8DY2g/qLWdm2jcst92kllfEsmnBfXio8h9floVPWSDeLha/Tyo0Zah4bjb
         9x9WVaIKA0ufM+BR+RM4we4lJl/yFngZ437eA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1UnPe12dT6b6iT2C3p6i0jSOevvJBWZfKVGfvi3n+4A=;
        b=psNb8jeWiAvA18K1lyibGY+IGXi/73dxU2HkVUHG1kUsVXL5o5mje37nTnjgBmmt0y
         pC2nYBYc6QGiE3DjFmwiHXfJOxPOtsoAbwEcUypmCcOYZd/t93SZgwDnfm3BhFxTXuqE
         ww0McVqrmsdgFZjbh5d4qpFu5JWILn2me7s2WI8ZzzzaMNzofLXjY+pSf0UcAV105F3A
         xC2dmpRlwczPe5JfAx6CkFU3z/TvGe6pj8RZJn+75DfeVAI5js+ZkTF5gL35TcOr7CFi
         PqsKXhl+3mta3flcJb9kPMtSYrSIdgoOg0Xu/yDFlMzpj6pVDpO3R+GLveUxqJBp8VyC
         seWQ==
X-Gm-Message-State: AOAM531IPavb5GBvxHU1hLFzWOCpbd8m1Za3mrI4CI72/ek20kWq4jfF
        55vWSlj0HL0lKAGdQ6hNG4o+o+Aq7bDrHA==
X-Google-Smtp-Source: ABdhPJyYR7QYt2Y7JFzV3OTCWyiglmqng5k93TIGp7kJzNduqM93tcZuMcXBbFERx+x9mDkIU7AE4Q==
X-Received: by 2002:a63:c26:: with SMTP id b38mr22979908pgl.333.1607930967361;
        Sun, 13 Dec 2020 23:29:27 -0800 (PST)
Received: from localhost ([2401:fa00:1:10:3e52:82ff:fe5e:cc9d])
        by smtp.gmail.com with ESMTPSA id gw7sm16746930pjb.36.2020.12.13.23.29.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Dec 2020 23:29:26 -0800 (PST)
From:   Claire Chang <tientzu@chromium.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        robh@kernel.org, sre@kernel.org, pavel@ucw.cz
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Claire Chang <tientzu@chromium.org>
Subject: [PATCH] Bluetooth: hci_uart: Fix a race for write_work scheduling
Date:   Mon, 14 Dec 2020 15:29:21 +0800
Message-Id: <20201214072921.3402608-1-tientzu@chromium.org>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In hci_uart_write_work, there is a loop/goto checking the value of
HCI_UART_TX_WAKEUP. If HCI_UART_TX_WAKEUP is set again, it keeps trying
hci_uart_dequeue; otherwise, it clears HCI_UART_SENDING and returns.

In hci_uart_tx_wakeup, if HCI_UART_SENDING is already set, it sets
HCI_UART_TX_WAKEUP, skips schedule_work and assumes the running/pending
hci_uart_write_work worker will do hci_uart_dequeue properly.

However, if the HCI_UART_SENDING check in hci_uart_tx_wakeup is done after
the loop breaks, but before HCI_UART_SENDING is cleared in
hci_uart_write_work, the schedule_work is skipped incorrectly.

Fix this race by changing the order of HCI_UART_SENDING and
HCI_UART_TX_WAKEUP modification.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Fixes: 82f5169bf3d3 ("Bluetooth: hci_uart: add serdev driver support library")
Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 drivers/bluetooth/hci_ldisc.c  | 7 +++----
 drivers/bluetooth/hci_serdev.c | 4 ++--
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index f83d67eafc9f..8be4d807d137 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -127,10 +127,9 @@ int hci_uart_tx_wakeup(struct hci_uart *hu)
 	if (!test_bit(HCI_UART_PROTO_READY, &hu->flags))
 		goto no_schedule;
 
-	if (test_and_set_bit(HCI_UART_SENDING, &hu->tx_state)) {
-		set_bit(HCI_UART_TX_WAKEUP, &hu->tx_state);
+	set_bit(HCI_UART_TX_WAKEUP, &hu->tx_state);
+	if (test_and_set_bit(HCI_UART_SENDING, &hu->tx_state))
 		goto no_schedule;
-	}
 
 	BT_DBG("");
 
@@ -174,10 +173,10 @@ static void hci_uart_write_work(struct work_struct *work)
 		kfree_skb(skb);
 	}
 
+	clear_bit(HCI_UART_SENDING, &hu->tx_state);
 	if (test_bit(HCI_UART_TX_WAKEUP, &hu->tx_state))
 		goto restart;
 
-	clear_bit(HCI_UART_SENDING, &hu->tx_state);
 	wake_up_bit(&hu->tx_state, HCI_UART_SENDING);
 }
 
diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
index ef96ad06fa54..9e03402ef1b3 100644
--- a/drivers/bluetooth/hci_serdev.c
+++ b/drivers/bluetooth/hci_serdev.c
@@ -83,9 +83,9 @@ static void hci_uart_write_work(struct work_struct *work)
 			hci_uart_tx_complete(hu, hci_skb_pkt_type(skb));
 			kfree_skb(skb);
 		}
-	} while (test_bit(HCI_UART_TX_WAKEUP, &hu->tx_state));
 
-	clear_bit(HCI_UART_SENDING, &hu->tx_state);
+		clear_bit(HCI_UART_SENDING, &hu->tx_state);
+	} while (test_bit(HCI_UART_TX_WAKEUP, &hu->tx_state));
 }
 
 /* ------- Interface to HCI layer ------ */
-- 
2.29.2.576.ga3fc446d84-goog

