Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5EE02929AA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 16:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729676AbgJSOnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 10:43:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27765 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728311AbgJSOnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 10:43:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603118602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=HS9j6NFClw0xbf6pUYexyg09LSF+fCEmAaVviysMnkA=;
        b=TaE6ksg86rpg5iH+qAkOv23k15+o21kd7RNg7np8fdlO4vuuy8AwJD+ZCoVazW1UtVRGRf
        QVxgddQhiMm8Ra2OVT8rYVRLIha6sMVvCmdYFkAgz/9/oDqAJdyD6L2a3cFgla1M/ja2QT
        fqWB0/WTlhnNHh1N6wVLCesq908wezY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-zzNzyYeCMQ6kMD_4W0AQmA-1; Mon, 19 Oct 2020 10:43:19 -0400
X-MC-Unique: zzNzyYeCMQ6kMD_4W0AQmA-1
Received: by mail-qk1-f200.google.com with SMTP id j185so7361893qkf.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 07:43:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HS9j6NFClw0xbf6pUYexyg09LSF+fCEmAaVviysMnkA=;
        b=J7Fejcu4APVcr1E2FXfprzdVzYhiSfrb15pZSjg268tI3Ua7nJNupZOZrbn2X/PAGc
         UZK80ad+8s+3xM/pjcxIyIL6+MRitQsKferL3bC2cfvVKI1VmzDg1ibQSAKwaD9wXj6z
         90PTS5yUAXd0XH1Ovd7ZQwegCaSZavgG912rsyxxidmJzFr7Fm4rl7HHVw4uor1C+cgF
         HRFpqS9wDCvA1Wj+KAhXpNUe3knioB/A0aRB1OOwayAa9CKZTxf2pdV+JLd9CZsOx4si
         IcrNioFYdmqilcEOsFQqdiKk5LSUuHZ60A/Hwr8MjjTfR9IIQt0p1342x4sm0lPxrWfM
         3NQg==
X-Gm-Message-State: AOAM532hFbq170q9ASBeMpsKDDaPlGQYdQWITaeKEvYpQ/uYwSn5wVNN
        bwpmmGGsPnDLOmCLSaZzjykSUSZw5qSC8VPVH1XUIws5oRVQ/ZriYJVo6oUOHkfhTPgrT+cHrbp
        C4CZJMu2jIXHADudroyvg3zx3
X-Received: by 2002:ac8:937:: with SMTP id t52mr15592697qth.268.1603118598556;
        Mon, 19 Oct 2020 07:43:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzAjzy0z6rzYX/CmMgw+uXDi5Q1r8M21MiqKjUC0Nu0rYOLfUvcBlanK5Bdn1pFWCESWLn7oQ==
X-Received: by 2002:ac8:937:: with SMTP id t52mr15592664qth.268.1603118598290;
        Mon, 19 Oct 2020 07:43:18 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id j8sm107460qke.38.2020.10.19.07.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 07:43:17 -0700 (PDT)
From:   trix@redhat.com
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@linux.ie, daniel@ffwll.ch, issor.oruam@gmail.com,
        Anthony.Koo@amd.com, Rodrigo.Siqueira@amd.com, Tony.Cheng@amd.com,
        Charlene.Liu@amd.com, yogesh.mohanmarimuthu@amd.com,
        Aric.Cyr@amd.com, Igor.Kravchenko@amd.com,
        colin.king@canonical.com, tao.zhou1@amd.com, Dennis.Li@amd.com,
        mario.kleiner.de@gmail.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/amdgpu: remove unneeded break
Date:   Mon, 19 Oct 2020 07:43:11 -0700
Message-Id: <20201019144311.18260-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A break is not needed if it is preceded by a return or break

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_transform.c      | 1 -
 drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c | 7 -------
 drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c | 7 -------
 drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c | 7 -------
 drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c | 7 -------
 drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c   | 7 -------
 drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c   | 7 -------
 7 files changed, 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
