Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF87A2C270E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 14:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388026AbgKXNZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 08:25:59 -0500
Received: from mga03.intel.com ([134.134.136.65]:19615 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728682AbgKXNZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 08:25:59 -0500
IronPort-SDR: IdTGzJlXhtMnimGgWGojycQTP8k+IrQcB+CwVsW+q2PGkkdnZX/Em2RGLDz0NcD5OLMxr4MYBl
 cT9//+LiwYPg==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="172039529"
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; 
   d="scan'208";a="172039529"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 05:25:58 -0800
IronPort-SDR: gETpOmSBhzL7Gl+IpiZZtP1DJNplQimRg9iyo6QDFx2+wZbrK+EwrOpUnEjUJgX91+VJjSho8t
 dnpndV72Txew==
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; 
   d="scan'208";a="546830554"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 05:25:54 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: [PATCH 0/5] soundwire: only clear valid interrupts
Date:   Tue, 24 Nov 2020 09:33:13 +0800
Message-Id: <20201124013318.8963-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We wrote 1 to the handled interrupts bits along with 0 to all other bits
to the SoundWire DPx interrupt register. However, DP0 has reserved fields
and the read-only SDCA_CASCADE bit. DPN also has reserved fields. We should
not try to write values in these fields.
Besides, we deal with pending interrupts in a loop but we didn't reset the
slave_notify status.

Pierre-Louis Bossart (5):
  soundwire: bus: add comments to explain interrupt loop filter
  soundwire: bus: reset slave_notify status at each loop
  soundwire: registers: add definitions for clearable interrupt fields
  soundwire: bus: only clear valid DP0 interrupts
  soundwire: bus: only clear valid DPN interrupts

 drivers/soundwire/bus.c                 | 27 +++++++++++++++++--------
 include/linux/soundwire/sdw_registers.h | 11 ++++++++++
 2 files changed, 30 insertions(+), 8 deletions(-)

-- 
2.17.1

