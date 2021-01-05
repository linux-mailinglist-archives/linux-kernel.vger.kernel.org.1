Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 062792EA631
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 08:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbhAEHwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 02:52:43 -0500
Received: from mail-m965.mail.126.com ([123.126.96.5]:59604 "EHLO
        mail-m965.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbhAEHwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 02:52:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=e2XyUn+LYHxPybZk4z
        bvlTIqAqmG55Q4KaO8QFzTy40=; b=il4xcscoQ6EZfmOMOWBzT3Iwib1bh+yJIT
        e3r1I1B1LiG/4Eqchm1PPO0euXc2Mt2wZMzFcKg/lFOufN4gGoiUf5TLXwR3sGtw
        dOSOANrs1ba3nA9ZEJmkPw/pFyyGSq+yJdFdvGCcGdl5j2nooF2qEp0q14CuTEu8
        iMveiG0jk=
Received: from localhost.localdomain (unknown [36.112.86.14])
        by smtp10 (Coremail) with SMTP id NuRpCgBXDq6EGvRfUVHZiw--.1017S2;
        Tue, 05 Jan 2021 15:51:33 +0800 (CST)
From:   Defang Bo <bodefang@126.com>
To:     airlied@linux.ie, daniel@ffwll.ch
Cc:     christian.koenig@amd.com, alexander.deucher@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Defang Bo <bodefang@126.com>
Subject: [PATCH] drm/amdgpu:fix IH overflow on Tonga
Date:   Tue,  5 Jan 2021 15:51:25 +0800
Message-Id: <1609833085-2287999-1-git-send-email-bodefang@126.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: NuRpCgBXDq6EGvRfUVHZiw--.1017S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr15Cw4xXF4UZF48Zw18Xwb_yoW8Kw1rpa
        ySq34Y9r1Iyr1xtw1fu3Z7uFn8Aw4qgFWfWr1DZw12gF4UKa4kWr98JayFqryjqayfCF47
        tryagay5W34vvFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRVc_hUUUUU=
X-Originating-IP: [36.112.86.14]
X-CM-SenderInfo: pergvwxdqjqiyswou0bp/1tbiEwUR11pD-CxVKAAAsk
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to commit <b82175750131>("drm/amdgpu: fix IH overflow on Vega10 v2").
When an ring buffer overflow happens the appropriate bit is set in the WPTR
register which is also written back to memory. But clearing the bit in the
WPTR doesn't trigger another memory writeback.

So what can happen is that we end up processing the buffer overflow over and
over again because the bit is never cleared. Resulting in a random system
lockup because of an infinite loop in an interrupt handler.

Signed-off-by: Defang Bo <bodefang@126.com>
---
 drivers/gpu/drm/amd/amdgpu/tonga_ih.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
index e40140bf6699..9c5947976717 100644
--- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
@@ -195,19 +195,28 @@ static u32 tonga_ih_get_wptr(struct amdgpu_device *adev,
 
 	wptr = le32_to_cpu(*ih->wptr_cpu);
 
-	if (REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW)) {
-		wptr = REG_SET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW, 0);
-		/* When a ring buffer overflow happen start parsing interrupt
-		 * from the last not overwritten vector (wptr + 16). Hopefully
-		 * this should allow us to catchup.
-		 */
-		dev_warn(adev->dev, "IH ring buffer overflow (0x%08X, 0x%08X, 0x%08X)\n",
-			 wptr, ih->rptr, (wptr + 16) & ih->ptr_mask);
-		ih->rptr = (wptr + 16) & ih->ptr_mask;
-		tmp = RREG32(mmIH_RB_CNTL);
-		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
-		WREG32(mmIH_RB_CNTL, tmp);
-	}
+	if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
+		goto out;
+
+	wptr = RREG32(mmIH_RB_CNTL);
+
+	if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
+		goto out;
+
+	wptr = REG_SET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW, 0);
+
+	/* When a ring buffer overflow happen start parsing interrupt
+	 * from the last not overwritten vector (wptr + 16). Hopefully
+	 * this should allow us to catchup.
+	 */
+	dev_warn(adev->dev, "IH ring buffer overflow (0x%08X, 0x%08X, 0x%08X)\n",
+		wptr, ih->rptr, (wptr + 16) & ih->ptr_mask);
+	ih->rptr = (wptr + 16) & ih->ptr_mask;
+	tmp = RREG32(mmIH_RB_CNTL);
+	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
+	WREG32(mmIH_RB_CNTL, tmp);
+
+out:
 	return (wptr & ih->ptr_mask);
 }
 
-- 
2.7.4

