Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 602072A817F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 15:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731525AbgKEOwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 09:52:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731315AbgKEOw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 09:52:28 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3A9C0613D4
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 06:52:27 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id 23so1282966wmg.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 06:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CpDMS+RHHV1rRQnMHYAjcZzCg3wY/F0STHOFtNum/rU=;
        b=QpushnzWopYXqm5YWwBvN6+FQaZHUZjNp1tHAUM5Ag2u5db4kXa+UJ3Z4yl/TOmdD1
         7T39shHAWcJiQRYKkCkciEbSRLy+kOmviXG4DtQVSWEgKSXKv6NFk9JKADhbaGGEZJAA
         gOR7hTYFkaC0n1XYj/O1NWU4cb3MOSx4JPotMGNGBBBgUy9K2NK2k9ZFVySebV+iywE1
         ekymQgI26V3+xOhGpSd0IXPly/an+QOpGzOAbVFqI8PeMMkoBWPrSIQ4gtFJRQR3c7NR
         DL62I58XDWWnnY0xsrxuDBjVmUGHkMYUoJYEyhvi3yBjSU1fQmaNCGo139n4SjKDzreO
         iqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CpDMS+RHHV1rRQnMHYAjcZzCg3wY/F0STHOFtNum/rU=;
        b=n7Erq9YW6oAt3qR14zDm+LhyVbibPO2MocUnpwocnYGQUmZcgq2A7FncqBZ3PCPQej
         WKYfSMeWvafasSh0+YwgmZYehpe/OUV+kaad8c/8FPoxCW/kwn5wDjGA0pxzg1eGNSsn
         kI6QEJPGyBH/khXC//lwt7LJ16TY44Yx0aT4IY32Q2gC+qYUk/M/dPGR1QpesRVB9bGL
         PNGzq6x8dTZ6nPA1tbwp1ibsk6MXZM4+S5IxH4dq4Ox8zvN954OuRPT3jqK6nQialBSb
         8qxghJne03hn2LmCRsoD4PS1g8L4m6Ro4/qBJH2COuNHp+U1nfb62lDehfJyDDlimTWj
         ZZoQ==
X-Gm-Message-State: AOAM5329+3lKgVdlktNOKoPcWvEOJSMfFzipf8z4rgAOCRy5A1jqV5gA
        7vOXZzbeib7hzX8OMOOl7hkws808hUuwRKdA
X-Google-Smtp-Source: ABdhPJyvqYkwE2uGejo6SM8lDSIcZCLWdzpd2TkAJxJyZGijBu5DUEM0XrGnnJJ+a8vBsZQGeJGfjw==
X-Received: by 2002:a05:600c:22d3:: with SMTP id 19mr3311106wmg.161.1604587945893;
        Thu, 05 Nov 2020 06:52:25 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id f5sm2631243wmh.16.2020.11.05.06.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 06:52:25 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 09/19] gpu: drm: selftests: test-drm_framebuffer: Remove set but unused variable 'fb'
Date:   Thu,  5 Nov 2020 14:45:07 +0000
Message-Id: <20201105144517.1826692-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201105144517.1826692-1-lee.jones@linaro.org>
References: <20201105144517.1826692-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/selftests/test-drm_framebuffer.c: In function ‘execute_drm_mode_fb_cmd2’:
 drivers/gpu/drm/selftests/test-drm_framebuffer.c:333:26: warning: variable ‘fb’ set but not used [-Wunused-but-set-variable]

Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/selftests/test-drm_framebuffer.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/selftests/test-drm_framebuffer.c b/drivers/gpu/drm/selftests/test-drm_framebuffer.c
index 2d29ea6f92e2a..789f22773dbc9 100644
--- a/drivers/gpu/drm/selftests/test-drm_framebuffer.c
+++ b/drivers/gpu/drm/selftests/test-drm_framebuffer.c
@@ -330,10 +330,9 @@ static struct drm_device mock_drm_device = {
 static int execute_drm_mode_fb_cmd2(struct drm_mode_fb_cmd2 *r)
 {
 	int buffer_created = 0;
-	struct drm_framebuffer *fb;
 
 	mock_drm_device.dev_private = &buffer_created;
-	fb = drm_internal_framebuffer_create(&mock_drm_device, r, NULL);
+	drm_internal_framebuffer_create(&mock_drm_device, r, NULL);
 	return buffer_created;
 }
 
-- 
2.25.1

