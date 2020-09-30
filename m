Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A6027EA40
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 15:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730318AbgI3NrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 09:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbgI3NrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 09:47:09 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D91DC061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 06:47:09 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id x23so1786192wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 06:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atcomputing.nl; s=atcomputing-nl;
        h=message-id:subject:from:to:date:organization:user-agent
         :mime-version:content-transfer-encoding;
        bh=DYqXNtnLEfZnCBFKtbviH+9NWjsKFBRmS/kwN3GTpa0=;
        b=HIYLfPKnGM8o5bdjc50HwUlCMAP3utMxQMs1kopwBfUxU4mwMV3d5yijzGxs5ccaEE
         Mb2jzlTBU7zoV8gjbps5lidJzdaB/la8hU43FSjJ5BkSOE3M7bzi3TILrnUv26JyDgyn
         pRPTdYNWmAHIHyIyFHpO8vwRmXbxbQSgRfsmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:organization
         :user-agent:mime-version:content-transfer-encoding;
        bh=DYqXNtnLEfZnCBFKtbviH+9NWjsKFBRmS/kwN3GTpa0=;
        b=A8n9g9PLwXIQx29cRbMzJH3aKZLGAhd2+3bXF7AwiJRrk11JpN41UHO10PsWWWvR4U
         jQ5WjIODS8yX+BV2hyYjmkuvDUqKNWhpsmAgeFYm85lGmGW8QXrTnyevs7VyqFp4CJQm
         XrFMkchPojuYoirZrRj8eHEvCXuSZgtGHLiwKIHedRjKMSdHZNpFazeOra2jxmmkU60+
         9vqZ5MH8qdUa1awMXigIzpLsF5W0wcTfSvGu0htWcYVdskeQHXPxYKrzuYdebMpFs60t
         FMpkCrIO0//qWTRgCEINrx7hOtw8xzf9CdVpaQfsjiwKZD3/fhEt7tZ7FfTfJMo3eZJU
         tYtw==
X-Gm-Message-State: AOAM531jXWMF9PSV7DoTG8XtblCyNHuPxx2ugi3hHTMBVxmIuFLNS+rX
        EOi1AOvAmd8kc8RD0pQw1cjEXA==
X-Google-Smtp-Source: ABdhPJzN/PZ6aGuW3RXOEPyUnQQ8HCa2Nbz6+quQg/MxuSdPTN35SEMoxvzwBkcsYYv5VfQ8XG4bUQ==
X-Received: by 2002:a05:600c:283:: with SMTP id 3mr3273113wmk.110.1601473627953;
        Wed, 30 Sep 2020 06:47:07 -0700 (PDT)
Received: from nyx ([2001:980:74ee:1:1ec4:4a28:e4c9:705c])
        by smtp.gmail.com with ESMTPSA id v128sm2797486wme.2.2020.09.30.06.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 06:47:07 -0700 (PDT)
Message-ID: <60a804aa6357eb17daa1729f4bce25e762344e9f.camel@atcomputing.nl>
Subject: [PATCH] Revert "drm/i915: Force state->modeset=true when
 distrust_bios_wm==true"
From:   Stefan Joosten <stefan@atcomputing.nl>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 30 Sep 2020 15:47:06 +0200
Organization: AT Computing
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fix of flagging state->modeset whenever distrust_bios_wm is set
causes a regression when initializing display(s) attached to a Lenovo
USB-C docking station. The display remains blank until the dock is
reattached. Revert to bring the behavior of the functional v5.6 stable.

This reverts commit 0f8839f5f323da04a800e6ced1136e4b1e1689a9.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1879442
Signed-off-by: Stefan Joosten <stefan@atcomputing.nl>
---
 drivers/gpu/drm/i915/display/intel_display.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index b18c5ac2934d..ece1c28278f7 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -14942,20 +14942,6 @@ static int intel_atomic_check(struct drm_device *dev,
 	if (ret)
 		goto fail;
 
-	/*
-	 * distrust_bios_wm will force a full dbuf recomputation
-	 * but the hardware state will only get updated accordingly
-	 * if state->modeset==true. Hence distrust_bios_wm==true &&
-	 * state->modeset==false is an invalid combination which
-	 * would cause the hardware and software dbuf state to get
-	 * out of sync. We must prevent that.
-	 *
-	 * FIXME clean up this mess and introduce better
-	 * state tracking for dbuf.
-	 */
-	if (dev_priv->wm.distrust_bios_wm)
-		any_ms = true;
-
 	intel_fbc_choose_crtc(dev_priv, state);
 	ret = calc_watermark_data(state);
 	if (ret)
-- 
2.25.4


