Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC70A2414D0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 04:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgHKCNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 22:13:06 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9259 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726380AbgHKCNF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 22:13:05 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9CE0B367C7515FE61482;
        Tue, 11 Aug 2020 10:13:02 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Tue, 11 Aug 2020
 10:12:54 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <hjc@rock-chips.com>, <heiko@sntech.de>, <airlied@linux.ie>,
        <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drm/rockchip: cdn-dp: Mark cdn_dp_core_suspend/resume __maybe_unused
Date:   Tue, 11 Aug 2020 10:12:25 +0800
Message-ID: <20200811021225.50296-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_PM is not set, gcc warns:

drivers/gpu/drm/rockchip/cdn-dp-core.c:1124:12:
 warning: ‘cdn_dp_resume’ defined but not used [-Wunused-function]

Mark them __maybe_unused to fix this.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/rockchip/cdn-dp-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
index a4a45daf93f2..413b0e90f10f 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
@@ -1107,7 +1107,7 @@ static const struct component_ops cdn_dp_component_ops = {
 	.unbind = cdn_dp_unbind,
 };
 
-static int cdn_dp_suspend(struct device *dev)
+static __maybe_unused int cdn_dp_suspend(struct device *dev)
 {
 	struct cdn_dp_device *dp = dev_get_drvdata(dev);
 	int ret = 0;
@@ -1121,7 +1121,7 @@ static int cdn_dp_suspend(struct device *dev)
 	return ret;
 }
 
-static int cdn_dp_resume(struct device *dev)
+static __maybe_unused int cdn_dp_resume(struct device *dev)
 {
 	struct cdn_dp_device *dp = dev_get_drvdata(dev);
 
-- 
2.17.1


