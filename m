Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6DD29FDF5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 07:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725832AbgJ3GsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 02:48:10 -0400
Received: from mga03.intel.com ([134.134.136.65]:2670 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgJ3GsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 02:48:10 -0400
IronPort-SDR: 2rSIPl350TqppAs81TIt/1/epXiToYs0xrpx9vzRO8kAJH2Sh6yTgoayi9itBu3WJ8mwWnBfGa
 66M3kOupvpDQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9789"; a="168663832"
X-IronPort-AV: E=Sophos;i="5.77,432,1596524400"; 
   d="scan'208";a="168663832"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 23:48:09 -0700
IronPort-SDR: IFt1+nBqLLkX+l35QIPUUmSBbUlkSuVnLhPzrmHKAVzzfSBlrjNmdZKQDx9XOzMviCj9iA3seM
 58xAKyTukACw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,432,1596524400"; 
   d="scan'208";a="361760812"
Received: from brentlu-desk0.itwn.intel.com ([10.5.253.11])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Oct 2020 23:47:54 -0700
From:   Brent Lu <brent.lu@intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Yong Zhi <yong.zhi@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Brent Lu <brent.lu@intel.com>,
        Fred Oh <fred.oh@linux.intel.com>,
        Rander Wang <rander.wang@intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Jason Yan <yanaijie@huawei.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Add rt1015 support to CML boards
Date:   Fri, 30 Oct 2020 14:36:52 +0800
Message-Id: <20201030063654.25877-1-brent.lu@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First patch adds tdm 4-slot 100fs DAI setting to avoid jitter of using
64fs on CML boards. Second patch is a DMI quirk for HP Dooly.


Brent Lu (2):
  ASoC: intel: sof_rt5682: Add support for cml_rt1015_rt5682
  ASoC: intel: sof_rt5682: Add quirk for Dooly

 sound/soc/intel/boards/sof_rt5682.c           | 61 +++++++++++++++++--
 .../intel/common/soc-acpi-intel-cml-match.c   | 13 ++++
 2 files changed, 69 insertions(+), 5 deletions(-)

-- 
2.17.1

