Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 492582DD0AC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 12:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbgLQLpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 06:45:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbgLQLpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 06:45:08 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A707C0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 03:44:28 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id w3so11028603qti.17
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 03:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=FSVX+8nSBBUKQq1ZLrI+OmJKsVh41/L0xGiVpz1i4AM=;
        b=tNolRNyjYFl4/CM+BmGWkkLJ27d/574h4YXn/dCqCYSKVUdxG/9QTc4GEnPk2MkqXE
         DTHbgBNRthruiGciOj7vZtVQC13pfTREHVVl0yuMWbECPgbNMjf3rM6Tc8oJiPLB9+o/
         cudm1SQEgce7S3dNHUzKzYXtwG1pZbM4Bg2LyzeaXDp3BZxNDO2jzZAkwhiew+6ZAwGE
         W3iRx2I/fJRjmon2uzt7/0E3c1/0xgH0CkyMprSImhp+6s39xyKGQ/sZIMx9Hd4Z8VHM
         3Wcw4A618xQba8Fbpe/PvfVHbE+NGHj41IJkGXfZIVVXZ8DaHguuTPkz/rjFm4WXILPf
         A1RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=FSVX+8nSBBUKQq1ZLrI+OmJKsVh41/L0xGiVpz1i4AM=;
        b=RUzat0cpMwZ5DOAXRdtW/S/JeC5o9xiCymspcb6xt6Xz39CPM07j6c+4ThHJRyhCgV
         YZvspbqIKP2LW/sIMu3uA+5ItNKKDz814RaZB4kRozBfUWNFtBzmju5PlHENlSUbbzeS
         0YSYOfxDvzQRQkPdfFmz6iCOAwUI/SBqKslyd7Rl1y0U7leS/+lNHmIV3iz2dV9y9err
         RWfa5BTPi0+CtXSyTjZLo37K+KMrTi+6qFY89FpfUIQ9/X8+NsPYOL7fLgJhS8BglrYB
         wU9nGdZr4ev/yNrptwCx28GrsxuVlM9wsLV3q2UvSUpC6v2DwRw/VJevBlLpuNNBXQBz
         njRg==
X-Gm-Message-State: AOAM531z3Mk4xmSX9Xkp/5kx/dkFliy3ENYf8qFsfHOuw5+QhAJjU48L
        k5HBeGYDnJl6g/x336F+zAemjmGprRPXUTZ9
X-Google-Smtp-Source: ABdhPJy/LLFKWoEyeoStLlr+OHOzO4UVSmtsrS6K/D2VffllSmeLjG7LvQwUVkOWmLClSdYA6t3i3IXYORbbkMqm
Sender: "jpawlowski via sendgmr" 
        <jpawlowski@jpawlowski-920.waw.corp.google.com>
X-Received: from jpawlowski-920.waw.corp.google.com ([2a00:79e0:2:11:7220:84ff:fe09:132a])
 (user=jpawlowski job=sendgmr) by 2002:a0c:bf0f:: with SMTP id
 m15mr47506939qvi.23.1608205467237; Thu, 17 Dec 2020 03:44:27 -0800 (PST)
Date:   Thu, 17 Dec 2020 12:44:22 +0100
Message-Id: <20201217114422.3617812-1-jpawlowski@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [PATCH] Bluetooth: hci_bcm: Add support for ISO packets
From:   Jakub Pawlowski <jpawlowski@google.com>
To:     jpawlowski@google.com
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables bcm driver to properly handle ISO packets.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 drivers/bluetooth/hci_bcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 8ea5ca8d71d6..3764ceb6fa0d 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -654,6 +654,7 @@ static const struct h4_recv_pkt bcm_recv_pkts[] = {
 	{ H4_RECV_ACL,      .recv = hci_recv_frame },
 	{ H4_RECV_SCO,      .recv = hci_recv_frame },
 	{ H4_RECV_EVENT,    .recv = hci_recv_frame },
+	{ H4_RECV_ISO,      .recv = hci_recv_frame },
 	{ BCM_RECV_LM_DIAG, .recv = hci_recv_diag  },
 	{ BCM_RECV_NULL,    .recv = hci_recv_diag  },
 	{ BCM_RECV_TYPE49,  .recv = hci_recv_diag  },
-- 
2.29.2.729.g45daf8777d-goog

