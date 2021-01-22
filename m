Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF213006C9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 16:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbhAVPLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 10:11:41 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:45201 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729097AbhAVPKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 10:10:44 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1l2y4U-00008M-10; Fri, 22 Jan 2021 15:09:58 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Ramalingam C <ramalingam.c@intel.com>,
        Anshuman Gupta <anshuman.gupta@intel.com>,
        Uma Shankar <uma.shankar@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/i915/hdcp: Fix return of value in uninitialized variable ret
Date:   Fri, 22 Jan 2021 15:09:57 +0000
Message-Id: <20210122150957.209779-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently when there are other connectors on the port using HDCP the
function _intel_hdcp_disable returns a garbage uninitialized value in
variable ret.  I believe the intention is to return 0, so return this
literal value instead of the value in ret.

Addresses-Coverity: ("Uninitialized scalar return")
Fixes: 899c8762f981 ("drm/i915/hdcp: Configure HDCP2.2 MST steram encryption status")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/i915/display/intel_hdcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_hdcp.c b/drivers/gpu/drm/i915/display/intel_hdcp.c
index db8dff2eeb0a..a0e7b0bf892b 100644
--- a/drivers/gpu/drm/i915/display/intel_hdcp.c
+++ b/drivers/gpu/drm/i915/display/intel_hdcp.c
@@ -883,7 +883,7 @@ static int _intel_hdcp_disable(struct intel_connector *connector)
 	 * until it disabled HDCP encryption for all connectors in MST topology.
 	 */
 	if (dig_port->num_hdcp_streams > 0)
-		return ret;
+		return 0;
 
 	hdcp->hdcp_encrypted = false;
 	intel_de_write(dev_priv, HDCP_CONF(dev_priv, cpu_transcoder, port), 0);
-- 
2.29.2

