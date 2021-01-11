Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDC3F2F1F00
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390924AbhAKTUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:20:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730195AbhAKTUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:20:31 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58822C0617A4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:19:38 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id w5so892574wrm.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wtAOwEmizSXmIkh30HKF25wTD18EAWpeWdhE7dkllNs=;
        b=fCyZq859P/dQeCyH44t2M93b+LQoVV7yA3BytWDVSHDCdpZj6czSYW8EQ493I11nZp
         TZLM8h9nbvI2ZSsDZ0F8ayzF1C0O+gVE3/ADElNiHrZ2OpcbodJ1pri3ZkxpU+ZxMz2C
         c/wfj4zzfbwk83kz3MsPJvWnnwj9kV8ZZGu/BYNeUEBCIVx/+M9UCiZytPHwoyJzOv1O
         EN8cE7QnMbiH3S7GnGgttIwXekKJseeGIsAkX6lFUjsUGz0Pk/XMypkchaaWWYtw0Pyv
         +SnwI8P7rBZIyj8cG13pJICOXd55WIo9KBphj19oSbkeD+UE3HvYdMMi9p0g/EMl349v
         V5hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wtAOwEmizSXmIkh30HKF25wTD18EAWpeWdhE7dkllNs=;
        b=o7gtLVVjRx4XG/6UImgOJS6X7vXuslWmTcTCxeqlngrTPy8PFpz44kTD6EA4Z7B8VR
         nbIVHEQP1SHndxbGUh0wVeI4mt9e8yZ67S69bp9JQBy1M20LTDnuM2T3aXQR1cOWK2Y6
         h236+R5caovEsqJtwFLp+LaKSY8pHUA5NA/P6zj7ltzsJtEyE6rgDGcwW2+V8By1eHXy
         aulWdlTibGXMeQ3riyPSRaJ96wPVCLFpjPqgSqRiaWXT1Ui2v4A/tVqmv1Jb9Xt9NIKq
         frZ6/XhgKmo1yU2vlKXG2D8gL0uVda2rBvifFj9K+QEollTervRUVtJZbvsh/xaRZ2e4
         X4iw==
X-Gm-Message-State: AOAM530GiKrtLR6w/S7+walC01juNMFW/vz/JSstJNaGWAgdtbQwMh7I
        kqjwnWyL04fN4hFPTIbls0QRKQ==
X-Google-Smtp-Source: ABdhPJxZvh7UGiKoLb3bQAdGOE/yM4veJW9oQ2ZzPN/cB2f7BL75dwU9v6EuG8b27l35DZYuMy6gXQ==
X-Received: by 2002:a5d:50c3:: with SMTP id f3mr555705wrt.287.1610392777131;
        Mon, 11 Jan 2021 11:19:37 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id n3sm778090wrw.61.2021.01.11.11.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 11:19:36 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mauro Rossi <issor.oruam@gmail.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 05/40] drm/amd/display/dc/dce/dce_transform: Demote kernel-doc abuse
Date:   Mon, 11 Jan 2021 19:18:51 +0000
Message-Id: <20210111191926.3688443-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210111191926.3688443-1-lee.jones@linaro.org>
References: <20210111191926.3688443-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The header doesn't provide any additional parameter descriptions.

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_transform.c:1104: warning: Cannot understand  *****************************************************************************

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Mauro Rossi <issor.oruam@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_transform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
index 6121bb7b009b8..abbaa6b0b2db9 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
@@ -1100,7 +1100,7 @@ static void program_gamut_remap(
 
 }
 
-/**
+/*
  *****************************************************************************
  *  Function: dal_transform_wide_gamut_set_gamut_remap
  *
-- 
2.25.1

