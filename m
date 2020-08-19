Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06068249D79
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 14:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbgHSMII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 08:08:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:49206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728060AbgHSLrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 07:47:25 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 968D12177B;
        Wed, 19 Aug 2020 11:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597837582;
        bh=KW/f3nmkG0TDh5RY8W50ZEBZaWXFRkp+lFkWS/eRvWo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kuIVRSyHRok0QM7+veTfMFmd/jFrFSUcPu2MOLfkljIf3I7u3UacTWRaqvIFT7ajy
         Wtz1G0SuDnLktczN9FW80W0sNxzdxdP+ZYPzKajRgMiDm84aFG27oSGULVERmA9z9t
         gzrd19kSxIH0+94rP6+Y0vGk9ujC6oBT9wF604Gc=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k8MXs-00EubH-HU; Wed, 19 Aug 2020 13:46:20 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Xiubin Zhang <zhangxiubin1@huawei.com>,
        Liwei Cai <cailiwei@hisilicon.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 30/49] staging: hikey9xx/gpu: register connector
Date:   Wed, 19 Aug 2020 13:45:58 +0200
Message-Id: <787b016a3c9d4c7081c520c98617b2f6673d4427.1597833138.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597833138.git.mchehab+huawei@kernel.org>
References: <cover.1597833138.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

call drm_connector_register() when initializing the connector.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/gpu/kirin9xx_dw_drm_dsi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/hikey9xx/gpu/kirin9xx_dw_drm_dsi.c b/drivers/staging/hikey9xx/gpu/kirin9xx_dw_drm_dsi.c
index 39ec39a6a69b..09d035038c1a 100644
--- a/drivers/staging/hikey9xx/gpu/kirin9xx_dw_drm_dsi.c
+++ b/drivers/staging/hikey9xx/gpu/kirin9xx_dw_drm_dsi.c
@@ -1786,6 +1786,8 @@ static int dsi_connector_init(struct drm_device *dev, struct dw_dsi *dsi)
 	if (ret)
 		return ret;
 
+	drm_connector_register(&dsi->connector);
+
 	DRM_INFO("connector init\n");
 	return 0;
 }
-- 
2.26.2

