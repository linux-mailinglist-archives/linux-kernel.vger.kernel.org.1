Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57EB421360C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 10:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgGCIQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 04:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbgGCIQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 04:16:21 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D096DC08C5C1;
        Fri,  3 Jul 2020 01:16:21 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 207so13501120pfu.3;
        Fri, 03 Jul 2020 01:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0qtaTWQIP7dT5z9HWnjECNBJhXaUERqbuK7Vo/b0CWQ=;
        b=MF4zU2YEmROsvNrm4lWaYlMCo4mPgxRc11U0WhecZifXOEmf3jvGJ1wErk1/YmKE++
         rxrk0Nlj5zKNy5J+ZOFPRWzKW/NZFgR5sLPFclN66wfwuVGXasVttowWxkHAJROl30K1
         pdzHKJDRSiDIat8raAVwNne6fs8t3sZxqELi+dLnZC2+e5w366DZ3KIMfdXP7irz+9AB
         e0bM/MUhi+0PcI/axeHCDF7E53Dg9R2CFzZgwJLbVHYlRZmM8/Mk8QR0sb8RgVMuFFrS
         YtW7tmAv5o77Hx8TIIKfLW52N1ut8HHFZNXX9QbDaVrZxG0Vx8KxS6w3Yf25dH2/DMd5
         3bFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0qtaTWQIP7dT5z9HWnjECNBJhXaUERqbuK7Vo/b0CWQ=;
        b=le+gmbGLtozQL+0XTvOl3M+nKmtc/WAE3EBn+6F0PC5iGQ5olThY07ThtFcFGCz1Fn
         R08vYQn/UCzQ940JIci/xr5v/o1g7x5CUuQlDedhbuNZ7IpRtXdBs71VVjwqO5Acfgzj
         l6Y7X1ymyC+fq1sBMq8RBOfYz3e3Fe0/8HAKu7q4kPrGq99h0l7Z2JUyqshRyf1zBIY5
         ls8WKIGju+e95B4yYSLni/scpiTSDEaeRj+jHkfqhWOm7b+m8SpFLdEC+BkjxwqRJdrU
         JgcOnQRw7930RUr7PDbJHa+9pVGAl52CmB0zxvICzbvVgiltudq0VWPBq/1BKLezZxmM
         E/sw==
X-Gm-Message-State: AOAM5301ii1yLS8AOZdH9UD5R8zwKsDOgh6aP2MAYgfOuIRrCzlrFPts
        1OjXLcd3VjPOPrDm1m9gWbjB2ll/gHxD2g==
X-Google-Smtp-Source: ABdhPJzjsbg1fNPq6kvaZGRneGCRIz5Fbt7AmrOTnEAMypaUf+GUuCNdQuM5L4e/3SL5A0hFAwfMuQ==
X-Received: by 2002:aa7:8283:: with SMTP id s3mr32726325pfm.90.1593764181123;
        Fri, 03 Jul 2020 01:16:21 -0700 (PDT)
Received: from varodek.iballbatonwifi.com ([103.105.153.57])
        by smtp.gmail.com with ESMTPSA id y198sm8437085pfg.116.2020.07.03.01.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 01:16:20 -0700 (PDT)
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, bjorn@helgaas.com,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-ide@vger.kernel.org
Subject: [PATCH v2 1/4] ide: use generic power management
Date:   Fri,  3 Jul 2020 13:44:25 +0530
Message-Id: <20200703081428.1011527-2-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200703081428.1011527-1-vaibhavgupta40@gmail.com>
References: <20200703081428.1011527-1-vaibhavgupta40@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Earlier, drivers had to manage the device's power states, and related
operations, themselves. With the generic approach, these are done by PCI
core.

The ide_pci_suspend() and ide_pci_resume(), declared in
include/linux/ide.h and defined in drivers/ide/setup-pci.c, were external
and were exported. Those were then used by other source files.

Now, as they have to bind with dev_pm_ops object, there is no need to
export them and they can be made static.

Declare an extern const dev_pm_ops object in include/linux/ide.h and define
it in drivers/ide/setup-pci.c with SIMPLE_DEV_PM_OPS macro, binding
suspend, and resume callbacks with it. This object can now be used by other
source files.

