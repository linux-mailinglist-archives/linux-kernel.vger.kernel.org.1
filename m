Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 589BA2AB200
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 08:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729775AbgKIH5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 02:57:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729758AbgKIH5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 02:57:43 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A387EC0613D3
        for <linux-kernel@vger.kernel.org>; Sun,  8 Nov 2020 23:57:43 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id 141so5338640qkh.18
        for <linux-kernel@vger.kernel.org>; Sun, 08 Nov 2020 23:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=cRPN1siIlVsn8AbvknNz+uPGXyjDKCgEUwApuU8hZr8=;
        b=OK4g+7nzOpaCtTolVcT99HmSnfwP6TLRaPt0cHCuU8sfwmR/9p5uBpR4EO/Z+nlqp8
         9zinomiLSSgwcEZQJTCeG/ipM2hzkrRjyvqdchrUX/09voCixiD7AQPX5EtYnBRiNB0Z
         0fBC/Dz6/99WVb0yBx3JvTICfolZjwAs4ii7S2MOySLQGqojuDv2rk355X48DasvZUlO
         DLxacv7u4ll1nK3BHO3oNhAOaI0frY6uqbnbJFilqN9WgD0WxJ6smCypZnRkZX8i43uy
         xCqG5+kkKjZDXShSZXLzU1VfMvtDD6lqjI4GU3f901jKH3FVk0qjSIW/qaEA0I8J46M8
         vtWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cRPN1siIlVsn8AbvknNz+uPGXyjDKCgEUwApuU8hZr8=;
        b=jfvBAU7yr0VJw0Y/HvOfFdErLBoI1DN+ID4PF4FN98AcG2+YmTADQqMOjkPatilumn
         fAAN7Mgh4oBm+h2Vr78lxnMNGtCOsBJ4Xd0za6Hpa+U4SojZFOTPPqwCmkVMExwc5SqZ
         513YywKmB54p6C1A0TV4Z7GsF81ABp80CmfyUZDM8MBDKElzf49E0CsdPK8QeUhttXS6
         TdogkAXVPWU1gdg16XGrE1mBY8Vl1OHbCxBiY1fSJJRI/NbtqfTT6qZS1uArPXIpce5i
         7gOWEav7iPminFXxBFTnzw1ED7p+xgeyDAqD3RcY5wHzf+9FQH9IwhXgn2yJh6fC4A8i
         2rFQ==
X-Gm-Message-State: AOAM5337ADutRiva1Z/5wHrCmbADs7jQUchlUar5eNXk2NF7LZ72fSQ3
        1QTEwsoNyWg0/ZlTn0rOHTI/Osl7GC5W8xP7aw==
X-Google-Smtp-Source: ABdhPJwj/CDkMa8/kwh76WQqi/Pnz2A31JwcTCtQmBViho0ff6iMStNvKHkkDIdz6KTKNIKyH7J2zLPfV3kua/bOaQ==
Sender: "howardchung via sendgmr" 
        <howardchung@howardchung-p920.tpe.corp.google.com>
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a05:6214:174f:: with SMTP id
 dc15mr12603420qvb.26.1604908662713; Sun, 08 Nov 2020 23:57:42 -0800 (PST)
Date:   Mon,  9 Nov 2020 15:57:24 +0800
In-Reply-To: <20201109155659.v7.1.Ib75f58e90c477f9b82c5598f00c59f0e95a1a352@changeid>
Message-Id: <20201109155659.v7.3.I21e5741249e78c560ca377499ba06b56c7214985@changeid>
Mime-Version: 1.0
References: <20201109155659.v7.1.Ib75f58e90c477f9b82c5598f00c59f0e95a1a352@changeid>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH v7 3/5] Bluetooth: Handle active scan case
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
index b615b981be9d6..396960ef54a13 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -3092,8 +3092,10 @@ static int active_scan(struct hci_request *req, unsigned long opt)
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

