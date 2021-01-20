Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38AF02FCDFB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 11:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731341AbhATKPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 05:15:19 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:37084 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731255AbhATJ1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 04:27:14 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1l29ku-0008OW-Ku; Wed, 20 Jan 2021 09:26:24 +0000
From:   Colin King <colin.king@canonical.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/amd/display: Fix spelling mistake of function name
Date:   Wed, 20 Jan 2021 09:26:24 +0000
Message-Id: <20210120092624.13061-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are two spelling mistakes of the function name, fix this
by using __func__ instead of a hard coded name string.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index c16af3983fdb..91d4130cd2cb 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1602,7 +1602,7 @@ static bool dc_link_construct(struct dc_link *link,
 
 	link->psr_settings.psr_version = DC_PSR_VERSION_UNSUPPORTED;
 
-	DC_LOG_DC("BIOS object table - dc_link_contruct finished successfully.\n");
+	DC_LOG_DC("BIOS object table - %s finished successfully.\n", __func__);
 	return true;
 device_tag_fail:
 	link->link_enc->funcs->destroy(&link->link_enc);
@@ -1619,7 +1619,7 @@ static bool dc_link_construct(struct dc_link *link,
 		link->hpd_gpio = NULL;
 	}
 
-	DC_LOG_DC("BIOS object table - dc_link_contruct failed.\n");
+	DC_LOG_DC("BIOS object table - %s failed.\n", __func__);
 	kfree(info);
 
 	return false;
-- 
2.29.2

