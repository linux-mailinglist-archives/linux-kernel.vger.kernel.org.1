Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 647F42740B2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 13:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgIVLXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 07:23:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:42094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726609AbgIVLW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 07:22:59 -0400
Received: from mail.kernel.org (ip5f5ad5bc.dynamic.kabel-deutschland.de [95.90.213.188])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D2C52388B;
        Tue, 22 Sep 2020 11:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600773778;
        bh=7oNtrCAc9I0+vEOO9y8qmGK4YQCampiFBV+447rAEz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LPrmPNhk3JDo5kGKrW+/awHCKS1KqyCRAc727Wh9x8CCW6sjmRMVlnVj7AgiIeKYW
         EZZLLx3PyknXJC1D7yE5a2MCw8soF7jp4ltvs4Tyjlyr2JuCOoSpJa4grnmec9ReTK
         lr16JI1oy/zqyIYWmQo0uzr5vVhn8YtKhXNSmRM0=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kKgNr-0010Kk-No; Tue, 22 Sep 2020 13:22:55 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>, Lyude Paul <lyude@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] drm/dp: fix a kernel-doc issue at drm_edid.c
Date:   Tue, 22 Sep 2020 13:22:54 +0200
Message-Id: <2a31b88b0cd1185e73fc8dc230b0b596f707cef7.1600773619.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1600773619.git.mchehab+huawei@kernel.org>
References: <cover.1600773619.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The name of the argument is different, causing those warnings:

	./drivers/gpu/drm/drm_edid.c:3754: warning: Function parameter or member 'video_code' not described in 'drm_display_mode_from_cea_vic'
	./drivers/gpu/drm/drm_edid.c:3754: warning: Excess function parameter 'vic' description in 'drm_display_mode_from_cea_vic'

Fixes: 7af655bce275 ("drm/dp: Add drm_dp_downstream_mode()")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/gpu/drm/drm_edid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index a82f37d44258..631125b46e04 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -3741,7 +3741,7 @@ drm_add_cmdb_modes(struct drm_connector *connector, u8 svd)
 /**
  * drm_display_mode_from_cea_vic() - return a mode for CEA VIC
  * @dev: DRM device
- * @vic: CEA VIC of the mode
+ * @video_code: CEA VIC of the mode
  *
  * Creates a new mode matching the specified CEA VIC.
  *
-- 
2.26.2

