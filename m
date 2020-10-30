Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B906D2A0C4A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 18:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgJ3RRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 13:17:01 -0400
Received: from mga05.intel.com ([192.55.52.43]:12152 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbgJ3RRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 13:17:01 -0400
IronPort-SDR: AbajC1DcM3MWsjpgUyrnwRbR/FsqQSTuEyEojmu8mGsEiglGIyZjqcpspQMX3nEFYtWdXxSVZU
 ci4aRz0zOIUA==
X-IronPort-AV: E=McAfee;i="6000,8403,9790"; a="253345790"
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="253345790"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 10:17:01 -0700
IronPort-SDR: /+T9kDmhijZAVN9aAqF7eeoqmhyF9zsJaTJLqkCrvSrxEvZ9DU3VPNNbezuuANQryLA3t2eYtv
 uwfZX2Hvv+QQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="469584679"
Received: from brentlu-desk0.itwn.intel.com ([10.5.253.11])
  by orsmga004.jf.intel.com with ESMTP; 30 Oct 2020 10:16:57 -0700
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
Subject: [PATCH v2 0/2] Add rt1015 support to CML boards
Date:   Sat, 31 Oct 2020 01:05:57 +0800
Message-Id: <20201030170559.20370-1-brent.lu@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First patch adds tdm 4-slot 100fs DAI setting to avoid jitter of using
64fs on CML boards. Second patch is a DMI quirk for HP Dooly.

Changes since v1:
-Add comment on Dooly's DMI quirk

Brent Lu (2):
  ASoC: intel: sof_rt5682: Add support for cml_rt1015_rt5682
  ASoC: intel: sof_rt5682: Add quirk for Dooly

 sound/soc/intel/boards/sof_rt5682.c           | 65 +++++++++++++++++--
 .../intel/common/soc-acpi-intel-cml-match.c   | 13 ++++
 2 files changed, 73 insertions(+), 5 deletions(-)

-- 
2.17.1

