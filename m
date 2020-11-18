Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1D7C2B7E8E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 14:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgKRNtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 08:49:06 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:59052 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgKRNtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 08:49:06 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kfNpV-0003wW-W4; Wed, 18 Nov 2020 13:49:02 +0000
From:   Colin King <colin.king@canonical.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Lyude Paul <lyude@redhat.com>,
        Lee Jones <lee.jones@linaro.org>,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/selftests/test-drm_dp_mst_helper: fix memory leak allocated to 'out'
Date:   Wed, 18 Nov 2020 13:49:01 +0000
Message-Id: <20201118134901.461841-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently when txmsg fails to allocate then there is a leak on 'out'. Fix
this by setting result to false and exiting via the clean up exit path.
Note since txmsg is NULL at this point, the kfree of txmsg is a no-op.

Addresses-Coverity: ("Resource leak")
Fixes: 09234b88ef55 ("drm/selftests/test-drm_dp_mst_helper: Move 'sideband_msg_req_encode_decode' onto the heap")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c b/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
index 6b4759ed6bfd..dbac073ed385 100644
--- a/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
+++ b/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
@@ -131,8 +131,10 @@ sideband_msg_req_encode_decode(struct drm_dp_sideband_msg_req_body *in)
 		return false;
 
 	txmsg = kzalloc(sizeof(*txmsg), GFP_KERNEL);
-	if (!txmsg)
-		return false;
+	if (!txmsg) {
+		result = false;
+		goto out;
+	}
 
 	drm_dp_encode_sideband_req(in, txmsg);
 	ret = drm_dp_decode_sideband_req(txmsg, out);
-- 
2.28.0

