Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED552F5BB2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 08:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbhANHzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 02:55:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:56968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726510AbhANHzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 02:55:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 317DC23A1D;
        Thu, 14 Jan 2021 07:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610610830;
        bh=idK8XxiiyoaOs4dRWdbCzNyTgXtfNWQ9SoHpDwL3m2Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b8dswQE7d/kB9wq8ybsSfUBXKKkwU+3so8XJ12vaHCSCAOzrG/sIRTcotmO+FIOzz
         1vYZ9ljGc1MW0Dj8OJg8cwTbG7ah/bKjkBpZS81UQc9bIZT7kpwEtysxp9kyeC8YNj
         BMMhNdj1HDHIU9lKBErMLGWf4PUEUI/PXXdnQHHtLit/GTocSZ6mEiu4Nylnqtzsul
         ksCxayncQ43o2mIIT9YzYNt5rl3Nf9z6BzewjVkiJbV7Q+HxaIxb1oeDssyR4stJ7v
         EYAIbYlNrw8cYi6Lm52mUAvcyXiJjjdqMR0SlsYePai6Os9DQUGBzvjpx8uYG1+sIY
         /zv635ZwB6Tmw==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kzxRz-00EPuD-9C; Thu, 14 Jan 2021 08:53:47 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Linux Doc Mailing List" <linux-doc@vger.kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Eryk Brol <eryk.brol@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Mikita Lipski <mikita.lipski@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Wayne Lin <Wayne.Lin@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/10] drm: amd: amdgpu_dm.h: fix a wrong kernel-doc markup
Date:   Thu, 14 Jan 2021 08:53:41 +0100
Message-Id: <8e16f3aa553786cd193e49882ce5131e3769afb8.1610610444.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1610610444.git.mchehab+huawei@kernel.org>
References: <cover.1610610444.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a missing colon, causing the markup to be ignored,
solving those warnings:

	../drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:340: warning: Incorrect use of kernel-doc format:          * @active_vblank_irq_count
	../drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:379: warning: Function parameter or member 'active_vblank_irq_count' not described in 'amdgpu_display_manager'

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index f084e2fc9569..5ee1b766884e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -337,7 +337,7 @@ struct amdgpu_display_manager {
 	const struct gpu_info_soc_bounding_box_v1_0 *soc_bounding_box;
 
 	/**
-	 * @active_vblank_irq_count
+	 * @active_vblank_irq_count:
 	 *
 	 * number of currently active vblank irqs
 	 */
-- 
2.29.2

