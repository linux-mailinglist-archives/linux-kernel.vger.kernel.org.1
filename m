Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4B729E7B8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 10:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbgJ2Jq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 05:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbgJ2Jqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 05:46:55 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69992C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 02:46:54 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id z1so1019866plo.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 02:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AYPEHTouurF1cTcYUar98MQMwBtfappOluNio1ar5uI=;
        b=FT6cCg/TyF33N24iefJhPYkrUdJUIMG9w8XzUmMXPt/B67H3VnLcxkvGAe76NsVVpc
         31Sx3VY+TSqi+EdQ/L3WImdWmMxzFCgKeUyDuOGoKtMYQjyQvhbz3r8jWXYLX7yOf/ku
         ZGyarUSm/j13GSwmYfPIsnO8Tat0QsKD9bZePu5o5cYljD9o0bHrcAWKgi9dxqgCVAxa
         uiilL86xFx4TMJUVRZDjbp4CUATO1kE2sBqy++veKhDQvK/7iDsz2dEKftaYXhdxwFpr
         UWB8FkJ85g2o8VXVfzr9uEjfEXISyBH4s9/ygZdoWigqdK37uYuFULZJKmzHhhGWahGo
         xhkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AYPEHTouurF1cTcYUar98MQMwBtfappOluNio1ar5uI=;
        b=LtIlR3LORzBSlNjr6/dPLqM1t/zaP2FnsR881HchpNq1NXFyQfeYguH2mr028+W3MI
         yET8hB94cgC7isDcW4wCW4Z5q1XnUQ3Bg3GIVDc4oky1jMBdRS1tbPLfkkM/DFVGLhXd
         sMq3pIEeVrBkZMMy/B+99KCSVFMz9VkNGnDZSzZ/k9CUNdI4uK4o7Ryk5d5ap7oZAtSi
         zg0UFpviTN6MlcITwmHlyz/F8ejdHs42fjpFz06t2Y1fVaSgxsd0w6C8llLnjGDL0+VE
         cOiTvcON499c341fGL894rP/LVYP4D+0gDdxa1teQqnHtTPUJbjDG9AKUMmKDoVx6+wT
         aFtQ==
X-Gm-Message-State: AOAM531coTIJh+mJM0tj8npiEGm3HyrBFNGuHRQZooNOXl9aLNNcjNXl
        9v8gXqB+xtEMt+2EvTwaxE4=
X-Google-Smtp-Source: ABdhPJzMMslfXX/O2/ZByYkV35XMo8LFDyOwhWwNQve6kdjZQT7DRckAa2snIGRQsiWbAPY0tNHNnQ==
X-Received: by 2002:a17:902:eb14:b029:d6:5a66:aa31 with SMTP id l20-20020a170902eb14b02900d65a66aa31mr3050480plb.53.1603964813977;
        Thu, 29 Oct 2020 02:46:53 -0700 (PDT)
Received: from localhost.localdomain (sau-465d4-or.servercontrol.com.au. [43.250.207.1])
        by smtp.gmail.com with ESMTPSA id d10sm2052270pgk.74.2020.10.29.02.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 02:46:52 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     harry.wentland@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] drivers: amdgpu: Correct spelling defalut to default in comment
Date:   Thu, 29 Oct 2020 15:13:46 +0530
Message-Id: <20201029094346.14185-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct spelling in one of the comment.

s/defalut/default/p

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 CCing Greg becasue it touched drivers file. Trivial though.

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 8cd646eef096..cdc8dd220a77 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -556,7 +556,7 @@ static ssize_t dp_phy_test_pattern_debugfs_write(struct file *f, const char __us
 	bool disable_hpd = false;
 	bool valid_test_pattern = false;
 	uint8_t param_nums = 0;
-	/* init with defalut 80bit custom pattern */
+	/* init with default 80bit custom pattern */
 	uint8_t custom_pattern[10] = {
 			0x1f, 0x7c, 0xf0, 0xc1, 0x07,
 			0x1f, 0x7c, 0xf0, 0xc1, 0x07
--
2.26.2