The following source files are binding same dev_pm_ops object in their PM:
    drivers/ide/aec62xx.c
    drivers/ide/alim15x3.c
    drivers/ide/amd74xx.c
    drivers/ide/atiixp.c
    drivers/ide/cmd64x.c
    drivers/ide/cs5520.c
    drivers/ide/cs5530.c
    drivers/ide/cs5535.c
    drivers/ide/cs5536.c
    drivers/ide/cy82c693.c
    drivers/ide/hpt366.c
    drivers/ide/ide-pci-generic.c
    drivers/ide/it8172.c
    drivers/ide/it8213.c
    drivers/ide/it821x.c
    drivers/ide/jmicron.c
    drivers/ide/ns87415.c
    drivers/ide/opti621.c
    drivers/ide/pdc202xx_new.c
    drivers/ide/pdc202xx_old.c
    drivers/ide/piix.c
    drivers/ide/serverworks.c
    drivers/ide/setup-pci.c
    drivers/ide/siimage.c
    drivers/ide/sis5513.c
    drivers/ide/sl82c105.c
    drivers/ide/slc90e66.c
    drivers/ide/via82cxxx.c
    include/linux/ide.h

The drivers/ide/triflex.c driver was also using ide_pci_resume() callback
but it had its own definition for .suspend() as it does not want to power
off the device during suspend. Hence, it was excluded from generic pm
upgrade and was provided a static triflex_ide_pci_resume() with definition
same as of ide_pci_resume() to prevent it from breaking. A PCI quirk is
needed while upgrading it for generic PM support.

Compile-tested only.

Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
---
 drivers/ide/aec62xx.c         |  3 +--
 drivers/ide/alim15x3.c        |  3 +--
 drivers/ide/amd74xx.c         |  3 +--
 drivers/ide/atiixp.c          |  3 +--
 drivers/ide/cmd64x.c          |  3 +--
 drivers/ide/cs5520.c          |  3 +--
 drivers/ide/cs5530.c          |  3 +--
 drivers/ide/cs5535.c          |  3 +--
 drivers/ide/cs5536.c          |  3 +--
 drivers/ide/cy82c693.c        |  3 +--
 drivers/ide/hpt366.c          |  3 +--
 drivers/ide/ide-pci-generic.c |  3 +--
 drivers/ide/it8172.c          |  3 +--
 drivers/ide/it8213.c          |  3 +--
 drivers/ide/it821x.c          |  3 +--
 drivers/ide/jmicron.c         |  3 +--
 drivers/ide/ns87415.c         |  3 +--
 drivers/ide/opti621.c         |  3 +--
 drivers/ide/pdc202xx_new.c    |  3 +--
 drivers/ide/pdc202xx_old.c    |  3 +--
 drivers/ide/piix.c            |  3 +--
 drivers/ide/serverworks.c     |  3 +--
 drivers/ide/setup-pci.c       | 29 ++++++-----------------------
 drivers/ide/siimage.c         |  3 +--
 drivers/ide/sis5513.c         |  3 +--
 drivers/ide/sl82c105.c        |  3 +--
 drivers/ide/slc90e66.c        |  3 +--
 drivers/ide/triflex.c         | 23 ++++++++++++++++++++++-
 drivers/ide/via82cxxx.c       |  3 +--
 include/linux/ide.h           |  8 +-------
 30 files changed, 56 insertions(+), 85 deletions(-)

diff --git a/drivers/ide/aec62xx.c b/drivers/ide/aec62xx.c
index 4c959ce41ba9..375c7b4946f1 100644
--- a/drivers/ide/aec62xx.c
+++ b/drivers/ide/aec62xx.c
@@ -309,8 +309,7 @@ static struct pci_driver aec62xx_pci_driver = {
 	.id_table	= aec62xx_pci_tbl,
 	.probe		= aec62xx_init_one,
 	.remove		= aec62xx_remove,
-	.suspend	= ide_pci_suspend,
-	.resume		= ide_pci_resume,
+	.driver.pm	= &ide_pci_pm_ops,
 };
 
 static int __init aec62xx_ide_init(void)
