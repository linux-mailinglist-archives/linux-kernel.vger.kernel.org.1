Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA8D299870
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 22:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbgJZVBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 17:01:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:55972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729137AbgJZVBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 17:01:37 -0400
Received: from localhost.localdomain (unknown [192.30.34.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D79C920829;
        Mon, 26 Oct 2020 21:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603746097;
        bh=Sl0AeOUeKfSSE44S4mD27orpF56Z7J4Bt+Y+zUMMhI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rtBeg7moyP4a3B0SOX45SiZm/0H9T7+m88WonKBeQpCZrNXuvsDDBReECtc89l7mB
         HTATx/M+wvYCcJqGBOrPtSYLFQRYvxrzpO/F2uouCVJxPK+YugcbhDvk5M/yQMcO6g
         rbWaVRMU2coTP9psQFMCCYLW8u3avu/7Roo7jnGA=
From:   Arnd Bergmann <arnd@kernel.org>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Leo Liu <leo.liu@amd.com>, Likun Gao <Likun.Gao@amd.com>,
        Huang Rui <ray.huang@amd.com>, Yong Zhao <Yong.Zhao@amd.com>,
        Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] drm/amdgpu: disable -Woverride-init warning
Date:   Mon, 26 Oct 2020 22:00:33 +0100
Message-Id: <20201026210039.3884312-5-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201026210039.3884312-1-arnd@kernel.org>
References: <20201026210039.3884312-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Building with 'make W=1' produces countless warnings like

amdgpu/../include/vega10_ip_offset.h:276:51: warning: initialized field overwritten [-Woverride-init]

Shut these up by disabling the particular warning in the
amdgpu driver.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/amdgpu/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 247dd46e1681..5a46949bc17c 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -36,7 +36,8 @@ ccflags-y := -I$(FULL_AMD_PATH)/include/asic_reg \
 	-I$(FULL_AMD_DISPLAY_PATH)/include \
 	-I$(FULL_AMD_DISPLAY_PATH)/dc \
 	-I$(FULL_AMD_DISPLAY_PATH)/amdgpu_dm \
-	-I$(FULL_AMD_PATH)/amdkfd
+	-I$(FULL_AMD_PATH)/amdkfd \
+	-Wno-override-init
 
 amdgpu-y := amdgpu_drv.o
 
-- 
2.27.0

