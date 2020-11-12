Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 657342AFEE4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 06:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbgKLFhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 00:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728566AbgKLEIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 23:08:52 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937B2C061A48
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 20:06:56 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id h64so4581474ybc.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 20:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=T6CplrPxy27A6yiutX6XDympOldMSJN7QDPt35avta4=;
        b=ELCFvjXL6ZEvxXAt7MuiY8qSckQNyrSWVYRUOWscjvr1LpO5rTXC2Ou2LYrySaI7tn
         Xk+MzbSByOEz4egWSxEO1I1BXs3nVgINfCXXM5UepiekzGhSUFydk5bUdFmcc3tMmsuT
         FgNABFsa1hOuHaJPoxGLdGofjQY/pQK1yplGL9rLeYieGVftYPPV0fi4ejOv0La7qQ7h
         KO7p/5pXLycOu4K9wAealuvgYsNnZOJTO6IUmeotFftH+YhRRqUe1YQrL8uWBqP8T8/q
         TwUcgv+tggp6Nw9oJ7QU9osxW4i1q9gSn30FEvwlR2jWqE4rLNMKAEPmCHsKSpJmTRJN
         LS8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=T6CplrPxy27A6yiutX6XDympOldMSJN7QDPt35avta4=;
        b=m3yMb0dpXDWtk5/bx418ftJSXyvo5DHJFeJODMUFP0rhhD7rkNviTpHWvSGZ3cE2qy
         B+eiG9XAOGXyOXC1o+ZGCvD7iXqliCdwXnDjVnRAqzuVtNv01KCP9FajvfEmrZN0WpFA
         OpzNuGkXX5Ark9himhI1DTTMo2fOAxYu2xY6FbUYWWMP94FEiPzbdo+mJM2ESuIMWY1I
         ufzKxKRXpk59GmYJ9vJxSKXGtfKG/52CAXMwsQ0ZeWxmxFKeJrh/6s69wEu1WFTlMe7C
         Go+F6I/ziuccXX2s//o8pUdBAjn225G7Na/f5a0eyGSoNFLCSwF54KJTR4gCuIe5oS+2
         5PLQ==
X-Gm-Message-State: AOAM532AGJZic955FCh+X2C/TE2YRRTbJeIRz8yxpIHA6AWUILzCQKNT
        9/ymUt5O8TqMBuDWGFbg6N3NZuuBI45M8tT/8Q==
X-Google-Smtp-Source: ABdhPJwUj5JDrVJ4ySn2SgAaNrjMtCBoDksecI53K6KX+m0pKHpJUZXGKoKkWokZ8qdgIzbHYok65FLyD6nH5Ak9Yg==
Sender: "howardchung via sendgmr" 
        <howardchung@howardchung-p920.tpe.corp.google.com>
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a25:b68a:: with SMTP id
 s10mr36237332ybj.311.1605154015834; Wed, 11 Nov 2020 20:06:55 -0800 (PST)
Date:   Thu, 12 Nov 2020 12:06:38 +0800
In-Reply-To: <20201112120532.v10.1.Ib75f58e90c477f9b82c5598f00c59f0e95a1a352@changeid>
Message-Id: <20201112120532.v10.3.I21e5741249e78c560ca377499ba06b56c7214985@changeid>
Mime-Version: 1.0
References: <20201112120532.v10.1.Ib75f58e90c477f9b82c5598f00c59f0e95a1a352@changeid>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH v10 3/5] Bluetooth: Handle active scan case
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com
Cc:     mmandlik@chromium.org, mcchou@chromium.org, alainm@chromium.org,
        Howard Chung <howardchung@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds code to handle the active scan during interleave
scan. The interleave scan will be canceled when users start active scan,
and it will be restarted after active scan stopped.

Signed-off-by: Howard Chung <howardchung@google.com>
Reviewed-by: Alain Michaud <alainm@chromium.org>
Reviewed-by: Manish Mandlik <mmandlik@chromium.org>
---

(no changes since v1)

 net/bluetooth/hci_request.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 3bb0d2a98e82c..2368b050c17f1 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -3099,8 +3099,10 @@ static int active_scan(struct hci_request *req, unsigned long opt)
 	 * running. Thus, we should temporarily stop it in order to set the
 	 * discovery scanning parameters.
 	 */
-	if (hci_dev_test_flag(hdev, HCI_LE_SCAN))
+	if (hci_dev_test_flag(hdev, HCI_LE_SCAN)) {
 		hci_req_add_le_scan_disable(req, false);
+		cancel_interleave_scan(hdev);
+	}
 
 	/* All active scans will be done with either a resolvable private
 	 * address (when privacy feature has been enabled) or non-resolvable
-- 
2.29.2.222.g5d2a92d10f8-goog