index 2a32b66959ba..130a0a0c8332 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
@@ -1330,7 +1330,6 @@ static bool configure_graphics_mode(
 			REG_SET(OUTPUT_CSC_CONTROL, 0,
 				OUTPUT_CSC_GRPH_MODE, 0);
 			break;
-			break;
 		case COLOR_SPACE_SRGB_LIMITED:
 			/* TV RGB */
 			REG_SET(OUTPUT_CSC_CONTROL, 0,
diff --git a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c b/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
index d741787f75dc..42c7d157da32 100644
--- a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
@@ -418,25 +418,18 @@ static int map_transmitter_id_to_phy_instance(
 	switch (transmitter) {
 	case TRANSMITTER_UNIPHY_A:
 		return 0;
-	break;
 	case TRANSMITTER_UNIPHY_B:
 		return 1;
-	break;
 	case TRANSMITTER_UNIPHY_C:
 		return 2;
-	break;
 	case TRANSMITTER_UNIPHY_D:
 		return 3;
-	break;
 	case TRANSMITTER_UNIPHY_E:
 		return 4;
-	break;
 	case TRANSMITTER_UNIPHY_F:
 		return 5;
-	break;
 	case TRANSMITTER_UNIPHY_G:
 		return 6;
-	break;
 	default:
 		ASSERT(0);
 		return 0;
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
index 2bbfa2e176a9..382581c4a674 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
@@ -471,25 +471,18 @@ static int map_transmitter_id_to_phy_instance(
 	switch (transmitter) {
 	case TRANSMITTER_UNIPHY_A:
 		return 0;
-	break;
 	case TRANSMITTER_UNIPHY_B:
 		return 1;
-	break;
 	case TRANSMITTER_UNIPHY_C:
 		return 2;
-	break;
 	case TRANSMITTER_UNIPHY_D:
 		return 3;
-	break;
 	case TRANSMITTER_UNIPHY_E:
 		return 4;
-	break;
 	case TRANSMITTER_UNIPHY_F:
 		return 5;
-	break;
 	case TRANSMITTER_UNIPHY_G:
 		return 6;
-	break;
 	default:
 		ASSERT(0);
 		return 0;
diff --git a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
index b622b4b1dac3..7b4b2304bbff 100644
--- a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
@@ -446,25 +446,18 @@ static int map_transmitter_id_to_phy_instance(
 	switch (transmitter) {
 	case TRANSMITTER_UNIPHY_A:
 		return 0;
-	break;
 	case TRANSMITTER_UNIPHY_B:
 		return 1;
-	break;
 	case TRANSMITTER_UNIPHY_C:
 		return 2;
-	break;
 	case TRANSMITTER_UNIPHY_D:
 		return 3;
-	break;
 	case TRANSMITTER_UNIPHY_E:
 		return 4;
-	break;
 	case TRANSMITTER_UNIPHY_F:
 		return 5;
-	break;
 	case TRANSMITTER_UNIPHY_G:
 		return 6;
-	break;
 	default:
 		ASSERT(0);
 		return 0;
diff --git a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
index 16fe7344702f..3d782b7c86cb 100644
--- a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
@@ -383,25 +383,18 @@ static int map_transmitter_id_to_phy_instance(
 	switch (transmitter) {
 	case TRANSMITTER_UNIPHY_A:
 		return 0;
-	break;
 	case TRANSMITTER_UNIPHY_B:
 		return 1;
-	break;
 	case TRANSMITTER_UNIPHY_C:
 		return 2;
-	break;
 	case TRANSMITTER_UNIPHY_D:
 		return 3;
-	break;
 	case TRANSMITTER_UNIPHY_E:
 		return 4;
-	break;
 	case TRANSMITTER_UNIPHY_F:
 		return 5;
-	break;
 	case TRANSMITTER_UNIPHY_G:
 		return 6;
-	break;
 	default:
 		ASSERT(0);
 		return 0;
diff --git a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
index 5a5a9cb77acb..e9dd78c484d6 100644
--- a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
@@ -453,25 +453,18 @@ static int map_transmitter_id_to_phy_instance(
 	switch (transmitter) {
 	case TRANSMITTER_UNIPHY_A:
 		return 0;
-	break;
 	case TRANSMITTER_UNIPHY_B:
 		return 1;
-	break;
 	case TRANSMITTER_UNIPHY_C:
 		return 2;
-	break;
 	case TRANSMITTER_UNIPHY_D:
 		return 3;
-	break;
 	case TRANSMITTER_UNIPHY_E:
 		return 4;
-	break;
 	case TRANSMITTER_UNIPHY_F:
 		return 5;
-	break;
 	case TRANSMITTER_UNIPHY_G:
 		return 6;
-	break;
 	default:
 		ASSERT(0);
 		return 0;
diff --git a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
index 0eae8cd35f9a..9dbf658162cd 100644
--- a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
@@ -458,25 +458,18 @@ static int map_transmitter_id_to_phy_instance(
 	switch (transmitter) {
 	case TRANSMITTER_UNIPHY_A:
 		return 0;
-	break;
 	case TRANSMITTER_UNIPHY_B:
 		return 1;
-	break;
 	case TRANSMITTER_UNIPHY_C:
 		return 2;
-	break;
 	case TRANSMITTER_UNIPHY_D:
 		return 3;
-	break;
 	case TRANSMITTER_UNIPHY_E:
 		return 4;
-	break;
 	case TRANSMITTER_UNIPHY_F:
 		return 5;
-	break;
 	case TRANSMITTER_UNIPHY_G:
 		return 6;
-	break;
 	default:
 		ASSERT(0);
 		return 0;
-- 
2.18.1

