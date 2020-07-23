Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E52722B66C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 21:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbgGWTIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 15:08:23 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:51860 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726758AbgGWTIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 15:08:23 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 7D641BC1B9;
        Thu, 23 Jul 2020 19:08:19 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     abbotti@mev.co.uk, hsweeten@visionengravers.com,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] staging: comedi: adl: Replace HTTP links with HTTPS ones
Date:   Thu, 23 Jul 2020 21:08:13 +0200
Message-Id: <20200723190813.71971-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++
X-Spam-Level: *****
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 Continuing my work started at 93431e0607e5.
 See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
 (Actually letting a shell for loop submit all this stuff for me.)

 If there are any URLs to be removed completely
 or at least not (just) HTTPSified:
 Just clearly say so and I'll *undo my change*.
 See also: https://lkml.org/lkml/2020/6/27/64

 If there are any valid, but yet not changed URLs:
 See: https://lkml.org/lkml/2020/6/26/837

 If you apply the patch, please let me know.

 Sorry again to all maintainers who complained about subject lines.
 Now I realized that you want an actually perfect prefixes,
 not just subsystem ones.
 I tried my best...
 And yes, *I could* (at least half-)automate it.
 Impossible is nothing! :)


 drivers/staging/comedi/drivers/adl_pci6208.c | 2 +-
 drivers/staging/comedi/drivers/adl_pci8164.c | 2 +-
 drivers/staging/comedi/drivers/adl_pci9111.c | 2 +-
 drivers/staging/comedi/drivers/adl_pci9118.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/comedi/drivers/adl_pci6208.c b/drivers/staging/comedi/drivers/adl_pci6208.c
index e21840e9002d..9ae4cc523dd4 100644
--- a/drivers/staging/comedi/drivers/adl_pci6208.c
+++ b/drivers/staging/comedi/drivers/adl_pci6208.c
@@ -196,6 +196,6 @@ static struct pci_driver adl_pci6208_pci_driver = {
 };
 module_comedi_pci_driver(adl_pci6208_driver, adl_pci6208_pci_driver);
 
-MODULE_AUTHOR("Comedi http://www.comedi.org");
+MODULE_AUTHOR("Comedi https://www.comedi.org");
 MODULE_DESCRIPTION("Comedi driver for ADLink 6208 series cards");
 MODULE_LICENSE("GPL");
diff --git a/drivers/staging/comedi/drivers/adl_pci8164.c b/drivers/staging/comedi/drivers/adl_pci8164.c
index 3022793b1bc5..d5e1bda81557 100644
--- a/drivers/staging/comedi/drivers/adl_pci8164.c
+++ b/drivers/staging/comedi/drivers/adl_pci8164.c
@@ -149,6 +149,6 @@ static struct pci_driver adl_pci8164_pci_driver = {
 };
 module_comedi_pci_driver(adl_pci8164_driver, adl_pci8164_pci_driver);
 
-MODULE_AUTHOR("Comedi http://www.comedi.org");
+MODULE_AUTHOR("Comedi https://www.comedi.org");
 MODULE_DESCRIPTION("Comedi low-level driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/staging/comedi/drivers/adl_pci9111.c b/drivers/staging/comedi/drivers/adl_pci9111.c
index f4dba6271d0d..a062c5ab20e9 100644
--- a/drivers/staging/comedi/drivers/adl_pci9111.c
+++ b/drivers/staging/comedi/drivers/adl_pci9111.c
@@ -742,6 +742,6 @@ static struct pci_driver adl_pci9111_pci_driver = {
 };
 module_comedi_pci_driver(adl_pci9111_driver, adl_pci9111_pci_driver);
 
-MODULE_AUTHOR("Comedi http://www.comedi.org");
+MODULE_AUTHOR("Comedi https://www.comedi.org");
 MODULE_DESCRIPTION("Comedi low-level driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/staging/comedi/drivers/adl_pci9118.c b/drivers/staging/comedi/drivers/adl_pci9118.c
index 2528ca0ede6d..cda3a4267dca 100644
--- a/drivers/staging/comedi/drivers/adl_pci9118.c
+++ b/drivers/staging/comedi/drivers/adl_pci9118.c
@@ -1731,6 +1731,6 @@ static struct pci_driver adl_pci9118_pci_driver = {
 };
 module_comedi_pci_driver(adl_pci9118_driver, adl_pci9118_pci_driver);
 
-MODULE_AUTHOR("Comedi http://www.comedi.org");
+MODULE_AUTHOR("Comedi https://www.comedi.org");
 MODULE_DESCRIPTION("Comedi low-level driver");
 MODULE_LICENSE("GPL");
-- 
2.27.0

