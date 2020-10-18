Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C312917A6
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 15:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgJRNrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 09:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbgJRNrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 09:47:45 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29F7C061755;
        Sun, 18 Oct 2020 06:47:44 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id h6so4408062pgk.4;
        Sun, 18 Oct 2020 06:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yITj8dBRv3eP6s3AyfeUdrvXg5i+GxFPHwm8RZEHOO4=;
        b=rM3pr12X746v1vIOK9QDqXttSIZ/dMOc3OTtp+397Zu3cQJG0VQd4BKvi2rDYM94vN
         SrQvNnlXb0aZUnNox/kB4aCnA+9PwI0aQch683c38FCO46FAk+xWkw7bWp6uGDj7JZ8c
         8wlCBUzGVOySCVAqGHTW7E6evkbXxDSAeoqxeQxLX+bhORLD019TH1bJhCUyUasAgRqz
         Q64BiMR3/G1tD8HRxKVK0/NoY5l9HT0irpGxdFsKCPZo0GtG2xPShc2bjWUJlfYqsuoM
         /+CfwlH8CSO1JPNpOn5H9WHhBrnA9i3ShwgyTxOLzXGWPEuoDVKhmBdh+Lu0BJrdrxV+
         vvdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yITj8dBRv3eP6s3AyfeUdrvXg5i+GxFPHwm8RZEHOO4=;
        b=ne15rntq+hANH2pekuEoLGUJKa0oNPv3XPAW7DHu3+2KFDeucBVF71YJNLTZOYT4P1
         GlRY9LQwIRRwd4Ut2U1F2nfKXPmShdAONBWHgdPfu/a7bSO70Ovv1X5G+C5vCoWd2phz
         xrJ5GddU/FZrHDTfFDm9/EbGoT7Md0mGAnfkzmZ5DCnV9O9T9i33RPoZi50sNBx01GoS
         BBwXpT356D5h3xukhnA4l1g8mt3XZAtwkaT9zB1vATCXtyWhOnIlEDJ4hDYYeutrjDIy
         8kvFzVAe9K/0E51Xahece/k17mXztyBgOZ4wz+PAgKfxd8UIkKR1t9ZVXJXvJjzl6SOW
         BcOg==
X-Gm-Message-State: AOAM530H2bRhSHzeyQxbbnBZr0PgPOOYh+cKpAeK9MO3lAIAhoP+CJnk
        XQz+6jSgLmj7tZDzZJRpsp8=
X-Google-Smtp-Source: ABdhPJzka8p1UURxATgAVhikDTB9qma4UG+5S5LaXOXMtfgGri2oh+7X/CWHrm3EtEB8URamSAfemA==
X-Received: by 2002:a63:1849:: with SMTP id 9mr10498295pgy.393.1603028864215;
        Sun, 18 Oct 2020 06:47:44 -0700 (PDT)
Received: from localhost ([204.124.180.191])
        by smtp.gmail.com with ESMTPSA id o2sm8428946pgg.3.2020.10.18.06.47.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 18 Oct 2020 06:47:43 -0700 (PDT)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Dejin Zheng <zhengdejin5@gmail.com>
Subject: [PATCH v1] usb: dwc3: core: fix a issue about clear connect state
Date:   Sun, 18 Oct 2020 21:47:34 +0800
Message-Id: <20201018134734.10406-1-zhengdejin5@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to Synopsys Programming Guide chapter 2.2 Register Resets,
it cannot reset the DCTL register by set DCTL.CSFTRST for Core Soft Reset,
if DWC3 controller as a slave device and stay connected with a usb host,
then, reboot linux, it will fail to reinitialize dwc3 as a slave device
when the DWC3 controller did not power off. because the connection status
is incorrect, so we also need clear DCTL.RUN_STOP bit for disable connect
when do core soft reset.

Fixes: f59dcab176293b6 ("usb: dwc3: core: improve reset sequence")
Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
---
 drivers/usb/dwc3/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 2eb34c8b4065..239636c454c2 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -256,6 +256,7 @@ static int dwc3_core_soft_reset(struct dwc3 *dwc)
 
 	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 	reg |= DWC3_DCTL_CSFTRST;
+	reg &= ~DWC3_DCTL_RUN_STOP;
 	dwc3_writel(dwc->regs, DWC3_DCTL, reg);
 
 	/*
-- 
2.25.0

