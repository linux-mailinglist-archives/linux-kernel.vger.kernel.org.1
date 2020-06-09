Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D51C71F3654
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 10:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbgFIIsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 04:48:52 -0400
Received: from mga12.intel.com ([192.55.52.136]:43990 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728159AbgFIIsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 04:48:52 -0400
IronPort-SDR: tw/4WDr7t+AECnTjtx2Zoq8Xuht1i8X4SZyPrhj1iMF7eE9UAhTUxuc08aROrP0MUaflcmNQiO
 qWMwuR1BaLIA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2020 01:48:51 -0700
IronPort-SDR: 7yonVY59kWE9uNCVidUEnpiMFOD+LWoHztW5Cj8cuLFu7pz7NBubQir4W+6VvfUuYtyt+jAFvo
 m/lzNksQuAjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,491,1583222400"; 
   d="scan'208";a="473001803"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by fmsmga005.fm.intel.com with ESMTP; 09 Jun 2020 01:48:47 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: [PATCH 0/4] soundwire: add SoundWire 1.2 spec support
Date:   Tue,  9 Jun 2020 04:54:32 +0800
Message-Id: <20200608205436.2402-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds basic support for SoundWire 1.2.

Pierre-Louis Bossart (4):
  soundwire: add definitions for 1.2 spec
  soundwire: bus_type: convert open-coded while() to for() loop
  soundwire: extend SDW_SLAVE_ENTRY
  soundwire: bus: initialize bus clock base and scale registers

 drivers/soundwire/bus.c                 | 107 ++++++++++++++++++++++
 drivers/soundwire/bus_type.c            |  19 ++--
 include/linux/mod_devicetable.h         |   2 +
 include/linux/soundwire/sdw.h           |  11 ++-
 include/linux/soundwire/sdw_registers.h | 117 +++++++++++++++++++++++-
 scripts/mod/devicetable-offsets.c       |   2 +
 scripts/mod/file2alias.c                |   6 +-
 7 files changed, 250 insertions(+), 14 deletions(-)

-- 
2.17.1

