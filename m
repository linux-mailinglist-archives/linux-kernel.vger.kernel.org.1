Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA1319C40C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 16:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388266AbgDBO2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 10:28:18 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35684 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388126AbgDBO2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 10:28:12 -0400
Received: by mail-wr1-f68.google.com with SMTP id g3so2159934wrx.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 07:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0yL1w5+JWaXNihGaTzT6saNdFzgGKd/d3GiibbTk4FI=;
        b=Tgny2VVk+APSF6iZvl9xqCiKBh+PaEW7ArlCg1cSjsRXQSTQ5Yd8ToRlbKatb4fc+O
         DgnfDXJ6PZTB4djmgmI+pQ4aRtJHr2MG7Ep0lQUyNohXdOu5cDLB+HRvoZZ6EZh4+C6j
         zHx+MRDpy7Yslqc+HNi5TKkLi9djfrdg386zxVtm1ZHkrrAP8RC8c2X9FsZlVPG9OIjF
         l7CKHzmpeIyARD8mLMyDR598kq6m5+lTwMkg0g0BDNKAQ0VU7rxaH+kWuMEG7Ex57Lfn
         N2ReeB2iWjtX9QsfXz1S0iRjexW/DUMI72AxmH/xeVAb8K+NggZwgJVhnHhs3CqIrGvg
         giXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0yL1w5+JWaXNihGaTzT6saNdFzgGKd/d3GiibbTk4FI=;
        b=fSdXn5bSsbA/qn1XAajGYTbX0T30qw4CEZTJtrt2ltd9XYwragwkjLoaxfVcein1dF
         QHuYgVWgN1YVTRcZN73Bxi72t75UKYlmvYvMrWXs+ihzKVI2JcDg9o9f3s2oTyNMwNyF
         clbyiTL4iMO+BAO2FqQe1HU9njR+bVeZNezs/uy4qMAWFfQbS2gf27gc/6M00QCQ6Jyt
         7l1Z53yUz34ylKd69iVedYeC9bXbtt+llWGSws1t97PCDy+WXt16P/Es2mLnExvOdV+8
         OvK11L0n5B40iQ8fgHkAR59KWgy4RZdniG4CIWkdh5nEwoOhHE4TlS6nTnD8emKMdXOR
         eAHw==
X-Gm-Message-State: AGi0PuawyzrBcUnY1Rf5w+C6OYCVFqOTlej9qaKq+g5qbH1dWyY+eupM
        SIPrqJIrAuSxCMY7zp6mp4RqOw==
X-Google-Smtp-Source: APiQypLhb4JxPDxJ1toEh0FNeaz9TM9nX/Zm+7qSIKRBmPBmdRaKUsoz+enVMUHIfk/h1R1UPepDkA==
X-Received: by 2002:adf:ea8f:: with SMTP id s15mr3738685wrm.393.1585837691388;
        Thu, 02 Apr 2020 07:28:11 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:4b2:e366:e86f:261a])
        by smtp.gmail.com with ESMTPSA id a7sm7045186wmm.34.2020.04.02.07.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 07:28:10 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     amit.kucheria@verdurent.com,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V2 9/9] thermal: Remove thermal_zone_device_update() stub
Date:   Thu,  2 Apr 2020 16:27:47 +0200
Message-Id: <20200402142747.8307-9-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200402142747.8307-1-daniel.lezcano@linaro.org>
References: <20200402142747.8307-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All users of the function depends on THERMAL, no stub is
needed. Remove it.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 include/linux/thermal.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 7b3dbfe15b59..216185bb3014 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -426,9 +426,6 @@ static inline struct thermal_zone_device *thermal_zone_device_register(
 static inline void thermal_zone_device_unregister(
 	struct thermal_zone_device *tz)
 { }
-static inline void thermal_zone_device_update(struct thermal_zone_device *tz,
-					      enum thermal_notify_event event)
-{ }
 static inline struct thermal_cooling_device *
 thermal_cooling_device_register(char *type, void *devdata,
 	const struct thermal_cooling_device_ops *ops)
-- 
2.17.1