diff --git a/drivers/ide/alim15x3.c b/drivers/ide/alim15x3.c
index 3265970aee34..a5043e048f91 100644
--- a/drivers/ide/alim15x3.c
+++ b/drivers/ide/alim15x3.c
@@ -580,8 +580,7 @@ static struct pci_driver alim15x3_pci_driver = {
 	.id_table	= alim15x3_pci_tbl,
 	.probe		= alim15x3_init_one,
 	.remove		= ide_pci_remove,
-	.suspend	= ide_pci_suspend,
-	.resume		= ide_pci_resume,
+	.driver.pm	= &ide_pci_pm_ops,
 };
 
 static int __init ali15x3_ide_init(void)
diff --git a/drivers/ide/amd74xx.c b/drivers/ide/amd74xx.c
index 7340597a373e..a9eb64b3e480 100644
--- a/drivers/ide/amd74xx.c
+++ b/drivers/ide/amd74xx.c
@@ -321,8 +321,7 @@ static struct pci_driver amd74xx_pci_driver = {
 	.id_table	= amd74xx_pci_tbl,
 	.probe		= amd74xx_probe,
 	.remove		= ide_pci_remove,
-	.suspend	= ide_pci_suspend,
-	.resume		= ide_pci_resume,
+	.driver.pm	= &ide_pci_pm_ops,
 };
 
 static int __init amd74xx_ide_init(void)
diff --git a/drivers/ide/atiixp.c b/drivers/ide/atiixp.c
index e08b0aac08b9..0bc98d5abaf4 100644
--- a/drivers/ide/atiixp.c
+++ b/drivers/ide/atiixp.c
@@ -190,8 +190,7 @@ static struct pci_driver atiixp_pci_driver = {
 	.id_table	= atiixp_pci_tbl,
 	.probe		= atiixp_init_one,
 	.remove		= ide_pci_remove,
-	.suspend	= ide_pci_suspend,
-	.resume		= ide_pci_resume,
+	.driver.pm	= &ide_pci_pm_ops,
 };
 
 static int __init atiixp_ide_init(void)
diff --git a/drivers/ide/cmd64x.c b/drivers/ide/cmd64x.c
index 943bf944bf72..480898a76133 100644
--- a/drivers/ide/cmd64x.c
+++ b/drivers/ide/cmd64x.c
@@ -430,8 +430,7 @@ static struct pci_driver cmd64x_pci_driver = {
 	.id_table	= cmd64x_pci_tbl,
 	.probe		= cmd64x_init_one,
 	.remove		= ide_pci_remove,
-	.suspend	= ide_pci_suspend,
-	.resume		= ide_pci_resume,
+	.driver.pm	= &ide_pci_pm_ops,
 };
 
 static int __init cmd64x_ide_init(void)
diff --git a/drivers/ide/cs5520.c b/drivers/ide/cs5520.c
index 89a4ff100b7a..ba0a5bc03d76 100644
--- a/drivers/ide/cs5520.c
+++ b/drivers/ide/cs5520.c
@@ -152,8 +152,7 @@ static struct pci_driver cs5520_pci_driver = {
 	.name		= "Cyrix_IDE",
 	.id_table	= cs5520_pci_tbl,
 	.probe		= cs5520_init_one,
-	.suspend	= ide_pci_suspend,
-	.resume		= ide_pci_resume,
+	.driver.pm	= &ide_pci_pm_ops,
 };
 
 static int __init cs5520_ide_init(void)
diff --git a/drivers/ide/cs5530.c b/drivers/ide/cs5530.c
index 65371599b976..5bb46e7130c8 100644
--- a/drivers/ide/cs5530.c
+++ b/drivers/ide/cs5530.c
@@ -273,8 +273,7 @@ static struct pci_driver cs5530_pci_driver = {
 	.id_table	= cs5530_pci_tbl,
 	.probe		= cs5530_init_one,
 	.remove		= ide_pci_remove,
-	.suspend	= ide_pci_suspend,
-	.resume		= ide_pci_resume,
+	.driver.pm	= &ide_pci_pm_ops,
 };
 
 static int __init cs5530_ide_init(void)
diff --git a/drivers/ide/cs5535.c b/drivers/ide/cs5535.c
index 70fdbe3161f8..c5b79f84d274 100644
--- a/drivers/ide/cs5535.c
+++ b/drivers/ide/cs5535.c
@@ -194,8 +194,7 @@ static struct pci_driver cs5535_pci_driver = {
 	.id_table	= cs5535_pci_tbl,
 	.probe		= cs5535_init_one,
 	.remove		= ide_pci_remove,
-	.suspend	= ide_pci_suspend,
-	.resume		= ide_pci_resume,
+	.driver.pm	= &ide_pci_pm_ops,
 };
 
 static int __init cs5535_ide_init(void)
