Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 817292E8B31
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 07:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbhACGkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 01:40:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbhACGkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 01:40:01 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED94C061573
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jan 2021 22:39:21 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id w1so4224465pjc.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jan 2021 22:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8Y92qT875d3aESyjMGQPzSpXc2nldV50acl7AIHo37A=;
        b=aJfunVgtA594mdIlnY6+iNnEoN8EeUnwfZM2aPkYdnvOHH3TsUErBI7Jz/aEHkeKAg
         YDO24SvnsuqBYzWNWs/o4U1ECjAbxvGMehUJtorDvy66YtT6dn/1QpCHDIm7dYQyl0Gm
         kAFEWoKiLQQ33guOh+kaEgieAX3+hQtAlDZVVuGnxYueMxr5VYFOKMM8LKbOlkzvc4PT
         bTzVtJWh7+ZLEyR7HS2thgQPNaZzEV/FlqfNRV1dikf53koxYtgnx4kXyDObxjdQJM2N
         SDhi8evkkV/JdmzVSig6oB6Hk45tNP7VNaD5ac4/MEXgPOdNat+tMpNRHWzPrdJrQgws
         eePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8Y92qT875d3aESyjMGQPzSpXc2nldV50acl7AIHo37A=;
        b=DjWXXuoBFkjb2trEgw7ZfsSgCWeY3G1HZ4oZ7kywRbsivvF26dlUxq3MmX8W2WdlBn
         cjE+CtTMt0dHkMUvDdtIH0ksCMebu3q8sR3xdmsDpumIbyxwEUprkoznbs/QkfgbjJrV
         rZdMOf96oc6gLeiU1mGJB2sNbybhnQQakVSmSvViNsCePR7pIimLZc6XSQEDHKEfdV3Y
         3kYV+6n0ayKm/UB8KNFhBgTwGbFVgGp3WYFvxkNBNEpwv4qLYTs9RbfXlzku4DuIXrE9
         pu4edeRbCDeUH8A5wHUhg5sdLmj3YSQf2Obh/xTSU2S1DKQujW6iDxUE2utJmC3gyRFK
         oP/A==
X-Gm-Message-State: AOAM533k/+o6oHuLSw8NNG3sPrRJo49ZcHIA3+/Q4W4dxuMnXTpRA3uR
        1dTg757kldvr9p/nJC9PtF47RZwbllI=
X-Google-Smtp-Source: ABdhPJzeGlVBHkODqjkK4saYepzEvXvy7uhk/R/nKknl9QnM1AvPAV/LHqngdTo1FSJyLwE8Wz/Stg==
X-Received: by 2002:a17:902:7086:b029:dc:8d:feab with SMTP id z6-20020a1709027086b02900dc008dfeabmr67602599plk.22.1609655960535;
        Sat, 02 Jan 2021 22:39:20 -0800 (PST)
Received: from localhost.localdomain (61-230-37-4.dynamic-ip.hinet.net. [61.230.37.4])
        by smtp.gmail.com with ESMTPSA id 73sm45465993pga.26.2021.01.02.22.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jan 2021 22:39:19 -0800 (PST)
From:   Lecopzer Chen <lecopzer@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com
Cc:     dan.j.williams@intel.com, aryabinin@virtuozzo.com,
        glider@google.com, dvyukov@google.com, akpm@linux-foundation.org,
        linux-mediatek@lists.infradead.org, yj.chiang@mediatek.com,
        Lecopzer Chen <lecopzer@gmail.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>
Subject: [PATCH] kasan: fix incorrect arguments passing in kasan_add_zero_shadow
Date:   Sun,  3 Jan 2021 14:38:47 +0800
Message-Id: <20210103063847.5963-1-lecopzer@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kasan_remove_zero_shadow() shall use original virtual address, start
and size, instead of shadow address.

Fixes: 0207df4fa1a86 ("kernel/memremap, kasan: make ZONE_DEVICE with work with KASAN")
Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
---
 mm/kasan/init.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/kasan/init.c b/mm/kasan/init.c
index bc0ad208b3a7..67051cfae41c 100644
--- a/mm/kasan/init.c
+++ b/mm/kasan/init.c
@@ -481,7 +481,6 @@ int kasan_add_zero_shadow(void *start, unsigned long size)
 
 	ret = kasan_populate_early_shadow(shadow_start, shadow_end);
 	if (ret)
-		kasan_remove_zero_shadow(shadow_start,
-					size >> KASAN_SHADOW_SCALE_SHIFT);
+		kasan_remove_zero_shadow(start, size);
 	return ret;
 }
-- 
2.25.1

