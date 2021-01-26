Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26557303B68
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 12:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392251AbhAZLUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 06:20:42 -0500
Received: from mga11.intel.com ([192.55.52.93]:35240 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390377AbhAZIjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 03:39:48 -0500
IronPort-SDR: +Q3xd+7DBfrhR6KudA2y4SHhA/iCoTo9cauN6mWjj7U0AXYd3Nx5Ovabp/mLFZs69vQWeiGSul
 5tAKaszJ+abA==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="176357405"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="176357405"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 00:37:57 -0800
IronPort-SDR: +zyozuRQn8lz0RxRfSC5afVN3ieABG3WvjsYCtO3LcLcwuCoKulEKbGSQMlwIS+Lj7hNH408Ut
 jzvBWKVYTW0Q==
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="577731212"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 00:37:53 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH 0/3] soundwire: clear bus clash/parity interrupt before the mask is enabled
Date:   Tue, 26 Jan 2021 16:37:43 +0800
Message-Id: <20210126083746.3238-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SoundWire specification allows a Slave device to report a bus clash
or parity error with the in-band interrupt mechanism.
Unfortunately, on some platforms, these errors are randomly reported and
don't seem to be valid.
This series suggests the addition of a Master level quirk to discard such
interrupts. The quirk should in theory have been added at the Slave level,
but since the problem was detected with different generations of Slave
devices it's hard to point to a specific IP. The problem might also be
board-dependent and hence dealing with a Master quirk is simpler.

Bard Liao (2):
  soundwire: bus: clear bus clash interrupt before the mask is enabled
  soundwire: intel: add SDW_MASTER_QUIRKS_CLEAR_INITIAL_CLASH quirk

Pierre-Louis Bossart (1):
  soundwire: bus: clear parity interrupt before the mask is enabled

 drivers/soundwire/bus.c       | 19 +++++++++++++++++++
 drivers/soundwire/intel.c     |  3 +++
 include/linux/soundwire/sdw.h |  5 +++++
 3 files changed, 27 insertions(+)

-- 
2.17.1