diff --git a/drivers/ide/cs5536.c b/drivers/ide/cs5536.c
index 8b5ca145191b..827cc6843934 100644
--- a/drivers/ide/cs5536.c
+++ b/drivers/ide/cs5536.c
@@ -279,8 +279,7 @@ static struct pci_driver cs5536_pci_driver = {
 	.id_table	= cs5536_pci_tbl,
 	.probe		= cs5536_init_one,
 	.remove		= ide_pci_remove,
-	.suspend	= ide_pci_suspend,
-	.resume		= ide_pci_resume,
+	.driver.pm	= &ide_pci_pm_ops,
 };
 
 module_pci_driver(cs5536_pci_driver);
diff --git a/drivers/ide/cy82c693.c b/drivers/ide/cy82c693.c
index bc01660ee8fd..511a870a352c 100644
--- a/drivers/ide/cy82c693.c
+++ b/drivers/ide/cy82c693.c
@@ -212,8 +212,7 @@ static struct pci_driver cy82c693_pci_driver = {
 	.id_table	= cy82c693_pci_tbl,
 	.probe		= cy82c693_init_one,
 	.remove		= cy82c693_remove,
-	.suspend	= ide_pci_suspend,
-	.resume		= ide_pci_resume,
+	.driver.pm	= &ide_pci_pm_ops,
 };
 
 static int __init cy82c693_ide_init(void)
diff --git a/drivers/ide/hpt366.c b/drivers/ide/hpt366.c
index fd3b5da44619..ecf58153ac8d 100644
--- a/drivers/ide/hpt366.c
+++ b/drivers/ide/hpt366.c
@@ -1523,8 +1523,7 @@ static struct pci_driver hpt366_pci_driver = {
 	.id_table	= hpt366_pci_tbl,
 	.probe		= hpt366_init_one,
 	.remove		= hpt366_remove,
-	.suspend	= ide_pci_suspend,
-	.resume		= ide_pci_resume,
+	.driver.pm	= &ide_pci_pm_ops,
 };
 
 static int __init hpt366_ide_init(void)
diff --git a/drivers/ide/ide-pci-generic.c b/drivers/ide/ide-pci-generic.c
index 673420db953f..cc677fbed6f1 100644
--- a/drivers/ide/ide-pci-generic.c
+++ b/drivers/ide/ide-pci-generic.c
@@ -181,8 +181,7 @@ static struct pci_driver generic_pci_driver = {
 	.id_table	= generic_pci_tbl,
 	.probe		= generic_init_one,
 	.remove		= ide_pci_remove,
-	.suspend	= ide_pci_suspend,
-	.resume		= ide_pci_resume,
+	.driver.pm	= &ide_pci_pm_ops,
 };
 
 static int __init generic_ide_init(void)
diff --git a/drivers/ide/it8172.c b/drivers/ide/it8172.c
index b6f674ab4fb7..d3b5147af7dd 100644
--- a/drivers/ide/it8172.c
+++ b/drivers/ide/it8172.c
@@ -143,8 +143,7 @@ static struct pci_driver it8172_pci_driver = {
 	.id_table	= it8172_pci_tbl,
 	.probe		= it8172_init_one,
 	.remove		= ide_pci_remove,
-	.suspend	= ide_pci_suspend,
-	.resume		= ide_pci_resume,
+	.driver.pm	= &ide_pci_pm_ops,
 };
 
 static int __init it8172_ide_init(void)
diff --git a/drivers/ide/it8213.c b/drivers/ide/it8213.c
index d0bf4430c437..56bc08ce5805 100644
--- a/drivers/ide/it8213.c
+++ b/drivers/ide/it8213.c
@@ -195,8 +195,7 @@ static struct pci_driver it8213_pci_driver = {
 	.id_table	= it8213_pci_tbl,
 	.probe		= it8213_init_one,
 	.remove		= ide_pci_remove,
-	.suspend	= ide_pci_suspend,
-	.resume		= ide_pci_resume,
+	.driver.pm	= &ide_pci_pm_ops,
 };
 
 static int __init it8213_ide_init(void)
