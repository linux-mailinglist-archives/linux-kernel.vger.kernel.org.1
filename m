Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 141FE2F8390
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387544AbhAOSOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733304AbhAOSOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:14:38 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC857C061798
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:13:22 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id w5so10179630wrm.11
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A6joXVovshGu0VUNPPEN8i/itJp2RBRid6Z1nZigsRg=;
        b=EXlvQ1xkuYaB0Z7MdEmm5WdvyxotwscXh8F9NHedDJhTWXPeZU2gdBVPYu2OMHO23K
         dJ1ancfIwxMzShrNifaoMD53u0iTsFUFLLs6DAH9RK+2Q52Dm1lQUbrkxG0psDGfvKZQ
         1q23GTqrN2ZlUI1/IGj7veXKtmNjfJrkK8xDHtZ4QHbvzK4yxaf0me/Bu1PmlP/rH1D5
         HjTLgfrnW1un6iLvAUuHfNUXBa5aGyYYh68Akri/+EqvSmQqc3TTb0ka82S/NodzUXbi
         50Fpepn8Iu6zfCgWWi5e2tJ4pPnKvyPkYTsgOxqzq3X5UIpDk/eC4DdZt0G0SexixD7z
         o0kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A6joXVovshGu0VUNPPEN8i/itJp2RBRid6Z1nZigsRg=;
        b=kGn6SM2jR6xwM+/qgH2J1Akjbg2ZPlAvf0qj5/fe0LBPXp1+Loo8hOs9BU3BUA9BnC
         hlqsWOZRUppDIW0dZzpQJI163ppjvlhtYOObq58MlNMYHdS2lL/lxn2eeSAYCsMCe0VV
         H2/nVY2o7fqKlUaeaNAry63xUqfRP4Ht1pAWpFkEEbcvXKPiTpqH4UBvnXRYnz72PWKQ
         mTmumbf3EINIw+d/t7sD2ShyaofhJ3WBAfBBJNgZwsmGPMQXjRv0pG0wFhJsQHWNJ/bt
         6boaGuw34YVI9KC2atI/EmuTiem5/9z/wQ4jGt1kSU2879IR6+dY5sk0oCNbxC90vQGY
         H30g==
X-Gm-Message-State: AOAM532/JOFqv/h986dkEtdVo55kW/MqNUy5Ot8IAkGyswEtx6hgRw1c
        p8eA7wGAuaFiBYx7dX87YxHXSw==
X-Google-Smtp-Source: ABdhPJzBkaanuNrwj5IIxpOf2GYlr9KoLi6NwQlWpRiq8dPyjtOk8hCZpIdDhOd8/ew2D5/WlxQr4A==
X-Received: by 2002:adf:eac7:: with SMTP id o7mr14550950wrn.23.1610734401637;
        Fri, 15 Jan 2021 10:13:21 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id j2sm16123484wrh.78.2021.01.15.10.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 10:13:21 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 04/40] drm/vmwgfx/vmwgfx_kms: Remove unused variable 'ret' from 'vmw_du_primary_plane_atomic_check()'
Date:   Fri, 15 Jan 2021 18:12:37 +0000
Message-Id: <20210115181313.3431493-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115181313.3431493-1-lee.jones@linaro.org>
References: <20210115181313.3431493-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c: In function ‘vmw_du_primary_plane_atomic_check’:
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c:460:31: warning: variable ‘vcs’ set but not used [-Wunused-but-set-variable]

Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
Cc: Roland Scheidegger <sroland@vmware.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index 9a89f658e501c..9293dc19a7683 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -453,10 +453,9 @@ int vmw_du_primary_plane_atomic_check(struct drm_plane *plane,
 
 	if (!ret && new_fb) {
 		struct drm_crtc *crtc = state->crtc;
-		struct vmw_connector_state *vcs;
 		struct vmw_display_unit *du = vmw_crtc_to_du(crtc);
 
-		vcs = vmw_connector_state_to_vcs(du->connector.state);
+		vmw_connector_state_to_vcs(du->connector.state);
 	}
 
 
-- 
2.25.1

