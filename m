Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF332B1C68
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 14:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgKMNt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 08:49:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbgKMNtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 08:49:50 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D9BC061A48
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:49:49 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id c16so8553667wmd.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6/SblzwLdOmJ9tWarQDFSbsr05Zj/WUad2ODh3SNdKc=;
        b=Y1p0NVuHUW4H9XgyeNEWCXTCVdtUlbV30yUCoYgsuqo4Y01RdEjka3nughIasrl1gp
         /eqiX+NbO1uIk+A3G8OtTbt0AwZXPnEaxkpnpoX0txhxN5lZMtgFsh2BUkU/LiDjdh36
         Ly8Ij7JoJsu4OIEFMhMk9bCFS5nA+jHJAv1qyMPRlaq1hSyddSb1ydx+hp1xs0J3hShO
         zbbnJdr/fBEncMp+JHcFJNpQqw0FQ5p88wQWyBocKZ+5TV7ehN7RQUtW07XFUDBVEgF8
         7dkkhHl5fRILzvVR8k65Yiax9xqCgRdFaUy/6BoiRrP+EWD61nsmY8gCMlxu2+ru4vjv
         k0Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6/SblzwLdOmJ9tWarQDFSbsr05Zj/WUad2ODh3SNdKc=;
        b=k6rA2bUxqNfdkW55dV4KZZOaUvrPD4YbGfnGY3WLPGD3mYde9gN7zzVpCzGZJhDQ8E
         jUI3palbBMcBxuCW/r8FHLqbA24cvE2X86m7l5Nzj6BrFpmgHxf++9da0GkJjvA3FoMC
         6OZ7RfTsnTEZ7rAXN/zPCUkRGp2XqbFwlDceDn8dKoyIDQtMfCD3BMc+wtub8oxUAq8j
         bE1UdoOO87ytHKca5CPuip97OskyaCq1mBlM4Vz9s34rHfRMI0m9UK5xYvxmPSPAYSQQ
         KSAjXSGjiNs9FlWD26riTkDjwTxinj3YG/P9DUVyGeKyErm3DD84O0Zr62/tthagd2SQ
         gXsQ==
X-Gm-Message-State: AOAM530bvq1VGCu66aa6Mr5mVX3JChCQR3yVLs5chAKxc3fvvahBbf6m
        qjEkQojVsgID5ivO9YzJflTxSQ==
X-Google-Smtp-Source: ABdhPJxrcuhGfoNe9QQTIoT/4z4aQpdapdF6KKqt0Msq0U2GXATSYUSIF5p6At39W9yFD+O2Ih7GmA==
X-Received: by 2002:a1c:c286:: with SMTP id s128mr2672526wmf.88.1605275388627;
        Fri, 13 Nov 2020 05:49:48 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id t11sm4561614wrm.8.2020.11.13.05.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 05:49:48 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: [PATCH 05/40] drm/amd/amdgpu/amdgpu_ring: Fix misnaming of param 'max_dw'
Date:   Fri, 13 Nov 2020 13:49:03 +0000
Message-Id: <20201113134938.4004947-6-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:168: warning: Function parameter or member 'max_dw' not described in 'amdgpu_ring_init'
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:168: warning: Excess function parameter 'max_ndw' description in 'amdgpu_ring_init'

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-media@vger.kernel.org
Cc: linaro-mm-sig@lists.linaro.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index a23b2079696a1..1a612f51ecd9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -154,7 +154,7 @@ void amdgpu_ring_undo(struct amdgpu_ring *ring)
  *
  * @adev: amdgpu_device pointer
  * @ring: amdgpu_ring structure holding ring information
- * @max_ndw: maximum number of dw for ring alloc
+ * @max_dw: maximum number of dw for ring alloc
  * @irq_src: interrupt source to use for this ring
  * @irq_type: interrupt type to use for this ring
  * @hw_prio: ring priority (NORMAL/HIGH)
-- 
2.25.1

