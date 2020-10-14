Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 289F428E847
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 23:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730270AbgJNVSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 17:18:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20161 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727403AbgJNVSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 17:18:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602710296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=8K91tpPhSfeMTW8U/TmEjC3SOUcTAJmMSlYekWW/OxY=;
        b=Nopb00QlBWpSjwg+E3TAPxLCPT1lBOVD+aO8pOTi7g+AyYvpdbxpCImJLOopJuD2HyO10W
        /rqfzFIbtrJEKyWax1xizYuVP0sZbrjKm+TzuJUmGGJnreQqeV2O/SVJJCQX2NVOVUq9/b
        47iOFTZTEU4BpqotvwciRkV/bdBI1qM=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-f-rd7JfCOxm-bBwhdTDKqw-1; Wed, 14 Oct 2020 17:18:13 -0400
X-MC-Unique: f-rd7JfCOxm-bBwhdTDKqw-1
Received: by mail-oo1-f69.google.com with SMTP id q75so323717ooq.16
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 14:18:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8K91tpPhSfeMTW8U/TmEjC3SOUcTAJmMSlYekWW/OxY=;
        b=ZyrOVNcEt9RGMiLskgsQXnWHFYYuW45lj6JflgEqsOuCSbBNWLGeRJAOzcHqmxsImL
         tJHzPQIMAmFZIueCjIhE20DjEj7ZWY0iRWAUdPWyc52ZopPQ9/iMrcqgqZVfb+/vb0TB
         nZmmYxKk6X1LndIDMEsWlILU2c3jZn6WTDhYLc2iG/koc5/4TzQrlCFYm+RefN8a99UV
         C3ykG4qA4tCDoL6V9q9OKB2TReon2KeEsoYzvXLrwTxxAsqFHE8MnwJfmo8ior0Uo/Ri
         rglGNBm6obSAsw7jkpj4PIU/vg2p3s7jFlEWaI4zuU/LBxv5CwhNCW29dm3DUuCPuZRp
         79bQ==
X-Gm-Message-State: AOAM533BXNp8XK3C92ygYUCckTurtyUK9bkw7JsFHntlsQap7s6s5c9Y
        yA+5T/gGY367wHVn9LV2tnkNkcpk4invPxs1j+VXp7of26/A8oJUD6C+Wj6jmvzq34WAeJCDYX1
        PYebF6Pdg8lHs9KMZ/+2udbKr
X-Received: by 2002:a05:6830:1301:: with SMTP id p1mr443971otq.241.1602710292748;
        Wed, 14 Oct 2020 14:18:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9w+ALYnZxhun1GSiSOJtZIsFA++Kd8+X4Bet9rJd1T4rMk1BW+ckqvG/zmRHnTzML5VPvuA==
X-Received: by 2002:a05:6830:1301:: with SMTP id p1mr443961otq.241.1602710292532;
        Wed, 14 Oct 2020 14:18:12 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id h15sm232082ots.31.2020.10.14.14.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 14:18:11 -0700 (PDT)
From:   trix@redhat.com
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@linux.ie, daniel@ffwll.ch, Hawking.Zhang@amd.com,
        Dennis.Li@amd.com, tao.zhou1@amd.com, ray.huang@amd.com,
        guchun.chen@amd.com, sonny.jiang@amd.com, xiaojian.du@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/amdgpu: add missing newline at eof
Date:   Wed, 14 Oct 2020 14:18:06 -0700
Message-Id: <20201014211806.16282-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Representative checkpatch.pl warning

WARNING: adding a line without newline at end of file
 30: FILE: drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.h:30:
+#endif

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_4_1_sh_mask.h | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.h           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_4_1_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_4_1_sh_mask.h
index f26246a600c6..4089cfa081f5 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_4_1_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_4_1_sh_mask.h
@@ -745,4 +745,4 @@
 #define RLC_EDC_CNT2__RLC_SPM_SE7_SCRATCH_RAM_SEC_COUNT_MASK                                                  0x30000000L
 #define RLC_EDC_CNT2__RLC_SPM_SE7_SCRATCH_RAM_DED_COUNT_MASK                                                  0xC0000000L
 
-#endif
\ No newline at end of file
+#endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.h
index 29929b360db8..d8696e2274c4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.h
@@ -27,4 +27,4 @@
 
 extern void vangogh_set_ppt_funcs(struct smu_context *smu);
 
-#endif
\ No newline at end of file
+#endif
-- 
2.18.1

