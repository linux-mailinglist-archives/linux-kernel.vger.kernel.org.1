Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C53929FC35
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 04:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgJ3Db6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 23:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgJ3Db6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 23:31:58 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F417EC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 20:31:56 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 13so4092122pfy.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 20:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=/T4zGmBDffm929p//CkvLaNebm6nyFAD9zUf2m9Khc4=;
        b=X1UWJ4sPXdTWBIvP+F+d5R4n1cI/VqlbKPsD5DFU8zgNOzIuU0AC9ZGBu9xoK1nvc9
         nLQpLTzbDXu6GLCZo8rs9F21QC1I/ouTPmpeh9aZRrsPJmQsdSz1mmWiVUDlJ2pxCFBQ
         HsUC+ecXEg0DEsWwh1r1i7yZZrhGSZ3sVXc+21L8sIz1N0MiX+FBnYm9qRkgAol30CU9
         gRgT+nzRfWjSCo4tfKtNOWkwE+WpXvnFmyjFz6L8aXVDOX+8DriE1vxyPtxNOs1NbTPq
         K6vUU6cObxxoRI09vmq3cdOPXcYnXPouUZzw9wcZwy++N2E4Sx1IY1REOHmCj4ER+4Yt
         K3Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=/T4zGmBDffm929p//CkvLaNebm6nyFAD9zUf2m9Khc4=;
        b=E8KCG/Qx7O+jocSLXN05Cbs7FXtsySZFq7shA0/NrAwcpoZsznMvZ6XwqQ+qnf2zHp
         pKRAOXL3tYIHdkwErURv8IR9b16mhOjL2iqU4FCPcCUrxXcW5renWg6d2xZLDs4Eg1rg
         hcND0FAWKkJ7hyPqUBsN32RTyjkvegycJUpKmu/CEowrTFVhJVsk2MNWvP+QPVAGTYzV
         RmXCFuFfdlLfIdniq/DCQpa4MAq/uSycDKL4CXS0bNcMK7oTUDZFCa66cSMbnzdonq2V
         7RrUKwNTzuaWRG1ZZz5k16SZi3Ukq8mtTIgQdG7VtciArSA0WsW6b8JrQ9GpNbPte23R
         FRfw==
X-Gm-Message-State: AOAM530N1gb2TuUkuVWuEDQrOBQF4tSGg/9w9mkkpJ8zTvPs/xGoAXAG
        djn5iC9zOtOvanl7ugVZCAU=
X-Google-Smtp-Source: ABdhPJxkSyJmnutDKVjlWOgdwKq+ADH5KNQw1TaMs0tFikKarD1tEV+1DKJFm/wnchCxAFJxjRiytg==
X-Received: by 2002:a17:90a:ba8d:: with SMTP id t13mr376040pjr.38.1604028716631;
        Thu, 29 Oct 2020 20:31:56 -0700 (PDT)
Received: from my--box ([103.98.79.70])
        by smtp.gmail.com with ESMTPSA id b17sm3932152pgb.94.2020.10.29.20.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 20:31:56 -0700 (PDT)
Date:   Fri, 30 Oct 2020 09:01:50 +0530
From:   Deepak R Varma <mh12gx2825@gmail.com>
To:     outreachy-kernel@googlegroups.com,
        Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Purism Kernel Team <kernel@puri.sm>,
        Ondrej Jirman <megous@megous.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     mh12gx2825@gmail.com, melissa.srw@gmail.com, daniel.vetter@ffwll.ch
Subject: [PATCH] drm/panel: st7703: use DEFINE_DEBUGFS_ATTRIBUTE with
 debugfs_create_file_unsafe()
Message-ID: <20201030033150.GA275009@my--box>
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

 drivers/gpu/drm/panel/panel-sitronix-st7703.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7703.c b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
index c22e7c49e077..89b71d4f810d 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7703.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
@@ -502,15 +502,14 @@ static int allpixelson_set(void *data, u64 val)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(allpixelson_fops, NULL,
-			allpixelson_set, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(allpixelson_fops, NULL, allpixelson_set, "%llu\n");
 
 static void st7703_debugfs_init(struct st7703 *ctx)
 {
 	ctx->debugfs = debugfs_create_dir(DRV_NAME, NULL);
 
-	debugfs_create_file("allpixelson", 0600, ctx->debugfs, ctx,
-			    &allpixelson_fops);
+	debugfs_create_file_unsafe("allpixelson", 0600, ctx->debugfs, ctx,
+				   &allpixelson_fops);
 }
 
 static void st7703_debugfs_remove(struct st7703 *ctx)
-- 
2.25.1

