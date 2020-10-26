Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7066F29986F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 22:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729280AbgJZVB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 17:01:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:55826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729259AbgJZVB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 17:01:28 -0400
Received: from localhost.localdomain (unknown [192.30.34.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E32620829;
        Mon, 26 Oct 2020 21:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603746087;
        bh=MIKQiQBZmnJNoIdqgw0/BlRmOZ5SjarctyzS0l2h4+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LhJGZKnxSeOcuD6ScbAADTnR9TLfI1UtJCyMiRiDdhHRuZuvsY3YrTaDxh6sGNlq/
         GJNUazGYQ518GnLMyj7JxnE+sR70RBTEk+CHDZnfJAwrk6Kz51sc2k3Eqe9KndcdNq
         Br42FS+wMsgrnj3jVqhMnunD5FRtHzyJ9KYNpdAU=
From:   Arnd Bergmann <arnd@kernel.org>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Anthony Koo <Anthony.Koo@amd.com>,
        Krunoslav Kovac <Krunoslav.Kovac@amd.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Denis Efremov <efremov@linux.com>,
        Aric Cyr <Aric.Cyr@amd.com>, Josip Pavic <Josip.Pavic@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Reza Amini <Reza.Amini@amd.com>,
        Lewis Huang <Lewis.Huang@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] drm/amdgpu: fix build_coefficients() argument
Date:   Mon, 26 Oct 2020 22:00:32 +0100
Message-Id: <20201026210039.3884312-4-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201026210039.3884312-1-arnd@kernel.org>
References: <20201026210039.3884312-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

gcc -Wextra warns about a function taking an enum argument
being called with a bool:

drivers/gpu/drm/amd/amdgpu/../display/modules/color/color_gamma.c: In function 'apply_degamma_for_user_regamma':
drivers/gpu/drm/amd/amdgpu/../display/modules/color/color_gamma.c:1617:29: warning: implicit conversion from 'enum <anonymous>' to 'enum dc_transfer_func_predefined' [-Wenum-conversion]
 1617 |  build_coefficients(&coeff, true);

It appears that a patch was added using the old calling conventions
after the type was changed, and the value should actually be 0
(TRANSFER_FUNCTION_SRGB) here instead of 1 (true).

Fixes: 55a01d4023ce ("drm/amd/display: Add user_regamma to color module")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/display/modules/color/color_gamma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
index b8695660b480..09bc2c249e1a 100644
--- a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
+++ b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
@@ -1614,7 +1614,7 @@ static void apply_degamma_for_user_regamma(struct pwl_float_data_ex *rgb_regamma
 	struct pwl_float_data_ex *rgb = rgb_regamma;
 	const struct hw_x_point *coord_x = coordinates_x;
 
-	build_coefficients(&coeff, true);
+	build_coefficients(&coeff, TRANSFER_FUNCTION_SRGB);
 
 	i = 0;
 	while (i != hw_points_num + 1) {
-- 
2.27.0

