Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4847F1EB854
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jun 2020 11:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgFBJVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jun 2020 05:21:00 -0400
Received: from mga01.intel.com ([192.55.52.88]:52971 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726817AbgFBJU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 05:20:59 -0400
IronPort-SDR: ExUWsR4JowE4yp/Y5bWYRvFds771TV69DlsAHKeoB8ABXsVF7we7c3PGaHl7QH0u4yUjTsyyel
 pl+77RjlA+Kw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2020 02:20:58 -0700
IronPort-SDR: VChBlGk7SnjeyZqycE+0HcWfXPLgoHlDQi9TQZ6QGtTv2ZrZKEkU2KtDXUowU8LPgUr5WoIshP
 5tX7Vwx/ZPNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,463,1583222400"; 
   d="scan'208";a="303948594"
Received: from gklab-125-110.igk.intel.com ([10.91.125.110])
  by fmsmga002.fm.intel.com with ESMTP; 02 Jun 2020 02:20:57 -0700
From:   Piotr Stankiewicz <piotr.stankiewicz@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Piotr Stankiewicz <piotr.stankiewicz@intel.com>
Subject: [PATCH 10/15] vmw_vmci: use PCI_IRQ_ALL_TYPES where appropriate
Date:   Tue,  2 Jun 2020 11:20:54 +0200
Message-Id: <20200602092054.32102-1-piotr.stankiewicz@intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Seeing as there is shorthand available to use when asking for any type
of interrupt, or any type of message signalled interrupt, leverage it.

Signed-off-by: Piotr Stankiewicz <piotr.stankiewicz@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/misc/vmw_vmci/vmci_guest.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/misc/vmw_vmci/vmci_guest.c b/drivers/misc/vmw_vmci/vmci_guest.c
index cc8eeb361fcd..ea300573f652 100644
--- a/drivers/misc/vmw_vmci/vmci_guest.c
+++ b/drivers/misc/vmw_vmci/vmci_guest.c
@@ -584,8 +584,7 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
 	error = pci_alloc_irq_vectors(pdev, VMCI_MAX_INTRS, VMCI_MAX_INTRS,
 			PCI_IRQ_MSIX);
 	if (error < 0) {
-		error = pci_alloc_irq_vectors(pdev, 1, 1,
-				PCI_IRQ_MSIX | PCI_IRQ_MSI | PCI_IRQ_LEGACY);
+		error = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
 		if (error < 0)
 			goto err_remove_bitmap;
 	} else {
-- 
2.17.2

