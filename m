Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A24B52B889B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 00:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbgKRXoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 18:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727369AbgKRXoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 18:44:08 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D61C0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 15:44:08 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id u2so1897381pls.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 15:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iTB3bo1UF4JJAzKkMT7p3MoDedREDQBRrj3yyH4Dl9Y=;
        b=WYix7Y11RrVt/dV88uG6yY7owq0gesu0k3Uq1qb9Jo40C/n097r0FsHMlWEZqBrVSI
         ML5yXL/+0ZlmVhUqg0d7l3feJCosQNnAHwuZZOHbxACwxin1AUgod0sJcLMh4ULrPD/3
         nos0h6RJi90luya6+9dAc3gfYPJU/Lau8xW2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iTB3bo1UF4JJAzKkMT7p3MoDedREDQBRrj3yyH4Dl9Y=;
        b=IZ6qseSgN7KYHr7z0Se5hqJXSAu6kOYeHHFIdgXH9dZO+12Z1WVfS90VOJH6KwI8N5
         UlcCZg2nVefHVn9MM0rcjmJiqnaAsYqqBXlG3YrvDEgSfs0DPh+xhQfH1ByYperCVjyU
         D4VUKbC8g1PSElyIvBzmn3XCQkJtMExjyLqC8VZxQRoV4hxLg9/4o4vddLLPEDKuJmZ/
         IkrnJ8TpSq79j3fYy+dPAb3/2eUPu7GxdjaH56tBjFyHeIdzVlC0zQdBi8oAfWi9M4PA
         tqLT9Fg6CBQozDZOgeWVE8fax5moCG9pjf7GTDSInH2Z5tdGloH7tVrPD7ZOzwn61cH1
         +dwQ==
X-Gm-Message-State: AOAM530xgX1kaKEkEzKfmKvYjkmnsuJAKv3LAId0dXcJjCmucAbMvUxK
        m7sGumuT8AFZUXYKWJ1lvpa+9A==
X-Google-Smtp-Source: ABdhPJx0o4QdC0y6N2nNJxQWQ+otJDXcwXowHU259cVnDIjOI+IOlgmejl3o0Homa+Q4GM9jUyawvQ==
X-Received: by 2002:a17:902:9042:b029:d6:fe3f:6688 with SMTP id w2-20020a1709029042b02900d6fe3f6688mr6388780plz.75.1605743048346;
        Wed, 18 Nov 2020 15:44:08 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id f6sm21437435pgi.70.2020.11.18.15.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 15:44:07 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org, linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org, mcchou@chromium.org,
        danielwinkler@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: btmrvl_sdio: Power down when suspending
Date:   Wed, 18 Nov 2020 15:43:52 -0800
Message-Id: <20201118154349.3.If6a8ea0def7ff7a1f6a8ba349b9c840201b1d1f0@changeid>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
In-Reply-To: <20201118234352.2138694-1-abhishekpandit@chromium.org>
References: <20201118234352.2138694-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After seeing a large number of suspend failures due to -EBUSY, the most
common cause for failure seems to be the log snippet below:

[ 4764.773873] Bluetooth: hci_cmd_timeout() hci0 command 0x0c14 tx timeout
[ 4767.777897] Bluetooth: btmrvl_enable_hs() Host sleep enable command failed
[ 4767.777920] Bluetooth: btmrvl_sdio_suspend() HS not actived, suspend failed!
[ 4767.777946] dpm_run_callback(): pm_generic_suspend+0x0/0x48 returns -16
[ 4767.777963] call mmc2:0001:2+ returned -16 after 4882288 usecs

Since the sleep command is timing out, this points to the firmware as
the most likely source of the problem and we don't have a way to address
the fix there (this is an old controller). So, to mitigate this issue,
we can simply power down the Bluetooth controller when entering suspend
and power it back up when exiting suspend. We control setting this quirk
via a module parameter, power_down_suspend (which defaults to false).

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

 drivers/bluetooth/btmrvl_sdio.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 33d58b30c5acfc..e2e4917b4fe589 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -35,6 +35,12 @@
 
 #define VERSION "1.0"
 
+/* Add module param to control whether the controller is powered down during
+ * suspend. Default is False.
+ */
+static bool power_down_suspend;
+module_param(power_down_suspend, bool, 0644);
+
 static struct memory_type_mapping mem_type_mapping_tbl[] = {
 	{"ITCM", NULL, 0, 0xF0},
 	{"DTCM", NULL, 0, 0xF1},
@@ -1587,6 +1593,10 @@ static int btmrvl_sdio_probe(struct sdio_func *func,
 		goto disable_host_int;
 	}
 
+	if (power_down_suspend)
+		set_bit(HCI_QUIRK_POWER_DOWN_SYSTEM_SUSPEND,
+			&priv->btmrvl_dev.hcidev->quirks);
+
 	return 0;
 
 disable_host_int:
-- 
2.29.2.299.gdc1121823c-goog

