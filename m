Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 670DC2F29CA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 09:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404508AbhALINk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 03:13:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392259AbhALINj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 03:13:39 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63069C061786
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 00:12:59 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id m5so1167734pjv.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 00:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m+5AY09mfGyaAgyXWDCF4dcfRL6QuYPJBXH3t6/wgY4=;
        b=tgoWzJQEWSCrjTpWAuH+eOFGUIx0zm8xNscUoWzeut2TGtSyxXnZLizlperYZgt8D2
         LiqVZWsBCBZtA1hE2qf9EoEGSNBQxGaizlDTweAFYpG+8eIaCdhNlF/iTzZjsAUAaAqm
         4u7iCrCBPbV/1llWf97rBO0MCgvvMJNf1H8Cetl3kwVG/vU3HB+Aj31KMnb6/DuZKUZQ
         6X6dtrS0Jxa35L5aJGTlF+w5FzUgTCdT/ttRwEopMrB8k9vyqdCZdhN/FVcc39PUhgGM
         QLsPeCw6/WUfY2vXq2ird3hRJDUFb1JZ+oDvmKyT7dwMo5gTwUQrUPQJsGNC4yECz6wF
         BBUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m+5AY09mfGyaAgyXWDCF4dcfRL6QuYPJBXH3t6/wgY4=;
        b=a+YZwTQbzX3eWwDo8J+wkVBVwr6yzDhGcrFHBjntBwlUDTaiJE7Bsk430emCCL4Qzx
         usVpgKFp3vgjOVWvKPuaUwbzgGJiWjKDGudxTGFhnJVovX35zxa/meimnvSSRNbDSgZk
         i/qkFVHlvqlez2ckeuBIZHLX6hh7qAbW2qwlNSeqrxBUqKvq0X4PLficH5IQduGWSBg+
         ic7U4GsMl3ySRy8gDm+kHEzY/KAJIHsH9WI4ByIQQNhd7ksIZ6OXwO9JJ86qNjp7oUP9
         j0ozGb9SM9wMabyGSdWa7kZxWgm0rDBtyayVhfhmShjp2lqmawMlnwlFuPCn6/s8INiR
         EeeQ==
X-Gm-Message-State: AOAM533j8rPq/DasMiD2fr/POa/cFLSgTPLxaL0qU+BG2Uo8uc9cFSKp
        7ETzORfu7j8gCpk4j2CG6LQ=
X-Google-Smtp-Source: ABdhPJz+kOsfexRaeZVC+/bOVCCXJVkFRicDzfL/dEPH8TbaccLDVNeWfxZoAfb4dOkfjxZXvsuBBg==
X-Received: by 2002:a17:902:d694:b029:dc:9820:12fb with SMTP id v20-20020a170902d694b02900dc982012fbmr3643095ply.19.1610439178993;
        Tue, 12 Jan 2021 00:12:58 -0800 (PST)
Received: from varodek.localdomain ([106.215.30.102])
        by smtp.gmail.com with ESMTPSA id l2sm2152381pjz.27.2021.01.12.00.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 00:12:58 -0800 (PST)
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
Subject: [PATCH v2 1/3] amd64-agp: use generic power management
Date:   Tue, 12 Jan 2021 13:39:22 +0530
Message-Id: <20210112080924.1038907-2-vaibhavgupta40@gmail.com>
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
 drivers/char/agp/amd64-agp.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/char/agp/amd64-agp.c b/drivers/char/agp/amd64-agp.c
index b40edae32817..dc78a4fb879e 100644
--- a/drivers/char/agp/amd64-agp.c
+++ b/drivers/char/agp/amd64-agp.c
@@ -588,20 +588,11 @@ static void agp_amd64_remove(struct pci_dev *pdev)
 	agp_bridges_found--;
 }
 
-#ifdef CONFIG_PM
+#define agp_amd64_suspend NULL
 
-static int agp_amd64_suspend(struct pci_dev *pdev, pm_message_t state)
+static int __maybe_unused agp_amd64_resume(struct device *dev)
 {
-	pci_save_state(pdev);
-	pci_set_power_state(pdev, pci_choose_state(pdev, state));
-
-	return 0;
-}
-
-static int agp_amd64_resume(struct pci_dev *pdev)
-{
-	pci_set_power_state(pdev, PCI_D0);
-	pci_restore_state(pdev);
+	struct pci_dev *pdev = to_pci_dev(dev);
 
 	if (pdev->vendor == PCI_VENDOR_ID_NVIDIA)
 		nforce3_agp_init(pdev);
@@ -609,8 +600,6 @@ static int agp_amd64_resume(struct pci_dev *pdev)
 	return amd_8151_configure();
 }
 
-#endif /* CONFIG_PM */
-
 static const struct pci_device_id agp_amd64_pci_table[] = {
 	{
 	.class		= (PCI_CLASS_BRIDGE_HOST << 8),
@@ -738,15 +727,14 @@ static const struct pci_device_id agp_amd64_pci_promisc_table[] = {
 	{ }
 };
 
+static SIMPLE_DEV_PM_OPS(agp_amd64_pm_ops, agp_amd64_suspend, agp_amd64_resume);
+
 static struct pci_driver agp_amd64_pci_driver = {
 	.name		= "agpgart-amd64",
 	.id_table	= agp_amd64_pci_table,
 	.probe		= agp_amd64_probe,
 	.remove		= agp_amd64_remove,
-#ifdef CONFIG_PM
-	.suspend	= agp_amd64_suspend,
-	.resume		= agp_amd64_resume,
-#endif
+	.driver.pm  = &agp_amd64_pm_ops,
 };
 
 
-- 
2.30.0

