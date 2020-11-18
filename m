Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEB212B825E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 17:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgKRQxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 11:53:46 -0500
Received: from mga04.intel.com ([192.55.52.120]:4883 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727008AbgKRQxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 11:53:45 -0500
IronPort-SDR: kkv7YsrhtILOk8w4oazSh3BWoyG09gpV33roYvgPCbdk4tKWm+D+32atFPShRVUD24ybPUKuRO
 BuJsfNdZMNwA==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="168575151"
X-IronPort-AV: E=Sophos;i="5.77,488,1596524400"; 
   d="scan'208";a="168575151"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 08:53:42 -0800
IronPort-SDR: PQkw+u4g1E8KZ66VZVeohgH8HZEtONx18A96/lUcKW2DV70qutK0aQmuHcHkqbUbWj6hOsmltV
 d4w4pKZ894ZQ==
X-IronPort-AV: E=Sophos;i="5.77,488,1596524400"; 
   d="scan'208";a="359541185"
Received: from dlmurray-mobl3.ger.corp.intel.com (HELO localhost) ([10.251.82.13])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 08:53:40 -0800
From:   Jani Nikula <jani.nikula@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     jani.nikula@intel.com, intel-gfx@lists.freedesktop.org
Subject: [PATCH 2/6] drm/i915: make relay callbacks const
Date:   Wed, 18 Nov 2020 18:53:16 +0200
Message-Id: <20201118165320.26829-2-jani.nikula@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201118165320.26829-1-jani.nikula@intel.com>
References: <20201118165320.26829-1-jani.nikula@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that relay_open() accepts const callbacks, make relay callbacks
const.

Cc: intel-gfx@lists.freedesktop.org
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/i915/gt/uc/intel_guc_log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc_log.c b/drivers/gpu/drm/i915/gt/uc/intel_guc_log.c
index 9bbe8a795cb8..c92f2c056db4 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_guc_log.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_guc_log.c
@@ -134,7 +134,7 @@ static int remove_buf_file_callback(struct dentry *dentry)
 }
 
 /* relay channel callbacks */
-static struct rchan_callbacks relay_callbacks = {
+static const struct rchan_callbacks relay_callbacks = {
 	.subbuf_start = subbuf_start_callback,
 	.create_buf_file = create_buf_file_callback,
 	.remove_buf_file = remove_buf_file_callback,
-- 
2.20.1

