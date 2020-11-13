Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD7F22B28AC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 23:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgKMWkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 17:40:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbgKMWkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 17:40:12 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0B9C0613D1;
        Fri, 13 Nov 2020 14:40:11 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id p1so11828257wrf.12;
        Fri, 13 Nov 2020 14:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xKudFHJ7NTrvGxc8c99xpuNccdIUwDTSbaq60DduiFo=;
        b=N1ZBOw79eZcRy9yLNVufX01Tp2tRSMnkLMiOJczGcWdWGyQGKB98D4yoS68T2Cyalu
         C8/hp3slDiCr2I8BSf5TzV/unPaZKk2/bLY9DpZXVdmbEKFyPX7cLTPPqF0KvGAZI6MY
         RozxM5tXfirncUayHRoRS6RiVgtjCfcl5FUjH93zmoHwVkm8k2Gdf4QVLj1t0orGTSlh
         BcF3mX0LOuJIJOB/LhQR2OmjOnVSWcEgSuBcEVnrl7NrIp3b10P6UNkl3o7tawqeCEHt
         sxgAI6foPa2cXSX7wj8By5HaVy8w5HtRQh58nmSYqv4xQ8mOhZP4vw+dHsczyvH6p11Y
         ZdAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xKudFHJ7NTrvGxc8c99xpuNccdIUwDTSbaq60DduiFo=;
        b=FSgfLwMKPd/65cseq2U58CIReyq5mn6NoRtennaoukdxuDtnxDsdn0FS9qHAOUPCpW
         rv67ebtMDSNKkES0W2DcOUjgKZmjcl9NWAzt4iZyRb9+DuaZU3ahteH43EUhvYQHP005
         DYsAmTyvqZtg+0b0Pzilo3BldmFWTGtc911zOqBPlXI2CMhkiFX9RpcGoxancVUUuodV
         0DolhN6pwA7xFSGv2HIjHuhTsrdY0TQe5woCogCTIUFdFfk5pozh5+e3tyKGh3SgChDi
         GxxveVQpZnvZ34vG8ko7vfL435311Lt4SFFx4akFmkGOBs4midQ5i9dyt8e573nGueBw
         +WWg==
X-Gm-Message-State: AOAM5300gFLrZDo2rRp9buy9cvaRkM+MrF2LD/mfpsdwknALz3faj8L6
        AacFmQJ3TqOckTYMhLyeT3PIQHNh8fc=
X-Google-Smtp-Source: ABdhPJyoO9AB1J+eCna4qFKpfFnA1J/Ce5QK8vXg7CpeJi+5cmx4Wrj7eHP73keYeTu2R8TgdSI8uA==
X-Received: by 2002:a5d:690c:: with SMTP id t12mr6038033wru.405.1605307210115;
        Fri, 13 Nov 2020 14:40:10 -0800 (PST)
Received: from xws.fritz.box (pd9e5a945.dip0.t-ipconnect.de. [217.229.169.69])
        by smtp.gmail.com with ESMTPSA id f23sm11206558wmb.43.2020.11.13.14.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 14:40:09 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH] platform/surface: gpe: Add support for 15" Intel version of Surface Laptop 3
Date:   Fri, 13 Nov 2020 23:39:35 +0100
Message-Id: <20201113223935.2073847-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In addition to a 13" version, there is also a 15" (business) version of
the Surface Laptop 3 based on Intel CPUs. This version also handles
wakeup by lid via (unmarked) GPEs, so add support for it as well.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 drivers/platform/surface/surface_gpe.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/platform/surface/surface_gpe.c b/drivers/platform/surface/surface_gpe.c
index 0f44a52d3a9b..e49e5d6d5d4e 100644
--- a/drivers/platform/surface/surface_gpe.c
+++ b/drivers/platform/surface/surface_gpe.c
@@ -146,6 +146,18 @@ static const struct dmi_system_id dmi_lid_device_table[] = {
 		},
 		.driver_data = (void *)lid_device_props_l4D,
 	},
+	{
+		.ident = "Surface Laptop 3 (Intel 15\")",
+		.matches = {
+			/*
+			 * We match for SKU here due to different variants: The
+			 * AMD (15") version does not rely on GPEs.
+			 */
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "Surface_Laptop_3_1872"),
+		},
+		.driver_data = (void *)lid_device_props_l4D,
+	},
 	{ }
 };
 
-- 
2.29.2

