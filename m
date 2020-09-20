Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCB99271BB7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 09:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgIUHZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 03:25:47 -0400
Received: from mga01.intel.com ([192.55.52.88]:12610 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbgIUHZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 03:25:47 -0400
IronPort-SDR: ZlgdVX+NsizLcI/We84FpzhMsLf71SFh/B6oUPq3OZcArSuuHMawurIvTZjK+N6qidWEn4xB4z
 1863/HHd/g/Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9750"; a="178401086"
X-IronPort-AV: E=Sophos;i="5.77,286,1596524400"; 
   d="scan'208";a="178401086"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2020 00:25:46 -0700
IronPort-SDR: XuY87G/blZLuUuWCPRFOxUsjWco43PVQqg3IOA1Ug9z0CYrfG76ZjEKGkriS5w7ZVT9V20CWOh
 4+Dr/N12P55w==
X-IronPort-AV: E=Sophos;i="5.77,286,1596524400"; 
   d="scan'208";a="485325626"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2020 00:25:43 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: [PATCH 0/3] soundwire: enable Data Port test modes
Date:   Mon, 21 Sep 2020 03:32:04 +0800
Message-Id: <20200920193207.31241-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Test modes are required for all SoundWire IP, and help debug
integration issues. This series adds debugfs support and data
port test fail interrupt to enable data port test mode feature
on Intel platforms. 

Pierre-Louis Bossart (3):
  soundwire: enable Data Port test modes
  soundwire: intel: enable test modes
  soundwire: cadence: add data port test fail interrupt

 drivers/soundwire/bus.c                       |  6 +++
 drivers/soundwire/cadence_master.c            | 27 ++++++++++--
 .../soundwire/generic_bandwidth_allocation.c  |  6 ++-
 drivers/soundwire/intel.c                     | 42 +++++++++++++++++++
 drivers/soundwire/stream.c                    |  3 +-
 include/linux/soundwire/sdw.h                 |  6 +++
 6 files changed, 84 insertions(+), 6 deletions(-)

-- 
2.17.1