diff --git a/drivers/ide/it821x.c b/drivers/ide/it821x.c
index 36a64c8ea575..aad746007330 100644
--- a/drivers/ide/it821x.c
+++ b/drivers/ide/it821x.c
@@ -690,8 +690,7 @@ static struct pci_driver it821x_pci_driver = {
 	.id_table	= it821x_pci_tbl,
 	.probe		= it821x_init_one,
 	.remove		= it821x_remove,
-	.suspend	= ide_pci_suspend,
-	.resume		= ide_pci_resume,
+	.driver.pm	= &ide_pci_pm_ops,
 };
 
 static int __init it821x_ide_init(void)
diff --git a/drivers/ide/jmicron.c b/drivers/ide/jmicron.c
index ae6480dcbadf..0fff50e712a2 100644
--- a/drivers/ide/jmicron.c
+++ b/drivers/ide/jmicron.c
@@ -154,8 +154,7 @@ static struct pci_driver jmicron_pci_driver = {
 	.id_table	= jmicron_pci_tbl,
 	.probe		= jmicron_init_one,
 	.remove		= ide_pci_remove,
-	.suspend	= ide_pci_suspend,
-	.resume		= ide_pci_resume,
+	.driver.pm	= &ide_pci_pm_ops,
 };
 
 static int __init jmicron_ide_init(void)
diff --git a/drivers/ide/ns87415.c b/drivers/ide/ns87415.c
index 11a672aba6ee..25c99265e85b 100644
--- a/drivers/ide/ns87415.c
+++ b/drivers/ide/ns87415.c
@@ -328,8 +328,7 @@ static struct pci_driver ns87415_pci_driver = {
 	.id_table	= ns87415_pci_tbl,
 	.probe		= ns87415_init_one,
 	.remove		= ide_pci_remove,
-	.suspend	= ide_pci_suspend,
-	.resume		= ide_pci_resume,
+	.driver.pm	= &ide_pci_pm_ops,
 };
 
 static int __init ns87415_ide_init(void)
diff --git a/drivers/ide/opti621.c b/drivers/ide/opti621.c
index c374f82333c6..9fa84e709c43 100644
--- a/drivers/ide/opti621.c
+++ b/drivers/ide/opti621.c
@@ -157,8 +157,7 @@ static struct pci_driver opti621_pci_driver = {
 	.id_table	= opti621_pci_tbl,
 	.probe		= opti621_init_one,
 	.remove		= ide_pci_remove,
-	.suspend	= ide_pci_suspend,
-	.resume		= ide_pci_resume,
+	.driver.pm	= &ide_pci_pm_ops,
 };
 
 static int __init opti621_ide_init(void)
diff --git a/drivers/ide/pdc202xx_new.c b/drivers/ide/pdc202xx_new.c
index 4fcafb9121e0..7c276b8aeb5f 100644
--- a/drivers/ide/pdc202xx_new.c
+++ b/drivers/ide/pdc202xx_new.c
@@ -535,8 +535,7 @@ static struct pci_driver pdc202new_pci_driver = {
 	.id_table	= pdc202new_pci_tbl,
 	.probe		= pdc202new_init_one,
 	.remove		= pdc202new_remove,
-	.suspend	= ide_pci_suspend,
-	.resume		= ide_pci_resume,
+	.driver.pm	= &ide_pci_pm_ops,
 };
 
 static int __init pdc202new_ide_init(void)
diff --git a/drivers/ide/pdc202xx_old.c b/drivers/ide/pdc202xx_old.c
index 5248ac064e6e..a902028dd5d2 100644
--- a/drivers/ide/pdc202xx_old.c
+++ b/drivers/ide/pdc202xx_old.c
@@ -340,8 +340,7 @@ static struct pci_driver pdc202xx_pci_driver = {
 	.id_table	= pdc202xx_pci_tbl,
 	.probe		= pdc202xx_init_one,
 	.remove		= ide_pci_remove,
-	.suspend	= ide_pci_suspend,
-	.resume		= ide_pci_resume,
+	.driver.pm	= &ide_pci_pm_ops,
 };
 
 static int __init pdc202xx_ide_init(void)
