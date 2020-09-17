Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9E926D317
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 07:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgIQFaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 01:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbgIQFaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 01:30:04 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23FBC061756
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 22:30:03 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id p20so762347qvl.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 22:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=XmWCE7age5UnMwS5JxN69B5KWt/qREsunjUKP7hacM0=;
        b=TohQyaKedV/7Ibhkoc0hUwGYUEX+/BNWsSL89N2gO0v+tE9tqhLwpg6tZeaw4GUbZo
         4HhpI/j7aAxBG2p8cW/hQfog/Kmro0dyRPtJQtGNmyH54sBGaXykSOQGiR/ASZmrz8BF
         tB78F/5HihiYxkviq3wgYXKfaYCMIF+MQqfbpXGGxHWVrp06DGKXlmhcBOx929fO4+VY
         fJ449NLpfNWft19izeqkHXiNKFEvYfZa1hQnlrx2VsjAIbgz1MzSDAimpkHRCDpoC6bK
         ePgoYsCEivmmA6gpPsZYqOuNoETRSoKI10bgfJU+B7xe6W6Huuf2ythSEi2yJIlqmoJr
         Zblg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XmWCE7age5UnMwS5JxN69B5KWt/qREsunjUKP7hacM0=;
        b=od+aTVQQ5GXf0IuFGlVHdkOOkvaZh7p/Mt4ITsJKITzc5GNBdoTJyE/xXMf0elF8sg
         yDrhdnfehYh/GkWEX2N6XZLWI77xDGc48Q+35LxwI5ZYFghDzGTXLkdQiM22V7+zYFye
         USH+40yd5XO5fKErI5BwONNmizmBWy3Dwp57Ky+DECOPlwcOINPkmyqa/j+MY/Cnoikh
         9G0z2EqCFw/WMzP29AbhU28K04b+wMPT9U3ALIcW2uPUwasBqTaZJa1F2UtPaL/SmGaf
         LT3opnzPf6FOufxbNQI7VFWid8JH462jE+8gRHrBybekmtI566PymjqTmmAgFIxkB+qE
         egBA==
X-Gm-Message-State: AOAM532FsdVhIOojGl5+ya6j80SXpcO35QX6AX6rYX74lk2RJ4a/lxpI
        E3N0T/A71WCq9vZe4k+sHhtUoZMaswslShCHOg==
X-Google-Smtp-Source: ABdhPJwtM46x5bZUFvh2+P9WwAGt7EnNMSpRF+abYwADScuXGTd4JUZBu0FtOj7Xlb0a4eiqNhvSTg7TGV+oMTOq8A==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a0c:d848:: with SMTP id
 i8mr27007933qvj.31.1600320603105; Wed, 16 Sep 2020 22:30:03 -0700 (PDT)
Date:   Thu, 17 Sep 2020 13:29:42 +0800
In-Reply-To: <20200917132836.BlueZ.1.I27ef2a783d8920c147458639f3fa91b69f6fd9ea@changeid>
Message-Id: <20200917132836.BlueZ.5.I21e5741249e78c560ca377499ba06b56c7214985@changeid>
Mime-Version: 1.0
References: <20200917132836.BlueZ.1.I27ef2a783d8920c147458639f3fa91b69f6fd9ea@changeid>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [BlueZ PATCH 5/6] Bluetooth: Handle active scan case
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     mcchou@chromium.org, marcel@holtmann.org, mmandlik@chromium.org,
        howardchung@google.com, luiz.dentz@gmail.com, alainm@chromium.org,
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

 net/bluetooth/hci_request.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index d9082019b6386..1fcf6736811e4 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -3085,8 +3085,10 @@ static int active_scan(struct hci_request *req, unsigned long opt)
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
2.28.0.618.gf4bc123cb7-goog

