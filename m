Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A15AD24929F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 04:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgHSCAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 22:00:49 -0400
Received: from mga04.intel.com ([192.55.52.120]:3680 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726815AbgHSCAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 22:00:46 -0400
IronPort-SDR: olPNFUZ2RRyyc6aw1Sb2ZP0KrxXKGY0wBAuNVj6GF+wP8KQVIzj9TOa3nolckyyMxIfobn3I+U
 +kfNLRJ4QagA==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="152449419"
X-IronPort-AV: E=Sophos;i="5.76,329,1592895600"; 
   d="scan'208";a="152449419"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 19:00:43 -0700
IronPort-SDR: RLty5/QthTzwkF3aCEloHkasj0GujUwB9QSiNGYW6ZnfDcs1KPXOzKe/jSJ7h+/bVLo9KHPlDs
 PB9tljYg4eSg==
X-IronPort-AV: E=Sophos;i="5.76,329,1592895600"; 
   d="scan'208";a="279565023"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 19:00:40 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: [PATCH 0/7] soundwire: filter out invalid PARITY errors
Date:   Tue, 18 Aug 2020 22:06:49 +0800
Message-Id: <20200818140656.29014-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some codecs may report fake PARITY errors in the initial state. This
series will filter them out.

Pierre-Louis Bossart (7):
  soundwire: bus: use property to set interrupt masks
  soundwire: bus: filter-out unwanted interrupt reports
  soundwire: slave: add first_interrupt_done status
  soundwire: bus: use quirk to filter out invalid parity errors
  ASoC: codecs: realtek-soundwire: ignore initial PARITY errors
  soundwire: bus: export broadcast read/write capability for tests
  soundwire: cadence: add parity error injection through debugfs

 drivers/soundwire/bus.c            | 93 ++++++++++++++++++++++++------
 drivers/soundwire/bus.h            |  4 ++
 drivers/soundwire/cadence_master.c | 86 +++++++++++++++++++++++++++
 drivers/soundwire/slave.c          |  1 +
 include/linux/soundwire/sdw.h      |  9 +++
 sound/soc/codecs/max98373-sdw.c    |  3 +
 sound/soc/codecs/rt1308-sdw.c      |  3 +
 sound/soc/codecs/rt5682-sdw.c      |  5 ++
 sound/soc/codecs/rt700-sdw.c       |  5 ++
 sound/soc/codecs/rt711-sdw.c       |  5 ++
 sound/soc/codecs/rt715-sdw.c       |  5 ++
 sound/soc/codecs/wsa881x.c         |  1 +
 12 files changed, 202 insertions(+), 18 deletions(-)

-- 
2.17.1

