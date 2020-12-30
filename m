Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E717E2E7A6C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 16:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgL3Pi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 10:38:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbgL3Pi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 10:38:57 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F16C06179C
        for <linux-kernel@vger.kernel.org>; Wed, 30 Dec 2020 07:38:16 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 3so5016176wmg.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Dec 2020 07:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t5qU0u0BbjyAf7ASokX3PDKEGwUdQpw6OEstGnrNo58=;
        b=CN437dPVzQo0tvO2u2a4Jee8cmUZkWsILIxPzYq/EoNcgHYmX8y3d7PWXku/qVwxRy
         Zbih/MHCKJ0s5zdvYyotn+sgkUAbn783RjApS1XoiEBHja3W0TkLhDNloVKFYYkBmZPu
         bVcCOIdNJMbJDfBeXs3wHJX3reDJ/A3syjLGnD4ylznyFGeKC+MoVy8YK4APmzXAjBuS
         0bhWQJ3ohVhocsH0n4miWboYQILyBW2+Q/1yPdUqZRoLnu7Oxv4w/V8HvP9eJUXrlEoS
         SZml0TkX7+8HKCCONeQ51dWaKMKvDIxnFUWfQV7WtXsmlJz8yBd7fMn2d2wxfoRVGLPr
         821g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=t5qU0u0BbjyAf7ASokX3PDKEGwUdQpw6OEstGnrNo58=;
        b=sfD7IRXXxo/EW6RF/vqrt3/GmTpbiteQgMwzC+1i7O3ay5Vd3NngwWsTda/y8hw8t+
         N+Wtf76gikTpT8cuP8paQVGyHpE7oaUHosCeef90JQckSQ7Jyv0DpWTVM21gB9OMu53O
         VdnHPOuoC0tmF5IbEhh/NDFCLSAc+tRLPr2oofJ8mVoizgGJPyfI058HGqClC5Ry6moq
         YYWD4X1B7/3MmyygtQ8tua97meHScia4hVFS/UIe3T4NG13bKP4vZpmKrYVzGRp8nXic
         J59iUDB8WNJUzKpD4Iuz0hPzNojd1tBAXgPM9bSWqledzE7gkgGdZwZ3snsHnFO+OiWS
         7pwg==
X-Gm-Message-State: AOAM531yO92+AKUypQwfVQc33N+5m3ZhTjiXMzyrhzhGSqV6XiKj/5XQ
        F9qDkd+fIAWhmA8Zrv43rXvuIA==
X-Google-Smtp-Source: ABdhPJzATfgVUVRnd0DMVpZVYIHm8h4tAgYslW1iLToSCwh2SN+9DdP1CGeN0glGGZOf/+K+y4Ot4w==
X-Received: by 2002:a05:600c:d8:: with SMTP id u24mr8094776wmm.103.1609342694387;
        Wed, 30 Dec 2020 07:38:14 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-148-164.adsl.proxad.net. [82.252.148.164])
        by smtp.gmail.com with ESMTPSA id g191sm8634484wmg.39.2020.12.30.07.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Dec 2020 07:38:13 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] powercap/drivers/dtpm: Fix __udivdi3 and __aeabi_uldivmod unresolved symbols
Date:   Wed, 30 Dec 2020 16:37:44 +0100
Message-Id: <20201230153744.15612-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAJZ5v0gN3NfWyAHA7At=1ZG90vCJbDoUzF5ts2_t3GmunSbrMQ@mail.gmail.com>
References: <CAJZ5v0gN3NfWyAHA7At=1ZG90vCJbDoUzF5ts2_t3GmunSbrMQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

32 bits architectures do not support u64 division, so the macro
DIV_ROUND_CLOSEST is not adequate as the compiler will replace the
call to an unexisting function for the platform, leading to an
unresolved symbols.

Fix this by using the compatible macros:

DIV64_U64_ROUND_CLOSEST and DIV_ROUND_CLOSEST_ULL.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/powercap/dtpm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
index 5b6857e9b064..0abcc439d728 100644
--- a/drivers/powercap/dtpm.c
+++ b/drivers/powercap/dtpm.c
@@ -99,8 +99,8 @@ static void __dtpm_rebalance_weight(struct dtpm *dtpm)
 		pr_debug("Setting weight '%d' for '%s'\n",
 			 child->weight, child->zone.name);
 
-		child->weight = DIV_ROUND_CLOSEST(child->power_max * 1024,
-						  dtpm->power_max);
+		child->weight = DIV64_U64_ROUND_CLOSEST(
+			child->power_max * 1024, dtpm->power_max);
 
 		__dtpm_rebalance_weight(child);
 	}
@@ -272,7 +272,7 @@ static int __set_power_limit_uw(struct dtpm *dtpm, int cid, u64 power_limit)
 			} else if (power_limit == dtpm->power_min) {
 				power = child->power_min;
 			} else {
-				power = DIV_ROUND_CLOSEST(
+				power = DIV_ROUND_CLOSEST_ULL(
 					power_limit * child->weight, 1024);
 			}
 
-- 
2.17.1

