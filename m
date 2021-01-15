Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 196CB2F83FD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388196AbhAOSTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:19:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388358AbhAOSR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:17:27 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14487C06179B
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:16:16 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id 6so2911319wri.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GmnTQYGZFT8V4aHtRElOATkEuVPQEpEkCVYessHQgb4=;
        b=ao9i4vgDHHQIUekQ87MHFQREuE2D0YpI1oA3cL0opjewp4Err83XY74KoQW+PUQcRb
         5/OpZ0hdYs3gjXlaP4yjSWRMs8fpNjQkP5N5s+0qHuSdnNtrQNkslDD5dTRBpdk81T82
         4WPof4xIye7KPIpjykKw+as/Cvbr9v1Rl35atrE3W11DRTGEVwpo/EwHgUrj5ekuqI7L
         UUn7enAqQxpHwWjStPF8uo8DaTyvkZ9pdHdvzPePM1Q8OkvY0mpwg96l4+z6Iw6+1tC0
         bxLNZbk/UNcrrkbxvO9Xtzv6XjYJ/EbZQr8gLmniTqceS+jGGfITIBLFZYamuuJSqY2e
         Qc5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GmnTQYGZFT8V4aHtRElOATkEuVPQEpEkCVYessHQgb4=;
        b=VZ2gFM1s2oqBiW55bJLdRH6lV9nUAWhjwxWgOjLtfmMoeVhyQYdS8l+0EV8VyTqYCv
         VG3bUUjEkXR9kefbPmmBXj6suChZ2YKCq9rfiPH8GvF4dU2H9tYqdWDNMvN/0fs3pbFe
         ctBK5RtlvcpolC9XV4W9U4A1zN78FFP3nShB9D6fUNUxlC5N1flISmRmBkjUUHkQiYLz
         VdJTp5/gXKrU562Er0ZJHj6iUN/bBZD5bA2rUx+isHKSGLDxR7TSUdzYT9uhTYkvoGv4
         eBYeuPI0BkkHo/mloeC/Z6aD9SR0K0op/QvaL7SQb/l4D+e2NSQLau7B5yAADkiiB+dn
         DhLA==
X-Gm-Message-State: AOAM5338A3PbsYbOvBClyzObpnDJWePAUt56xw3hwKfqB8OHmfRGulrq
        mtHCCoSq9mEMqcVDkjO6L6SgBQ==
X-Google-Smtp-Source: ABdhPJym4/tW0/UVxoaeFRN8gzoR+0lDT/OQGytPzdRqN6VKamUOSS/5kWdr2iqHm14l/DYCyWCijA==
X-Received: by 2002:adf:92a4:: with SMTP id 33mr14241917wrn.347.1610734574855;
        Fri, 15 Jan 2021 10:16:14 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id b133sm14405979wme.33.2021.01.15.10.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 10:16:14 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 06/29] drm/gma500/mmu: Actually return an error if one occurs
Date:   Fri, 15 Jan 2021 18:15:38 +0000
Message-Id: <20210115181601.3432599-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115181601.3432599-1-lee.jones@linaro.org>
References: <20210115181601.3432599-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/gma500/mmu.c: In function ‘psb_mmu_insert_pfn_sequence’:
 drivers/gpu/drm/gma500/mmu.c:651:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]

Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/gma500/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/gma500/mmu.c b/drivers/gpu/drm/gma500/mmu.c
index 014daf0280485..13aff19aae9ba 100644
--- a/drivers/gpu/drm/gma500/mmu.c
+++ b/drivers/gpu/drm/gma500/mmu.c
@@ -681,7 +681,7 @@ int psb_mmu_insert_pfn_sequence(struct psb_mmu_pd *pd, uint32_t start_pfn,
 	if (pd->hw_context != -1)
 		psb_mmu_flush(pd->driver);
 
-	return 0;
+	return ret;
 }
 
 int psb_mmu_insert_pages(struct psb_mmu_pd *pd, struct page **pages,
-- 
2.25.1

