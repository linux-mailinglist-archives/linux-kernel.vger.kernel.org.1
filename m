Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CEF427E9CD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 15:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730745AbgI3N2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 09:28:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:38766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730209AbgI3NZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 09:25:21 -0400
Received: from mail.kernel.org (unknown [95.90.213.196])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85AD0221EC;
        Wed, 30 Sep 2020 13:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601472320;
        bh=pYfN+ieQDEUX+k8Yfc6bcFKKurTB/rbuEY6mHTD/h2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CMuLT/JDOHCnRn6h9cTT+zryRTbRTftIjSwvS6kkH7Fr3ZpdrM69pE8T6P6qMZfpO
         p7mB49kXxyVtfLjx9e0xryn7JdPUU8xjPnJlJF5Mhjt/K10hLHjCbZkuaAFHaZVrpx
         Vy42sPJvQzXxM4QdaxNi6DYwjyo/+E5699PnLNro=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kNc6g-001XJh-Jv; Wed, 30 Sep 2020 15:25:18 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 20/52] drm: drm_dsc.h: fix a kernel-doc markup
Date:   Wed, 30 Sep 2020 15:24:43 +0200
Message-Id: <3d467022325e15bba8dcb13da8fb730099303266.1601467849.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601467849.git.mchehab+huawei@kernel.org>
References: <cover.1601467849.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As warned by Sphinx:

	./Documentation/gpu/drm-kms-helpers:305: ./include/drm/drm_dsc.h:587: WARNING: Unparseable C cross-reference: 'struct'
	Invalid C declaration: Expected identifier in nested name, got keyword: struct [error at 6]
	  struct
	  ------^

The markup for one struct is wrong, as struct is used twice.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 include/drm/drm_dsc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_dsc.h b/include/drm/drm_dsc.h
index 887954cbfc60..732f32740c86 100644
--- a/include/drm/drm_dsc.h
+++ b/include/drm/drm_dsc.h
@@ -588,7 +588,7 @@ struct drm_dsc_picture_parameter_set {
  * This structure represents the DSC PPS infoframe required to send the Picture
  * Parameter Set metadata required before enabling VESA Display Stream
  * Compression. This is based on the DP Secondary Data Packet structure and
- * comprises of SDP Header as defined &struct struct dp_sdp_header in drm_dp_helper.h
+ * comprises of SDP Header as defined &struct dp_sdp_header in drm_dp_helper.h
  * and PPS payload defined in &struct drm_dsc_picture_parameter_set.
  *
  * @pps_header: Header for PPS as per DP SDP header format of type
-- 
2.26.2

