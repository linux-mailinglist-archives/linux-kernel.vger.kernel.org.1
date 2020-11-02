Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D06412A26E1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 10:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgKBJVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 04:21:34 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:7399 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727992AbgKBJVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 04:21:34 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CPnV33Bt7z72BL;
        Mon,  2 Nov 2020 17:21:31 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Mon, 2 Nov 2020 17:21:23 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <robh@kernel.org>, <tomeu.vizoso@collabora.com>,
        <steven.price@arm.com>, <alyssa.rosenzweig@collabora.com>,
        <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] drm/panfrost: Fix unused variable warning
Date:   Mon, 2 Nov 2020 17:33:19 +0800
Message-ID: <1604309599-10078-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning:

./panfrost_job.c:617:28: warning: unused variable ‘js’ [-Wunused-variable]
  struct panfrost_job_slot *js = pfdev->js;
                            ^~

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/gpu/drm/panfrost/panfrost_job.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
index 4902bc6..e75b7d2 100644
--- a/drivers/gpu/drm/panfrost/panfrost_job.c
+++ b/drivers/gpu/drm/panfrost/panfrost_job.c
@@ -613,8 +613,6 @@ int panfrost_job_open(struct panfrost_file_priv *panfrost_priv)
 
 void panfrost_job_close(struct panfrost_file_priv *panfrost_priv)
 {
-	struct panfrost_device *pfdev = panfrost_priv->pfdev;
-	struct panfrost_job_slot *js = pfdev->js;
 	int i;
 
 	for (i = 0; i < NUM_JOB_SLOTS; i++)
-- 
2.6.2

