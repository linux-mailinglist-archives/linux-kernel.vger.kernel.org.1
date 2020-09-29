Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A033A27C01E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 10:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgI2IzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 04:55:09 -0400
Received: from inva021.nxp.com ([92.121.34.21]:53748 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbgI2IzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 04:55:07 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B7BB3201589;
        Tue, 29 Sep 2020 10:55:04 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AB56B2000AA;
        Tue, 29 Sep 2020 10:55:04 +0200 (CEST)
Received: from fsr-ub1864-111.ea.freescale.net (fsr-ub1864-111.ea.freescale.net [10.171.82.141])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 5818F2032C;
        Tue, 29 Sep 2020 10:55:04 +0200 (CEST)
From:   Diana Craciun <diana.craciun@oss.nxp.com>
To:     linux-kernel@vger.kernel.org, laurentiu.tudor@nxp.com
Cc:     stuyoder@gmail.com, leoyang.li@nxp.com, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org,
        Diana Craciun <diana.craciun@oss.nxp.com>
Subject: [PATCH v5 00/13] bus/fsl-mc: Extend mc-bus driver functionalities in preparation for mc-bus VFIO support
Date:   Tue, 29 Sep 2020 11:54:28 +0300
Message-Id: <20200929085441.17448-1-diana.craciun@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vfio-mc bus driver needs some additional services to be exported by the
mc-bus driver like:
- a way to reset the DPRC container
- driver_override support
- functions to setup/tear down a DPRC
- functions for allocating the pool of interrupts. In case of VFIO the
interrupts are not configured at probe time, but later by userspace
request

v4 -> v5
- dprc_celanup should not fail

v3 -> v4
- Rebased on the latest kernel.
- Exported a dprc_remove function

v2 -> v3
- Add a new version for dprc_get_obj_region
- Export the cacheability bus specific bits defines

v1 -> v2
- Remove driver_override propagation through various functions
- Cache the DPRC API version

The patches are related with "vfio/fsl-mc: VFIO support for FSL-MC
devices" patches, but the series were split because they are targeting
different subsystems. However, the mc-bus patches may suffer changes
when addressing the VFIO review comments.

The patches do not address the comment regarding moving driver_override
in the core code. I prefer not to tie these patches on that change and
address that separately.

Bharat Bhushan (3):
  bus/fsl-mc: add support for 'driver_override' in the mc-bus
  bus/fsl-mc: Add dprc-reset-container support
  bus/fsl-mc: Extend ICID size from 16bit to 32bit

Diana Craciun (10):
  bus/fsl-mc: Do no longer export the total number of irqs outside
    dprc_scan_objects
  bus/fsl-mc: Add a new parameter to dprc_scan_objects function
  bus/fsl-mc: Set the QMAN/BMAN region flags
  bus/fsl-mc: Cache the DPRC API version
  bus/fsl-mc: Export dprc_scan/dprc_remove functions to be used by
    multiple entities
  bus/fsl-mc: Export a cleanup function for DPRC
  bus/fsl-mc: Add a container setup function
  bus/fsl_mc: Do not rely on caller to provide non NULL mc_io
  bus/fsl-mc: Export IRQ pool handling functions to be used by VFIO
  bus/fsl-mc: Add a new version for dprc_get_obj_region command

 drivers/bus/fsl-mc/dprc-driver.c      | 190 ++++++++++++++++----------
 drivers/bus/fsl-mc/dprc.c             | 141 +++++++++++++++----
 drivers/bus/fsl-mc/fsl-mc-allocator.c |  12 +-
 drivers/bus/fsl-mc/fsl-mc-bus.c       |  64 ++++++++-
 drivers/bus/fsl-mc/fsl-mc-private.h   |  31 ++---
 drivers/bus/fsl-mc/mc-io.c            |   7 +-
 include/linux/fsl/mc.h                |  41 +++++-
 7 files changed, 359 insertions(+), 127 deletions(-)

-- 
2.17.1

