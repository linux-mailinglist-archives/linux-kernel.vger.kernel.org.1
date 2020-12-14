Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE5D2DA449
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 00:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbgLNXl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 18:41:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727141AbgLNXlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 18:41:15 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9A2C0611CE
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 15:40:06 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id 3so16791628wmg.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 15:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AjsclEsqT88jpSQ7xfg3w1NdJS1z7YOg80HC0xXR68s=;
        b=Yhypwya/g0XFvAC4yF97ofNejTZRbDAMPY6R5qH7pFRe2VEtAvsN3ZMtHKnjIXapNO
         XPeUEGcNll8vn1LjHAEBpljNv4jLfxle0gMFoSDHEMzFjl9GqTgxunbevV6CjZ7ZI/2E
         ywP5U13diSRGlrJHkbYwmHFMzP7MSLmOygLiBBtmnYFGCYK1smRUlC+Xp9yxLbaGYqup
         e4JPMH5ac/9fYLUkXEb9qCr3ETN74hYLnxIfRLBjdE4efkH9qOVug0Gr3x8lZqFFHjn+
         FYg9hVfnEh0qKxOzHIpP0fiWoO4QlKvUVPdYeQ22ouRz7Y7L/MpTIV7795yW8S/ntYRn
         flyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AjsclEsqT88jpSQ7xfg3w1NdJS1z7YOg80HC0xXR68s=;
        b=TUDJNlrca9LSU8QJ0QC8M7wFKyhH1uhF8p2imwVWdxrz6hLD+OcR/Ai0iXSbtlWCKo
         3I0Po/2XZglBsR/2n/lKTzuuwVveK4GNv/PuH+ce/BVz2Gs/6NP2lpyzXNW4lPK4NYWy
         ovQ3YR4vk8/KXX1e8nfeL9kKWubMofPicdJfnX0mnkmVVI50mXgFpZz09ydTf0XuQKKK
         LCdcNJbqUH/Qind97ZA/OCBQBv6JEYWXZbAh4FrZIGMSnLlo0y/qCHRGBf5Eot894bWc
         wf6LiEfj8sUfULjOBrnLY+gTMcON6y7LihSR7LujSe/9lk8sVgoHcsI+dfC+iaZRwRnd
         2nAA==
X-Gm-Message-State: AOAM533mss9qsqYUr2OyQitMenA/d62cQG2KOUg/TowUr2YQYCR1QeBj
        ItsuaUwNFH/FEcMcD2m5u7aT4w==
X-Google-Smtp-Source: ABdhPJyTPOduhar+VS6zDewwhwiUxZs6e511iBQDuRYXqghCcIYvkDimf8rE3Iy6mvlypHGijwcM0g==
X-Received: by 2002:a1c:e084:: with SMTP id x126mr29921117wmg.109.1607989205027;
        Mon, 14 Dec 2020 15:40:05 -0800 (PST)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:e842:4086:6f24:55a6])
        by smtp.gmail.com with ESMTPSA id h3sm34145075wmm.4.2020.12.14.15.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 15:40:04 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     mjg59@codon.org.uk, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, amitk@kernel.org,
        thara.gopinath@linaro.org
Subject: [PATCH 6/6] thermal/core: Remove unused macro THERMAL_TRIPS_NONE
Date:   Tue, 15 Dec 2020 00:38:09 +0100
Message-Id: <20201214233811.485669-6-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201214233811.485669-1-daniel.lezcano@linaro.org>
References: <20201214233811.485669-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macro THERMAL_TRIPS_NONE is no longer used, remove it.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 include/linux/thermal.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index a57232a9a6f9..060a2160add4 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -17,7 +17,6 @@
 #include <linux/workqueue.h>
 #include <uapi/linux/thermal.h>
 
-#define THERMAL_TRIPS_NONE	-1
 #define THERMAL_MAX_TRIPS	12
 
 /* invalid cooling state */
-- 
2.25.1

