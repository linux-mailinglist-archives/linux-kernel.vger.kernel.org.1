Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B48429985B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 22:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbgJZVAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 17:00:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:54888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729011AbgJZVAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 17:00:46 -0400
Received: from localhost.localdomain (unknown [192.30.34.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B36520B1F;
        Mon, 26 Oct 2020 21:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603746046;
        bh=igjkUN6wESAd/DH60fWZ+VmAdJIU5sWPvyCPO5XJN48=;
        h=From:To:Cc:Subject:Date:From;
        b=VzUdhLcPpA/VYtY4oGcXxakGk/klmGlbWxN7jUe4lHINDG2OR0v498DkIilt3SKQx
         9EgiYQT80bpyfptSqnLQC0nlOAwQ27biV7F2UzJBbeJzhw12tMcXZhs3tumDFTCB5/
         EPQlB8+1RK2gG1f7tadgZIZl9RITJf45G3X7XF84=
From:   Arnd Bergmann <arnd@kernel.org>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Arnd Bergmann <arnd@arndb.de>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] drm/amdgpu: fix enum mismatches
Date:   Mon, 26 Oct 2020 22:00:29 +0100
Message-Id: <20201026210039.3884312-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

gcc -Wextra warns about an incorrect prototype causing multiple
mismatched enums:

display/dc/gpio/gpio_service.c: In function 'dal_gpio_service_create':
display/dc/gpio/gpio_service.c:70:50: warning: implicit conversion from 'enum dce_environment' to 'enum dce_version' [-Wenum-conversion]
display/dc/gpio/gpio_service.c:71:4: warning: implicit conversion from 'enum dce_version' to 'enum dce_environment' [-Wenum-conversion]
display/dc/gpio/gpio_service.c:76:46: warning: implicit conversion from 'enum dce_environment' to 'enum dce_version' [-Wenum-conversion]
display/dc/gpio/gpio_service.c:77:4: warning: implicit conversion from 'enum dce_version' to 'enum dce_environment' [-Wenum-conversion]

display/dc/core/dc.c: In function 'dc_construct':
display/dc/core/dc.c:718:10: warning: implicit conversion from 'enum dce_version' to 'enum dce_environment' [-Wenum-conversion]
display/dc/core/dc.c:719:10: warning: implicit conversion from 'enum dce_environment' to 'enum dce_version' [-Wenum-conversion]

Fixes: 4562236b3bc0 ("drm/amd/dc: Add dc display driver (v2)")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c           | 2 +-
 drivers/gpu/drm/amd/display/include/gpio_service_interface.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c b/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
index 92280cc05e2d..67bb5cc67255 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
@@ -54,7 +54,7 @@
 
 struct gpio_service *dal_gpio_service_create(
 	enum dce_version dce_version_major,
-	enum dce_version dce_version_minor,
+	enum dce_environment dce_version_minor,
 	struct dc_context *ctx)
 {
 	struct gpio_service *service;
diff --git a/drivers/gpu/drm/amd/display/include/gpio_service_interface.h b/drivers/gpu/drm/amd/display/include/gpio_service_interface.h
index 9c55d247227e..5f0f94e83d19 100644
--- a/drivers/gpu/drm/amd/display/include/gpio_service_interface.h
+++ b/drivers/gpu/drm/amd/display/include/gpio_service_interface.h
@@ -43,7 +43,7 @@ void dal_gpio_destroy(
 
 struct gpio_service *dal_gpio_service_create(
 	enum dce_version dce_version_major,
-	enum dce_version dce_version_minor,
+	enum dce_environment dce_version_minor,
 	struct dc_context *ctx);
 
 struct gpio *dal_gpio_service_create_irq(
-- 
2.27.0

