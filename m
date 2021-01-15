Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68AA32F83C3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388042AbhAOSPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:15:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728176AbhAOSO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:14:56 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E26DC0617BE
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:14:06 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id a9so6748494wrt.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H7kqjYWcwKGFjqciQAFyPifJs/CUQ6UusnBVQQ2LEnA=;
        b=t8+Z985NiQCY1D2zCsot42xG+heah2+ELntWWsNu+kvRMZrmlPFjA3v7RNx9mNzsCx
         b5cOetQ27f2+guT1vjTkoArcvLofqdC/MEegEdNu/UgYngo4vnnSj2WP3ia83B6v2Kak
         bCNp/Wh8cbGI9GRGzsJ+GUeWUgIl8gRoxkOltUr9gaoeAhAY072+Fd8mB+OY/7JWahJr
         jlF8/C6crPHmhJSJIXGyErUptJSdMmu5vIta/Tpown103vkIfV/3YFKoLh24N7FN0AS7
         aOFsxPShtl3VSluamHIZ9cYl+lcSKMEwV9w87zjtWc1Di5stNLjRZTF9G5JO9YtUzhfb
         xPRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H7kqjYWcwKGFjqciQAFyPifJs/CUQ6UusnBVQQ2LEnA=;
        b=rADvRg3IKGhEkibLhe9MiqLhcymTwjMuH0L4W25kulXaBoVOZ1rj1+xuil96+pIDJB
         nIn5o/u0uOFwaA1aBTUwfpBCFy6iQ+Tp2WTwkqk09HcQhttFrXPWWlt83wwU6YCDRCXw
         XdX297aqidC7nnYUmuwVPjgD3wmf9j1qidMMIXz8Y3fWvws5cO/QZ/PwYziBQNWrGxtd
         EjJ6AOVyc7ysXiyq3emrHifN/kjmREHcYbiPAJxXt8kmu/dR9WaibTxTsMLkrmtbf8ul
         Rkt4zp9oxVPVDAnA2huI+CSJIVPgca4SSxBxQRph+vjO3gQuvIGkdswg10eYhs78T2MM
         Gpww==
X-Gm-Message-State: AOAM531+Zj+HrsERYHQJiIVGt+meeUaoLQ5lLn1M6gquaEa+w3gOIUJa
        n6+nwI5eQ2NjAUojDEh38yuvxQ==
X-Google-Smtp-Source: ABdhPJzlqzn/CqhwXTx8+dBCcy5NljeBmibdEvqIGWxowfd/wAnWSzYrCIXXS92X76e/88dLB2k35w==
X-Received: by 2002:adf:c444:: with SMTP id a4mr10948115wrg.164.1610734444892;
        Fri, 15 Jan 2021 10:14:04 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id j2sm16123484wrh.78.2021.01.15.10.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 10:14:04 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 32/40] drm/gma500/gem: Include our own header containing prototypes
Date:   Fri, 15 Jan 2021 18:13:05 +0000
Message-Id: <20210115181313.3431493-33-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115181313.3431493-1-lee.jones@linaro.org>
References: <20210115181313.3431493-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/gma500/gem.c:59:5: warning: no previous prototype for ‘psb_gem_create’ [-Wmissing-prototypes]

Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/gma500/gem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/gma500/gem.c b/drivers/gpu/drm/gma500/gem.c
index 5ef5480f999e9..fbf420051ef5f 100644
--- a/drivers/gpu/drm/gma500/gem.c
+++ b/drivers/gpu/drm/gma500/gem.c
@@ -16,6 +16,7 @@
 #include <drm/drm.h>
 #include <drm/drm_vma_manager.h>
 
+#include "gem.h"
 #include "psb_drv.h"
 
 static vm_fault_t psb_gem_fault(struct vm_fault *vmf);
-- 
2.25.1

