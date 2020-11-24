Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E63242C3154
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 20:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbgKXTrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 14:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgKXToI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 14:44:08 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA14C061A4D
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 11:44:07 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id 1so91766wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 11:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tr6g3sY0MoTTAswpPOODkkh+Vew/Ispj+AKTskHKpgk=;
        b=qiXoIqvCMOLUq4U1R3LxpHUjrA2UfLXQwtIgcDg/bve9rBIcBU6zvTPTLWB8mU41mJ
         yNesZnheuX8iEimQVaX1MYgbUJuApVl8SKZDd94qb8h193gkXpIH4PHoCquNcUd2KUaZ
         qzyEWjwYNhlCEelu6/qgYmDAobsZCOXW7W/HY6wDZFUzMWzzUnDs9v7Fmcbjb1xzc27f
         9ZWepClRYIMa51Ty4Y/zahsIuPV7OHEC8Xz6kwomcfX7mNkdRZ/C8vy+FvdBYVNk4Pvv
         oqekY5Z5AMTu68tqKvBMEgM8QLEU/5s/+28bdXHPb3z0kOt3tUzcm+Xx/kktIquRTN1G
         +Yqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tr6g3sY0MoTTAswpPOODkkh+Vew/Ispj+AKTskHKpgk=;
        b=mQzAzXEILOvT/uWgYWwZbUtgxViFYJ4Xdt0YYFVEpfL3Usi4DHQEiEgzZhiu4dKwy0
         G10aDCLkm856iAdcsMgs9WcbYS+psS9psIR69Rg0bi61yXV8g7dsR+1DhEB7/wd6OqaV
         X33IDsxJUraIM4bJCO+r6hAm6MRcbIAFBqeRjkctFIAfAbItbthp3fRTIeoJ6Cx81gas
         l2FuADVOp0Pju1tB1xUNi3nhG1iK1hcLRo62Rw3vcAoraC1SuzEUrWJzlJcuBEvHm1lr
         36FEpaecKZrJ12XoydLelCsOpg7jDFmAuUfX9nXIG4+Ob0+NZ9JGsUIExzjhODo28Ys/
         rwJA==
X-Gm-Message-State: AOAM532LV7zILGC1J/Gk7Cv0rlkNhGQClwLRUbTYYMkzUFSRKTN9JFKz
        ttS25QJHfS/VKj0knmtRcJEGmw==
X-Google-Smtp-Source: ABdhPJwuxJm/b/b0AS806h+qGtDQjuuTjAOa1Z/OoKhj44vaUS2oJoYRXaRfeQaotdc6Y/JsjXoHRA==
X-Received: by 2002:a05:600c:414b:: with SMTP id h11mr61966wmm.89.1606247046524;
        Tue, 24 Nov 2020 11:44:06 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id d134sm200511wmd.8.2020.11.24.11.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 11:44:05 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 06/40] drm/amd/amdgpu/cz_ih: Add missing function param descriptions for 'ih' and 'entry'
Date:   Tue, 24 Nov 2020 19:37:50 +0000
Message-Id: <20201124193824.1118741-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201124193824.1118741-1-lee.jones@linaro.org>
References: <20201124193824.1118741-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/cz_ih.c:191: warning: Function parameter or member 'ih' not described in 'cz_ih_get_wptr'
 drivers/gpu/drm/amd/amdgpu/cz_ih.c:223: warning: Function parameter or member 'ih' not described in 'cz_ih_decode_iv'
 drivers/gpu/drm/amd/amdgpu/cz_ih.c:223: warning: Function parameter or member 'entry' not described in 'cz_ih_decode_iv'
 drivers/gpu/drm/amd/amdgpu/cz_ih.c:253: warning: Function parameter or member 'ih' not described in 'cz_ih_set_rptr'

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/cz_ih.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/cz_ih.c b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
index 1dca0cabc326a..da37f8a900afb 100644
--- a/drivers/gpu/drm/amd/amdgpu/cz_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
@@ -179,6 +179,7 @@ static void cz_ih_irq_disable(struct amdgpu_device *adev)
  * cz_ih_get_wptr - get the IH ring buffer wptr
  *
  * @adev: amdgpu_device pointer
+ * @ih: IH ring buffer to fetch wptr
  *
  * Get the IH ring buffer wptr from either the register
  * or the writeback memory buffer (VI).  Also check for
@@ -213,6 +214,8 @@ static u32 cz_ih_get_wptr(struct amdgpu_device *adev,
  * cz_ih_decode_iv - decode an interrupt vector
  *
  * @adev: amdgpu_device pointer
+ * @ih: IH ring buffer to decode
+ * @entry: IV entry to place decoded information into
  *
  * Decodes the interrupt vector at the current rptr
  * position and also advance the position.
@@ -245,6 +248,7 @@ static void cz_ih_decode_iv(struct amdgpu_device *adev,
  * cz_ih_set_rptr - set the IH ring buffer rptr
  *
  * @adev: amdgpu_device pointer
+ * @ih: IH ring buffer to set rptr
  *
  * Set the IH ring buffer rptr.
  */
-- 
2.25.1

