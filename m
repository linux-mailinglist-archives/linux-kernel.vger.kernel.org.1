Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41100292B89
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 18:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730367AbgJSQbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 12:31:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51629 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729916AbgJSQbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 12:31:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603125092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=LpnhnrtYzrTCJy3i8KObDi/AapzpryDouhoDtyAluxc=;
        b=ROXt/3NnCVGFYtNgYTdb/u36Qq3QA3qR3RHmWTue4v2NEtK0c8aQaGCJvojTreMGLztZK/
        UI/AyCQvoiSqVMuwDdaZfd/eXnuK0g5Vj8yzr8EnPOLOGXWXZBk2AJWy13giHhGvgfjRno
        sz4olT20SLD8R1UXddw5W9tKlC+mfsE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-fLLiBh7EMd---C0-ZY-S8A-1; Mon, 19 Oct 2020 12:31:27 -0400
X-MC-Unique: fLLiBh7EMd---C0-ZY-S8A-1
Received: by mail-qt1-f198.google.com with SMTP id e19so295274qtq.17
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 09:31:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LpnhnrtYzrTCJy3i8KObDi/AapzpryDouhoDtyAluxc=;
        b=bz5Ubvn+OJrKjsiTahHK+QXjXvQCT1V0j/crfmX6fhR8cRLByvrwNB8YEesBy1mCsU
         4rBBe/XMM0bLpZaTB4LF7LNOXBIpbQdxoOywqkwThOxO3A3pwJAu3lAsdDmkVbrhKqhq
         Y5D9luQvr7ivqtIHF0/lJIQRFBe0r5XBRDTWBZe6Qdvgz+eq8s5mVVhzTBvJnWqcfQgG
         iVTaDJiI0TsdpfxmfSnE20hF5PHBCDuE/1gQI6NXqXjYvlnys0PA14rB3naxEJuXnEUM
         b/bs3aTFf/6GeED/4+fmtfIqyTnjAQwqP4j4UQhIUtMrR6bjTVMQP2yd4OWMj3nHzdLV
         Vt7Q==
X-Gm-Message-State: AOAM532FLt54QFECOkxOSvCh7KFpwarrxbk78ttOS17P0Xy+5L+qaH6z
        WyiU9WVSl5x7Cgshzk80ZizozyT5T7YzwwTUqrRw651ZOU5Uo+OmHwkZlLd2luxjv2IoclCrwpe
        GolFaEoqj3oYqZe2zCYUCCYfB
X-Received: by 2002:a37:dc45:: with SMTP id v66mr436798qki.38.1603125085984;
        Mon, 19 Oct 2020 09:31:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyDaqr3WO9m6PHgyGJrH9ZpAecy65bRCQBDG9pExuCA3UA+eaazh0XFo1qMoM9NaIFuQxjMug==
X-Received: by 2002:a37:dc45:: with SMTP id v66mr436599qki.38.1603125081657;
        Mon, 19 Oct 2020 09:31:21 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id x5sm214149qkf.44.2020.10.19.09.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 09:31:20 -0700 (PDT)
From:   trix@redhat.com
To:     airlied@redhat.com, tzimmermann@suse.de, airlied@linux.ie,
        daniel@ffwll.ch, bskeggs@redhat.com, kraxel@redhat.com,
        gustavoars@kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        nouveau@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        spice-devel@lists.freedesktop.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm: remove unneeded break
Date:   Mon, 19 Oct 2020 09:31:15 -0700
Message-Id: <20201019163115.25814-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A break is not needed if it is preceded by a return or break

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/mgag200/mgag200_mode.c           | 5 -----
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/pll.c   | 1 -
 drivers/gpu/drm/nouveau/nvkm/subdev/clk/mcp77.c  | 3 ---
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv50.c | 1 -
 drivers/gpu/drm/nouveau/nvkm/subdev/top/gk104.c  | 1 -
 drivers/gpu/drm/qxl/qxl_ioctl.c                  | 1 -
 6 files changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/mgag200/mgag200_mode.c b/drivers/gpu/drm/mgag200/mgag200_mode.c
