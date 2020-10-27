Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA8A229A9FC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 11:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1418589AbgJ0Kqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 06:46:30 -0400
Received: from mga07.intel.com ([134.134.136.100]:5401 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1418538AbgJ0KqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 06:46:21 -0400
IronPort-SDR: n3wR2xNXVCvuZPqPijwzXyoZgfHq+P83zG/DMJBIMMgDNeljEoY7K+3/K7d61cJpyreBzqFM0n
 6ObZG6lWI3uw==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="232244795"
X-IronPort-AV: E=Sophos;i="5.77,423,1596524400"; 
   d="scan'208";a="232244795"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2020 03:46:19 -0700
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

