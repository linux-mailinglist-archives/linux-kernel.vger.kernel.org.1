Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 855732EF8CD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 21:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729257AbhAHUQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 15:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729164AbhAHUQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 15:16:36 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43275C0612AC
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 12:15:29 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id t30so10182793wrb.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 12:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8pCWTLh6pUKUhVwO0TotxP6oyBluQlcMqNIDaPfcM14=;
        b=j4HTaC5teLJEWSrAqsMlehCTa/mrh1JvnNZigcfcW2Jv35J5T8GWVT4ZgZsX6LEscY
         QED6g9o4ceQ8RoCri7MtZd0Ew+XQLnuspak171c5bLYoG0e2UFlddvWCwiINRxdVHeTo
         g+WZSYoI1lYoJ78oS08z1p/OCBxFDiEEofnAbNtlpzywGkIQfnTJXobArUqLtU6QlqNT
         /ykGtHidoKH0olRRP7iKOrT3KMqLGcxYjSqj8zLn5rUIULqqVX/slgvoSl1uBFxtzGV1
         ejamhodQxeGIsV7CwOI6ke/S1yoHU9jdtTdkKxg0z51QnvH1Qwz8mqH9gn4dityIug9q
         qfQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8pCWTLh6pUKUhVwO0TotxP6oyBluQlcMqNIDaPfcM14=;
        b=Evyi+l6JAqjzYa7tSi7ZFAhLCrteLGqJKSikFCZ0KCD5JCzhuDHl6sScbt2VL2Lt/w
         DjLpbvjnDSKz+gNs9HkHwtcSAKxhVblwjCGABK9Ag7o1S3DfRoxd0p/NTakKeCMYvfJ+
         ql9nJemezzgivOdDcXOzlwSU6aIP6diSjJXpc4fusZX6UBlgJ3ce4TwhvW/kupMEjZZS
         H/5wodIe6N+n8JebM6Y6ZpVFDWmRfdwFgLv69AUi7jaTxuXA91Cn1t8DEKPDF3v2NExO
         IdkzZxIIY6TYEFucAPCkFUBEejtHF6X1CBT+Rq1uULmoOuD+6/Tkc1rXDs93AWwW0lvk
         20yw==
X-Gm-Message-State: AOAM530XCYTJheBapSC2vrgDPdmn16XrfLi2BvyUWLInsz11UCrVB97I
        luaVkUVmila2vjMLxpbco8KAVw==
X-Google-Smtp-Source: ABdhPJyfhVs/DnlMxcILfmD8bIoFox48Y/pMO+pIEVfz2Kl9AB2bShxi7CR/gVg+KkktUNdpTXcftw==
X-Received: by 2002:a5d:650f:: with SMTP id x15mr5265127wru.332.1610136927993;
        Fri, 08 Jan 2021 12:15:27 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id l8sm15598671wrb.73.2021.01.08.12.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 12:15:27 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 16/40] drm/amd/display/dc/bios/command_table_helper2: Fix legacy formatting problems
Date:   Fri,  8 Jan 2021 20:14:33 +0000
Message-Id: <20210108201457.3078600-17-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table_helper2.c:145: warning: Function parameter or member 't' not described in 'dal_cmd_table_helper_transmitter_bp_to_atom2'

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../display/dc/bios/command_table_helper2.c   | 20 ++++++++-----------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
index 7736c92d55c40..455ee2be15a36 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
@@ -128,18 +128,14 @@ bool dal_cmd_table_helper_controller_id_to_atom2(
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
+ * translate_transmitter_bp_to_atom2 - Translate the Transmitter to the
+ *                                     corresponding ATOM BIOS value
+ *  @t: transmitter
+ *  returns: digitalTransmitter
+ *    // =00: Digital Transmitter1 ( UNIPHY linkAB )
+ *    // =01: Digital Transmitter2 ( UNIPHY linkCD )
+ *    // =02: Digital Transmitter3 ( UNIPHY linkEF )
+ */
 uint8_t dal_cmd_table_helper_transmitter_bp_to_atom2(
 	enum transmitter t)
 {
-- 
2.25.1

