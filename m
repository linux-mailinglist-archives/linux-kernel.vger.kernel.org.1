Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5741FAF6D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 13:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbgFPLmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 07:42:32 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51173 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgFPLmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 07:42:31 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jl9yv-0006sx-D3; Tue, 16 Jun 2020 11:42:21 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Animesh Manna <animesh.manna@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915/display: fix missing null check on allocated dsb object
Date:   Tue, 16 Jun 2020 12:42:21 +0100
Message-Id: <20200616114221.73971-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0.rc0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently there is no null check for a failed memory allocation
on the dsb object and without this a null pointer dereference
error can occur. Fix this by adding a null check.

Note: added a drm_err message in keeping with the error message style
in the function.

Addresses-Coverity: ("Dereference null return")
Fixes: afeda4f3b1c8 ("drm/i915/dsb: Pre allocate and late cleanup of cmd buffer")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/i915/display/intel_dsb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_dsb.c b/drivers/gpu/drm/i915/display/intel_dsb.c
index 24e6d63e2d47..566fa72427b3 100644
--- a/drivers/gpu/drm/i915/display/intel_dsb.c
+++ b/drivers/gpu/drm/i915/display/intel_dsb.c
@@ -271,6 +271,10 @@ void intel_dsb_prepare(struct intel_crtc_state *crtc_state)
 		return;
 
 	dsb = kmalloc(sizeof(*dsb), GFP_KERNEL);
+	if (!dsb) {
+		drm_err(&i915->drm, "DSB object creation failed\n");
+		return;
+	}
 
 	wakeref = intel_runtime_pm_get(&i915->runtime_pm);
 
-- 
2.27.0.rc0

