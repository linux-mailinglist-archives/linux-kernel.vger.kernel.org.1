Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36D842C695A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 17:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731215AbgK0Q0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 11:26:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44570 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730786AbgK0Q0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 11:26:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606494377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=9kcT9NngfazbuS/JmAbn32wrrn8CkOa26eF7oEFiGFI=;
        b=Q5Nxv5640UEOOM9EhrhfC7+TAupY6aCunb0rj7qhSy9P8tOQelN/EZqmagsS/ARZKQZrO2
        1gb1CFPTPpWWbFdZZ2erMn68Y7Pkgik1JGVrAEu3Bx+WUB7yO+Qn4LuhJjJYX5qDCK+CK3
        jlKEi6e4Bwob4ZtNZfAEUDHfCyuSceA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-3wVkL_wHMMWPMYRj60ZarQ-1; Fri, 27 Nov 2020 11:26:16 -0500
X-MC-Unique: 3wVkL_wHMMWPMYRj60ZarQ-1
Received: by mail-qt1-f198.google.com with SMTP id n95so3515175qte.16
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 08:26:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9kcT9NngfazbuS/JmAbn32wrrn8CkOa26eF7oEFiGFI=;
        b=sSLWpQIIiX6lZVd2TDpP5CsVKYRFi8cY3FIDlhpUn97jMrT8Ym84YokzxQnzvGBDhK
         +7G0CW8e3xPmk7uCtKLf1RPetJ4cY0KUpi5GJyvsqYpiJLWD/25nWY8CSYsnUX3F3ozz
         YQNaihFewzNbtxg3qMsckpC2gr8Q6GVKoGJZe+IAwSzjJ3EfjpjN30jKVjjbkcBwXWBj
         v8mlPvCAW7nI5pJ+q+FhrUlUq5td/gNra6UUSmfk4CcL55VKMeNlEVMmqDz/rK6alXFN
         WfYb7FAxxA41a8mkspnzxA9T4zfYEYNfcTV3dXhLOoAxpbFCjKZ4BcW1Iu0diqsMVhyU
         JENg==
X-Gm-Message-State: AOAM530Pk6v1KIWUZe5zARuKaC6iHyms0OqVNet/d68yLTFzxLA0gxP2
        veMxCrKjyctOL1QazYbf5gVyP5d2H/mTm7F5TjrUu66Wy9rCL/sbybery9QRfnGKytrnKA75lUp
        5WdrmErkiNZcPZvEPOle5VSpc
X-Received: by 2002:a37:4350:: with SMTP id q77mr9607302qka.14.1606494374657;
        Fri, 27 Nov 2020 08:26:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxNGd4qb8oVRkjqDYpGhY8hkSGk1iJ3KkPlgznYCKM24/i6OjNo9tI0muQNVpoA0U0g2g/58g==
X-Received: by 2002:a37:4350:: with SMTP id q77mr9607280qka.14.1606494374479;
        Fri, 27 Nov 2020 08:26:14 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id x33sm6358454qte.73.2020.11.27.08.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 08:26:13 -0800 (PST)
From:   trix@redhat.com
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@linux.ie, daniel@ffwll.ch, Hawking.Zhang@amd.com,
        evan.quan@amd.com, Felix.Kuehling@amd.com, luben.tuikov@amd.com,
        Dennis.Li@amd.com, andrey.grodzovsky@amd.com,
        Joseph.Greathouse@amd.com, jonathan.kim@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/amdgpu/display: remove trailing semicolon in macro definition
Date:   Fri, 27 Nov 2020 08:26:07 -0800
Message-Id: <20201127162607.2656353-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

The macro use will already have a semicolon.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index f9c81bc21ba4..301e93c9e72a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1213,7 +1213,7 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 #define amdgpu_asic_update_umd_stable_pstate(adev, enter) \
 	((adev)->asic_funcs->update_umd_stable_pstate ? (adev)->asic_funcs->update_umd_stable_pstate((adev), (enter)) : 0)
 
-#define amdgpu_inc_vram_lost(adev) atomic_inc(&((adev)->vram_lost_counter));
+#define amdgpu_inc_vram_lost(adev) atomic_inc(&((adev)->vram_lost_counter))
 
 /* Common functions */
 bool amdgpu_device_has_job_running(struct amdgpu_device *adev);
-- 
2.18.4

