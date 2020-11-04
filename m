Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 984E92A6706
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 16:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730450AbgKDPDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 10:03:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726919AbgKDPDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 10:03:47 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA6CC0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 07:03:47 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id z3so11113932pfz.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 07:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Cpcyf2os5AGZUKltjzw6mmvdqbBSobD8RORnek/XVyo=;
        b=D8ncMu08T1OvGeBwqUDALGzrifbn52YuhJiLosvBbOamy07+NM4aRofAi6wpZhFu7o
         h6+vsSgcuCac+V2pdkw8jQUXQO4fMMNMHJJYkr1bwJqmmZZICd+PzKySiGcaGb2iIoVr
         OBL0dalld+I48UA6Fx5fpYfVGzZ+KxU9rUqlwKfiRqWvuX2vZLeEDrl4vLNaHUYCvLhj
         DcCQXPJTYd0UjGjzrFXenLrwgbyNDEncChAJ31m+CXLgt6Kbx6vYJZa5FkLttq8S07Lk
         ySRi1mkBE+5tARxbwx6uKCIV9dFa2jCUNVrB2IpckikzQVS81JiZdJvQO7401/mfHR/8
         vWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Cpcyf2os5AGZUKltjzw6mmvdqbBSobD8RORnek/XVyo=;
        b=DT9mOPzfkg5X9/Q/beU7JJzmma8NGx32CptY87OLZ6WrwZ+ztTY4ICJzpeTmvg/Zu9
         va5bGFlVOvaCi+A33eYZdJ9zqdDlc4cKgsvUPUeP2Fue7l7+TD174iTPeN2lj/rLWKeb
         Pw1MgC+kl0JdmXRzzGylB0BV6NFqLMKJmYMJJ5GmPDqtbXf0E/or6iAHrszt4ryTvC/Y
         aO6Cez7tnamqDAcRIxvO0wcYWV+tO8quwL1m14TZX6MYRY9fYoBiffOJQTgLg8LYhZJw
         Q6h9T5ylgEKUOEqjivHavlGngzsbxAf+XDtmRqWEuZEfGLhw4rM3c76wzo7OaSyd9VWC
         T8LQ==
X-Gm-Message-State: AOAM533+HcgpqTk6+Q1kzmsVrlnrIyB1ippRhpLdLSdvcjZF7hd3iCWx
        LTUfVtyYgGvRkE2bYTxX7Ww=
X-Google-Smtp-Source: ABdhPJwAnv8VuhxZLOh69pT/O6WNOFA7xnF9jPLzCeTgfTiii/Zr65gXy4oBF1C/+g76XjU5+oip1w==
X-Received: by 2002:a17:90b:30d2:: with SMTP id hi18mr4834398pjb.186.1604502227223;
        Wed, 04 Nov 2020 07:03:47 -0800 (PST)
Received: from localhost ([160.202.157.3])
        by smtp.gmail.com with ESMTPSA id 21sm2831827pfv.122.2020.11.04.07.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 07:03:46 -0800 (PST)
Date:   Wed, 4 Nov 2020 20:33:39 +0530
From:   Deepak R Varma <mh12gx2825@gmail.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     mh12gx2825@gmail.com, lionel.g.landwerlin@intel.com
Subject: [PATCH] drm/i915/perf: replace idr_init() by idr_init_base()
Message-ID: <20201104150339.GA68663@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

idr_init() uses base 0 which is an invalid identifier. The new function
idr_init_base allows IDR to set the ID lookup from base 1. This avoids
all lookups that otherwise starts from 0 since 0 is always unused.

References: commit 6ce711f27500 ("idr: Make 1-based IDRs more efficient")

Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
---
 drivers/gpu/drm/i915/i915_perf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_perf.c b/drivers/gpu/drm/i915/i915_perf.c
index e94976976571..2d033255b7cf 100644
--- a/drivers/gpu/drm/i915/i915_perf.c
+++ b/drivers/gpu/drm/i915/i915_perf.c
@@ -4367,7 +4367,7 @@ void i915_perf_init(struct drm_i915_private *i915)
 			RUNTIME_INFO(i915)->cs_timestamp_frequency_hz / 2;
 
 		mutex_init(&perf->metrics_lock);
-		idr_init(&perf->metrics_idr);
+		idr_init_base(&perf->metrics_idr, 1);
 
 		/* We set up some ratelimit state to potentially throttle any
 		 * _NOTES about spurious, invalid OA reports which we don't
-- 
2.25.1

