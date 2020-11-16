Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59B322B4E17
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387812AbgKPRmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:42:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387807AbgKPRmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:42:01 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FA8C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:42:01 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id d12so19622757wrr.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CpDMS+RHHV1rRQnMHYAjcZzCg3wY/F0STHOFtNum/rU=;
        b=QlKnEKn0xfMVNLUegEwHbQJPic1l06CYGWhnCfguIw3hOMik3KVBqH/YP2yC43asib
         f2UuSmKRJY3ecRRD++REiBaL5pWLlMxhw1cFZQCjed41kvQSU0SGSZtp9IwUC7oTxOY+
         IpjXbOfgYmytr6s4LWK+mUcADEQ3vuWFSK+Snb0r0qofwWKJlfopeqr6X/efE/o9nVwJ
         4SrgKh1saEWCXQLFmnbhf6Vie+X3ikuQBxtqtUHAqCklAxucNV3+wM8pAVjlhsr+aK/V
         ReN+ZybmaVikrjvBfRAKqXEBrF+Xi2uq1UDMrge12cB/vdXOFlCOoJIJ4k3963py/kLv
         o6RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CpDMS+RHHV1rRQnMHYAjcZzCg3wY/F0STHOFtNum/rU=;
        b=amXOgi2fjayVbByBtC4Pj0KRsLczEdcncyyU0W4Xwhfvz6/kXEnLowip9WEK4FLGT7
         h27PEwA9VK0l2RYkQqsSJ4EzJEycUkAMT3gR/LwZsgWLCK90aHDx0dualYcwB0E6X2qC
         4uXGk9PNgfNh7J9SiXX4QnnBDZ5178hhqVV5NVafSQfYnBoKHWDKqXFJm7Ea3bnRH2de
         EuDzt9MxztcDWQ66p72afDe9FfcGzllxBFlF+b3mxIQ+eBOGMgI2sLtjmj6zscKt/1sT
         6cdsYIbC2q+CD1YYBHqt7Eo2zD8gsK9gzfdZ+3BHUaHZw0UuVh9Vi1V6huxJZfUaTUbR
         yN1g==
X-Gm-Message-State: AOAM530gFGbkkpAChgKzzOCxJuVeCmTZxYUyPOWoUWRGl/4fmmLjIpPz
        LGa8J7kg17tB1EJ3xKzpOwlsDQ==
X-Google-Smtp-Source: ABdhPJyX0D9RJLsPH5aoo8t225qk75KVbJPi+9yZsHZ7TD39meFO6erQN2FqkzZVH2u+74DxgOk0TQ==
X-Received: by 2002:adf:c803:: with SMTP id d3mr20484445wrh.108.1605548520115;
        Mon, 16 Nov 2020 09:42:00 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id n10sm24667224wrx.9.2020.11.16.09.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:41:59 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 28/42] drm/selftests/test-drm_framebuffer: Remove set but unused variable 'fb'
Date:   Mon, 16 Nov 2020 17:40:58 +0000
Message-Id: <20201116174112.1833368-29-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201116174112.1833368-1-lee.jones@linaro.org>
References: <20201116174112.1833368-1-lee.jones@linaro.org>
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

