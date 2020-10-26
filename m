Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6498C299861
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 22:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbgJZVBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 17:01:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:55104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729082AbgJZVA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 17:00:58 -0400
Received: from localhost.localdomain (unknown [192.30.34.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8461220829;
        Mon, 26 Oct 2020 21:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603746058;
        bh=S+371Kp/IEcbCZF0KcUqWMaT3Ju144hq0HM9jkLGkDs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m822+6P8iDuJDuwAS8D18uBp61uaCDfIDuLAp2fLjHgite5aZ+kwFSZXL/9WSJORV
         /KkDjt9Sv5LhsK/XWztvak4Sib5HC6/58r74NMoQ96R8+oF9+xfg2U8GtbhYS1R72v
         /EA4cEBQEuTfqiLLEzJm1NYeo4s8FYevkp8lepRY=
From:   Arnd Bergmann <arnd@kernel.org>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Galiffi <david.galiffi@amd.com>,
        Jun Lei <Jun.Lei@amd.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Wenjing Liu <wenjing.liu@amd.com>, Aric Cyr <aric.cyr@amd.com>,
        abdoulaye berthe <abdoulaye.berthe@amd.com>,
        Hersen Wu <hersenxs.wu@amd.com>,
        Martin Tsai <martin.tsai@amd.com>,
        jinlong zhang <jinlong.zhang@amd.com>,
        David Galiffi <David.Galiffi@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] drm/amdgpu: fix incorrect enum type
Date:   Mon, 26 Oct 2020 22:00:30 +0100
Message-Id: <20201026210039.3884312-2-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201026210039.3884312-1-arnd@kernel.org>
References: <20201026210039.3884312-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

core_link_write_dpcd() returns enum dc_status, not ddc_result:

display/dc/core/dc_link_dp.c: In function 'dp_set_panel_mode':
display/dc/core/dc_link_dp.c:4237:11: warning: implicit conversion from 'enum dc_status' to 'enum ddc_result'
[-Wenum-conversion]

Avoid the warning by using the correct enum in the caller.

Fixes: 0b226322434c ("drm/amd/display: Synchronous DisplayPort Link Training")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index ff1e9963ec7a..98464886341f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -4230,7 +4230,7 @@ void dp_set_panel_mode(struct dc_link *link, enum dp_panel_mode panel_mode)
 
 		if (edp_config_set.bits.PANEL_MODE_EDP
 			!= panel_mode_edp) {
-			enum ddc_result result = DDC_RESULT_UNKNOWN;
+			enum dc_status result = DC_ERROR_UNEXPECTED;
 
 			edp_config_set.bits.PANEL_MODE_EDP =
 			panel_mode_edp;
@@ -4240,7 +4240,7 @@ void dp_set_panel_mode(struct dc_link *link, enum dp_panel_mode panel_mode)
 				&edp_config_set.raw,
 				sizeof(edp_config_set.raw));
 
-			ASSERT(result == DDC_RESULT_SUCESSFULL);
+			ASSERT(result == DC_OK);
 		}
 	}
 	DC_LOG_DETECTION_DP_CAPS("Link: %d eDP panel mode supported: %d "
-- 
2.27.0

