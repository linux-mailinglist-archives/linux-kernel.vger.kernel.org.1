Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 289B829A8D5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 11:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896863AbgJ0KBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 06:01:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:42612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896037AbgJ0Jvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 05:51:43 -0400
Received: from mail.kernel.org (ip5f5ad5af.dynamic.kabel-deutschland.de [95.90.213.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5710A22403;
        Tue, 27 Oct 2020 09:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603792301;
        bh=GXxTZan9lCjKZoVF0lUNE8RECi6/oK6GikJCLqZEg9Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CA3IYj1Fzt6EDUWDkvZVmekclltK8XNXWCleUkiU9mCzICo8dgbIJjO8TabbYNfGm
         dYvZXxQkPyXED1kP5TFCJFNzFcQf2TDIHlKznDzRTAsvbs629tWNadxZ6/4mp8bf7+
         ZnOJZqrTJbkAZAhZy835FyGXOdfJC9u1oned1KQA=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kXLdj-003FEt-92; Tue, 27 Oct 2020 10:51:39 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, Lyude Paul <lyude@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/32] drm/dp: fix kernel-doc warnings at drm_dp_helper.c
Date:   Tue, 27 Oct 2020 10:51:15 +0100
Message-Id: <03c9c8ba3f492aca76e2b4836803219cd9c971cf.1603791716.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603791716.git.mchehab+huawei@kernel.org>
References: <cover.1603791716.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As warned by kernel-doc:

	./drivers/gpu/drm/drm_dp_helper.c:385: warning: Function parameter or member 'type' not described in 'drm_dp_downstream_is_type'
	./drivers/gpu/drm/drm_dp_helper.c:886: warning: Function parameter or member 'dev' not described in 'drm_dp_downstream_mode'

Some function parameters weren't documented.

Fixes: 38784f6f8805 ("drm/dp: Add helpers to identify downstream facing port types")
Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/gpu/drm/drm_dp_helper.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
index b1c71af88579..deeed73f4ed6 100644
--- a/drivers/gpu/drm/drm_dp_helper.c
+++ b/drivers/gpu/drm/drm_dp_helper.c
@@ -374,6 +374,10 @@ static bool is_edid_digital_input_dp(const struct edid *edid)
  * drm_dp_downstream_is_type() - is the downstream facing port of certain type?
  * @dpcd: DisplayPort configuration data
  * @port_cap: port capabilities
+ * @type: port type to be checked. Can be:
+ * 	  %DP_DS_PORT_TYPE_DP, %DP_DS_PORT_TYPE_VGA, %DP_DS_PORT_TYPE_DVI,
+ * 	  %DP_DS_PORT_TYPE_HDMI, %DP_DS_PORT_TYPE_NON_EDID,
+ *	  %DP_DS_PORT_TYPE_DP_DUALMODE or %DP_DS_PORT_TYPE_WIRELESS.
  *
  * Caveat: Only works with DPCD 1.1+ port caps.
  *
@@ -870,6 +874,7 @@ EXPORT_SYMBOL(drm_dp_downstream_444_to_420_conversion);
 
 /**
  * drm_dp_downstream_mode() - return a mode for downstream facing port
+ * @dev: DRM device
  * @dpcd: DisplayPort configuration data
  * @port_cap: port capabilities
  *
-- 
2.26.2

