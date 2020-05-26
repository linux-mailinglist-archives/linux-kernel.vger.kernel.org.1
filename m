Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 281291AEC01
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Apr 2020 12:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgDRK4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Apr 2020 06:56:52 -0400
Received: from m176115.mail.qiye.163.com ([59.111.176.115]:19464 "EHLO
        m176115.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgDRK4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 06:56:52 -0400
Received: from ubuntu.localdomain (unknown [157.0.31.122])
        by m176115.mail.qiye.163.com (Hmail) with ESMTPA id 107F8663346;
        Sat, 18 Apr 2020 18:56:47 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Philip Yang <Philip.Yang@amd.com>,
        =?UTF-8?q?Nicolai=20H=C3=A4hnle?= <nicolai.haehnle@amd.com>,
        Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Bernard Zhao <bernard@vivo.com>
Subject: [PATCH] amdgpu_cs_bo_handles_chunk, remove check info NULL branch
Date:   Sat, 18 Apr 2020 03:56:35 -0700
Message-Id: <1587207396-116489-1-git-send-email-bernard@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSFVMTElCQkJMTUhPQ0NMTFlXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Phg6EQw5Fjg9Cg0POg4iNBIZ
        AzVPCwpVSlVKTkNMSUtMT0tMSEJLVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlKTkxV
        S1VISlVKSUlZV1kIAVlBSUhJQjcG
X-HM-Tid: 0a718cef06c79373kuws107f8663346
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kvfree ensure that the null pointer will do nothing.
If addr is NULL, first is_vmalloc_addr will not enter,
and kfree function just return when addr is NULL. There
will be no risk here.

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index af91627b..814bd5d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -98,8 +98,7 @@ static int amdgpu_cs_bo_handles_chunk(struct amdgpu_cs_parser *p,
 	return 0;
 
 error_free:
-	if (info)
-		kvfree(info);
+	kvfree(info);
 
 	return r;
 }
-- 
2.7.4

