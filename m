Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB491EA0CD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 11:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbgFAJTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 05:19:05 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:51528 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726011AbgFAJTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 05:19:01 -0400
Received: from Internal Mail-Server by MTLPINE2 (envelope-from vadimp@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 1 Jun 2020 12:18:54 +0300
Received: from r-build-lowlevel.mtr.labs.mlnx. (r-build-lowlevel.mtr.labs.mlnx [10.209.0.190])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 0519IsSo003135;
        Mon, 1 Jun 2020 12:18:54 +0300
From:   Vadim Pasternak <vadimp@mellanox.com>
To:     andy@infradead.org, dvhart@infradead.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vadim Pasternak <vadimp@mellanox.com>
Subject: [PATCH platform-next v1 0/8] platform/x86: Add new features for Mellanox systems
Date:   Mon,  1 Jun 2020 12:18:43 +0300
Message-Id: <20200601091851.5491-1-vadimp@mellanox.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patchset adds new features for the existing Mellanox systems.

Patch #1 allows to configure number of hotplug 'sysfs' attributes for
		 the particular system class according to the hardware data for
		 the specific system from this class, instead of configuring it
		 up-to maximum number in the class.
Patch #2 adds environmental data to hotplug uevent.
Patches #3-#4 adds more definitions for system attributes.
Patch #5 extends 'mlxreg-io' driver with complex attributes support.
Patches #6 extends documentation with new attributes.
Patches #7-#8 extends FAN platform data with register presence field.

Vadim Pasternak (8):
  platform/mellanox: mlxreg-hotplug: Use capability register for
    attribute creation
  platform/mellanox: mlxreg-hotplug: Add environmental data to uevent
  platform_data/mlxreg: Add support for complex attributes
  platform/x86: mlx-platform: Add more definitions for system attributes
  platform/mellanox: mlxreg-io: Add support for complex attributes
  Documentation/ABI: Add new attribute for mlxreg-io sysfs interfaces
  platform_data/mlxreg: Add presence register field for FAN devices
  platform/x86: mlx-platform: Extend FAN platform data description

 Documentation/ABI/stable/sysfs-driver-mlxreg-io |  17 +++
 drivers/platform/mellanox/mlxreg-hotplug.c      |  81 ++++++++++----
 drivers/platform/mellanox/mlxreg-io.c           |  47 ++++++--
 drivers/platform/x86/mlx-platform.c             | 141 ++++++++++++++++++++++++
 include/linux/platform_data/mlxreg.h            |   4 +
 5 files changed, 258 insertions(+), 32 deletions(-)

-- 
2.11.0

