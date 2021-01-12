Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F35B12F29CC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 09:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404599AbhALINp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 03:13:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404521AbhALINo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 03:13:44 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71503C061794
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 00:13:04 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id i5so952839pgo.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 00:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vcxzFRC3QqajwKXtnr3rvlSJkzsApn1wGE9frhGONmw=;
        b=OMtpx1iBgoebcdpgyFngx+rFvAZPV3UlPMZ8+mDwIrm9vmkoZPigaoYI5f7xCgaFtl
         ZFOLQzCmfkmPv2NNtq5Qc86n9qA28IoR5EcgGiCGW3fEwUb4YgbqfIAwn8zjxAAVRgEZ
         +d1ake4m/7s7sk3G5Q5rUVQzCIKDeH4uM5yiiK2PEGtIaI4kbdGQjq8/DH06yVoRpGux
         /wBzhf64lRgw2r/9YzRsl+9AceBsVbLsKDSUpUcX5pS/CUCWSfn5IcSCb9BX8KAGk9d6
         z7qWqkZGCuwaRqTmFWxm06NHvSHD0IthKrHzxGvFpXJHKRwQjmxqsu0A4u6crCioGVwK
         BcwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vcxzFRC3QqajwKXtnr3rvlSJkzsApn1wGE9frhGONmw=;
        b=ARgdvlkmxBmTXJ+5519g9DZUajXi69H5vsEOzi5TmWU0gmRatflY3sDJBYnUHok34U
         +bCCaB2NUo91UPnl4we3jBvlKaVStfbdXs0b6icGDKFZhrpAyOP1eIkaRvXr9Muh0C3V
         s0xA36uba/RjJGcoruGY5FoHCbZ/kLbudwY0mdgIKg2kdwJrgryHf4AEbWIPIGW2s0+O
         OMwQekt894hbjmpmXOmsH68jmbwhBXLoKAdGfg/uX1VUxvJXONRXy+79JBpIppp1xv/t
         2p9luALzbdgEBc2ufaJxuUEZzKFrHdm7TdYprzj89MjROpKcAKPTOGwygIHzVn90ag0J
         Ha1A==
X-Gm-Message-State: AOAM532Zq+a5V8Ilmr8e4pH51cTe3q5M8iLEv6zgP9yNVFDsLGR9iX4b
        N/Ihx32G1mDbq3iQ9WINoRA=
X-Google-Smtp-Source: ABdhPJzODkjLmfPHA9H28EQj2qkm045cv/RwvIoFnC2ZEUdVTE0O7l/kJHA/rd1PopHEhJ3LfhDJPA==
X-Received: by 2002:a63:c64a:: with SMTP id x10mr3715467pgg.14.1610439184002;
        Tue, 12 Jan 2021 00:13:04 -0800 (PST)
Received: from varodek.localdomain ([106.215.30.102])
        by smtp.gmail.com with ESMTPSA id l2sm2152381pjz.27.2021.01.12.00.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 00:13:03 -0800 (PST)
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
Subject: [PATCH v2 2/3] sis-agp: use generic power management
Date:   Tue, 12 Jan 2021 13:39:23 +0530
Message-Id: <20210112080924.1038907-3-vaibhavgupta40@gmail.com>
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
 drivers/char/agp/sis-agp.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/drivers/char/agp/sis-agp.c b/drivers/char/agp/sis-agp.c
index 14909fc5d767..f8a02f4bef1b 100644
--- a/drivers/char/agp/sis-agp.c
+++ b/drivers/char/agp/sis-agp.c
@@ -217,26 +217,14 @@ static void agp_sis_remove(struct pci_dev *pdev)
 	agp_put_bridge(bridge);
 }
 
-#ifdef CONFIG_PM
+#define agp_sis_suspend NULL
 
-static int agp_sis_suspend(struct pci_dev *pdev, pm_message_t state)
+static int __maybe_unused agp_sis_resume(
+	__attribute__((unused)) struct device *dev)
 {
-	pci_save_state(pdev);
-	pci_set_power_state(pdev, pci_choose_state(pdev, state));
-
-	return 0;
-}
-
-static int agp_sis_resume(struct pci_dev *pdev)
-{
-	pci_set_power_state(pdev, PCI_D0);
-	pci_restore_state(pdev);
-
 	return sis_driver.configure();
 }
 
-#endif /* CONFIG_PM */
-
 static const struct pci_device_id agp_sis_pci_table[] = {
 	{
 		.class		= (PCI_CLASS_BRIDGE_HOST << 8),
@@ -419,15 +407,14 @@ static const struct pci_device_id agp_sis_pci_table[] = {
 
 MODULE_DEVICE_TABLE(pci, agp_sis_pci_table);
 
+static SIMPLE_DEV_PM_OPS(agp_sis_pm_ops, agp_sis_suspend, agp_sis_resume);
+
 static struct pci_driver agp_sis_pci_driver = {
 	.name		= "agpgart-sis",
 	.id_table	= agp_sis_pci_table,
 	.probe		= agp_sis_probe,
 	.remove		= agp_sis_remove,
-#ifdef CONFIG_PM
-	.suspend	= agp_sis_suspend,
-	.resume		= agp_sis_resume,
-#endif
+	.driver.pm      = &agp_sis_pm_ops,
 };
 
 static int __init agp_sis_init(void)
-- 
2.30.0

