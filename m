Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2395D1EE025
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jun 2020 10:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbgFDIuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jun 2020 04:50:46 -0400
Received: from mga05.intel.com ([192.55.52.43]:39770 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728364AbgFDIun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 04:50:43 -0400
IronPort-SDR: YwxIvaVaKnc6Q113Nbc+Mqx874n6G0jgmpt9/sIePLURu2j70xn38Zmu09+Y2HMyrddIwr7S42
 M4wfZxsUC7uQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2020 01:50:43 -0700
IronPort-SDR: 7CgaXj/Deftgsaq3f358dJiDvKIevJ1ocKFaWViYvKU5sEjr2D6UdRv5MU5hRquRvIWWNTELb3
 0BthCp1UZSJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,471,1583222400"; 
   d="scan'208";a="445435145"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by orsmga005.jf.intel.com with ESMTP; 04 Jun 2020 01:50:40 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     mfd@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, bhu@redhat.com, mtosatti@redhat.com,
        gregkh@linuxfoundation.org, Xu Yilun <yilun.xu@intel.com>,
        Luwei Kang <luwei.kang@intel.com>, Wu Hao <hao.wu@intel.com>
Subject: [PATCH v6 7/7] Documentation: fpga: dfl: add descriptions for interrupt related interfaces.
Date:   Thu,  4 Jun 2020 16:46:28 +0800
Message-Id: <1591260388-15128-8-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591260388-15128-1-git-send-email-yilun.xu@intel.com>
References: <1591260388-15128-1-git-send-email-yilun.xu@intel.com>
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
----
v2: Update Documents cause change of irq ioctl interfaces.
v3: No change
v4: Update interrupt support part.
v5: No change
v6: No change
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

