Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03B842F7254
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 06:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731935AbhAOFjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 00:39:24 -0500
Received: from mga17.intel.com ([192.55.52.151]:21251 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727654AbhAOFjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 00:39:23 -0500
IronPort-SDR: tesuXE9P4sOLzgmlPweys1PQvG3PBh+wrC49ZTouVdIswL6FFtDvrJN1/63NRPu5mWYWRYPCgR
 DyHvCHAKP8Yg==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="158276372"
X-IronPort-AV: E=Sophos;i="5.79,348,1602572400"; 
   d="scan'208";a="158276372"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 21:37:38 -0800
IronPort-SDR: Nk686ladbWhuXKf4QEUop2KYUfhQln5NLiiAnpVSzxFMl+1llXbN3mZm2wvJQMVATuCN7Xs3Bg
 XhbUFHY31jQw==
X-IronPort-AV: E=Sophos;i="5.79,348,1602572400"; 
   d="scan'208";a="382542415"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 21:37:34 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        hui.wang@canonical.com, pierre-louis.bossart@linux.intel.com,
        sanyog.r.kale@intel.com, bard.liao@intel.com
Subject: [PATCH 0/5] soundwire: fix ACK/NAK handling and improve log
Date:   Fri, 15 Jan 2021 13:37:33 +0800
Message-Id: <20210115053738.22630-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing code reports a NAK only when ACK=0
This is not aligned with the SoundWire 1.x specifications.

Table 32 in the SoundWire 1.2 specification shows that a Device shall
not set NAK=1 if ACK=1. But Table 33 shows the Combined Response
may very well be NAK=1/ACK=1, e.g. if another Device than the one
addressed reports a parity error.

NAK=1 signals a 'Command_Aborted', regardless of the ACK bit value.

Move the tests for NAK so that the NAK=1/ACK=1 combination is properly
detected according to the specification.

Also, improve the demesg log to get more information for debugging.

Bard Liao (1):
  soundwire: bus: add more details to track failed transfers

Pierre-Louis Bossart (4):
  soundwire: use consistent format for Slave devID logs
  soundwire: cadence: add status in dev_dbg 'State change' log
  soundwire: cadence: fix ACK/NAK handling
  soundwire: cadence: adjust verbosity in response handling

 drivers/soundwire/bus.c            | 11 ++++++-----
 drivers/soundwire/cadence_master.c | 29 +++++++++++++++--------------
 drivers/soundwire/slave.c          | 10 ++++------
 3 files changed, 25 insertions(+), 25 deletions(-)

-- 
2.17.1

