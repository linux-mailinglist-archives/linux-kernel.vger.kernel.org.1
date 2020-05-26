Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B54E1D920A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 10:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbgESIah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 04:30:37 -0400
Received: from mga05.intel.com ([192.55.52.43]:31993 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbgESIag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 04:30:36 -0400
IronPort-SDR: xoU9tTcdvdG5VedeGGQTVYCCjVrY7SBMhVVfeBLntepbusMXTCVR96/o3g2bw6EFkT2iyKENT/
 2i05HKiDHPzg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2020 01:30:36 -0700
IronPort-SDR: AQXqWabIG9YUNyN4LGq+DhgjSEPaAgzGHICFr/3PQwdOW1dL8+SZBpRnXzNjZGDuIWULwX77r9
 VgF0wrEZVgOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,409,1583222400"; 
   d="scan'208";a="264233977"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga003.jf.intel.com with ESMTP; 19 May 2020 01:30:31 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: [PATCH 0/3] soundwire: add sysfs support
Date:   Tue, 19 May 2020 04:35:48 +0800
Message-Id: <20200518203551.2053-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add soundwire sysfs support.

Pierre-Louis Bossart (3):
  soundwire: disco: s/ch/channels/
  soundwire: master: add sysfs support
  soundwire: add Slave sysfs support

 .../ABI/testing/sysfs-bus-soundwire-master    |  23 ++
 .../ABI/testing/sysfs-bus-soundwire-slave     |  91 ++++++
 drivers/soundwire/Makefile                    |   3 +-
 drivers/soundwire/bus.c                       |   1 +
 drivers/soundwire/bus.h                       |   1 +
 drivers/soundwire/bus_type.c                  |   9 +-
 drivers/soundwire/master.c                    |  84 +++++
 drivers/soundwire/mipi_disco.c                |  11 +-
 drivers/soundwire/sysfs_local.h               |  14 +
 drivers/soundwire/sysfs_slave.c               | 215 +++++++++++++
 drivers/soundwire/sysfs_slave_dpn.c           | 300 ++++++++++++++++++
 include/linux/soundwire/sdw.h                 |   8 +-
 12 files changed, 748 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-soundwire-master
 create mode 100644 Documentation/ABI/testing/sysfs-bus-soundwire-slave
 create mode 100644 drivers/soundwire/sysfs_local.h
 create mode 100644 drivers/soundwire/sysfs_slave.c
 create mode 100644 drivers/soundwire/sysfs_slave_dpn.c

-- 
2.17.1

