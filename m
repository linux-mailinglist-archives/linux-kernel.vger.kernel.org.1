Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 968812B8260
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 17:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbgKRQx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 11:53:58 -0500
Received: from mga01.intel.com ([192.55.52.88]:27137 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726924AbgKRQx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 11:53:57 -0500
IronPort-SDR: /A9BJfCtwSrtWhdRRneap9n4Jp+NzdT6XpdY2Z++xA2+fX1ha1ZVYjHw7l+Y6T9EvX1QSS03W1
 2un7SHM+E8Sg==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="189225091"
X-IronPort-AV: E=Sophos;i="5.77,488,1596524400"; 
   d="scan'208";a="189225091"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 08:53:54 -0800
IronPort-SDR: 5w0I3UUSeGLJLJiMv9LlRTYT7oJkfY7IZNpLLOgy5Esh1RbcfdTwHGfgbhMYwoP7jIzegSSmsn
 9b8YKy0Ym60w==
X-IronPort-AV: E=Sophos;i="5.77,488,1596524400"; 
   d="scan'208";a="330580051"
Received: from dlmurray-mobl3.ger.corp.intel.com (HELO localhost) ([10.251.82.13])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 08:53:51 -0800
From:   Jani Nikula <jani.nikula@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     jani.nikula@intel.com, intel-gfx@lists.freedesktop.org,
        Kalle Valo <kvalo@codeaurora.org>, ath11k@lists.infradead.org
Subject: [PATCH 4/6] ath11k: make relay callbacks const
Date:   Wed, 18 Nov 2020 18:53:18 +0200
Message-Id: <20201118165320.26829-4-jani.nikula@intel.com>
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

Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: ath11k@lists.infradead.org
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/net/wireless/ath/ath11k/spectral.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/spectral.c b/drivers/net/wireless/ath/ath11k/spectral.c
index ac2a8cfdc1c0..1afe67759659 100644
--- a/drivers/net/wireless/ath/ath11k/spectral.c
+++ b/drivers/net/wireless/ath/ath11k/spectral.c
@@ -148,7 +148,7 @@ static int remove_buf_file_handler(struct dentry *dentry)
 	return 0;
 }
 
-static struct rchan_callbacks rfs_scan_cb = {
+static const struct rchan_callbacks rfs_scan_cb = {
 	.create_buf_file = create_buf_file_handler,
 	.remove_buf_file = remove_buf_file_handler,
 };
-- 
2.20.1

