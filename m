Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20901278478
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 11:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbgIYJ4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 05:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727922AbgIYJ4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 05:56:09 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0B8C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 02:56:09 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id v12so2590758wmh.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 02:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LmvJmrZLHAQ+QV8FuMLW/yww8QDVxDh2p5wK5tqUR2w=;
        b=W6rYHVotm7k2M3robtD8w+SzOwwK/f3A1ELMVHL2yjUsnEpDQPrvhkfdZJVTPYzqwF
         DCOFd+BGl4I6bzrLO81vRPAfCVtfK7ov2CtphyAhp5QxLuaG7x+XervZtreZmxU4IRfc
         aNq96Hbu2zwEMp05826GQAPxzyVVydJzxgDMUQ0JOxwf3hfNvFnHgG/toLxVrINZKoYX
         5Wmcod4ggx6ldZTYgRn4K1mQEKDim6rMZdsUqUfMh2xs/z/1tA7yPMUnMqnD6pYL4qC+
         gKuekaupomcMZBO/3amxRY0gJ/0eAyxNVNYbJUktKbu8a8LUfVDtJoR4C1q/MRGCMqHz
         s9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LmvJmrZLHAQ+QV8FuMLW/yww8QDVxDh2p5wK5tqUR2w=;
        b=T5FAboWclboaxwClx086A4zWuyLFvpoJwT8OVLOaOoqJvsSeX0fSC17hJwWcD0fr+m
         28YG6e5E6v6JpnoYxZIsAcIDKWsHoHIqj/d9lk2aDjI91akVp8OofARvGDOLYsNs2tCm
         yuL1SxYGhLGsQWnlRzQ+3FqbEXLbYrFCTISuXomxb+p21urLk0Xlf1VRYgkOEA3x7iZe
         YmWhVD64d7yHLQHMUScc8jf1FRuFonExbv97iilPqbttJcyDZ0oOybOjbcv1kqCWyRek
         HRTU88An8QCLZZzyuIZ9IjiamKCMKmsR9OHVYStx30cM2lBs7mp+RMyIuJIqB9VvyF1Y
         GMkQ==
X-Gm-Message-State: AOAM533yVZXW4hAFh0YiH18NAewV1vezv83IUhk8dGr9u9BPxW1rk3Gz
        gX/3Tgmy3BoNCBraaCbL9zlWJw==
X-Google-Smtp-Source: ABdhPJzmkzBUPxyBrvmzH4OdrXlCe98mQylroQ/seYAUAHjGW9KNFKmodoVfejJP+fBoMe3JxqPycg==
X-Received: by 2002:a7b:cbcb:: with SMTP id n11mr2180943wmi.5.1601027768073;
        Fri, 25 Sep 2020 02:56:08 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id g14sm2227598wrv.25.2020.09.25.02.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 02:56:07 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/3] slimbus: core: check get_addr before removing laddr ida
Date:   Fri, 25 Sep 2020 10:55:18 +0100
Message-Id: <20200925095520.27316-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200925095520.27316-1-srinivas.kandagatla@linaro.org>
References: <20200925095520.27316-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

logical address can be either assigned by the SLIMBus controller or the core.
Core uses IDA in cases where get_addr callback is not provided by the
controller.
Core already has this check while allocating IDR, however during absence
reporting this is not checked. This patch fixes this issue.

Fixes: 46a2bb5a7f7ea("slimbus: core: Add slim controllers support")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
index ae1e248a8fb8..58b63ae0e75a 100644
--- a/drivers/slimbus/core.c
+++ b/drivers/slimbus/core.c
@@ -326,8 +326,8 @@ void slim_report_absent(struct slim_device *sbdev)
 	mutex_lock(&ctrl->lock);
 	sbdev->is_laddr_valid = false;
 	mutex_unlock(&ctrl->lock);
-
-	ida_simple_remove(&ctrl->laddr_ida, sbdev->laddr);
+	if (!ctrl->get_laddr)
+		ida_simple_remove(&ctrl->laddr_ida, sbdev->laddr);
 	slim_device_update_status(sbdev, SLIM_DEVICE_STATUS_DOWN);
 }
 EXPORT_SYMBOL_GPL(slim_report_absent);
-- 
2.21.0

