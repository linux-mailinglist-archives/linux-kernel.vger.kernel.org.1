Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0752FC1D3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 22:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391600AbhASVFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 16:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729133AbhASUo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 15:44:58 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB0BC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 12:43:25 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id y8so11222377plp.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 12:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2KPL8bz/DsmwTeTaJ4A3VI/judTjbMrQhWrVgCOV11c=;
        b=GTbi5NVABmar6gXKJ2rGY5w0Kaoyj6OX4eP8CdhOHzJWUoLXhcRZajGg/NE8jsrund
         mq55GrutSYVzE7mKJG3Vk0oF/L/8KWQqzgxAwirtgJdLbmCGvLLrOXv1NrdfazU5Ihsq
         dOwiEDoKR9IKQNWfMGxKvkkPwmHW/cBYIhA7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2KPL8bz/DsmwTeTaJ4A3VI/judTjbMrQhWrVgCOV11c=;
        b=AgmGXVVBwnACueeSk/66uNbmqh2Msl/z62Sp4ylbLEsWHCewYtG7vLcLi6bVpfSFo8
         yos2IGCiFY6cnql2JIM+2syMhf+HqzrwD3VsXCL/FK/L1YhN9vEQ6UVk2s34g0A+swJ+
         zuP8fd5lOlq170n/VjPkiH3hF5BhZY8ecrTNc8Ld1m4LfOU9XwvKMaZ7ovtVtoZmf7f3
         RB8cZVIPT6hRJZmBRPX4zPRKOegrurWCrqNILKOcRJqTZQdba/YG0hRznVjYEdcyefIR
         AUyr3mDy+/5Wgd4LSv6S+GoEcMjTmh+pdYw4+Kj7ijyA/qPP+Bs50zZbiwDuyS0Nt/Bq
         WIEw==
X-Gm-Message-State: AOAM532P0LNS1gBWWrn2WsHwDOuZ47/BtwMHlfpp/s1dpAFmP1R7hBH5
        LAq6dEZ81JeaueSFjnP0N4+uZg==
X-Google-Smtp-Source: ABdhPJz71RGGjKYuVOHERmx7xaJriybr2/w8Dr7ETf2Zs6/LYn1K4HSQCGy/aYohUgYfBSWAh5n9+w==
X-Received: by 2002:a17:903:1c2:b029:de:ad0a:2dbf with SMTP id e2-20020a17090301c2b02900dead0a2dbfmr6620147plh.44.1611089004824;
        Tue, 19 Jan 2021 12:43:24 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id x15sm13835pfa.80.2021.01.19.12.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 12:43:24 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org, mcchou@chromium.org,
        michaelfsun@google.com, linux-bluetooth@vger.kernel.org,
        apusaka@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Daniel Winkler <danielwinkler@google.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: btusb: Trigger gpio reset quicker
Date:   Tue, 19 Jan 2021 12:43:13 -0800
Message-Id: <20210119124258.2.I52cc5d2b62fdeb5f3c5249d41f3631ae25d8dc71@changeid>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
In-Reply-To: <20210119204315.2611811-1-abhishekpandit@chromium.org>
References: <20210119204315.2611811-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, btusb will only trigger gpio reset during cmd_timeout after
5 commands fail. This number is arbitrarily large and can result in
resets taking longer to occur than necessary.

Reduce this number to 3, which was chosen as a recommended value by
Intel (their firmware allow two commands in flight so they recommend
resetting on the third failed command).

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Reviewed-by: Daniel Winkler <danielwinkler@google.com>
---

 drivers/bluetooth/btusb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 03341e6cbf3ed..880e9cd4ee713 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -578,7 +578,7 @@ static void btusb_gpio_cmd_timeout(struct hci_dev *hdev)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
 
-	if (++data->cmd_timeout_cnt < 5)
+	if (++data->cmd_timeout_cnt < 3)
 		return;
 
 	if (!data->reset_gpio) {
-- 
2.30.0.284.gd98b1dd5eaa7-goog

