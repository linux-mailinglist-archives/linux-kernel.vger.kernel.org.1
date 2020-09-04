Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 600EE25D3CE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 10:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729909AbgIDIlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 04:41:23 -0400
Received: from mga04.intel.com ([192.55.52.120]:13460 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726425AbgIDIlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 04:41:23 -0400
IronPort-SDR: I9wKeNtuF0a6JkzvXN7VVfyZFeTvf7W2r/CCkFO6QWhszUS/ukLPSyadD+KPvvHK33GRRz7Ml9
 0iTR1EMsNPPg==
X-IronPort-AV: E=McAfee;i="6000,8403,9733"; a="155108895"
X-IronPort-AV: E=Sophos;i="5.76,389,1592895600"; 
   d="scan'208";a="155108895"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2020 01:41:22 -0700
IronPort-SDR: Ok55I6yq4TTwLRRlpQIWfnIrtGkBmGNQoiM3mQQUNdGvoetYpFlWOb4lNYuudu9ZpCmVmxI8wZ
 lIzOxAJTTJ+g==
X-IronPort-AV: E=Sophos;i="5.76,389,1592895600"; 
   d="scan'208";a="284358880"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2020 01:41:19 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: [PATCH v2 0/4] soundwire: Remove sdw stream operations from Intel
Date:   Fri,  4 Sep 2020 04:47:35 +0800
Message-Id: <20200903204739.31206-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sdw stream operation APIs can be called once per stream. Move these
operations to dailink ops. The linked series is "ASoC: Add sdw stream
operations to dailink ops".

Pierre-Louis Bossart (4):
  soundwire: stream: fix NULL/IS_ERR confusion
  soundwire: intel: fix NULL/ERR_PTR confusion
  soundwire: intel: remove .trigger operation
  soundwire: intel: remove stream handling from .prepare and .hw_free

 drivers/soundwire/intel.c  | 60 +++++---------------------------------
 drivers/soundwire/stream.c |  2 +-
 2 files changed, 9 insertions(+), 53 deletions(-)

-- 
2.17.1

