Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 490612EAA07
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 12:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729706AbhAELg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 06:36:29 -0500
Received: from m15114.mail.126.com ([220.181.15.114]:37008 "EHLO
        m15114.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbhAELg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 06:36:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=15VgomEyshS/XXryYa
        QwqIxLrVBEvq7TJjmDFxBZ2yU=; b=J8J0zIykqFObQbB2k5OBqQOuKRkj0RVYxU
        vKnj8d+IuTficlDlbVcqF9zooJycwgUvBa/eRCo+Q6KFbC0BbMshp+ehulVofCvZ
        bJvNiQc3XdFgou9ive4oIUbiEk+cQHhQl8AmajXO5v3kwXiLO79mfUhAttD/rFGh
        AOQ1joNmE=
Received: from localhost.localdomain (unknown [36.112.86.14])
        by smtp7 (Coremail) with SMTP id DsmowACXmmoTFvRfq4zUMw--.32724S2;
        Tue, 05 Jan 2021 15:32:37 +0800 (CST)
From:   Defang Bo <bodefang@126.com>
To:     airlied@linux.ie, daniel@ffwll.ch, christian.koenig@amd.com,
        alexander.deucher@amd.com
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, Defang Bo <bodefang@126.com>
Subject: [PATCH v2] drm/amdgpu:fix IH overflow on Cz
Date:   Tue,  5 Jan 2021 15:32:21 +0800
Message-Id: <1609831941-2277695-1-git-send-email-bodefang@126.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: DsmowACXmmoTFvRfq4zUMw--.32724S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr15Cw4xXF4UZF48Zw18Xwb_yoW5JFyxpa
        1Sg3s09r10yr1IyryfZ3Z7uFn8Aw4vgrWfCrsrAw12gF4jya4kWry5tayFqryUtFWSkF47
        Kryaq3y5W34qvrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRF1vhUUUUU=
X-Originating-IP: [36.112.86.14]
X-CM-SenderInfo: pergvwxdqjqiyswou0bp/1tbikhUR11pECIqqZgAAsR
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
Changes since v1:
- Modify the code and correct the wrong fix. 
---
---
 drivers/gpu/drm/amd/amdgpu/cz_ih.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/cz_ih.c b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
index 1dca0cabc326..45dd47f45fa2 100644
--- a/drivers/gpu/drm/amd/amdgpu/cz_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
@@ -190,22 +190,32 @@ static u32 cz_ih_get_wptr(struct amdgpu_device *adev,
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
+
+out:
 	return (wptr & ih->ptr_mask);
 }
 
-- 
2.7.4

