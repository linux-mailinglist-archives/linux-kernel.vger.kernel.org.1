Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 957172DFC30
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 14:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbgLUNF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 08:05:57 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9544 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbgLUNF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 08:05:56 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4D006m55Mlzhw7F;
        Mon, 21 Dec 2020 21:04:32 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Mon, 21 Dec 2020 21:05:06 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] gpu: drm: Replace simple_strtol by simple_strtoul
Date:   Mon, 21 Dec 2020 21:05:41 +0800
Message-ID: <20201221130541.1975-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The simple_strtol() function is deprecated, use simple_strtoul() instead.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/gpu/drm/drm_modes.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
index 501b4fe55a3d..048d6a2c1623 100644
--- a/drivers/gpu/drm/drm_modes.c
+++ b/drivers/gpu/drm/drm_modes.c
@@ -1395,7 +1395,7 @@ static int drm_mode_parse_cmdline_bpp(const char *str, char **end_ptr,
 		return -EINVAL;
 
 	str++;
-	bpp = simple_strtol(str, end_ptr, 10);
+	bpp = simple_strtoul(str, end_ptr, 10);
 	if (*end_ptr == str)
 		return -EINVAL;
 
@@ -1414,7 +1414,7 @@ static int drm_mode_parse_cmdline_refresh(const char *str, char **end_ptr,
 		return -EINVAL;
 
 	str++;
-	refresh = simple_strtol(str, end_ptr, 10);
+	refresh = simple_strtoul(str, end_ptr, 10);
 	if (*end_ptr == str)
 		return -EINVAL;
 
@@ -1486,7 +1486,7 @@ static int drm_mode_parse_cmdline_res_mode(const char *str, unsigned int length,
 	int remaining, i;
 	char *end_ptr;
 
-	xres = simple_strtol(str, &end_ptr, 10);
+	xres = simple_strtoul(str, &end_ptr, 10);
 	if (end_ptr == str)
 		return -EINVAL;
 
@@ -1495,7 +1495,7 @@ static int drm_mode_parse_cmdline_res_mode(const char *str, unsigned int length,
 	end_ptr++;
 
 	str = end_ptr;
-	yres = simple_strtol(str, &end_ptr, 10);
+	yres = simple_strtoul(str, &end_ptr, 10);
 	if (end_ptr == str)
 		return -EINVAL;
 
@@ -1553,7 +1553,7 @@ static int drm_mode_parse_cmdline_int(const char *delim, unsigned int *int_ret)
 		return -EINVAL;
 
 	value = delim + 1;
-	*int_ret = simple_strtol(value, &endp, 10);
+	*int_ret = simple_strtoul(value, &endp, 10);
 
 	/* Make sure we have parsed something */
 	if (endp == value)
-- 
2.22.0

