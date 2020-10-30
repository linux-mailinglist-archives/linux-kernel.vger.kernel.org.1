Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16FD129FC39
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 04:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbgJ3DeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 23:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgJ3DeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 23:34:05 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A9CC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 20:34:03 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id x13so4041474pgp.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 20:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=0dmV/CR2ixHQrxpfc1u4wESPQI/4+pG75mm91eKFO/I=;
        b=cGHq059jOI/OKifCzdFXyVg+UBZQHuv/ZQ2se7LpOBjz9fKNLXGdVF8hhSX10jzUFl
         trKUJ3ukZIF0xbFq8ydvkaiDgQHrxpVyKOjzYlvGHmJMtWJ1bvPkMNvlwAu/x+P8w8Ao
         RUs7HLtG/Xw736RQRnqTD6ygZyxTkjS2DScxRQz5H2x2Dz4op/hOenaz2bRTZMabYYTf
         iN/VmACa0OmHa3+Mt9LqTpM+j4mGBwiMWXStiEX+0/i+JJ68fXVcKi8WYB556GZJylmm
         tHzBBV6n+bKZiHSwQH0jab0Unt1kdesZRk7AvagO8eVt6BHsBVNlh4Hfnx0L/86APmX8
         si2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=0dmV/CR2ixHQrxpfc1u4wESPQI/4+pG75mm91eKFO/I=;
        b=HeAvulHj349L/WyQtkNzpwLWuBOIOxsO/psbAPaeD9P/au1P9avh/g8A7oqTcjm+rC
         MqlIol0hNggvFo6SAaV6x5mRlNjpcmfed9pRWzVNhhRWipxxYIaZq9pbtETAoza6BMAR
         ObIMKgftPwPitdjWlSVGEsW0WLnKZmagRKqj9/KZlIXOFuPypaiRyiA1mVbcVM6mrMep
         bnfcx2rNa2pg3ySNr0wJjMRP5rwY62isVTLIK/itPoFJ/pteD+kIwQjlmuR4QW6YoGiR
         2kA6FiRDsZiA87E2lp8vgwgSHbgaiCXidkbXCHUmclW02k+BJIiEK/T3QaNtJ05zMHKR
         hREQ==
X-Gm-Message-State: AOAM530LnMuvZAiv4ri9r+EXe8wq63HSJHUOEQlIk68BL3Fap2rrmrRb
        X7IZ0GtduP+kTdGX2uhZW3w=
X-Google-Smtp-Source: ABdhPJygkP1YEs01A252TcskXebd1Ann3fBmrJQ+e+HCwnue7s3XOdZxU4n3Hu6M9H8S8X6wE/AQYQ==
X-Received: by 2002:a65:688a:: with SMTP id e10mr394514pgt.347.1604028843566;
        Thu, 29 Oct 2020 20:34:03 -0700 (PDT)
Received: from my--box ([103.98.79.70])
        by smtp.gmail.com with ESMTPSA id bo16sm1326504pjb.41.2020.10.29.20.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 20:34:03 -0700 (PDT)
Date:   Fri, 30 Oct 2020 09:03:57 +0530
From:   Deepak R Varma <mh12gx2825@gmail.com>
To:     outreachy-kernel@googlegroups.com,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     mh12gx2825@gmail.com, melissa.srw@gmail.com, daniel.vetter@ffwll.ch
Subject: [PATCH] drm/sti: use DEFINE_DEBUGFS_ATTRIBUTE with
 debugfs_create_file_unsafe()
Message-ID: <20201030033357.GA275168@my--box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using DEFINE_DEBUGFS_ATTRIBUTE macro with debugfs_create_file_unsafe()
function in place of the debugfs_create_file() function will make the
file operation struct "reset" aware of the file's lifetime. Additional
details here: https://lists.archive.carbon60.com/linux/kernel/2369498

Issue reported by Coccinelle script:
scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci

Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
---
Please Note: This is a Outreachy project task patch.

 drivers/gpu/drm/sti/sti_drv.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/sti/sti_drv.c b/drivers/gpu/drm/sti/sti_drv.c
index 3f54efa36098..18c6639e4dbf 100644
--- a/drivers/gpu/drm/sti/sti_drv.c
+++ b/drivers/gpu/drm/sti/sti_drv.c
@@ -68,8 +68,8 @@ static int sti_drm_fps_set(void *data, u64 val)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(sti_drm_fps_fops,
-			sti_drm_fps_get, sti_drm_fps_set, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(sti_drm_fps_fops, sti_drm_fps_get,
+			 sti_drm_fps_set, "%llu\n");
 
 static int sti_drm_fps_dbg_show(struct seq_file *s, void *data)
 {
@@ -98,8 +98,8 @@ static void sti_drm_dbg_init(struct drm_minor *minor)
 				 ARRAY_SIZE(sti_drm_dbg_list),
 				 minor->debugfs_root, minor);
 
-	debugfs_create_file("fps_show", S_IRUGO | S_IWUSR, minor->debugfs_root,
-			    minor->dev, &sti_drm_fps_fops);
+	debugfs_create_file_unsafe("fps_show", S_IRUGO | S_IWUSR, minor->debugfs_root,
+				   minor->dev, &sti_drm_fps_fops);
 
 	DRM_INFO("%s: debugfs installed\n", DRIVER_NAME);
 }
-- 
2.25.1