diff --git a/drivers/ide/piix.c b/drivers/ide/piix.c
index a671cead6ae7..2634768a4e66 100644
--- a/drivers/ide/piix.c
+++ b/drivers/ide/piix.c
@@ -453,8 +453,7 @@ static struct pci_driver piix_pci_driver = {
 	.id_table	= piix_pci_tbl,
 	.probe		= piix_init_one,
 	.remove		= ide_pci_remove,
-	.suspend	= ide_pci_suspend,
-	.resume		= ide_pci_resume,
+	.driver.pm	= &ide_pci_pm_ops,
 };
 
 static int __init piix_ide_init(void)
diff --git a/drivers/ide/serverworks.c b/drivers/ide/serverworks.c
index 458e72e034b0..cdc05b23e03b 100644
--- a/drivers/ide/serverworks.c
+++ b/drivers/ide/serverworks.c
@@ -434,8 +434,7 @@ static struct pci_driver svwks_pci_driver = {
 	.id_table	= svwks_pci_tbl,
 	.probe		= svwks_init_one,
 	.remove		= ide_pci_remove,
-	.suspend	= ide_pci_suspend,
-	.resume		= ide_pci_resume,
+	.driver.pm	= &ide_pci_pm_ops,
 };
 
 static int __init svwks_ide_init(void)
