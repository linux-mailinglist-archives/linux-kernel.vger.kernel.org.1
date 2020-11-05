Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 297C52A750C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 02:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733017AbgKEBru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 20:47:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731646AbgKEBru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 20:47:50 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36345C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 17:47:50 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id i7so116266pgh.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 17:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sYYwClh6EchPM2BfZR+4AEHuja7044UzaidnsIy8Qcg=;
        b=Id8UrqPwcLEkt9PwDuwqYhVZ9KTxZgq/wynDwuSf63/F8l75yjB81xuZ0c4D5Ds6AP
         xq1NsRzKt7wNjgVtk1D7RAGyiBSy1Wn7OcIaiCLSFEDDpo/VmCUPfdJuYrgAYSxHSEkj
         fWS+97jxKFivtDHmynjuL6EiRM3lAt+VObgAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sYYwClh6EchPM2BfZR+4AEHuja7044UzaidnsIy8Qcg=;
        b=ld1AwNx5ywPV6Cvx5p4WjecfAHfpwqubbGqdUbhnc6Sgq6b1JRnQP1BYr4erMQlroH
         I07IxaWCSNu9Qb5dWT5Kt3or/GfETTK02gRkhhULOuj3Kn0jFttrDbvGwb0kdih5ibxn
         cPzrxN6+Ltkx02evqPxKcK7+bBTVcW+o2r1pr0pxbsbehOfAhDFhVWZGenCQe1c1C+C4
         qOk6bIj8vmjuqFclnyaiGyc1oEwRDztZt5MmXp1b6fJ67ytfmhREBpuaQPl75YjzOmRy
         HL4LoqJIvllHOtg/91h0m6JUD9B8f8/GWThg9Qy1+vVuFv6S4d7csru5KgtHxe2lVmt5
         pp4A==
X-Gm-Message-State: AOAM533LogQiNm8L3lR2Cb/g40sVFtEY0HMmC9TwpquBNvMLLB8Myqdj
        Oo5A0aDBKVIH8nMNxln/QpfJtQ==
X-Google-Smtp-Source: ABdhPJz6AoKdhCysWyJGFbxwj173ZuJ5XbaST4akQgoDruF8T/h8yzY9MmP+ZneLYT0hbQ/+OukUJQ==
X-Received: by 2002:a17:90a:7d12:: with SMTP id g18mr362516pjl.137.1604540869798;
        Wed, 04 Nov 2020 17:47:49 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:a6ae:11ff:fe11:4b46])
        by smtp.gmail.com with ESMTPSA id d190sm116741pfc.185.2020.11.04.17.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 17:47:49 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Suleiman Souhlal <suleiman@google.com>,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] drm/virtio: use kvmalloc for large allocations
Date:   Thu,  5 Nov 2020 10:47:44 +0900
Message-Id: <20201105014744.1662226-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We observed that some of virtio_gpu_object_shmem_init() allocations
can be rather costly - order 6 - which can be difficult to fulfill
under memory pressure conditions. Switch to kvmalloc_array() in
virtio_gpu_object_shmem_init() and let the kernel vmalloc the entries
array.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/gpu/drm/virtio/virtgpu_object.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
index 2d3aa7baffe4..d9ad27e00905 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -184,8 +184,9 @@ static int virtio_gpu_object_shmem_init(struct virtio_gpu_device *vgdev,
 		*nents = shmem->pages->orig_nents;
 	}
 
-	*ents = kmalloc_array(*nents, sizeof(struct virtio_gpu_mem_entry),
-			      GFP_KERNEL);
+	*ents = kvmalloc_array(*nents,
+			       sizeof(struct virtio_gpu_mem_entry),
+			       GFP_KERNEL);
 	if (!(*ents)) {
 		DRM_ERROR("failed to allocate ent list\n");
 		return -ENOMEM;
-- 
2.29.1.341.ge80a0c044ae-goog

