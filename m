Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 731022D4B6F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 21:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388319AbgLIUQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 15:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388286AbgLIUQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 15:16:20 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C34C0613CF;
        Wed,  9 Dec 2020 12:15:39 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id g20so713460plo.2;
        Wed, 09 Dec 2020 12:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8mYMzOF+p91eY75PR2FP5hB0zHJG8fpKiiHoI3m1zEc=;
        b=Ydy6mAnREKb5hsjfwtUusvjv3OCpw3rO9Xlfks9u6li/gLFNeH24Nn5PORcnn2PBJx
         xPfTNT2oNJoWTnnk404V6iXd5NiOiIBlj26MYfjrcdCEB/aVKZFy6ibSfu7A7e9cWSST
         hqGv9tjoxCd+V5egNcyXEuhhXIxc7ADQVbglxPTaf0+niEBUm5bUJz4bIGKv/75YR3AQ
         876uadMvbaPBzRsOAJbMfCr2zw8poqP/b1uann26n8j8uNBWXAKX63WPPVstHL883t1w
         TeWkouL8xNArASaYl7YokKCJS/YwgaaG/JqAUYy/j1ptv1GBdfxTxZY7W/Tsh9WjKccn
         1bqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8mYMzOF+p91eY75PR2FP5hB0zHJG8fpKiiHoI3m1zEc=;
        b=NPSD8cXJcLEWT8luuUvBhWJMSdlx9M8NJwwoCpna2XYjOL+ZrI2atM5A+xxQJFVFeE
         VWmGzsWYfW/dIl2Te3r2zJKtGia13T0wQYZzIm+t+5VVeBp5rVDEipia9UJ3/SBbwj4g
         EOoC+23kC4pRUfiqivJ9HuF0sJiFyq4d9Ab7nvWN312eNOaZQ0TTqNCoInL+MIyurRXY
         VvJtq9q852+ltzzbDJaF0soOUpBQ5vvv0enJJLMw7qXw8BSUHomvVvHBmC65HZNJ+4wX
         fSRX0bQ/7HXGMFb6JfD5L+bG9NIA6S50tUDwHa9h8OjkfYJ+8+msCUZiFPAUJHIR9ffL
         3pnQ==
X-Gm-Message-State: AOAM532Y92BSFJp95Ue4t7eud+k/drfRbAqLL1ls9uGkAjDVICjRb0fS
        vGcWN3G7Gio3G6oE7oh3QEo=
X-Google-Smtp-Source: ABdhPJxfm5yGwfiLc6IMz4xQk9KqHt2nQFBHOr6evDYkHw92MavECtkCyTtelC7rI1ccgeppv8rKtg==
X-Received: by 2002:a17:902:c40c:b029:da:74c9:df4f with SMTP id k12-20020a170902c40cb02900da74c9df4fmr3489151plk.68.1607544939428;
        Wed, 09 Dec 2020 12:15:39 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC.domain.name ([122.179.87.107])
        by smtp.gmail.com with ESMTPSA id p21sm3277814pfn.15.2020.12.09.12.15.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Dec 2020 12:15:38 -0800 (PST)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     pawell@cadence.com, peter.chen@nxp.com, rogerq@ti.com,
        a-govindraju@ti.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>
Subject: [PATCH] usb: cdns3: Fixed kernel test robot warning
Date:   Thu, 10 Dec 2020 01:45:52 +0530
Message-Id: <1607544952-4891-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel test robot throws below warning ->

In file included from drivers/usb/cdns3/core.c:23:
>> drivers/usb/cdns3/host-export.h:27:51: warning: 'struct usb_hcd'
>> declared inside parameter list will not be visible outside of this
>> definition or declaration
      27 | static inline int xhci_cdns3_suspend_quirk(struct usb_hcd
*hcd)
         |                                                   ^~~~~~~

This patch will silence it.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/usb/cdns3/host-export.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/cdns3/host-export.h b/drivers/usb/cdns3/host-export.h
index fb8541b..c1259af 100644
--- a/drivers/usb/cdns3/host-export.h
+++ b/drivers/usb/cdns3/host-export.h
@@ -24,7 +24,7 @@ static inline int cdns_host_init(struct cdns *cdns)
 }
 
 static inline void cdns_host_exit(struct cdns *cdns) { }
-static inline int xhci_cdns3_suspend_quirk(struct usb_hcd *hcd)
+static int xhci_cdns3_suspend_quirk(struct usb_hcd *hcd)
 {
 	return 0;
 }
-- 
1.9.1

