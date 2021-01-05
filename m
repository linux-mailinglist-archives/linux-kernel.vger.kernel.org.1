Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0984B2EA616
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 08:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbhAEHi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 02:38:57 -0500
Received: from m15112.mail.126.com ([220.181.15.112]:57876 "EHLO
        m15112.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbhAEHi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 02:38:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=8fmDUeFVJFC5//EFW/
        jRYhaLf6qLpr18P8j1GBYqxXQ=; b=CPw0LcxAqgJQK2Kc0BiDuPcyuq5pbwnduI
        aZ3kWRV4aLfvApaWchkIiVcgMvAtcjzA2zcltuI3oYoYkz31i6mzR5Wwo1xAjnHk
        fPmHVWtWDPR1C4rXYxzRCFc+7XiPx4dUI2rXxef99zKZrZAfg64zMFkd9Rpci04S
        +HAMUkk7Q=
Received: from localhost.localdomain (unknown [36.112.86.14])
        by smtp2 (Coremail) with SMTP id DMmowACnkWXTD_RfJqqgKw--.55502S2;
        Tue, 05 Jan 2021 15:05:57 +0800 (CST)
From:   Defang Bo <bodefang@126.com>
To:     airlied@linux.ie, daniel@ffwll.ch, christian.koenig@amd.com,
        alexander.deucher@amd.com
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, Defang Bo <bodefang@126.com>
Subject: [PATCH] drm/amdgpu:fix IH overflow on Cz
Date:   Tue,  5 Jan 2021 15:05:43 +0800
Message-Id: <1609830343-2263566-1-git-send-email-bodefang@126.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: DMmowACnkWXTD_RfJqqgKw--.55502S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr1rWF45XF1xurWDtFy7ZFb_yoW5Jr45pa
        1Sg34Y9r10yr12yryfu3Z7uFn8Aw4vgrWfGrnrAw12gF4UAa4kWr98tayFqryjqFWfCF47
        Kryag3y5W34qvrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zEubkrUUUUU=
X-Originating-IP: [36.112.86.14]
X-CM-SenderInfo: pergvwxdqjqiyswou0bp/1tbiExUR11pD-CwS+wAAsg
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to commit <b82175750131>("drm/amdgpu: fix IH overflow on Vega10 v2")
When an ring buffer overflow happens the appropriate bit is set in the WPTR
register which is also written back to memory. But clearing the bit in the
WPTR doesn't trigger another memory writeback.

So what can happen is that we end up processing the buffer overflow over and
over again because the bit is never cleared. Resulting in a random system
lockup because of an infinite loop in an interrupt handler.

Signed-off-by: Defang Bo <bodefang@126.com>
---
 drivers/gpu/drm/amd/amdgpu/cz_ih.c | 39 ++++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/cz_ih.c b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
index 1dca0cabc326..345987d45ff6 100644
--- a/drivers/gpu/drm/amd/amdgpu/cz_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
@@ -190,22 +190,33 @@ static u32 cz_ih_get_wptr(struct amdgpu_device *adev,
 			  struct amdgpu_ih_ring *ih)
 {
 	u32 wptr, tmp;
-
+
 	wptr = le32_to_cpu(*ih->wptr_cpu);
 
-	if (REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW)) {
-		wptr = REG_SET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW, 0);
-		/* When a ring buffer overflow happen start parsing interrupt
-		 * from the last not overwritten vector (wptr + 16). Hopefully
-		 * this should allow us to catchup.
-		 */
-		dev_warn(adev->dev, "IH ring buffer overflow (0x%08X, 0x%08X, 0x%08X)\n",
-			wptr, ih->rptr, (wptr + 16) & ih->ptr_mask);
-		ih->rptr = (wptr + 16) & ih->ptr_mask;
-		tmp = RREG32(mmIH_RB_CNTL);
-		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
-		WREG32(mmIH_RB_CNTL, tmp);
-	}
+	if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
+		goto out;
+
+	wptr = WREG32(mmIH_RB_CNTL, tmp);
+
+	if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
+		goto out;
+
+
+
+	wptr = REG_SET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW, 0);
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
+
+out:
 	return (wptr & ih->ptr_mask);
 }
 
-- 
2.7.4

