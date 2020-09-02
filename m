Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71A9925B45B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 21:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbgIBTWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 15:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgIBTWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 15:22:07 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39236C061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 12:22:07 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id g14so161888iom.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 12:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WsMM23fn71eKtIwvzR7uEW5lI14ipQ/sjn3Hdadfad4=;
        b=VD8sSYZPzVO/xnzOqXO3FKH5QMNwpBZiVzmbCrT/mim/hq8cMZykVXvmdMacMiEaUw
         Hf5H7SfbmuuF1CCSJuyV2HnRObJhimWfEgFu3Z2MREZPZ9ucZ8OZ1f5OFFsnUw2vSbph
         QkkiJ0t/iqodrOqggN4mIcp3Zl2aEwb65mjAh+zf9mXjMP6Z0q0+Y8OMJ0rbWs2/oox+
         /f+ddVkNCb2b7PvId+NO0CPFaK3BbX7IB1T6uBQEy5NpMPdAGDL3dfwDV9vfZJo8WNEr
         tjVIqOVcAe7eYGqxuqgJEP8Mx+VR9pH4cGFrVWwarA0pWULSi4hXuQ9O2ZAqe4V7ortw
         268Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WsMM23fn71eKtIwvzR7uEW5lI14ipQ/sjn3Hdadfad4=;
        b=FQ/8Kvbe2vES7iOqHsPt6ZfuhZnW/HzMzHezZ4h3yHDCNKIIcaNeJbuUkR8FY4joEc
         2+YRkr9PXFSyGHzntyz197pmv4v/GC2nJoTKVtPksfNDdCKIw0tV1QSyJUdISfpTQ7YA
         Zg0pQxSy4MQBeOJaDB9pA6qJrYu6a9kG2Ece9/WIuGYhKW6/XBG2CER6/EtxOTsfg+uR
         Z4k4LrsmILSWO/ie10OL6+YHnquhy4yX+asStve0vcK0+OOu68t15a9cdIZfqo/KSIUv
         ZMhaklu+PxmdtDCKhr/RYcpugp8e3qP0OPsGJEr0pbvnDsCstpOeUgvc30ovfPaCV77P
         PLHw==
X-Gm-Message-State: AOAM530I2fR+8ECWL9fSG/LOWuov3UHqhl3fnHLoELRChNkY6K6boy4Z
        algkBuwmb430LbiyoXCr13k=
X-Google-Smtp-Source: ABdhPJy/EjZvYbeVgZmH1VKO9FUSqIczM0zF9aIIuGasrMVS6Dg30Icb6MlD2djkEtJU/rS1rUv4dw==
X-Received: by 2002:a02:7055:: with SMTP id f82mr4757922jac.54.1599074526537;
        Wed, 02 Sep 2020 12:22:06 -0700 (PDT)
Received: from localhost.localdomain (c-73-242-81-227.hsd1.mn.comcast.net. [73.242.81.227])
        by smtp.gmail.com with ESMTPSA id z1sm243838ilk.5.2020.09.02.12.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 12:22:06 -0700 (PDT)
From:   Ross Schmidt <ross.schm.dev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ross Schmidt <ross.schm.dev@gmail.com>
Subject: [PATCH] staging: rtl8723bs: os_dep: added blank line to fix coding style issue
Date:   Wed,  2 Sep 2020 14:20:44 -0500
Message-Id: <20200902192044.19143-1-ross.schm.dev@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a coding style issue by adding a blank line after declarations in
sdio_intf.c to fix a checkpatch warning.

Signed-off-by: Ross Schmidt <ross.schm.dev@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
index f1e2829a19a7..79b55ec827a4 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
@@ -131,6 +131,7 @@ static irqreturn_t gpio_hostwakeup_irq_thread(int irq, void *data)
 static u8 gpio_hostwakeup_alloc_irq(struct adapter *padapter)
 {
 	int err;
+
 	if (oob_irq == 0) {
 		DBG_871X("oob_irq ZERO!\n");
 		return _FAIL;
-- 
2.26.2

