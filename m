Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B17A29C85B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 20:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1829418AbgJ0THh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 15:07:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24037 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S369529AbgJ0THg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 15:07:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603825655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=l0PCwDa1wHGV+Q/jQHXorblfnJ1kxgpeCNddFrrP2u8=;
        b=ZCVPrEyP9LT16VN31sd1O2kqvCX7gyq02fhyCJq77Dtv1rLtQ+bWhlH0HH8tMlaodXtClY
        zSh7KMVNbjxDB4VRR55fJiklUaE/tKpH72ATrWgwnU8k2hzSyao/9pSioijuL5huSrqUUX
        3vQ1NkZ71mN/QNmPF1sAOJ9ywDluuKs=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-8XsvLgJQNy-hiir8UNPWCA-1; Tue, 27 Oct 2020 15:07:33 -0400
X-MC-Unique: 8XsvLgJQNy-hiir8UNPWCA-1
Received: by mail-oo1-f72.google.com with SMTP id l13so1205848oot.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 12:07:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=l0PCwDa1wHGV+Q/jQHXorblfnJ1kxgpeCNddFrrP2u8=;
        b=hx2BsviUzRVAN1aWuWQ1+Yi7PLn9yHIE1xGFdI+QTNY1MX74+SVWf/XvdFjHrKH/K3
         2cj1iBe4dbSO7RhwvQbTqYhLkj018jtT2C7JZkkm6q6zSZwgUTKtvFg5dKrXzEQ3rdHO
         eTrDV5kQrZJobNP4vdIJ8UFrjCcIq44JciVLHv5VNJi+5UdNgUn73+KP2OhKoJoC4iAG
         cPeDGNVpdW8fwbmeD9aYhBN6KVl+LJVMpkail2j5mLNaThqo21GDGV7gXRJeRs9VNygt
         qm80hsbOiokcRrIV9lRJZriB1pCjBpm7Q+TBzhaf7TjzNMXUtquj2mAVHDqnQukbjFQr
         Ic0Q==
X-Gm-Message-State: AOAM5317SyonMxOR+BMt8/WwQruyDxosofpQBs4tM3yhQxKVv+ytUvTv
        FokEvWoazEfbMAmv7vRHBrFUP1vu1ltjYWPAnhB4cnYp9OXsBNxaetE2STGSlcAXCICvgOKwocF
        sDmmJDlHJzdC4U0yhKxZl1LQr
X-Received: by 2002:a9d:491:: with SMTP id 17mr2601955otm.338.1603825652821;
        Tue, 27 Oct 2020 12:07:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzWW33cuqBanM3RqWmNlIAsoMbT3S8VnWYdIw36FDCID2skFOgGdV/X/Ei7bypd9s6bTTHJSg==
X-Received: by 2002:a9d:491:: with SMTP id 17mr2601933otm.338.1603825652601;
        Tue, 27 Oct 2020 12:07:32 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id x83sm1765339oig.39.2020.10.27.12.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 12:07:32 -0700 (PDT)
From:   trix@redhat.com
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@linux.ie, daniel@ffwll.ch, jonathan.kim@amd.com,
        harish.kasiviswanathan@amd.com, Felix.Kuehling@amd.com,
        zhengbin13@huawei.com, luben.tuikov@amd.com,
        Joseph.Greathouse@amd.com, Hawking.Zhang@amd.com,
        guchun.chen@amd.com, john.clements@amd.com, tao.zhou1@amd.com,
        Dennis.Li@amd.com, Stanley.Yang@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/amdgpu: remove unneeded semicolon
Date:   Tue, 27 Oct 2020 12:07:26 -0700
Message-Id: <20201027190726.1588801-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A semicolon is not needed after a switch statement.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
index 1b213c4ddfcb..19c0a3655228 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
@@ -654,7 +654,7 @@ int amdgpu_pmu_init(struct amdgpu_device *adev)
 
 	default:
 		return 0;
-	};
+	}
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 8bf6a7c056bc..a61cf8cfbfc3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -953,7 +953,7 @@ static char *amdgpu_ras_badpage_flags_str(unsigned int flags)
 	case AMDGPU_RAS_RETIRE_PAGE_FAULT:
 	default:
 		return "F";
-	};
+	}
 }
 
 /**
-- 
2.18.1

