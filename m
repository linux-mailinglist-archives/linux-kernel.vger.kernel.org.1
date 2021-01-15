Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 816882F83C1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387985AbhAOSPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:15:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387803AbhAOSOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:14:55 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15B0C0617BD
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:14:04 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id m187so1958711wme.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JPqjkgIRJp+MRlYiJIdOLESmtI1+G3x8A3c4gbTlrp8=;
        b=URYUQikT1ubIBypdWNn5JgBBuXlql29P1qAbd5qPje/NQfeENl1ULvQa//CbMbYFoF
         b20uBNi16xepfMRbzFAyJRUVZ5MqivZm/jQ3qlfN7rnn+QWmxkY2iaz8w1vQ2BgJSII3
         0FwKk8O6S4fT3G1jrL1Nm0znrOhkfTzKQcuxjdDJigTEszxLz87IAitAEMwf4C97U6AX
         KHGWLXJiXGxqvJNLPK3vjQ0+TiasqtTYfpbhyX8g1IJOabVyiiW4vHc7/d9vvvMkRYZT
         bAG0gZZTYzUgwzxPPL+V2uepaHxF6vv6mwTy6iwe+9FlYsL9SGj8WiBBjMMNQZgSFKdY
         uCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JPqjkgIRJp+MRlYiJIdOLESmtI1+G3x8A3c4gbTlrp8=;
        b=YgH4PY8FGAPgjoJ30gWIXCTXW119btdbfc0Ehvy+Mtdv2v6VGq2R65LI9gvKf7y7Ab
         yyTOK2pqK2+KR+bDSwncSHz7wagtiExIdRct1p+xwXPPQ6MOnDeTjDraGFnjFiZVPv1Q
         Fgw08jNmecBIYWStfA4BvxE8aIRsT79g0Uu0JbvVj6ce85xHYeK7FwR0/bG8qMKcKAoy
         fLTPUfukRL8gCF63YFYNiq+KGtpZJkZetRAWhBb74IGjjsIPwcp088KnltBokvkFmZ2k
         fxETVtv+NQkzlcoPtIfJA6k0QRQxzVY214cVkqf0TRS9t6fGjQeb1zieu201naVhfK9t
         QBPA==
X-Gm-Message-State: AOAM532J25/qEUbcjbqUyMEQmPqW4WC0LlejhyQGr1Uh8QFsQkTnDFUQ
        A2gC1fF6atzIo818sbSGPlFzRw==
X-Google-Smtp-Source: ABdhPJw2MMzpvaVQAHHCh49HDDbQw3JQpBE0IuwjQPFWWV6qwKFryTl5zZIFzmE6Gxwu+wLm18l++w==
X-Received: by 2002:a1c:2d48:: with SMTP id t69mr9677839wmt.124.1610734443715;
        Fri, 15 Jan 2021 10:14:03 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id j2sm16123484wrh.78.2021.01.15.10.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 10:14:03 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 31/40] drm/gma500/gem: Do not rely on consumers to include drm/drm_device.h before gem.h
Date:   Fri, 15 Jan 2021 18:13:04 +0000
Message-Id: <20210115181313.3431493-32-lee.jones@linaro.org>
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

 drivers/gpu/drm/gma500/gem.h:13:57: warning: ‘struct drm_device’ declared inside parameter list will not be visible outside of this definition or declaration

Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/gma500/gem.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/gma500/gem.h b/drivers/gpu/drm/gma500/gem.h
index 3741a711b9fde..bae6454ead292 100644
--- a/drivers/gpu/drm/gma500/gem.h
+++ b/drivers/gpu/drm/gma500/gem.h
@@ -8,6 +8,8 @@
 #ifndef _GEM_H
 #define _GEM_H
 
+struct drm_device;
+
 extern const struct drm_gem_object_funcs psb_gem_object_funcs;
 
 extern int psb_gem_create(struct drm_file *file, struct drm_device *dev,
-- 
2.25.1

