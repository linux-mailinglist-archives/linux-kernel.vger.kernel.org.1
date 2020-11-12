Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 143E82B0D48
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 20:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgKLTBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 14:01:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgKLTBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 14:01:40 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545C6C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 11:01:40 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id d142so6187947wmd.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 11:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kwAPsdpVMxl/zDOaEKrvh3eBbThND3Sgn5s6wfB0Uyk=;
        b=Fres0t8Jfa1sMxBPb0ng+NZpGwBSuzbU/49z0C3NU890xFlv5eHKoMT2jnyDkSsUAN
         wnRBK1oLvYnOS19g9mm4bLKMsv9QVIR5nFRFSZWpq4hV9GOrTC/JGCdpMREo/tXyua0o
         yOQ+ZpxcYuoKP3bJmtqPuD29cfasJafnwYwqQ5N3PcfAC+KckZT0h88fD71xx84k1skp
         eq8Tqu+RqO9DtehkdDNiMSEVRYhVFTAgnDzbmHo0/bPuddqsieHSGFIiKKn8/3Ss8SUC
         BcPKgebo/3N3FuVsc+Wq0lAi/oI16TaiL3sJTGXmlIbX+H6M5+9j9E4xR+fS2u2xGkV9
         TW3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kwAPsdpVMxl/zDOaEKrvh3eBbThND3Sgn5s6wfB0Uyk=;
        b=OKhB0/rJN+gqufwaL/njcnRDwiNa7NuXtkofm6n8UAwWb32sLdl0nQstJcdXfXwnr4
         jhzFwzaTTN+9iEDmC9QNbwY/FuUmkDpcCHtHMR2aNg3DGi55oLb2cTuKTa/xQrE80wfv
         JQBl+Qkyk3CmiLN89VcAEhz6d87TJKb7EjNY+cT9YVGAWRATV+307W/4TOwIDnCe5QyN
         IWjAK1VChCeP1s4j4nJz9gL4bb8mimVBtzJflJPjSXeh7i0NvHFVoPkQ5MBlBOBp8zYG
         QRUcfsRdV+MyV4R/7oTHSQ9iZ9949NlfMLheEBcMYyD2klkTkAwsjOyWqG55KtoQUVqC
         AMow==
X-Gm-Message-State: AOAM533vXNE05GetRJoVfoqBwClHJ48RX0Vl9rkG2NsO8CPc8oQSMJmr
        dXl3mRh3KEJ5NZss6O022vPttw==
X-Google-Smtp-Source: ABdhPJwQaq6TEqkEhJtdM52YHXCBLInCKG5NdmlDOQQdgOFewzRY4CZLDjSKCrgHJpbyf0s6E3WmfA==
X-Received: by 2002:a7b:cf05:: with SMTP id l5mr1029122wmg.81.1605207697949;
        Thu, 12 Nov 2020 11:01:37 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id p4sm8105214wrm.51.2020.11.12.11.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 11:01:37 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 21/30] drm/vc4/vc4_debugfs: Demote non-conformant kernel-doc headers
Date:   Thu, 12 Nov 2020 19:00:30 +0000
Message-Id: <20201112190039.2785914-22-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201112190039.2785914-1-lee.jones@linaro.org>
References: <20201112190039.2785914-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/vc4/vc4_debugfs.c:25: warning: Function parameter or member 'minor' not described in 'vc4_debugfs_init'
 drivers/gpu/drm/vc4/vc4_debugfs.c:62: warning: Function parameter or member 'dev' not described in 'vc4_debugfs_add_file'
 drivers/gpu/drm/vc4/vc4_debugfs.c:62: warning: Function parameter or member 'name' not described in 'vc4_debugfs_add_file'
 drivers/gpu/drm/vc4/vc4_debugfs.c:62: warning: Function parameter or member 'show' not described in 'vc4_debugfs_add_file'
 drivers/gpu/drm/vc4/vc4_debugfs.c:62: warning: Function parameter or member 'data' not described in 'vc4_debugfs_add_file'

Cc: Eric Anholt <eric@anholt.net>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/vc4/vc4_debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_debugfs.c b/drivers/gpu/drm/vc4/vc4_debugfs.c
index 4fbbf980a299f..6da22af4ee911 100644
--- a/drivers/gpu/drm/vc4/vc4_debugfs.c
+++ b/drivers/gpu/drm/vc4/vc4_debugfs.c
@@ -16,7 +16,7 @@ struct vc4_debugfs_info_entry {
 	struct drm_info_list info;
 };
 
-/**
+/*
  * Called at drm_dev_register() time on each of the minors registered
  * by the DRM device, to attach the debugfs files.
  */
@@ -46,7 +46,7 @@ static int vc4_debugfs_regset32(struct seq_file *m, void *unused)
 	return 0;
 }
 
-/**
+/*
  * Registers a debugfs file with a callback function for a vc4 component.
  *
  * This is like drm_debugfs_create_files(), but that can only be
-- 
2.25.1

