Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8D72F29CD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 09:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404671AbhALINy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 03:13:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404521AbhALINw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 03:13:52 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72680C061795
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 00:13:12 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id c22so910847pgg.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 00:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2HTIY82uemgwmbK0pP0s2dMMVpv9lSP3ccVzRYJgtA4=;
        b=L2A+459rpaVdfcKuOSTA/XmFKoSF2tSXbK0zhsphbh6quPoW9lkAAUYl3+EMX3jIfv
         DR/jqNoDrKAr9tu+XjJv92gJVH56BblFHKfdwBUCRO6V5lgmTAJfDk38i7zIeYlsW1eY
         fbxpdALhTGmEfAM0SAiyK3pj9cjW/pZnO0z5F4PI1CIMHp0uVbu9V1mTOwtx68Jr3rpf
         lOGEwzd9m3oQSG6VK40W+d0u2JvsmuYBpFYHJMGwt9e1WZ1rHJfPhoZRvgReQbSWyF2c
         NLsZXsAjwTp4xw9y6WquRQozczmtJyliqKyLKP7SikojAJ9JN6pvSmeUxLrc1kIrMRTQ
         trkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2HTIY82uemgwmbK0pP0s2dMMVpv9lSP3ccVzRYJgtA4=;
        b=qyTUoS8QhPSguEYKViL7WTPNksX2ZM8/09fEmhdXMUe7D388BAGU9JaQD1l21oFqej
         q03xuyijvzfOIxYXJG7Q9+NEPBZ+2bxr7f+5rmQKUh+b77ADq4vH3f8x9pQ5J2h6SuHm
         g8tvUmQFufNIX085wOI0YhMBvZU4lV7We1quVh8C0QawSzoAS/Dr0M34OpCWCtFTyx6H
         KSy9xf5H+7lubVPNDJbwqdVIu7OlTT+ZnX5aQrPYVUisU2miFEDEvx3MYW05NUhP43Wy
         DdcB2wKXUTcokQIoJOSl5g/jQ8tSWNlwvH+AoGAiFGjhIZF8TmLnCx95lkMi61kmEmIX
         jdpg==
X-Gm-Message-State: AOAM5312fyYVtnjCRovbw1ZHdT5EygUwMU/i0ODaMu9k5GGSdpAQ9/lT
        v+62C9RT4/ATnB3p3jbujk8=
X-Google-Smtp-Source: ABdhPJx6Hy/0wT6mZyfoCbIwRo/k5Z3PbU8MR4JZ1BFD3QJkvOM9DMExTYTl5vYUQhesr/P/xi7K1w==
X-Received: by 2002:aa7:9ab7:0:b029:19d:ac89:39aa with SMTP id x23-20020aa79ab70000b029019dac8939aamr3662822pfi.10.1610439191884;
        Tue, 12 Jan 2021 00:13:11 -0800 (PST)
Received: from varodek.localdomain ([106.215.30.102])
        by smtp.gmail.com with ESMTPSA id l2sm2152381pjz.27.2021.01.12.00.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 00:13:11 -0800 (PST)
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        David Airlie <airlied@linux.ie>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v2 3/3] via-agp: use generic power management
Date:   Tue, 12 Jan 2021 13:39:24 +0530
Message-Id: <20210112080924.1038907-4-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210112080924.1038907-1-vaibhavgupta40@gmail.com>
References: <20200717074937.296192-1-vaibhavgupta40@gmail.com>
 <20210112080924.1038907-1-vaibhavgupta40@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drivers should do only device-specific jobs. But in general, drivers using
legacy PCI PM framework for .suspend()/.resume() have to manage many PCI
PM-related tasks themselves which can be done by PCI Core itself. This
brings extra load on the driver and it directly calls PCI helper functions
to handle them.

Switch to the new generic framework by updating function signatures and
define a "struct dev_pm_ops" variable to bind PM callbacks. Also, remove
unnecessary calls to the PCI Helper functions along with the legacy
.suspend & .resume bindings.

After upgrading, .suspend() became an empty-body function, hence defined as
NULL.

Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
---
 drivers/char/agp/via-agp.c | 25 +++++--------------------
 1 file changed, 5 insertions(+), 20 deletions(-)

diff --git a/drivers/char/agp/via-agp.c b/drivers/char/agp/via-agp.c
index 87a92a044570..a460ae352772 100644
--- a/drivers/char/agp/via-agp.c
+++ b/drivers/char/agp/via-agp.c
@@ -492,22 +492,11 @@ static void agp_via_remove(struct pci_dev *pdev)
 	agp_put_bridge(bridge);
 }
 
-#ifdef CONFIG_PM
+#define agp_via_suspend NULL
 
-static int agp_via_suspend(struct pci_dev *pdev, pm_message_t state)
+static int __maybe_unused agp_via_resume(struct device *dev)
 {
-	pci_save_state (pdev);
-	pci_set_power_state (pdev, PCI_D3hot);
-
-	return 0;
-}
-
-static int agp_via_resume(struct pci_dev *pdev)
-{
-	struct agp_bridge_data *bridge = pci_get_drvdata(pdev);
-
-	pci_set_power_state (pdev, PCI_D0);
-	pci_restore_state(pdev);
+	struct agp_bridge_data *bridge = dev_get_drvdata(dev);
 
 	if (bridge->driver == &via_agp3_driver)
 		return via_configure_agp3();
@@ -517,8 +506,6 @@ static int agp_via_resume(struct pci_dev *pdev)
 	return 0;
 }
 
-#endif /* CONFIG_PM */
-
 /* must be the same order as name table above */
 static const struct pci_device_id agp_via_pci_table[] = {
 #define ID(x) \
@@ -567,16 +554,14 @@ static const struct pci_device_id agp_via_pci_table[] = {
 
 MODULE_DEVICE_TABLE(pci, agp_via_pci_table);
 
+static SIMPLE_DEV_PM_OPS(agp_via_pm_ops, agp_via_suspend, agp_via_resume);
 
 static struct pci_driver agp_via_pci_driver = {
 	.name		= "agpgart-via",
 	.id_table	= agp_via_pci_table,
 	.probe		= agp_via_probe,
 	.remove		= agp_via_remove,
-#ifdef CONFIG_PM
-	.suspend	= agp_via_suspend,
-	.resume		= agp_via_resume,
-#endif
+	.driver.pm      = &agp_via_pm_ops,
 };
 
 
-- 
2.30.0