index 38672f9e5c4f..bbe4e60dfd08 100644
--- a/drivers/gpu/drm/mgag200/mgag200_mode.c
+++ b/drivers/gpu/drm/mgag200/mgag200_mode.c
@@ -794,21 +794,16 @@ static int mgag200_crtc_set_plls(struct mga_device *mdev, long clock)
 	case G200_SE_A:
 	case G200_SE_B:
 		return mga_g200se_set_plls(mdev, clock);
-		break;
 	case G200_WB:
 	case G200_EW3:
 		return mga_g200wb_set_plls(mdev, clock);
-		break;
 	case G200_EV:
 		return mga_g200ev_set_plls(mdev, clock);
-		break;
 	case G200_EH:
 	case G200_EH3:
 		return mga_g200eh_set_plls(mdev, clock);
-		break;
 	case G200_ER:
 		return mga_g200er_set_plls(mdev, clock);
-		break;
 	}
 
 	misc = RREG8(MGA_MISC_IN);
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/pll.c b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/pll.c
index 350f10a3de37..2ec84b8a3b3a 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/pll.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/pll.c
@@ -123,7 +123,6 @@ pll_map(struct nvkm_bios *bios)
 	case NV_20:
 	case NV_30:
 		return nv04_pll_mapping;
-		break;
 	case NV_40:
 		return nv40_pll_mapping;
 	case NV_50:
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/mcp77.c b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/mcp77.c
index efa50274df97..4884eb4a9221 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/mcp77.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/mcp77.c
@@ -140,17 +140,14 @@ mcp77_clk_read(struct nvkm_clk *base, enum nv_clk_src src)
 		break;
 	case nv_clk_src_mem:
 		return 0;
-		break;
 	case nv_clk_src_vdec:
 		P = (read_div(clk) & 0x00000700) >> 8;
 
 		switch (mast & 0x00400000) {
 		case 0x00400000:
 			return nvkm_clk_read(&clk->base, nv_clk_src_core) >> P;
-			break;
 		default:
 			return 500000 >> P;
-			break;
 		}
 		break;
 	default:
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv50.c b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv50.c
index 2ccb4b6be153..7b1eb44ff3da 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv50.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv50.c
@@ -171,7 +171,6 @@ nv50_ram_timing_read(struct nv50_ram *ram, u32 *timing)
 		break;
 	default:
 		return -ENOSYS;
-		break;
 	}
 
 	T(WR) = ((timing[1] >> 24) & 0xff) - 1 - T(CWL);
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/top/gk104.c b/drivers/gpu/drm/nouveau/nvkm/subdev/top/gk104.c
index e01746ce9fc4..1156634533f9 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/top/gk104.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/top/gk104.c
@@ -90,7 +90,6 @@ gk104_top_oneinit(struct nvkm_top *top)
 		case 0x00000010: B_(NVDEC ); break;
 		case 0x00000013: B_(CE    ); break;
 		case 0x00000014: C_(GSP   ); break;
-			break;
 		default:
 			break;
 		}
diff --git a/drivers/gpu/drm/qxl/qxl_ioctl.c b/drivers/gpu/drm/qxl/qxl_ioctl.c
index 5cea6eea72ab..2072ddc9549c 100644
--- a/drivers/gpu/drm/qxl/qxl_ioctl.c
+++ b/drivers/gpu/drm/qxl/qxl_ioctl.c
@@ -160,7 +160,6 @@ static int qxl_process_single_command(struct qxl_device *qdev,
 	default:
 		DRM_DEBUG("Only draw commands in execbuffers\n");
 		return -EINVAL;
-		break;
 	}
 
 	if (cmd->command_size > PAGE_SIZE - sizeof(union qxl_release_info))
-- 
2.18.1

