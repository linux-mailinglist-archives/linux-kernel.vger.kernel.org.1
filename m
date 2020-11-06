Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B602A98A4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 16:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbgKFPjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 10:39:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbgKFPjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 10:39:51 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44ADAC0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 07:39:51 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id 33so1766542wrl.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 07:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=dHttO5/yXe+zE/4cXNc13Yjy23cOxk1sqyCBSDVq+3g=;
        b=uK62e2DxF8OgnyqYBVt7Q+L5l5lGR6ORzq2pC+Y4KGtNo8H27Y6pbH+6yicg/pTbcs
         NHgpPLNWOYWASU3CRTMP9ijnYPneoIsc84KlGNiSJu2Jg4pByEHkDAHu+xykYuqVNbFx
         K6NT5suBaa+NMGTQtlC0kqh/DPzDdt5XInQy3cV15MOJnzP30fhWrH+NmGf/+JA64UuE
         Os3hZREqEb6mNPr+7cowh5PJQLsN4Zap7FbykQlYEYFScHlthQcYZ2k4KVj0+J2btogk
         1CrfpYb+kOJFk4reXOKd5ryhLTNPuR0/uHjMkmbueS0cNCPt7BMVNodEv6FT0wYZOpuy
         dLJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dHttO5/yXe+zE/4cXNc13Yjy23cOxk1sqyCBSDVq+3g=;
        b=IeIi7AhLtfWjzEMwatjvk/lOnT8DfMFzpzMmznTt/91J99mrt0C/XRNccfwNzwDj2H
         R+oCkVl++8sg/09XuETeauqgnCVbO08zdtJaS+kKnQsReQiZAaF2EfGKm98Pr5izWo12
         Y8X3nyIhCMa6ZLMnoURLLho76wmwX/8uN33OAum7qvQertbGP8dUCu50ZHWThikfoypO
         3OnBZXLo/jFHTGp4jN3QNRnXjCDumGxuuLeqz0Qjc4w+dCSYHIIt+qE3Egs3Vtfuc+Fk
         luU8XreIGIUaFtGPBt/OkSiEQtxK0Mr7Rl4lVrBlefjXWC3UUB7swrRLn9zRudGe7WhD
         TCXw==
X-Gm-Message-State: AOAM533rsVB0Ks9p94SUNpFQPOw+VDd2gqp1Pp1mVPrKgR3XN5Evm6bt
        0CZvkxOdMy8RHi7M63N+/y0=
X-Google-Smtp-Source: ABdhPJxk+8+5r5VPDtQML9neWLWfMJgNT/HWaTQAhXXcppGzmOId7Hli2cTUXAjz1Mq6pcPeITOSpw==
X-Received: by 2002:adf:8bcc:: with SMTP id w12mr3616870wra.157.1604677189926;
        Fri, 06 Nov 2020 07:39:49 -0800 (PST)
Received: from localhost.localdomain (host-92-5-241-147.as43234.net. [92.5.241.147])
        by smtp.gmail.com with ESMTPSA id v189sm3095576wmg.14.2020.11.06.07.39.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Nov 2020 07:39:49 -0800 (PST)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] driver core: export device_is_bound() to fix build failure
Date:   Fri,  6 Nov 2020 15:37:44 +0000
Message-Id: <20201106153744.22661-1-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_MXC_CLK_SCU is configured as 'm' the build fails as it
is unable to find device_is_bound(). The error being:
ERROR: modpost: "device_is_bound" [drivers/clk/imx/clk-imx-scu.ko]
	undefined!

Export the symbol so that the module finds it.

Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---

 drivers/base/dd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 148e81969e04..a796a57e5efb 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -353,6 +353,7 @@ bool device_is_bound(struct device *dev)
 {
 	return dev->p && klist_node_attached(&dev->p->knode_driver);
 }
+EXPORT_SYMBOL(device_is_bound);
 
 static void driver_bound(struct device *dev)
 {
-- 
2.11.0

