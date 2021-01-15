Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 679F02F8393
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387674AbhAOSOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:14:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733306AbhAOSOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:14:38 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BAF4C061799
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:13:24 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id m4so10183264wrx.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K2J3GjpOO3HekYRLC9b6PVtgl9N3gd4w+azAVwpWeog=;
        b=LxwyehuC8GrWwvLbGs+Rh5yjqTjMc92zt0+XsCWcB2L6OviLjYZJ+vhBjbplszNCXn
         g6TyGID0z2rgR55jgd2irYjclgl+gS0Jqnisd8W2QFF8g1EtL6hZu2p57vGbErjXtCbh
         FQB1weosVOThVbi05jFtscL+11qNHfhw1DZfFu4Rqp22rz+Q2TxSRx9vgqHlaaH2pQjx
         r5LyEptMvzxNzv/Au4o2h/UsGeDxr/p7tv9/ip9axINBqq9d/tuojLnV4JwHHFYOgL67
         zn36WMzXqgJ+z8DBDANHuLJcsV4OOEsOCWwOYWfeoRnL6u0C1MZjtX0kdt8k8KHMCIs8
         gGGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K2J3GjpOO3HekYRLC9b6PVtgl9N3gd4w+azAVwpWeog=;
        b=kcN3Jox6QGv68VghttYtDK1GvuLOAxvwTweU8GovXOWLx+ruP/OqXhuB1+abEhCeS/
         zs3A9PmVNrac86hIB2WLIS2gwxs2+YwnRpQYoHdd1T1Y2kr9M4ck6CU5qgV0WwhgA09O
         L1kO4TWdRamn3E6JOU90m2m5wtrApWuL7FArJk9WkPCNoQKNljNLdEFEkF/7q5uPAIw3
         hpRWfXpcmcFdf9Y126qFL+U0L1NWBe80NG4i5g/1Wn9E1HbwCsPzikuacqdLp2H3A7L1
         dsKYRVhbK4N0r98Hc3rde8TD3Q4NiznPHOfhkK+809MeRJbmc5BpHj+NHqVdZKHgmpEN
         cQ5w==
X-Gm-Message-State: AOAM530Ibvo6ccYf2+ZIxF7g9C4UaIcOIFubQ2J/QnqelXRVF9fIJ5yn
        09DqbCI4JH2nlX01zUo+W5g4aA==
X-Google-Smtp-Source: ABdhPJwFsstq3kKhxXDJeD6jx43iN+/htYNp695e9BAORta+J3PbuXxbkAN7oi9iI0hB/Ug9WYwRQw==
X-Received: by 2002:a5d:6884:: with SMTP id h4mr14406677wru.174.1610734403031;
        Fri, 15 Jan 2021 10:13:23 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id j2sm16123484wrh.78.2021.01.15.10.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 10:13:22 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 05/40] drm/r128/r128_ioc32: Fix formatting issues in 'r128_compat_ioctl()'s header
Date:   Fri, 15 Jan 2021 18:12:38 +0000
Message-Id: <20210115181313.3431493-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115181313.3431493-1-lee.jones@linaro.org>
References: <20210115181313.3431493-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/r128/r128_ioc32.c:182: warning: Function parameter or member 'filp' not described in 'r128_compat_ioctl'
 drivers/gpu/drm/r128/r128_ioc32.c:182: warning: Function parameter or member 'cmd' not described in 'r128_compat_ioctl'
 drivers/gpu/drm/r128/r128_ioc32.c:182: warning: Function parameter or member 'arg' not described in 'r128_compat_ioctl'

Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/r128/r128_ioc32.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/r128/r128_ioc32.c b/drivers/gpu/drm/r128/r128_ioc32.c
index 187bdc435cb54..cdeb1db872226 100644
--- a/drivers/gpu/drm/r128/r128_ioc32.c
+++ b/drivers/gpu/drm/r128/r128_ioc32.c
@@ -170,13 +170,13 @@ drm_ioctl_compat_t *r128_compat_ioctls[] = {
 };
 
 /**
- * Called whenever a 32-bit process running under a 64-bit kernel
- * performs an ioctl on /dev/dri/card<n>.
+ * r128_compat_ioctl - Called whenever a 32-bit process running under
+ *                     a 64-bit kernel performs an ioctl on /dev/dri/card<n>.
  *
- * \param filp file pointer.
- * \param cmd command.
- * \param arg user argument.
- * \return zero on success or negative number on failure.
+ * @filp: file pointer.
+ * @cmd: command.
+ * @arg: user argument.
+ * return: zero on success or negative number on failure.
  */
 long r128_compat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
-- 
2.25.1

