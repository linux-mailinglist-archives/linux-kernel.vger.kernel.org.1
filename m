Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7EBC231D32
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jul 2020 13:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgG2LIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jul 2020 07:08:00 -0400
Received: from mga06.intel.com ([134.134.136.31]:6746 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbgG2LIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 07:08:00 -0400
IronPort-SDR: f9qGAA6BYOLuaY29Vjq93xjhtklZ+W46kExS02fKrS/P81Qz5aNhrnypfOU8Jo9O9P+pGQHoi2
 oy7PR/Rlnz+A==
X-IronPort-AV: E=McAfee;i="6000,8403,9696"; a="212927275"
X-IronPort-AV: E=Sophos;i="5.75,410,1589266800"; 
   d="scan'208";a="212927275"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2020 04:07:59 -0700
IronPort-SDR: 6q3ObfXHhAmD/7ZkVTNxq7TjBbtQxv4gPtus3R33bX3z+k7cQWfbvY1vcf5AWir2F7yANU6IZ4
 K09zWkdPHbKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,410,1589266800"; 
   d="scan'208";a="490254701"
Received: from brentlu-desk0.itwn.intel.com ([10.5.253.11])
  by fmsmga006.fm.intel.com with ESMTP; 29 Jul 2020 04:07:54 -0700
From:   Brent Lu <brent.lu@intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Brent Lu <brent.lu@intel.com>, linux-kernel@vger.kernel.org,
        Daniel Stuart <daniel.stuart14@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Sam McNally <sammc@chromium.org>,
        Damian van Soelen <dj.vsoelen@gmail.com>
Subject: [PATCH 0/2] Add period size constraint for Atom Chromebook
Date:   Wed, 29 Jul 2020 19:03:03 +0800
Message-Id: <1596020585-11517-1-git-send-email-brent.lu@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two different constraints are implemented: one is in platform's CPU
DAI to enforce period sizes which are already used in Android BSP. The
other is in Atom Chromebook's machine driver to use 240 as period size.

Brent Lu (1):
  ASoC: intel: atom: Add period size constraint

Yu-Hsuan Hsu (1):
  ASoC: Intel: Add period size constraint on strago board

 sound/soc/intel/atom/sst-mfld-platform-pcm.c | 15 +++++++++++++++
 sound/soc/intel/boards/cht_bsw_max98090_ti.c | 14 +++++++++++++-
 sound/soc/intel/boards/cht_bsw_rt5645.c      | 14 +++++++++++++-
 3 files changed, 41 insertions(+), 2 deletions(-)

-- 
2.7.4

