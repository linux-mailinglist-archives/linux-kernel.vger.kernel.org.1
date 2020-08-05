Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0B423CDD2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Aug 2020 19:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbgHERyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Aug 2020 13:54:52 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39312 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728841AbgHERyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:54:41 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1k3HeF-0000A2-96; Wed, 05 Aug 2020 11:31:55 +0000
From:   Colin King <colin.king@canonical.com>
To:     VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/vmwgfx: fix spelling mistake "Cound" -> "Could"
Date:   Wed,  5 Aug 2020 12:31:55 +0100
Message-Id: <20200805113155.18006-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a DRM_ERROR message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
index 4284c4bd444d..e67e2e8f6e6f 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
@@ -3037,7 +3037,7 @@ static int vmw_cmd_dx_bind_streamoutput(struct vmw_private *dev_priv,
 	res = vmw_dx_streamoutput_lookup(vmw_context_res_man(ctx_node->ctx),
 					 cmd->body.soid);
 	if (IS_ERR(res)) {
-		DRM_ERROR("Cound not find streamoutput to bind.\n");
+		DRM_ERROR("Could not find streamoutput to bind.\n");
 		return PTR_ERR(res);
 	}
 
-- 
2.27.0

