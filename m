Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A279D2B1C67
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 14:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgKMNtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 08:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbgKMNtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 08:49:45 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDA4C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:49:45 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id p8so9999394wrx.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QEthodLp7zvU/usXf0Jd0tX794GA416VlkIhPueoa+8=;
        b=ZdiNluaSHrfyOSKiCyfIsfzHnN2Ubklqxy5e05xB5noS3l4Qp2ccLJohbanBayWkyC
         17l2Gw5aDJEX1j23na1uoagh+3/vhv6xyXmvXrqUFgOAHKFxsS6gO7ppNxQICzr6Ztly
         fMcb/6VgEilAxRWJbIm43gWFxOkYGgTMwCT9z4VjmwDir+B9FHFVw92C0lt6x4cM8Y71
         fReNNPIb7uOcOWlXVG8Cnp789ThiDLK5Zb7/ymHtcNAzLlzFViRxl/NUOXmC6Faf+bc+
         vEem3AiLKmDSdwJfIBzEGWAxs9IFWHKBiT0XUAlnCLMEMRcaIghkdkyJ0Do25SxLhS4h
         x+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QEthodLp7zvU/usXf0Jd0tX794GA416VlkIhPueoa+8=;
        b=A/C5dKgYyWN/0NtBfEO4loeajWx+G9THWT9R0JJ/kh13kI93bR0XfZA8GvhnToA6qv
         +F6SrvPjM6NA89uO0Alpr6rztc/TFzBT/hSm64HMKU93yvyi8DgwVQLHJvZWXU4yTGHo
         lVIFQ92NmjkQw3LJ4u/8skevu36uxIosBwd0pGJPlvuLKGll2I2DJa2po/ljrRedo12o
         FPZ0ZpbxBd1GugNCUfAGpxNnq7x41FlrqGUIQuY0sWtyRY/PMcp3znctYqQLdlXJ23Us
         0tdwXKFHuwE/JdLdYXyXsovpL45CuB9TliArEAj1dHZO6EDAyXLevEwg85iG3j3hKsP/
         ckdw==
X-Gm-Message-State: AOAM532rs43vK2uv5c2dcawz8WdDGBitFcWeW5eRZgv9RWK4SOoNDVQb
        ZNNF4UBd1pjGO4BcXEF48Y4krA==
X-Google-Smtp-Source: ABdhPJyXQ4SeW1DahMMDXOR8m2v1m6dxEe2eofYoKIAJWDN2RlH6HULuj1K7ZMWUfE2A16rj2Zl0gg==
X-Received: by 2002:a5d:6946:: with SMTP id r6mr3592679wrw.125.1605275384043;
        Fri, 13 Nov 2020 05:49:44 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id t11sm4561614wrm.8.2020.11.13.05.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 05:49:43 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 01/40] drm/amd/include/vega10_ip_offset: Mark _BASE structs as __maybe_unused
Date:   Fri, 13 Nov 2020 13:48:59 +0000
Message-Id: <20201113134938.4004947-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201113134938.4004947-1-lee.jones@linaro.org>
References: <20201113134938.4004947-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes nearly 400 warnings!

These structures are too widely used in too many varying
configurations to be split-up into different headers or moved into
source files.

Instead, we'll mark them as __maybe_unused which tells the compiler
that we're aware they're being included into source files which do not
make use of them - but we've looked into it, and it's okay.

Let's tidy-up whilst were here.  Just alignment stuff.

