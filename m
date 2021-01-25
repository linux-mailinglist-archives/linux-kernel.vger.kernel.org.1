Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0713E302590
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 14:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728867AbhAYNgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 08:36:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:46570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728941AbhAYNeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 08:34:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C9B122AEC;
        Mon, 25 Jan 2021 11:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611574818;
        bh=imRMguePrRlh4uW9e4XxMGfsGUxkK+bwXiHzZqO3Lfk=;
        h=From:To:Cc:Subject:Date:From;
        b=Ip1QXuQsU9uUE/EF4n+BVfUEq61Zdw8/dP3khpaYi4AUlj1yREcXD4ZVqVlDTu+5T
         r0DaS5VV6QN5VPKZV2efZHtJbaFEj8lRcEEpZwXV/P5T9SnYXa4kkPCE8NDIVsQFrF
         6xCt1WXIY4ODEzX+ji14hKUArR2coftxRwlB7iKH+BnVXwMJu27EynYyb/8pL4anA3
         h9MzorSjudFf9Me4W82DINBpwapQuffCJ/Kxhgoe2Bjb2wLKk8zpyATWUSq8yPjmMZ
         H0pVYl2EL0CaHP9Ku4f4+r+UiAy1YvL1CWmIvKCvccTLN8nnCQ/f+DmYyJZlB36PEy
         OC11OOTu8R7fQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Joshua Aberback <joshua.aberback@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Wesley Chalmers <Wesley.Chalmers@amd.com>,
        Jacky Liao <ziyu.liao@amd.com>,
        Martin Leung <martin.leung@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: use div_s64() for 64-bit division
Date:   Mon, 25 Jan 2021 12:39:55 +0100
Message-Id: <20210125114012.2480845-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The open-coded 64-bit division causes a link error on 32-bit
machines:

ERROR: modpost: "__udivdi3" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: modpost: "__divdi3" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!

Use the div_s64() to perform the division here. One of them was an
unsigned division originally, but it looks like signed division was
intended, so use that to consistently allow a negative delay.

Fixes: ea7154d8d9fb ("drm/amd/display: Update dcn30_apply_idle_power_optimizations() code")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index dff83c6a142a..a133e399e76d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -772,8 +772,8 @@ bool dcn30_apply_idle_power_optimizations(struct dc *dc, bool enable)
 							cursor_cache_enable ? &cursor_attr : NULL)) {
 				unsigned int v_total = stream->adjust.v_total_max ?
 						stream->adjust.v_total_max : stream->timing.v_total;
-				unsigned int refresh_hz = (unsigned long long) stream->timing.pix_clk_100hz *
-						100LL /	(v_total * stream->timing.h_total);
+				unsigned int refresh_hz = div_s64((unsigned long long) stream->timing.pix_clk_100hz *
+						100LL, v_total * stream->timing.h_total);
 
 				/*
 				 * one frame time in microsec:
@@ -800,8 +800,8 @@ bool dcn30_apply_idle_power_optimizations(struct dc *dc, bool enable)
 				unsigned int denom = refresh_hz * 6528;
 				unsigned int stutter_period = dc->current_state->perf_params.stutter_period_us;
 
-				tmr_delay = (((1000000LL + 2 * stutter_period * refresh_hz) *
-						(100LL + dc->debug.mall_additional_timer_percent) + denom - 1) /
+				tmr_delay = div_s64(((1000000LL + 2 * stutter_period * refresh_hz) *
+						(100LL + dc->debug.mall_additional_timer_percent) + denom - 1),
 						denom) - 64LL;
 
 				/* scale should be increased until it fits into 6 bits */
@@ -815,8 +815,8 @@ bool dcn30_apply_idle_power_optimizations(struct dc *dc, bool enable)
 					}
 
 					denom *= 2;
-					tmr_delay = (((1000000LL + 2 * stutter_period * refresh_hz) *
-							(100LL + dc->debug.mall_additional_timer_percent) + denom - 1) /
+					tmr_delay = div_s64(((1000000LL + 2 * stutter_period * refresh_hz) *
+							(100LL + dc->debug.mall_additional_timer_percent) + denom - 1),
 							denom) - 64LL;
 				}
 
-- 
2.29.2

