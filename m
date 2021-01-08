Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 903DE2EF8C3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 21:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbhAHUPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 15:15:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729049AbhAHUPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 15:15:49 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3243C0612FE
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 12:15:08 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id i9so10168229wrc.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 12:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CLC3wxlYHWQ6PZsMNQdNLlm9sisuncKTa88XLx3zSUE=;
        b=yAbWapUqHe8VBH9G3KF49EDy/sQO6m+wgwLul50t3CREipW6GSC25Q0XUGNXI+5XDS
         cAMwcDsYmksX5DAN6QjkNeVu+KSWOoBaiMbvkUIXK9OlK14JbvaAtWtCGg8QIHPRyxjV
         e7YVrUJHXqnL8JE6wvQIBqXddGl+TU/O0ne7C55/pIRN5Pw1te6MlvwclqB2a3wyJYxt
         ZSUwUtFgjcXdYIpYfvOCe9W9jeLF6WARUmrw91MnBu2qdIVBQrtRZ5rP43ChK0k87CYf
         Pgj99VtP3blz3INbhrXCSedTTuvz/tA64m63/vAtY0NWtL67rDl7yraJ/QLw0A/4GyhL
         o/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CLC3wxlYHWQ6PZsMNQdNLlm9sisuncKTa88XLx3zSUE=;
        b=ChMRXqs/S4hvYTfzXmPhUJMxmjZ7WBAUCyEDQWJRXwa6UTZZX5MD0JcKqmZ5S/bHNc
         dQZJ2LcsuOYdK/gCgyMIvc7X1c4s+4pCzPC8iz7bCgYyBfWAMPixkAGoSdGS11UTNKta
         t+/5nW+2zUDNuuwerXT5Om1otS624JGJdOc2L0J1/UoeidMiKeyuTumpM36DLpsdFjui
         A5K3If8JXuZw5c9XcTx3QNy0l6X3IX7POeTTGx7do35K18q2RPS3dE3Gn5qjHP/Y9SRD
         riASyurHB5vnwtOivPBYYSCBosoP3Rpla2hnH4IDEF3ydMjPDUl0y3bZE90fthtO5uO8
         MCFg==
X-Gm-Message-State: AOAM533CWEvs4bgWhjSnsNTgCfNFFhIfVwf9iFqLckOMyil7QMgBmLPM
        z+IriadHRNWIa1CDI6gjrJINMGnL27/vXYIz
X-Google-Smtp-Source: ABdhPJwQxL1faOPxx3kXmSO23mgrSfY+Szq+BvgRMYG9nDkR7lKbbRKJvC5wf10qTP7Y1M1j0pYTnA==
X-Received: by 2002:a5d:69cf:: with SMTP id s15mr5214417wrw.372.1610136907434;
        Fri, 08 Jan 2021 12:15:07 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id l8sm15598671wrb.73.2021.01.08.12.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 12:15:06 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH 02/40] drm/nouveau/dispnv50/disp: Remove unused variable 'ret'
Date:   Fri,  8 Jan 2021 20:14:19 +0000
Message-Id: <20210108201457.3078600-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210108201457.3078600-1-lee.jones@linaro.org>
References: <20210108201457.3078600-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/nouveau/dispnv50/disp.c:1381:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]

Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 33fff388dd83c..b615204c2cba6 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -1378,10 +1378,9 @@ nv50_mstm_prepare(struct nv50_mstm *mstm)
 {
 	struct nouveau_drm *drm = nouveau_drm(mstm->outp->base.base.dev);
 	struct drm_encoder *encoder;
-	int ret;
 
 	NV_ATOMIC(drm, "%s: mstm prepare\n", mstm->outp->base.base.name);
-	ret = drm_dp_update_payload_part1(&mstm->mgr);
+	drm_dp_update_payload_part1(&mstm->mgr);
 
 	drm_for_each_encoder(encoder, mstm->outp->base.base.dev) {
 		if (encoder->encoder_type == DRM_MODE_ENCODER_DPMST) {
-- 
2.25.1