Fixes the following W=1 kernel build warning(s):

 In file included from drivers/gpu/drm/amd/amdgpu/navi14_reg_init.c:27:
 drivers/gpu/drm/amd/amdgpu/../include/navi14_ip_offset.h:179:29: warning: ‘USB0_BASE’ defined but not used [-Wunused-const-variable=]
 179 | static const struct IP_BASE USB0_BASE ={ { { { 0x0242A800, 0x05B00000, 0, 0, 0 } },
 | ^~~~~~~~~
 drivers/gpu/drm/amd/amdgpu/../include/navi14_ip_offset.h:172:29: warning: ‘UMC_BASE’ defined but not used [-Wunused-const-variable=]
 172 | static const struct IP_BASE UMC_BASE ={ { { { 0x00014000, 0x02425800, 0, 0, 0 } },
 | ^~~~~~~~
 drivers/gpu/drm/amd/amdgpu/../include/navi14_ip_offset.h:151:29: warning: ‘SDMA_BASE’ defined but not used [-Wunused-const-variable=]
 151 | static const struct IP_BASE SDMA_BASE ={ { { { 0x00001260, 0x0000A000, 0x02402C00, 0, 0 } },
 | ^~~~~~~~~
 drivers/gpu/drm/amd/amdgpu/../include/navi14_ip_offset.h:144:29: warning: ‘PCIE0_BASE’ defined but not used [-Wunused-const-variable=]
 144 | static const struct IP_BASE PCIE0_BASE ={ { { { 0x00000000, 0x00000014, 0x00000D20, 0x00010400, 0x0241B000 } },
 | ^~~~~~~~~~

NB: Snipped for brevity

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../gpu/drm/amd/include/vega10_ip_offset.h    | 76 +++++++++----------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/vega10_ip_offset.h b/drivers/gpu/drm/amd/include/vega10_ip_offset.h
index 976dd2d565ba4..bb5463152f6b0 100644
--- a/drivers/gpu/drm/amd/include/vega10_ip_offset.h
+++ b/drivers/gpu/drm/amd/include/vega10_ip_offset.h
@@ -35,177 +35,177 @@ struct IP_BASE
 };
 
 
-static const struct IP_BASE NBIF_BASE			= { { { { 0x00000000, 0x00000014, 0x00000D20, 0x00010400, 0 } },
+static const struct IP_BASE __maybe_unused NBIF_BASE	= { { { { 0x00000000, 0x00000014, 0x00000D20, 0x00010400, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } } } };
-static const struct IP_BASE NBIO_BASE			= { { { { 0x00000000, 0x00000014, 0x00000D20, 0x00010400, 0 } },
+static const struct IP_BASE __maybe_unused NBIO_BASE	= { { { { 0x00000000, 0x00000014, 0x00000D20, 0x00010400, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } } } };
-static const struct IP_BASE DCE_BASE			= { { { { 0x00000012, 0x000000C0, 0x000034C0, 0, 0 } },
+static const struct IP_BASE __maybe_unused DCE_BASE	= { { { { 0x00000012, 0x000000C0, 0x000034C0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } } } };
-static const struct IP_BASE DCN_BASE			= { { { { 0x00000012, 0x000000C0, 0x000034C0, 0, 0 } },
+static const struct IP_BASE __maybe_unused DCN_BASE	= { { { { 0x00000012, 0x000000C0, 0x000034C0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } } } };
-static const struct IP_BASE MP0_BASE			= { { { { 0x00016000, 0, 0, 0, 0 } },
+static const struct IP_BASE __maybe_unused MP0_BASE	= { { { { 0x00016000, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } } } };
-static const struct IP_BASE MP1_BASE			= { { { { 0x00016000, 0, 0, 0, 0 } },
+static const struct IP_BASE __maybe_unused MP1_BASE	= { { { { 0x00016000, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } } } };
-static const struct IP_BASE MP2_BASE			= { { { { 0x00016000, 0, 0, 0, 0 } },
+static const struct IP_BASE __maybe_unused MP2_BASE	= { { { { 0x00016000, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } } } };
-static const struct IP_BASE DF_BASE			= { { { { 0x00007000, 0, 0, 0, 0 } },
+static const struct IP_BASE __maybe_unused DF_BASE	= { { { { 0x00007000, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } } } };
-static const struct IP_BASE UVD_BASE			= { { { { 0x00007800, 0x00007E00, 0, 0, 0 } },
+static const struct IP_BASE __maybe_unused UVD_BASE	= { { { { 0x00007800, 0x00007E00, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } } } };  //note: GLN does not use the first segment
-static const struct IP_BASE VCN_BASE			= { { { { 0x00007800, 0x00007E00, 0, 0, 0 } },
+static const struct IP_BASE __maybe_unused VCN_BASE	= { { { { 0x00007800, 0x00007E00, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } } } };  //note: GLN does not use the first segment
-static const struct IP_BASE DBGU_BASE			= { { { { 0x00000180, 0x000001A0, 0, 0, 0 } },
+static const struct IP_BASE __maybe_unused DBGU_BASE	= { { { { 0x00000180, 0x000001A0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } } } }; // not exist
-static const struct IP_BASE DBGU_NBIO_BASE		= { { { { 0x000001C0, 0, 0, 0, 0 } },
+static const struct IP_BASE __maybe_unused DBGU_NBIO_BASE	= { { { { 0x000001C0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } } } }; // not exist
-static const struct IP_BASE DBGU_IO_BASE		= { { { { 0x000001E0, 0, 0, 0, 0 } },
+static const struct IP_BASE __maybe_unused DBGU_IO_BASE	= { { { { 0x000001E0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } } } }; // not exist
-static const struct IP_BASE DFX_DAP_BASE		= { { { { 0x000005A0, 0, 0, 0, 0 } },
+static const struct IP_BASE __maybe_unused DFX_DAP_BASE	= { { { { 0x000005A0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } } } }; // not exist
-static const struct IP_BASE DFX_BASE			= { { { { 0x00000580, 0, 0, 0, 0 } },
+static const struct IP_BASE __maybe_unused DFX_BASE	= { { { { 0x00000580, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } } } }; // this file does not contain registers
-static const struct IP_BASE ISP_BASE			= { { { { 0x00018000, 0, 0, 0, 0 } },
+static const struct IP_BASE __maybe_unused ISP_BASE	= { { { { 0x00018000, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } } } }; // not exist
-static const struct IP_BASE SYSTEMHUB_BASE		= { { { { 0x00000EA0, 0, 0, 0, 0 } },
+static const struct IP_BASE __maybe_unused SYSTEMHUB_BASE	= { { { { 0x00000EA0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } } } }; // not exist
-static const struct IP_BASE L2IMU_BASE			= { { { { 0x00007DC0, 0, 0, 0, 0 } },
+static const struct IP_BASE __maybe_unused L2IMU_BASE	= { { { { 0x00007DC0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } } } };
-static const struct IP_BASE IOHC_BASE			= { { { { 0x00010000, 0, 0, 0, 0 } },
+static const struct IP_BASE __maybe_unused IOHC_BASE	= { { { { 0x00010000, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } } } };
-static const struct IP_BASE ATHUB_BASE			= { { { { 0x00000C20, 0, 0, 0, 0 } },
+static const struct IP_BASE __maybe_unused ATHUB_BASE	= { { { { 0x00000C20, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } } } };
-static const struct IP_BASE VCE_BASE			= { { { { 0x00007E00, 0x00048800, 0, 0, 0 } },
+static const struct IP_BASE __maybe_unused VCE_BASE	= { { { { 0x00007E00, 0x00048800, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } } } };
-static const struct IP_BASE GC_BASE			= { { { { 0x00002000, 0x0000A000, 0, 0, 0 } },
+static const struct IP_BASE __maybe_unused GC_BASE	= { { { { 0x00002000, 0x0000A000, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } } } };
-static const struct IP_BASE MMHUB_BASE			= { { { { 0x0001A000, 0, 0, 0, 0 } },
+static const struct IP_BASE __maybe_unused MMHUB_BASE	= { { { { 0x0001A000, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } } } };
-static const struct IP_BASE RSMU_BASE			= { { { { 0x00012000, 0, 0, 0, 0 } },
+static const struct IP_BASE __maybe_unused RSMU_BASE	= { { { { 0x00012000, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } } } };
-static const struct IP_BASE HDP_BASE			= { { { { 0x00000F20, 0, 0, 0, 0 } },
+static const struct IP_BASE __maybe_unused HDP_BASE	= { { { { 0x00000F20, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } } } };
-static const struct IP_BASE OSSSYS_BASE		= { { { { 0x000010A0, 0, 0, 0, 0 } },
+static const struct IP_BASE __maybe_unused OSSSYS_BASE	 = { { { { 0x000010A0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } } } };
-static const struct IP_BASE SDMA0_BASE			= { { { { 0x00001260, 0, 0, 0, 0 } },
+static const struct IP_BASE __maybe_unused SDMA0_BASE	= { { { { 0x00001260, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } } } };
-static const struct IP_BASE SDMA1_BASE			= { { { { 0x00001460, 0, 0, 0, 0 } },
+static const struct IP_BASE __maybe_unused SDMA1_BASE	= { { { { 0x00001460, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } } } };
-static const struct IP_BASE XDMA_BASE			= { { { { 0x00003400, 0, 0, 0, 0 } },
+static const struct IP_BASE __maybe_unused XDMA_BASE	= { { { { 0x00003400, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } } } };
-static const struct IP_BASE UMC_BASE			= { { { { 0x00014000, 0, 0, 0, 0 } },
+static const struct IP_BASE __maybe_unused UMC_BASE	= { { { { 0x00014000, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } } } };
-static const struct IP_BASE THM_BASE			= { { { { 0x00016600, 0, 0, 0, 0 } },
+static const struct IP_BASE __maybe_unused THM_BASE	= { { { { 0x00016600, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } } } };
-static const struct IP_BASE SMUIO_BASE			= { { { { 0x00016800, 0, 0, 0, 0 } },
+static const struct IP_BASE __maybe_unused SMUIO_BASE	= { { { { 0x00016800, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } } } };
-static const struct IP_BASE PWR_BASE			= { { { { 0x00016A00, 0, 0, 0, 0 } },
+static const struct IP_BASE __maybe_unused PWR_BASE	= { { { { 0x00016A00, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } } } };
-static const struct IP_BASE CLK_BASE			= { { { { 0x00016C00, 0, 0, 0, 0 } },
-									    { { 0x00016E00, 0, 0, 0, 0 } },
+static const struct IP_BASE __maybe_unused CLK_BASE	= { { { { 0x00016C00, 0, 0, 0, 0 } },
+										{ { 0x00016E00, 0, 0, 0, 0 } },
 										{ { 0x00017000, 0, 0, 0, 0 } },
-	                                    { { 0x00017200, 0, 0, 0, 0 } },
-						                { { 0x00017E00, 0, 0, 0, 0 } } } };
-static const struct IP_BASE FUSE_BASE			= { { { { 0x00017400, 0, 0, 0, 0 } },
+										{ { 0x00017200, 0, 0, 0, 0 } },
+						                		{ { 0x00017E00, 0, 0, 0, 0 } } } };
+static const struct IP_BASE __maybe_unused FUSE_BASE	= { { { { 0x00017400, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
 										{ { 0, 0, 0, 0, 0 } },
-- 
2.25.1

