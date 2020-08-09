Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD3623FC98
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Aug 2020 06:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgHIEgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Aug 2020 00:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgHIEgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 00:36:10 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34AD3C061756
        for <linux-kernel@vger.kernel.org>; Sat,  8 Aug 2020 21:36:10 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id r11so3369649pfl.11
        for <linux-kernel@vger.kernel.org>; Sat, 08 Aug 2020 21:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P21tL7daBF3yjezrA/PL3bwhuuAyesA+HDqEdHI5eFU=;
        b=kJemo03+X3oJOjE2qhGI/wrF+x2Bq9Nuxd1UkRw82JP/J/1UnCgQPhfTA5DK2ghreM
         DEOYdYirxqKjEkhZ+1AdiFMgUyktbxHcmE/7fPHbx6eW1pkdy/DqqpRvl0gqVQtG3qfL
         xem9WVqBLZcVZ8qjGhr0hy7Vut7NmmaurZt1seGoXYLBEuyjx7th9ECe4pUgaE1D4Z5e
         a/d/rjoeiFdC7v27eGX0CH35ekQ02kYJr5DfVW8y9eusgCUHaUa3ITY3cPRKalhENr3x
         +NREy22FYA47eKSr4VFOLVzlNoT79jUnjLM6RLRkf8CzKJ3QKHG2a0oFBPOo6JfMQSHC
         ri5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P21tL7daBF3yjezrA/PL3bwhuuAyesA+HDqEdHI5eFU=;
        b=ZAvSj/e9iAJLQGXjRFE9jYtqcJpuvckxCsRLR5pG4DEdW0HEndIbyqsSWZTOTY/Aua
         dbzn4lGCG5iUMpZfSZhlVBJyEgZni4zlu8CF0JSFxg0jAwDFOMYS0YUUT7aLfR2qJ4TI
         7xihUvjijYEoIA748GokW7mARDEYqEd4lpb0/IOIcBTlWKSQORTa5OJvaFv0DKyngqAH
         q/YpPsiG6vyDP3ZAHK/ksH03t9my68/gwBUL2A+gXrXTonjA8OG/8mvxuI1mGAw8mHcx
         3ufFX9amJ7vWYhoCeugFk9YF7UESKoyDs1sfNLDC92exRABX5gxX4hLKK3b+kdiyhiBj
         Ac1Q==
X-Gm-Message-State: AOAM530YP/gp2uKREvckSEqncDGZZu508Eh9fqQYuX58FEmBfOPqfduX
        eyQtHabaJu3xnxURx6JtAsLXIA==
X-Google-Smtp-Source: ABdhPJyaQAVZfx7NE4LBNsDHpjcC+Y5iS7iQdOvy3wN6qrVmdEYeRBauSp4wkqNvWbki3tozGQn05g==
X-Received: by 2002:a05:6a00:22c9:: with SMTP id f9mr2728054pfj.212.1596947769639;
        Sat, 08 Aug 2020 21:36:09 -0700 (PDT)
Received: from FVFX41FWHV2J.bytedance.net ([103.136.220.69])
        by smtp.gmail.com with ESMTPSA id s2sm16267741pjb.33.2020.08.08.21.36.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Aug 2020 21:36:08 -0700 (PDT)
From:   Feng zhou <zhoufeng.zf@bytedance.com>
To:     bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rrichter@marvell.com
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        liuxian.1@bytedance.com, zhoufeng.zf@bytedance.com
Subject: [PATCH] x86/MCE/AMD, EDAC/mce_amd
Date:   Sun,  9 Aug 2020 12:35:59 +0800
Message-Id: <20200809043559.9740-1-zhoufeng.zf@bytedance.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhoufeng <zhoufeng.zf@bytedance.com>

The edac_mce_amd module calls decode_dram_ecc() on AMD Family17h and
later systems. This function is used in amd64_edac_mod to do
system-specific decoding for DRAM ECC errors. The function takes a
"NodeId" as a parameter.

In AMD documentation, NodeId is used to identify a physical die in a
system. This can be used to identify a node in the AMD_NB code and also
it is used with umc_normaddr_to_sysaddr().

However, the input used for decode_dram_ecc() is currently the NUMA node
of a logical CPU. so this will cause the address translation function to
fail or report incorrect results.

Signed-off-by: zhoufeng <zhoufeng.zf@bytedance.com>
---
 drivers/edac/mce_amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 325aedf46ff2..73c805113322 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -996,7 +996,7 @@ static void decode_smca_error(struct mce *m)
 	}
 
 	if (bank_type == SMCA_UMC && xec == 0 && decode_dram_ecc)
-		decode_dram_ecc(cpu_to_node(m->extcpu), m);
+		decode_dram_ecc(topology_physical_package_id(m->extcpu), m);
 }
 
 static inline void amd_decode_err_code(u16 ec)
-- 
2.20.1

