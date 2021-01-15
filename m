Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7BF2F72CD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 07:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbhAOGSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 01:18:35 -0500
Received: from mga05.intel.com ([192.55.52.43]:21415 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726702AbhAOGSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 01:18:34 -0500
IronPort-SDR: 8GEyeRXgJRR7t2JrM5V8EB6OcFTL+qChip9QKsGaJNXIZSUkTBhtAzVussrx2qjyTyrSwZbBNI
 5z23xcPs9piw==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="263296412"
X-IronPort-AV: E=Sophos;i="5.79,348,1602572400"; 
   d="scan'208";a="263296412"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 22:16:48 -0800
IronPort-SDR: mnVgka02Sl1SnutUAJk+1wWr2oACyhES3UBR8sx5a+sh96oUIQtho+6nMIcVYvHCrQG+ksXjAT
 TKFLeZffMh8A==
X-IronPort-AV: E=Sophos;i="5.79,348,1602572400"; 
   d="scan'208";a="382551858"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 22:16:45 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH 0/2] ASoC/SoundWire: fix timeout values
Date:   Fri, 15 Jan 2021 14:16:49 +0800
Message-Id: <20210115061651.9740-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The timeout for an individual transaction w/ the Cadence IP is the same as
the entire resume operation for codecs.
This doesn't make sense, we need to have at least one order of magnitude
between individual transactions and the entire resume operation.

Set the timeout on the Cadence side to 500ms and 5s for the codec resume.

Both ASoC and SoundWire trees are fine for this series.

Pierre-Louis Bossart (2):
  ASoC: codecs: soundwire: increase resume timeout
  soundwire: cadence: reduce timeout on transactions

 drivers/soundwire/cadence_master.c | 2 +-
 sound/soc/codecs/max98373-sdw.c    | 4 +++-
 sound/soc/codecs/rt1308-sdw.c      | 2 +-
 sound/soc/codecs/rt5682.h          | 2 +-
 sound/soc/codecs/rt700-sdw.c       | 2 +-
 sound/soc/codecs/rt711-sdw.c       | 2 +-
 sound/soc/codecs/rt715-sdw.c       | 2 +-
 7 files changed, 9 insertions(+), 7 deletions(-)

-- 
2.17.1

