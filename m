Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EADE2F88B4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 23:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbhAOWp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 17:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727410AbhAOWp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 17:45:27 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595F0C061795
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 14:44:47 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id q4so5442160plr.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 14:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mTA49NGZFHIajQ9unaV1ybBctL6ERy3zYWaKCRHno4w=;
        b=ESFR8XE28uKU8I9Yi8nLrOKz7DRInG2Yb87P5sczoq2dC2AFbH0WFnaqVQfnKRPjeJ
         5LGPRmxjq24G5gw2ablyQXl1Bd9mZvyI2OpKe8SHBjqNYA8Lw6JOesczgCrQFuXm9jMD
         /HCfMbBCxNcBEqwpxPl7IwGTRN+K2TCuZHNfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mTA49NGZFHIajQ9unaV1ybBctL6ERy3zYWaKCRHno4w=;
        b=Z55lwApVLIgwInahBMTgKWud038b6vn6W0SkFlmt8UpLFeSq969Qhu2iYq7ydO+wgi
         vtGdPBAeaJUQuDbrawDKNTIbas+hyXLakwcKV+NgRSCs8X1ZG0cm0iLm76Eoanq//nww
         78u3wmueLoS3EeAtVih+yDx5l1g9K7X5Y+XCgl/Pv1zkJskj3UDyQOWLpkjtytwABUKg
         5z67JlZPoyOTKXViHoilPccner0b2lMWdd5SQt+tJSL3/vDGqnw9vcpFRry0J4XXG0qR
         jRASKunVeTuXEITVmUd6Dp9ejYP4l65RkNPXk92JaS5h6wPIrdplUaEZ/foZ7npuXY1i
         kg/w==
X-Gm-Message-State: AOAM531wLggfvPtrjL1f3l13IN7m4/Vs5z+/HOKItfF+o2txl2aNF7IT
        CghBQql0HNB/x7UrV5GDcYYG8w==
X-Google-Smtp-Source: ABdhPJyoaYtRn2BrXjvFuddlTtkAwmEk+srgLAChXqS259ceINg3HgxgyQaHayHSXGJyGut0yKSKUQ==
X-Received: by 2002:a17:90b:490c:: with SMTP id kr12mr13051567pjb.227.1610750686904;
        Fri, 15 Jan 2021 14:44:46 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id q16sm9131100pfg.139.2021.01.15.14.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 14:44:46 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Rob Clark <robdclark@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] drm/panel-simple: Patches for N116BCA-EA1
Date:   Fri, 15 Jan 2021 14:44:15 -0800
Message-Id: <20210115224420.1635017-1-dianders@chromium.org>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is to get the N116BCA-EA1 panel working. Most of the
patches are simple, but on hardware I have in front of me the panel
sometimes doesn't come up. I'm still working with the hardware
manufacturer to get to the bottom of it, but I've got it working with
retries. Adding the retries doesn't seem like an insane thing to do
and makes some of the error handling more robust, so I've gone ahead
and included those patches here. Hopefully they look OK.

Changes in v2:
- Set the "unprepared_time" so if we retry we give the proper delay.
- ("drm/panel-simple: Don't wait longer for HPD...") new for v2.
- ("drm/panel-simple: Retry if we timeout waiting for HPD") new for v2.
- ("dt-bindings: dt-bindings: display: simple: Add N116BCA-EA1") new for v2.
- ("drm/panel-simple: Add N116BCA-EA1") new for v2.

Douglas Anderson (5):
  drm/panel-simple: Undo enable if HPD never asserts
  drm/panel-simple: Don't wait longer for HPD than hpd_absent_delay
  drm/panel-simple: Retry if we timeout waiting for HPD
  dt-bindings: dt-bindings: display: simple: Add N116BCA-EA1
  drm/panel-simple: Add N116BCA-EA1

 .../bindings/display/panel/panel-simple.yaml  |  2 +
 drivers/gpu/drm/panel/panel-simple.c          | 84 +++++++++++++++++--
 2 files changed, 80 insertions(+), 6 deletions(-)

-- 
2.30.0.284.gd98b1dd5eaa7-goog

