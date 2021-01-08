Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E71972EF8E8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 21:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbhAHUS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 15:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729281AbhAHUQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 15:16:45 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4BFC0612AB
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 12:15:27 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 190so8767588wmz.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 12:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mGH9J7vG9w88diVL7S4q4GpxhT0ewyJTldBss+diQXU=;
        b=PoNsSs56+BhMbOp3HWwYXgMD2QalVIqugoJIccivvlUXtTK6KydRosDvXV2ZMuK/j6
         V6deq3qJNwDrJvTtxb7rjmxTFTbONrxIeNL/zfclyDWG6Fn3P7ALgSPgu3EF4Cs7h1gO
         QZxb/a0xh4i64xWfdI1wyCJhnaWHq7gvEWk5XBusIVSbcBRJeaVcaKPSyAjQcin6JAsX
         e3aD9yBqliYSPffaP0lhXjbatKqzhsO3cZn/JuwGPbJUBYgkcGg9pspsR7XYLAjAezOQ
         trOtfe1OF81CcTOBCg2m0rxWecucTjnZDHJ1PtOw0qT/qF9F4x0mLHsKgtc6B4gxw12G
         HsCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mGH9J7vG9w88diVL7S4q4GpxhT0ewyJTldBss+diQXU=;
        b=bCDKdk/RU+wH5ODC3sdBqfYRiTlNxJ/GsnB6k7I5Q7m8P6XD4vYuI9WlhFjoAtLxqv
         HF1WNYkK2gXD+XWmzTkZajixxhpK1ADIL/Tmx7w8gjklZGgetxiY/xJpNwRewOI80yno
         KNmtBMwLaNHwaRKqNl3UwKjv5Uou0VEgfzAIHTrWNG8dc4nOtP+zj6mXgIAWj8yI6/pH
         u31QDcODEqlXEuM5fZygeWBqphYASe+ys4hux9bfCWz4uzEMVwyz7MEiSkzm+55r6yDS
         CIqVPN9z50pjHZcR/QSZn2stVPTRnlbn0rKXhkLZs5DBzlHlAiihelG2e9mj7QCeJ/od
         ukhA==
X-Gm-Message-State: AOAM530o2gAZnNJh4MNlpJOhIf4qSemJoYKm8ik1AWd/CDX3mhAIecwv
        CKtT5KK6HLe8VLZHKRG9X10ZSA==
X-Google-Smtp-Source: ABdhPJwK8AFiXaFBtq8APb9s+USZEr9/YOKlixvoWl/dOKnQX99kel0RW2cLzwRidX++r0XSx7n0KA==
X-Received: by 2002:a1c:1d08:: with SMTP id d8mr4586785wmd.159.1610136926583;
        Fri, 08 Jan 2021 12:15:26 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id l8sm15598671wrb.73.2021.01.08.12.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 12:15:25 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mauro Rossi <issor.oruam@gmail.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 15/40] drm/amd/display/dc/bios/command_table_helper: Fix kernel-doc formatting
Date:   Fri,  8 Jan 2021 20:14:32 +0000
Message-Id: <20210108201457.3078600-16-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210108201457.3078600-1-lee.jones@linaro.org>
References: <20210108201457.3078600-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table_helper.c:131: warning: Function parameter or member 't' not described in 'dal_cmd_table_helper_transmitter_bp_to_atom'

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Mauro Rossi <issor.oruam@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../display/dc/bios/command_table_helper.c    | 20 ++++++++-----------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper.c b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper.c
index 48b4ef03fc8f8..5b77251e05909 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper.c
@@ -114,18 +114,14 @@ bool dal_cmd_table_helper_controller_id_to_atom(
 }
 
 /**
-* translate_transmitter_bp_to_atom
-*
-* @brief
-*  Translate the Transmitter to the corresponding ATOM BIOS value
-*
-* @param
-*   input transmitter
-*   output digitalTransmitter
-*    // =00: Digital Transmitter1 ( UNIPHY linkAB )
-*    // =01: Digital Transmitter2 ( UNIPHY linkCD )
-*    // =02: Digital Transmitter3 ( UNIPHY linkEF )
-*/
+ * translate_transmitter_bp_to_atom - Translate the Transmitter to the
+ *                                    corresponding ATOM BIOS value
+ * @t: transmitter
+ * returns: output digitalTransmitter
+ *    // =00: Digital Transmitter1 ( UNIPHY linkAB )
+ *    // =01: Digital Transmitter2 ( UNIPHY linkCD )
+ *    // =02: Digital Transmitter3 ( UNIPHY linkEF )
+ */
 uint8_t dal_cmd_table_helper_transmitter_bp_to_atom(
 	enum transmitter t)
 {
-- 
2.25.1

