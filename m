Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1412B1C93
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 14:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727293AbgKMNwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 08:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbgKMNuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 08:50:13 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE38C0617A7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:50:12 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id w24so8597647wmi.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WGHBLLfArp3MHXb6jRmdWLcwUbJpj6uRO7upfU2OHuw=;
        b=QWB7Rb3uSLXYnQQ2cEAuBHkFwyMP09ZejFdY7z3yP4RvHuVLM8LVdxKcPQGfkX0TKa
         SVSi+znYIGs/2/tYZ/ZM7cf4ByhJpxXQ1r84QAhba/dAqu7NVoXFlaxI4/C8eZR1/+hG
         RIPQmHWl95mquQI5VjH7Var1GM0bDOgfEcy8Dk1k3CVLUlDdsDYrkKv85BsjY/OKbJUh
         JHKjCn8N4k+Se9bxCU06GpXUD0K37g+NsFV4+PVAHjDUROTTE+NPOCiZOYZqcT/8EWoM
         8VeZhX3TU86f3ojfoRTtOqaJN5quuiNEOpOHsuJdVbvH+o2SM9aDX4dtxdn5EQiojVNx
         k1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WGHBLLfArp3MHXb6jRmdWLcwUbJpj6uRO7upfU2OHuw=;
        b=TN0X5wH8mNVMvm9TfKvGpVPwy85bbZg9nw11BH2j4IcMabfnjxBCCweFHipfpj0guz
         wi7RKiN/dcy6FLy5vD5yT8JGWysg5KaX/X3fXF9c79vUWx2ev3/+yWrfvpiu2z/9/UXQ
         bkJF5xyFprZevgW7ubx7KffKSQRB4gBLymwdxd+4oreLzM6NCpFe8PtigWdBJmzkGxJK
         4Ck5SMUOzP5MkHtuF/77Q/LY6Vje3/GmLblxky70fNOMtfy9h2RA2w8C93VQXzmO1hVD
         7GrbHg8wpb7N3JgzGqe8/aAEptclAlTRKv/ZUYY8hmFt3uECK30E2ArY7SlZOEiafDtt
         JG/g==
X-Gm-Message-State: AOAM533goVC/fF4IBj3AF3VYGCpIZWqJE0YIQ8R5Sr38YcWZdM+xtGHo
        KuZiy63CoFdUYyFvnri8JTa+6Q==
X-Google-Smtp-Source: ABdhPJzwfvzA9X+I0jwrBedFid2wysIoR3AvVUixW2DKt9Kt6WBq2YTZwEfgGhWJ9mTLrkrYjanI8A==
X-Received: by 2002:a1c:2583:: with SMTP id l125mr2655884wml.50.1605275411325;
        Fri, 13 Nov 2020 05:50:11 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id t11sm4561614wrm.8.2020.11.13.05.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 05:50:10 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: [PATCH 24/40] drm/amd/amdgpu/amdgpu_ids: Supply missing docs for 'id' and 'vmhub'
Date:   Fri, 13 Nov 2020 13:49:22 +0000
Message-Id: <20201113134938.4004947-25-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201113134938.4004947-1-lee.jones@linaro.org>
References: <20201113134938.4004947-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c:271: warning: Function parameter or member 'id' not described in 'amdgpu_vmid_grab_reserved'
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c:523: warning: Function parameter or member 'vmhub' not described in 'amdgpu_vmid_reset'

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-media@vger.kernel.org
Cc: linaro-mm-sig@lists.linaro.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index 6e9a9e5dbea07..61a1331f482c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -259,6 +259,7 @@ static int amdgpu_vmid_grab_idle(struct amdgpu_vm *vm,
  * @sync: sync object where we add dependencies
  * @fence: fence protecting ID from reuse
  * @job: job who wants to use the VMID
+ * @id: resulting VMID
  *
  * Try to assign a reserved VMID.
  */
@@ -514,6 +515,7 @@ void amdgpu_vmid_free_reserved(struct amdgpu_device *adev,
  * amdgpu_vmid_reset - reset VMID to zero
  *
  * @adev: amdgpu device structure
+ * @vmhub: vmhub type
  * @vmid: vmid number to use
  *
  * Reset saved GDW, GWS and OA to force switch on next flush.
-- 
2.25.1

