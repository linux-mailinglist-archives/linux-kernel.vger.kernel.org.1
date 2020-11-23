Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B16752C12C8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 19:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390669AbgKWSA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 13:00:26 -0500
Received: from mga06.intel.com ([134.134.136.31]:43942 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390648AbgKWSAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 13:00:25 -0500
IronPort-SDR: ae3tFYITL//BtqmnhwNpaUa+cJUJj7lW+UfyYkmde5+Veeic86HfbPCtawbTibGLtutUQLxTcK
 ey21wAOQkovw==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="233424422"
X-IronPort-AV: E=Sophos;i="5.78,364,1599548400"; 
   d="scan'208";a="233424422"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 10:00:25 -0800
IronPort-SDR: I/dIaj8McgBAF8fbBMTWYNjDwRaHgScIBhjDR8/VnoQsLPDta9Rw+2HbaQNWVmYH8s1xj6cZ9X
 0qFD9loD8gbw==
X-IronPort-AV: E=Sophos;i="5.78,364,1599548400"; 
   d="scan'208";a="361534968"
Received: from suygunge-mobl.ger.corp.intel.com (HELO localhost) ([10.249.40.108])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 10:00:22 -0800
From:   Jani Nikula <jani.nikula@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        intel-gfx@lists.freedesktop.org, jani.nikula@intel.com,
        Kalle Valo <kvalo@codeaurora.org>, ath11k@lists.infradead.org
Subject: [PATCH 7/9] ath11k: make relay callbacks const
Date:   Mon, 23 Nov 2020 19:59:27 +0200
Message-Id: <44e3d65b71025c462948d0c554061dc7b40ab488.1606153547.git.jani.nikula@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1606153547.git.jani.nikula@intel.com>
References: <cover.1606153547.git.jani.nikula@intel.com>
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

