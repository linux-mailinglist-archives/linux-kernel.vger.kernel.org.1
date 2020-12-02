Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1B022CB726
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 09:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbgLBI2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 03:28:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:57828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729051AbgLBI2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 03:28:00 -0500
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Alex Deucher <alexander.deucher@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Mihir Bhogilal Patel <Mihir.Patel@amd.com>,
        Nirmoy Das <nirmoy.aiemd@gmail.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, xinhui pan <xinhui.pan@amd.com>
Subject: [PATCH 2/2] drm: amdgpu: fix a kernel-doc markup
Date:   Wed,  2 Dec 2020 09:27:15 +0100
Message-Id: <65bae21ebb9de534483b282fb091d4526cff0be8.1606897462.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1606897462.git.mchehab+huawei@kernel.org>
References: <cover.1606897462.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function name at kernel-doc markup doesn't match the name
of the function:

	drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:1534: warning: expecting prototype for amdgpu_debugfs_print_bo_info(). Prototype was for amdgpu_bo_print_info() instead

Fix it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index c6c9723d3d8a..fd7a93c32235 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1518,7 +1518,7 @@ uint32_t amdgpu_bo_get_preferred_pin_domain(struct amdgpu_device *adev,
 	} while (0)
 
 /**
- * amdgpu_debugfs_print_bo_info - print BO info in debugfs file
+ * amdgpu_bo_print_info - print BO info in debugfs file
  *
  * @id: Index or Id of the BO
  * @bo: Requested BO for printing info
-- 
2.28.0

