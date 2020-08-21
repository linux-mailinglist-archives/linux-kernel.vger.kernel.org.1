Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08CA524CF37
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 09:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbgHUHXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 03:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728037AbgHUHQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 03:16:58 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344ADC061349
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 00:16:57 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id r2so995074wrs.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 00:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FczcR0ercDVomHQV+kYc66obKABVvqRvMsKpTYbOb2Y=;
        b=e0hXyqDlAAZ9jrSp0+sgcKZDbu6p3FBSXUaKZ6W+P9XOdw2nqYDzx952fChZnmGG91
         5+4qSQjtdLEMnOGgBECLn3s4SgE6TSGzzOBzw/bpfavLGVuTKKn+0jz8o2m7/Irjr/sx
         eYVjc3yKv9lWL99bA4znqsAheZKVhHJjZBZVMBJ9Sj1N3lfpSZMYPpINV+iJsgwnmVXS
         i3y8uVNt+iW7Akx5GXHpu4Tu4KnPCGYzlTyhkxVXEs6kLGaTwQEv9ZXz3/2F7P2OHwvy
         QimHNTb44nMbCeIyswq1Z7MXUPsBumZmemzb5Hae9i2zwh2dUzbIbhmxAtO5dUPwDnRt
         UAbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FczcR0ercDVomHQV+kYc66obKABVvqRvMsKpTYbOb2Y=;
        b=Fz9rxNk/rSPSvlWRfDmAdQUmBe7mUMc477y5HBf/KhYphCHxeJfO+bKUdZmRBdgG8U
         kWaDRZz0berISbp5GbTxvlmoQWIZaCZaExKcYxRYVl9uUnr7G5cwlBe/+p7yPB/y+k+n
         u7eEMV9Hneys9k59IkB+ZaiscbFA2rzCv5nMtEECoy7wVifFb/vcLpq+T1c5HnTR4qGu
         bE3asIx2gUM2pLtkOvjuGDttNFF+5sX+TTNN0sx+25zmvGJghPXXCSEKIW2lQo3N6M3U
         vR3kNoYtSxUx3YnGN2xBXYPvrcqsB4DHwsRO65fWH7Be+DOftctazLlEaxqS1qity+og
         tWPA==
X-Gm-Message-State: AOAM531i0xtbMB+ZOxDQnoeawUBIA6nPD5Wa5bBdXmHf/WeMHoMXG12T
        DpcVpO/Cs/xm3WX5FA0lY9wyh9yM57roZw==
X-Google-Smtp-Source: ABdhPJy3djGQTGa6RdmcN+ZodCOU6sEYPtl+YXW+C/GDR/ex5sdGuOEKhjfrWHWRXtavynqHSdfFpw==
X-Received: by 2002:adf:de8d:: with SMTP id w13mr1359898wrl.129.1597994215916;
        Fri, 21 Aug 2020 00:16:55 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id y24sm2667957wmi.17.2020.08.21.00.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 00:16:55 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Siva Rebbagondla <siva8118@gmail.com>
Subject: [PATCH 06/32] wireless: rsi: rsi_91x_mgmt: Add descriptions for rsi_set_vap_capabilities()'s parameters
Date:   Fri, 21 Aug 2020 08:16:18 +0100
Message-Id: <20200821071644.109970-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821071644.109970-1-lee.jones@linaro.org>
References: <20200821071644.109970-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/rsi/rsi_91x_mgmt.c:713: warning: Function parameter or member 'mac_addr' not described in 'rsi_set_vap_capabilities'
 drivers/net/wireless/rsi/rsi_91x_mgmt.c:713: warning: Function parameter or member 'vap_id' not described in 'rsi_set_vap_capabilities'
 drivers/net/wireless/rsi/rsi_91x_mgmt.c:713: warning: Function parameter or member 'vap_status' not described in 'rsi_set_vap_capabilities'

Cc: Amitkumar Karwar <amitkarwar@gmail.com>
Cc: Siva Rebbagondla <siva8118@gmail.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/rsi/rsi_91x_mgmt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/rsi/rsi_91x_mgmt.c b/drivers/net/wireless/rsi/rsi_91x_mgmt.c
index c331084bdc170..33c76d39a8e96 100644
--- a/drivers/net/wireless/rsi/rsi_91x_mgmt.c
+++ b/drivers/net/wireless/rsi/rsi_91x_mgmt.c
@@ -702,6 +702,9 @@ static int rsi_program_bb_rf(struct rsi_common *common)
  * rsi_set_vap_capabilities() - This function send vap capability to firmware.
  * @common: Pointer to the driver private structure.
  * @mode: Operating mode of device.
+ * @mac_addr: MAC address
+ * @vap_id: Rate information - offset and mask
+ * @vap_status: VAP status - ADD, DELETE or UPDATE
  *
  * Return: 0 on success, corresponding negative error code on failure.
  */
-- 
2.25.1

