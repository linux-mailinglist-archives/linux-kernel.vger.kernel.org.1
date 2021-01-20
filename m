Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCE002FC867
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 04:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389002AbhATDF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 22:05:28 -0500
Received: from mga17.intel.com ([192.55.52.151]:3819 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388619AbhATCst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 21:48:49 -0500
IronPort-SDR: p5iyAp8MsYvWLYr9t8lP+1C1wJvhMOaLlqJq9NSZMjscsMBGW0JewC1858NPDkesrp0nsDBX+4
 1kRUP6kgbfcw==
X-IronPort-AV: E=McAfee;i="6000,8403,9869"; a="158808458"
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="158808458"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 18:48:08 -0800
IronPort-SDR: 1SVqAj3W3yzn564qBozYFExqlpsnBU5pclLYoaNWmJNyZkYZw5Zyv4wJjgQ6fn0Qzh1Pkybny1
 /GMmCh+R5g+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="355871066"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by fmsmga008.fm.intel.com with ESMTP; 19 Jan 2021 18:48:07 -0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, trix@redhat.com, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com
Subject: [PATCH v7 2/2] Documentation: fpga: dfl: Add description for DFL UIO support
Date:   Wed, 20 Jan 2021 10:43:26 +0800
Message-Id: <1611110606-10380-3-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1611110606-10380-1-git-send-email-yilun.xu@intel.com>
References: <1611110606-10380-1-git-send-email-yilun.xu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds description for UIO support for dfl devices on DFL
bus.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
---
v2: no doc in v1, add it for v2.
v3: some documentation fixes.
v4: documentation change since the driver matching is changed.
v5: no change.
v6: improve the title of the userspace driver support section.
    some word improvement.
v7: rebased to next-20210119
---
 Documentation/fpga/dfl.rst | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
index c41ac76..f96a6fb 100644
--- a/Documentation/fpga/dfl.rst
+++ b/Documentation/fpga/dfl.rst
@@ -7,6 +7,7 @@ Authors:
 - Enno Luebbers <enno.luebbers@intel.com>
 - Xiao Guangrong <guangrong.xiao@linux.intel.com>
 - Wu Hao <hao.wu@intel.com>
+- Xu Yilun <yilun.xu@intel.com>
 
 The Device Feature List (DFL) FPGA framework (and drivers according to
 this framework) hides the very details of low layer hardwares and provides
@@ -530,6 +531,30 @@ Being able to specify more than one DFL per BAR has been considered, but it
 was determined the use case did not provide value.  Specifying a single DFL
 per BAR simplifies the implementation and allows for extra error checking.
 
+
+Userspace driver support for DFL devices
+========================================
+The purpose of an FPGA is to be reprogrammed with newly developed hardware
+components. New hardware can instantiate a new private feature in the DFL, and
+then get a DFL device in their system. In some cases users may need a userspace
+driver for the DFL device:
+
+* Users may need to run some diagnostic test for their hardwares.
+* Users may prototype the kernel driver in user space.
+* Some hardware is designed for specific purposes and does not fit into one of
+  the standard kernel subsystems.
+
+This requires direct access to MMIO space and interrupt handling from
+userspace. The dfl-uio-pdev module exposes the UIO device interfaces for this
+purpose. It adds the uio_pdrv_genirq platform device with the resources of
+the DFL feature, and lets the generic UIO platform device driver provide UIO
+support to userspace.
+
+FPGA_DFL_UIO_PDEV should be selected to enable the dfl-uio-pdev module driver.
+To support a new DFL feature been directly accessed via UIO, its feature id
+should be added to the driver's id_table.
+
+
 Open discussion
 ===============
 FME driver exports one ioctl (DFL_FPGA_FME_PORT_PR) for partial reconfiguration
-- 
2.7.4

