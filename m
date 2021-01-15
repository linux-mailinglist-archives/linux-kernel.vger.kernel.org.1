Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF66F2F70CE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 04:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732356AbhAODQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 22:16:11 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:53523 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbhAODQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 22:16:10 -0500
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=canonical.com)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kaichuan.hsieh@canonical.com>)
        id 1l0Fa1-0004Zi-VE; Fri, 15 Jan 2021 03:15:18 +0000
From:   Kai-Chuan Hsieh <kaichuan.hsieh@canonical.com>
To:     alsa-devel@alsa-project.org, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com,
        guennadi.liakhovetski@linux.intel.com, kai.heng.feng@canonical.com,
        kai.vehmanen@linux.intel.com, rppt@kernel.org,
        linux-kernel@vger.kernel.org, kaichuan.hsieh@canonical.com
Subject: [PATCH] ALSA: hda: Add Cometlake-R PCI ID
Date:   Fri, 15 Jan 2021 11:15:15 +0800
Message-Id: <20210115031515.13100-1-kaichuan.hsieh@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add HD Audio Device PCI ID for the Intel Cometlake-R platform

Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Kai-Chuan Hsieh <kaichuan.hsieh@canonical.com>
---
 sound/pci/hda/hda_intel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 83a4a6290070..313d2c9fb35d 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2482,6 +2482,9 @@ static const struct pci_device_id azx_ids[] = {
 	/* CometLake-S */
 	{ PCI_DEVICE(0x8086, 0xa3f0),
 	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
+	/* CometLake-R */
+	{ PCI_DEVICE(0x8086, 0xf0c8),
+	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
 	/* Icelake */
 	{ PCI_DEVICE(0x8086, 0x34c8),
 	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
-- 
2.25.1

