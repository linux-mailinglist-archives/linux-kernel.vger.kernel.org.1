Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4210E2CE6B9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 04:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgLDDyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 22:54:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgLDDyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 22:54:10 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE28C061A4F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 19:53:29 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id z5so4393767iob.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 19:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K46J11OuhAH7Ds8aixOF5TU2H/Kjo5yHrmhtSRIp5TU=;
        b=p0BGihhBa64eNmopWOvTN7ox4Ck1IVh2mFJsyp8lB1U1vZ4WdGaz6rcUpopFT9JLez
         lYhANwAM+c66g9Os6Cr5SgXWXP9UnsvFd6O7lUKg8StYJIlPich5Qz3v2g6282sAdku/
         C4KFE4YmHYNbEsaNqBCVjXPjlSbvJdTZu4dOA/5NFURw7FQbFKQDOs8mmOBkjLRx4idR
         3zRSJQHHYpoEMaNBZZTTf38+3UHaDw98w4B98ISA0HVkpwOMR5WTXcbT9hnvyRXuM64O
         GsKpcvx+jzU1rq72oOM/OLH1+HKehCkAnXDDjYmlNKLq/CU9/si8uSIBmYBokBNmNN1t
         1kXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K46J11OuhAH7Ds8aixOF5TU2H/Kjo5yHrmhtSRIp5TU=;
        b=cLiu0HltgfCGWMeT+iX1k0bBGY1KVSfu+GnHPFrTpUZaK13zOL/gSt2MObi5PPU2d0
         aJq/Hnp5cG9Ver3/LQqsE0GsTApF/DMZiv8ycoTbk7HnLE2L505KL0a0Q0N+cA59q2B/
         4PJm8BRgjcHmHan+/MDz9+bmGNkkVP7ZfmvmnDm4aN+1DRPt4ZNDMErnCDGgPtc1LRql
         iyZcsCTgGdD13wlsttMoPCmMRjFVZ8gr8kICEHdzms/k18JXdflWnIvMMHlki1eUqw9E
         O20Ny7vM+Err7nF+30E91zR251jBW+VbLs5cFbnEMRL454WpEZUj0lYt8A3bf45r44Yt
         goqQ==
X-Gm-Message-State: AOAM532mXL44zJ7y7i2FrIkcOSjw1kyUV+QaMuzWT0DqKXsGugXz6xLh
        ALyH1YboEMAGglMCVNd/yQG+2AwDWXw=
X-Google-Smtp-Source: ABdhPJykXXanjpHBCbmyiGm2JEVaEU8jlsqOBpQAQQyq/B36FBcHwgS+ru3hhjyd2ymyz6ZR5GUysQ==
X-Received: by 2002:a02:ccca:: with SMTP id k10mr3490531jaq.100.1607054009282;
        Thu, 03 Dec 2020 19:53:29 -0800 (PST)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id o12sm671361ilj.55.2020.12.03.19.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 19:53:28 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     jbaron@akamai.com, Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH 0/2] drm: use dynamic_debug
Date:   Thu,  3 Dec 2020 20:53:16 -0700
Message-Id: <20201204035318.332419-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hello gentle readers,

These 2 rfc patches convert part of drm-world to use dynamic debug.

1st one addresses drm.debug category based logging.  If DYNAMIC_DEBUG
is configured, then CONFIG_DRM_USE_DYNAMIC_DEBUG controls whether
dynamic-debug is used to avoid runtime costs of drm_debug_enabled().
We require CONFIG_JUMP_LABEL too, since we are selling its
optimization.

This change adds many new callsites to /proc/dynamic_debug/control;
~300 in drm, ~200 in drm_kms_helper, as well as ~1500 in i915 driver,
and ~3200 in amdgpu.  So there are substantial implications here.

2nd one is for i915, which I have in my laptop.  `grep pr_debug` found
~90 callsites with a meaningful format-prefix-string, to demonstrate
use of "format ^prefix" to control user categorized debugs.

Jim Cromie (2):
  drm: RFC add choice to use dynamic debug in drm-debug
  i915: POC use dynamic_debug_exec_queries to control pr_debugs in gvt

 drivers/gpu/drm/Kconfig            | 13 +++++
 drivers/gpu/drm/drm_print.c        | 75 ++++++++++++++++++++++--
 drivers/gpu/drm/i915/gvt/Makefile  |  1 +
 drivers/gpu/drm/i915/i915_params.c | 74 ++++++++++++++++++++++++
 include/drm/drm_print.h            | 92 ++++++++++++++++++++++--------
 5 files changed, 228 insertions(+), 27 deletions(-)

-- 
2.28.0

