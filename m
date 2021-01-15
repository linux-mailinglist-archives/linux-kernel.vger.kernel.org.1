Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9242F85DF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 21:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388345AbhAOUBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 15:01:21 -0500
Received: from mga11.intel.com ([192.55.52.93]:25631 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733252AbhAOUBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 15:01:20 -0500
IronPort-SDR: pIWf5mRi+c+TFSj2gtFT4+mlr13CxXPde8mAQVYvt5xe30rLuAW7+wS8r+rQRjciWkxLP2QyB4
 uo1gisoDASEA==
X-IronPort-AV: E=McAfee;i="6000,8403,9865"; a="175096291"
X-IronPort-AV: E=Sophos;i="5.79,350,1602572400"; 
   d="scan'208";a="175096291"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2021 11:59:34 -0800
IronPort-SDR: rXZeBqaKPja0deLa4iWzl3uBVLkJjF9aTa+RipWt6/0geujjxQ06OJ5+jj5Ziqp691ch0uuQN4
 EMTldog2Ghuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,350,1602572400"; 
   d="scan'208";a="465686870"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 15 Jan 2021 11:59:33 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH 2/2] intel_th: pci: Add Alder Lake-P support
Date:   Fri, 15 Jan 2021 22:59:17 +0300
Message-Id: <20210115195917.3184-3-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210115195917.3184-1-alexander.shishkin@linux.intel.com>
References: <20210115195917.3184-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for the Trace Hub in Alder Lake-P.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 drivers/hwtracing/intel_th/pci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hwtracing/intel_th/pci.c b/drivers/hwtracing/intel_th/pci.c
index 52acd77438ed..251e75c9ba9d 100644
--- a/drivers/hwtracing/intel_th/pci.c
+++ b/drivers/hwtracing/intel_th/pci.c
@@ -268,6 +268,11 @@ static const struct pci_device_id intel_th_pci_id_table[] = {
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x7aa6),
 		.driver_data = (kernel_ulong_t)&intel_th_2x,
 	},
+	{
+		/* Alder Lake-P */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x51a6),
+		.driver_data = (kernel_ulong_t)&intel_th_2x,
+	},
 	{
 		/* Alder Lake CPU */
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x466f),
-- 
2.29.2

