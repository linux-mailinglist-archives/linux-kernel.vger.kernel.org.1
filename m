Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F33F2287111
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 10:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbgJHI6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 04:58:00 -0400
Received: from ns.lineo.co.jp ([203.141.200.203]:38822 "EHLO mail.lineo.co.jp"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726346AbgJHI5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 04:57:33 -0400
Received: from [172.31.78.0] (unknown [203.141.200.204])
        by mail.lineo.co.jp (Postfix) with ESMTPSA id D24C480535E2A;
        Thu,  8 Oct 2020 17:47:46 +0900 (JST)
From:   Naoki Hayama <naoki.hayama@lineo.co.jp>
Subject: [PATCH 5/6] drm/etnaviv: Fix typo arbitary
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Naoki Hayama <naoki.hayama@lineo.co.jp>
Message-ID: <db33738b-9b6d-c11e-c603-99a0f8ae3c3f@lineo.co.jp>
Date:   Thu, 8 Oct 2020 17:47:46 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix comment typo.
s/arbitary/arbitrary/

Signed-off-by: Naoki Hayama <naoki.hayama@lineo.co.jp>
---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index c6404b8d067f..5077004f7fbf 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -1811,7 +1811,7 @@ static int etnaviv_gpu_platform_probe(struct platform_device *pdev)
 
 	/*
 	 * We treat the device as initially suspended.  The runtime PM
-	 * autosuspend delay is rather arbitary: no measurements have
+	 * autosuspend delay is rather arbitrary: no measurements have
 	 * yet been performed to determine an appropriate value.
 	 */
 	pm_runtime_use_autosuspend(gpu->dev);
-- 
2.17.1
