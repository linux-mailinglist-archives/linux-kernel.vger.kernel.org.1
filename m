Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF1A1FA781
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 06:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbgFPENS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 00:13:18 -0400
Received: from mga14.intel.com ([192.55.52.115]:64734 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbgFPENO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 00:13:14 -0400
IronPort-SDR: RnN0iDFF+cY28CsyzSw+1SftTq2MHLLy66UrkdO0WYSzUHtHPMl4n2H58RTb+SAoCkFuE6I0zT
 NX9+OtGMRNmw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2020 21:13:14 -0700
IronPort-SDR: Sa2R73IS03mbJtXx9sgWuOPJuZGMmHNfIfSN6Pel4s8rcmcFlJ6dZsbxMG6BCDM2DomGY5qzxG
 qANUPIa4Dycg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,517,1583222400"; 
   d="scan'208";a="261298581"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by fmsmga007.fm.intel.com with ESMTP; 15 Jun 2020 21:13:11 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, bhu@redhat.com, mtosatti@redhat.com,
        gregkh@linuxfoundation.org, Xu Yilun <yilun.xu@intel.com>,
        Luwei Kang <luwei.kang@intel.com>, Wu Hao <hao.wu@intel.com>
Subject: [PATCH v7 7/7] Documentation: fpga: dfl: add descriptions for interrupt related interfaces.
Date:   Tue, 16 Jun 2020 12:08:48 +0800
Message-Id: <1592280528-6350-8-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592280528-6350-1-git-send-email-yilun.xu@intel.com>
References: <1592280528-6350-1-git-send-email-yilun.xu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds introductions of interrupt related interfaces for FME
error reporting, port error reporting and AFU user interrupts features.

Signed-off-by: Luwei Kang <luwei.kang@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>
Acked-by: Wu Hao <hao.wu@intel.com>
---
v2: Update Documents cause change of irq ioctl interfaces.
v3: No change
v4: Update interrupt support part.
v5: No change
v6: No change
v7: No change
---
 Documentation/fpga/dfl.rst | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
index 978c4af..2df9a0a 100644
--- a/Documentation/fpga/dfl.rst
+++ b/Documentation/fpga/dfl.rst
@@ -89,6 +89,8 @@ The following functions are exposed through ioctls:
 - Program bitstream (DFL_FPGA_FME_PORT_PR)
 - Assign port to PF (DFL_FPGA_FME_PORT_ASSIGN)
 - Release port from PF (DFL_FPGA_FME_PORT_RELEASE)
+- Get number of irqs of FME global error (DFL_FPGA_FME_ERR_GET_IRQ_NUM)
+- Set interrupt trigger for FME error (DFL_FPGA_FME_ERR_SET_IRQ)
 
 More functions are exposed through sysfs
 (/sys/class/fpga_region/regionX/dfl-fme.n/):
@@ -149,6 +151,10 @@ The following functions are exposed through ioctls:
 - Map DMA buffer (DFL_FPGA_PORT_DMA_MAP)
 - Unmap DMA buffer (DFL_FPGA_PORT_DMA_UNMAP)
 - Reset AFU (DFL_FPGA_PORT_RESET)
+- Get number of irqs of port error (DFL_FPGA_PORT_ERR_GET_IRQ_NUM)
+- Set interrupt trigger for port error (DFL_FPGA_PORT_ERR_SET_IRQ)
+- Get number of irqs of UINT (DFL_FPGA_PORT_UINT_GET_IRQ_NUM)
+- Set interrupt trigger for UINT (DFL_FPGA_PORT_UINT_SET_IRQ)
 
 DFL_FPGA_PORT_RESET:
   reset the FPGA Port and its AFU. Userspace can do Port
@@ -462,6 +468,19 @@ since they are system-wide counters on FPGA device.
 The current driver does not support sampling. So "perf record" is unsupported.
 
 
+Interrupt support
+=================
+Some FME and AFU private features are able to generate interrupts. As mentioned
+above, users could call ioctl (DFL_FPGA_*_GET_IRQ_NUM) to know whether or how
+many interrupts are supported for this private feature. Drivers also implement
+an eventfd based interrupt handling mechanism for users to get notified when
+interrupt happens. Users could set eventfds to driver via
+ioctl (DFL_FPGA_*_SET_IRQ), and then poll/select on these eventfds waiting for
+notification.
+In Current DFL, 3 sub features (Port error, FME global error and AFU interrupt)
+support interrupts.
+
+
 Add new FIUs support
 ====================
 It's possible that developers made some new function blocks (FIUs) under this
-- 
2.7.4

