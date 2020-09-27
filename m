Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE0A127A2F4
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 21:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgI0Tz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 15:55:26 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:10061
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726309AbgI0TzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 15:55:22 -0400
X-IronPort-AV: E=Sophos;i="5.77,311,1596492000"; 
   d="scan'208";a="360169495"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES256-SHA256; 27 Sep 2020 21:55:13 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     David Airlie <airlied@linux.ie>
Cc:     =?UTF-8?q?Valdis=20Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Joe Perches <joe@perches.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel-janitors@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/18] agp: use semicolons rather than commas to separate statements
Date:   Sun, 27 Sep 2020 21:12:18 +0200
Message-Id: <1601233948-11629-9-git-send-email-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1601233948-11629-1-git-send-email-Julia.Lawall@inria.fr>
References: <1601233948-11629-1-git-send-email-Julia.Lawall@inria.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace commas with semicolons.  What is done is essentially described by
the following Coccinelle semantic patch (http://coccinelle.lip6.fr/):

// <smpl>
@@ expression e1,e2; @@
e1
-,
+;
e2
... when any
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/char/agp/amd-k7-agp.c |    2 +-
 drivers/char/agp/nvidia-agp.c |    2 +-
 drivers/char/agp/sworks-agp.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/char/agp/amd-k7-agp.c b/drivers/char/agp/amd-k7-agp.c
index 6914e4f0ce98..2b2095542816 100644
--- a/drivers/char/agp/amd-k7-agp.c
+++ b/drivers/char/agp/amd-k7-agp.c
@@ -425,7 +425,7 @@ static int agp_amdk7_probe(struct pci_dev *pdev,
 		return -ENOMEM;
 
 	bridge->driver = &amd_irongate_driver;
-	bridge->dev_private_data = &amd_irongate_private,
+	bridge->dev_private_data = &amd_irongate_private;
 	bridge->dev = pdev;
 	bridge->capndx = cap_ptr;
 
diff --git a/drivers/char/agp/nvidia-agp.c b/drivers/char/agp/nvidia-agp.c
index 623205bcd04a..f78e756157db 100644
--- a/drivers/char/agp/nvidia-agp.c
+++ b/drivers/char/agp/nvidia-agp.c
@@ -382,7 +382,7 @@ static int agp_nvidia_probe(struct pci_dev *pdev,
 		return -ENOMEM;
 
 	bridge->driver = &nvidia_driver;
-	bridge->dev_private_data = &nvidia_private,
+	bridge->dev_private_data = &nvidia_private;
 	bridge->dev = pdev;
 	bridge->capndx = cap_ptr;
 
diff --git a/drivers/char/agp/sworks-agp.c b/drivers/char/agp/sworks-agp.c
index 7729414100ff..f875970bda65 100644
--- a/drivers/char/agp/sworks-agp.c
+++ b/drivers/char/agp/sworks-agp.c
@@ -513,7 +513,7 @@ static int agp_serverworks_probe(struct pci_dev *pdev,
 		return -ENOMEM;
 
 	bridge->driver = &sworks_driver;
-	bridge->dev_private_data = &serverworks_private,
+	bridge->dev_private_data = &serverworks_private;
 	bridge->dev = pci_dev_get(pdev);
 
 	pci_set_drvdata(pdev, bridge);