diff --git a/drivers/ide/setup-pci.c b/drivers/ide/setup-pci.c
index fdc8e813170c..1a8fb033e4b3 100644
--- a/drivers/ide/setup-pci.c
+++ b/drivers/ide/setup-pci.c
@@ -648,35 +648,18 @@ void ide_pci_remove(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(ide_pci_remove);
 
-#ifdef CONFIG_PM
-int ide_pci_suspend(struct pci_dev *dev, pm_message_t state)
-{
-	pci_save_state(dev);
-	pci_disable_device(dev);
-	pci_set_power_state(dev, pci_choose_state(dev, state));
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(ide_pci_suspend);
+#define ide_pci_suspend NULL
 
-int ide_pci_resume(struct pci_dev *dev)
+static int __maybe_unused ide_pci_resume(struct device *dev_d)
 {
+	struct pci_dev *dev = to_pci_dev(dev_d);
 	struct ide_host *host = pci_get_drvdata(dev);
-	int rc;
-
-	pci_set_power_state(dev, PCI_D0);
-
-	rc = pci_enable_device(dev);
-	if (rc)
-		return rc;
-
-	pci_restore_state(dev);
-	pci_set_master(dev);
 
 	if (host->init_chipset)
 		host->init_chipset(dev);
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(ide_pci_resume);
-#endif
+
+SIMPLE_DEV_PM_OPS(ide_pci_pm_ops, ide_pci_suspend, ide_pci_resume);
+EXPORT_SYMBOL_GPL(ide_pci_pm_ops);
diff --git a/drivers/ide/siimage.c b/drivers/ide/siimage.c
index c4b20f350b84..198847488cc6 100644
--- a/drivers/ide/siimage.c
+++ b/drivers/ide/siimage.c
@@ -821,8 +821,7 @@ static struct pci_driver siimage_pci_driver = {
 	.id_table	= siimage_pci_tbl,
 	.probe		= siimage_init_one,
 	.remove		= siimage_remove,
-	.suspend	= ide_pci_suspend,
-	.resume		= ide_pci_resume,
+	.driver.pm	= &ide_pci_pm_ops,
 };
 
 static int __init siimage_ide_init(void)
diff --git a/drivers/ide/sis5513.c b/drivers/ide/sis5513.c
index 024bc7ba49ee..410eddd3629f 100644
--- a/drivers/ide/sis5513.c
+++ b/drivers/ide/sis5513.c
@@ -615,8 +615,7 @@ static struct pci_driver sis5513_pci_driver = {
 	.id_table	= sis5513_pci_tbl,
 	.probe		= sis5513_init_one,
 	.remove		= sis5513_remove,
-	.suspend	= ide_pci_suspend,
-	.resume		= ide_pci_resume,
+	.driver.pm	= &ide_pci_pm_ops,
 };
 
 static int __init sis5513_ide_init(void)
diff --git a/drivers/ide/sl82c105.c b/drivers/ide/sl82c105.c
index 5c24c420c438..4ad5c6bce2b7 100644
--- a/drivers/ide/sl82c105.c
+++ b/drivers/ide/sl82c105.c
@@ -346,8 +346,7 @@ static struct pci_driver sl82c105_pci_driver = {
 	.id_table	= sl82c105_pci_tbl,
 	.probe		= sl82c105_init_one,
 	.remove		= ide_pci_remove,
-	.suspend	= ide_pci_suspend,
-	.resume		= ide_pci_resume,
+	.driver.pm	= &ide_pci_pm_ops,
 };
 
 static int __init sl82c105_ide_init(void)
diff --git a/drivers/ide/slc90e66.c b/drivers/ide/slc90e66.c
index f521d5ebf916..cd47445fda1f 100644
--- a/drivers/ide/slc90e66.c
+++ b/drivers/ide/slc90e66.c
@@ -160,8 +160,7 @@ static struct pci_driver slc90e66_pci_driver = {
 	.id_table	= slc90e66_pci_tbl,
 	.probe		= slc90e66_init_one,
 	.remove		= ide_pci_remove,
-	.suspend	= ide_pci_suspend,
-	.resume		= ide_pci_resume,
+	.driver.pm	= &ide_pci_pm_ops,
 };
 
 static int __init slc90e66_ide_init(void)
diff --git a/drivers/ide/triflex.c b/drivers/ide/triflex.c
index 16ddd0956832..1886bbfb9e5d 100644
--- a/drivers/ide/triflex.c
+++ b/drivers/ide/triflex.c
@@ -110,8 +110,29 @@ static int triflex_ide_pci_suspend(struct pci_dev *dev, pm_message_t state)
 	pci_save_state(dev);
 	return 0;
 }
+
+static int triflex_ide_pci_resume(struct pci_dev *dev)
+{
+	struct ide_host *host = pci_get_drvdata(dev);
+	int rc;
+
+	pci_set_power_state(dev, PCI_D0);
+
+	rc = pci_enable_device(dev);
+	if (rc)
+		return rc;
+
+	pci_restore_state(dev);
+	pci_set_master(dev);
+
+	if (host->init_chipset)
+		host->init_chipset(dev);
+
+	return 0;
+}
 #else
 #define triflex_ide_pci_suspend NULL
+#define triflex_ide_pci_resume NULL
 #endif
 
 static struct pci_driver triflex_pci_driver = {
@@ -120,7 +141,7 @@ static struct pci_driver triflex_pci_driver = {
 	.probe		= triflex_init_one,
 	.remove		= ide_pci_remove,
 	.suspend	= triflex_ide_pci_suspend,
-	.resume		= ide_pci_resume,
+	.resume		= triflex_ide_pci_resume,
 };
 
 static int __init triflex_ide_init(void)
diff --git a/drivers/ide/via82cxxx.c b/drivers/ide/via82cxxx.c
index 63a3aca506fc..166feaeed6e3 100644
--- a/drivers/ide/via82cxxx.c
+++ b/drivers/ide/via82cxxx.c
@@ -510,8 +510,7 @@ static struct pci_driver via_pci_driver = {
 	.id_table 	= via_pci_tbl,
 	.probe 		= via_init_one,
 	.remove		= via_remove,
-	.suspend	= ide_pci_suspend,
-	.resume		= ide_pci_resume,
+	.driver.pm	= &ide_pci_pm_ops,
 };
 
 static int __init via_ide_init(void)
diff --git a/include/linux/ide.h b/include/linux/ide.h
index a254841bd315..77b41103e12b 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1394,13 +1394,7 @@ int ide_pci_init_two(struct pci_dev *, struct pci_dev *,
 		     const struct ide_port_info *, void *);
 void ide_pci_remove(struct pci_dev *);
 
-#ifdef CONFIG_PM
-int ide_pci_suspend(struct pci_dev *, pm_message_t);
-int ide_pci_resume(struct pci_dev *);
-#else
-#define ide_pci_suspend NULL
-#define ide_pci_resume NULL
-#endif
+extern const struct dev_pm_ops ide_pci_pm_ops;
 
 void ide_map_sg(ide_drive_t *, struct ide_cmd *);
 void ide_init_sg_cmd(struct ide_cmd *, unsigned int);
-- 
2.27.0

