Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51C8D29F5DF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 21:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgJ2UIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 16:08:05 -0400
Received: from mga17.intel.com ([192.55.52.151]:19840 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbgJ2UID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 16:08:03 -0400
IronPort-SDR: bXGJ8phC45GDCRKzK61pvGuSCaMa6d2oicTq2GvW5Sun8yjcFPbJF32gQZnjPDfDvvKJ8APc6Z
 aMwNv0c00Ltg==
X-IronPort-AV: E=McAfee;i="6000,8403,9789"; a="148358912"
X-IronPort-AV: E=Sophos;i="5.77,430,1596524400"; 
   d="scan'208";a="148358912"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 13:08:02 -0700
IronPort-SDR: Mlw+4gQBPZX6SElMSdx/fyUu2jiJYZ6pHggGp/kBGTNlIudPBsFwL4lGelZcSpYoQZwE5UtaVO
 fKoPpkaIKx/w==
X-IronPort-AV: E=Sophos;i="5.77,430,1596524400"; 
   d="scan'208";a="525645289"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 13:08:01 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1kYEEK-001UNr-9q; Thu, 29 Oct 2020 22:09:04 +0200
X-Original-To: andriy.shevchenko@linux.intel.com
Received: from linux.intel.com [10.54.29.200]
        by smile.fi.intel.com with IMAP (fetchmail-6.4.12)
        for <andy@localhost> (single-drop); Tue, 27 Oct 2020 13:00:05 +0200 (EET)
Received: from FMSMGA003.fm.intel.com (fmsmga003.fm.intel.com [10.253.24.29])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id DB14B58089E;
        Tue, 27 Oct 2020 03:46:19 -0700 (PDT)
IronPort-SDR: yhg4RqO2u1dTIO7Y9rtH4cZ+6SXPvTEHGn6CmjfRf/xuWfoawSwx9uJATwrElKSx709WgnSXaZ
 zocSclAqVrAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,423,1596524400"; 
   d="scan'208";a="360701761"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Oct 2020 03:46:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 93099249; Tue, 27 Oct 2020 12:46:17 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] mfd: intel-lpss: Add Intel Alder Lake PCH-S PCI IDs
Date:   Tue, 27 Oct 2020 12:46:16 +0200
Message-Id: <20201027104616.49098-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Add Intel Alder Lake LPSS PCI IDs.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel-lpss-pci.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/mfd/intel-lpss-pci.c b/drivers/mfd/intel-lpss-pci.c
index 2d7c588ef1ed..9d6daa780df7 100644
--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -293,6 +293,21 @@ static const struct pci_device_id intel_lpss_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x5ac4), (kernel_ulong_t)&bxt_info },
 	{ PCI_VDEVICE(INTEL, 0x5ac6), (kernel_ulong_t)&bxt_info },
 	{ PCI_VDEVICE(INTEL, 0x5aee), (kernel_ulong_t)&bxt_uart_info },
+	/* ADL-S */
+	{ PCI_VDEVICE(INTEL, 0x7aa8), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0x7aa9), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0x7aaa), (kernel_ulong_t)&bxt_info },
+	{ PCI_VDEVICE(INTEL, 0x7aab), (kernel_ulong_t)&bxt_info },
+	{ PCI_VDEVICE(INTEL, 0x7acc), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x7acd), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x7ace), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x7acf), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x7adc), (kernel_ulong_t)&bxt_uart_info },
+	{ PCI_VDEVICE(INTEL, 0x7af9), (kernel_ulong_t)&bxt_info },
+	{ PCI_VDEVICE(INTEL, 0x7afb), (kernel_ulong_t)&bxt_info },
+	{ PCI_VDEVICE(INTEL, 0x7afc), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x7afd), (kernel_ulong_t)&bxt_i2c_info },
+	{ PCI_VDEVICE(INTEL, 0x7afe), (kernel_ulong_t)&bxt_uart_info },
 	/* LKF */
 	{ PCI_VDEVICE(INTEL, 0x98a8), (kernel_ulong_t)&bxt_uart_info },
 	{ PCI_VDEVICE(INTEL, 0x98a9), (kernel_ulong_t)&bxt_uart_info },
-- 
2.28.0

