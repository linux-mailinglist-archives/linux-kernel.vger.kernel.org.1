Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24AAB293DF7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 15:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407752AbgJTN6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 09:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407709AbgJTN6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 09:58:21 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69CDC061755;
        Tue, 20 Oct 2020 06:58:19 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id s22so1113961pga.9;
        Tue, 20 Oct 2020 06:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EmCwFwYFjJcvvPvj3xW9hTTGW6kw0jqSI7/0U5V6eHs=;
        b=cp5VAVaMHDGMFzM/Z+dznDq+aZrfTiTq49OJfy8GgMksWaU3P6Llj6OiGy2bZIbYdW
         8eaLvUGB0w5JhhCN26QOLvU4GadGhk6IyoEn7HZlzE/i49t0bC+L9hx5FxqGCM/5Sg2t
         IhxZNeotSS+4Ev0mTtg2anJe0otGP6zYFXX/BO5C1UDzbHU64ajM1ymfF6Uhq1n/gRE1
         oSzpyPIaxZfiAzjEsKnpxgWjQkivRm9f3RpyR4Gr9ss1qWtOLHssWoE6dqWB5Zr7IPWv
         ykOykdKB7EmuykNQ1lpN4/Jado+KMMxyRLgKpIp6qYtDHUsyCBrP7QwX6fHkV+H+Cnw9
         JANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EmCwFwYFjJcvvPvj3xW9hTTGW6kw0jqSI7/0U5V6eHs=;
        b=rnGy8WyCzyo6Tcl16qRWitwjCIL/Wd1IBWVkVK4qATKJDR8PmM5PfGIjU0yZ+YGK0B
         k9bhKH4dy+ZoG4JxCA5q4LrggWJicnIH21vKX/FETJ4fq1EM8xAXZkeEB2vj4U2Lerzm
         saTmvsrmM97ctRw+VyLJXzboj8IcYrPlfYRjvua1SwOKaZj/tZ1KFe34KFs7Nsiok79h
         gUC4Yora4fgRsPN23haY9XM6m7C0KGCqmJuSXxYTK9rSXIohzisZmjrfEgeOM73Q5bA0
         dD6gjp6UxilNCVKGoJDJk+H2QRH5y0jByyfXwLELxWpqXiKUiosgdY2CCP4WrWlaj0SN
         izyw==
X-Gm-Message-State: AOAM533EgKVeGG8Q7l7L8uRwBpPy1uKQyuDkkjtYNi2HanauDZZ0i0wO
        u/7sligEEsxAYy7D3UmfJqU=
X-Google-Smtp-Source: ABdhPJxJLo1PIJSDILFyteEqF3PzPkVvEcsif5St8OgZbwYJPZQMLcfSubH5aQF2F7L/IlLkObdQ6g==
X-Received: by 2002:a63:8c49:: with SMTP id q9mr2834921pgn.427.1603202299376;
        Tue, 20 Oct 2020 06:58:19 -0700 (PDT)
Received: from localhost (23.83.240.116.16clouds.com. [23.83.240.116])
        by smtp.gmail.com with ESMTPSA id s23sm2196668pgl.47.2020.10.20.06.58.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Oct 2020 06:58:18 -0700 (PDT)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Dejin Zheng <zhengdejin5@gmail.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH v3] usb: dwc3: core: fix a issue about clear connect state
Date:   Tue, 20 Oct 2020 21:58:06 +0800
Message-Id: <20201020135806.30268-1-zhengdejin5@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to Synopsys Programming Guide chapter 2.2 Register Resets,
it cannot reset the DCTL register by setting DCTL.CSFTRST for core soft
reset, if DWC3 controller as a slave device and stay connected with a usb
host, then, while rebooting linux, it will fail to reinitialize dwc3 as a
slave device when the DWC3 controller did not power off. because the
connection status is incorrect, so we also need to clear DCTL.RUN_STOP
bit for disabling connect when doing core soft reset. There will still
be other stale configuration in DCTL, so reset the other fields of DCTL
to the default value 0.

Fixes: f59dcab176293b6 ("usb: dwc3: core: improve reset sequence")
Suggested-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
---
v2 -> v3:
	* Reset all fields of DCTL register by Thinh's suggest,
	  Thanks for Thinh's help!
v1 -> v2:
	* modify some commit messages by Sergei's suggest, Thanks
	  very much for Sergei's help!

 drivers/usb/dwc3/core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 2eb34c8b4065..86375cfd9481 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -254,9 +254,7 @@ static int dwc3_core_soft_reset(struct dwc3 *dwc)
 	if (dwc->current_dr_role == DWC3_GCTL_PRTCAP_HOST)
 		return 0;
 
-	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
-	reg |= DWC3_DCTL_CSFTRST;
-	dwc3_writel(dwc->regs, DWC3_DCTL, reg);
+	dwc3_writel(dwc->regs, DWC3_DCTL, DWC3_DCTL_CSFTRST);
 
 	/*
 	 * For DWC_usb31 controller 1.90a and later, the DCTL.CSFRST bit
-- 
2.25.0

