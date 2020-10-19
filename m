Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0D2A29212A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 04:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730886AbgJSCeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 22:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728791AbgJSCeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 22:34:44 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9135AC061755;
        Sun, 18 Oct 2020 19:34:42 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t22so1274751plr.9;
        Sun, 18 Oct 2020 19:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YLHWIaul/DBFCQm+n/Gv9ezGO4oMICeIOh7ut+TCr4c=;
        b=oJTrVl+CfTRFU4ZbjUxGTkRrM2XLjDl0iZx7WqGIOL+Dqxt3t8hSw366RyeXtagEXA
         x0wcATwG7SMpUfG+PhnBsou0bAuH8Aq7Ib9Yjza5kY270Z3ymbV7J7EjeHM3FviKqrbn
         V4zKyhuTuaf3cBvuY8iD7I7IwRI+nyma1y1p/cJdNMx9qrLhgiymb8P2tM2T0jDmpQUo
         iok2Q9aqd1zebEKXhCq15bI8vw11b8rOp0xSCz9n1BV4qu9sekXDUrUp7Jdeiayoq5Sc
         hAuNy8+ThWKvuWQMT0XusutlJG70Dwfm/aK0ZLqfIuSfr6TGyVB2hqnGYuB1xrObUxu9
         iI4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YLHWIaul/DBFCQm+n/Gv9ezGO4oMICeIOh7ut+TCr4c=;
        b=bK+8pbuYxfaLCtPozearGi8QQCgd1bv5HVytLNlXi2OOfd7JrU1LsriiKjcPagFc14
         kS10LgdxbQ1PZ7l5aW8Y/K9JFFmiKsLgOuORpqNGfG/76mW3Y9sG+gGxYdVJIE/+14I4
         nidPom7sm7yF0pRw/CF9+6jfA6RE34odBmns/L0P0HP76TiQbHvJJZOqs1dMcVluecTW
         iLrIUeppoeyDZavC8yShKXMJMmP4JEJZ3JfSbxOQNDeij5QxwN7/D6tYMqLHg3lJN4eQ
         5MHdVaGu32ED7iZaGD7TjDztrWtLqxvAycN9yU0hbFj+OeGzchbWYpSAvjIfx2OnDmbu
         m18g==
X-Gm-Message-State: AOAM532WvCWw2oO54gGLHEwUWrAvXDgoq0neU2HvYz5aov40YCVt7hBv
        x5ZYUCwC3GKrFoPSwP3PPK3S/rqpVMc=
X-Google-Smtp-Source: ABdhPJwkQLUvo1Mio6U/nz6HjiljuWxjapaLQV/lLGljiZtwBo+CUaRqTiQlmblysiGKwiBWN3wgjA==
X-Received: by 2002:a17:90a:7089:: with SMTP id g9mr15488745pjk.4.1603074882130;
        Sun, 18 Oct 2020 19:34:42 -0700 (PDT)
Received: from localhost (23.83.240.116.16clouds.com. [23.83.240.116])
        by smtp.gmail.com with ESMTPSA id z5sm9816901pfn.20.2020.10.18.19.34.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 18 Oct 2020 19:34:41 -0700 (PDT)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        sergei.shtylyov@gmail.com, linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Dejin Zheng <zhengdejin5@gmail.com>
Subject: [PATCH v2] usb: dwc3: core: fix a issue about clear connect state
Date:   Mon, 19 Oct 2020 10:34:35 +0800
Message-Id: <20201019023435.5482-1-zhengdejin5@gmail.com>
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
bit for disabling connect when doing core soft reset.

Fixes: f59dcab176293b6 ("usb: dwc3: core: improve reset sequence")
Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
---
v1 -> v2:
	* modify some commit messages by Sergei's suggest, Thanks
	  very much for Sergei's help!

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

