Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31AA82F73C7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 08:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731793AbhAOHmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 02:42:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731680AbhAOHmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 02:42:20 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6822FC061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 23:41:40 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id l23so4719874pjg.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 23:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=O+ju7GzUSXgEyONqw2hDG3TWhp+lRUaB6LNMrBnInUE=;
        b=c4aQ4cyO+IgwfmpdLIqX1q419sayYIGKJD7IUTfQz/7f8CHhBNqAF3Wzrjya7/P7hH
         TxL/eVFXPOVDkVf5wwZ7v4kMLifmKRHFlyLUHIGST1zgiVGMHkR4hNYOkf4lveAhA0oS
         1JhKVacOoCfPS5nlfV+CbFh2UMrIOLz53NDcGWOpf0HOehUB3NoZjDItyhGiAit5SYUA
         htG0JawNAtwSzaVx015CNsEZEjiDBl98T+2wbYYjqRGUd5LgPSdeAVGnCAz3lL9uOC12
         8ABg0muchJyr4U4WR8mCRraOsIinPmYPLeoNSV/pmoNU0DQDIiI2WD4AIRmyA6QaSdUH
         eMDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=O+ju7GzUSXgEyONqw2hDG3TWhp+lRUaB6LNMrBnInUE=;
        b=uD8gAK2QLqInYuLmYjpb7QQoNDhmX0Gr//RurCoGacQ+PkS+4XPyReUJJOzuHGPdj4
         qelo9kj3LKX+v7u5KOzEIN5UXp1wil4xPbMGzFPlP3DBHmUPWzaOrDs7mnOz8rgScenr
         FuEBIyvZViJCipeVWY6vFlVRwLPMlSEYypUX2skoMqJnEORTPKB/+AH8HBvRxgpb6uBZ
         ie5UHMwiS+pUXkbxeWT/EC7hSjuMnrJDLHpIIzUCN6eHbodnVlvgwyMtpwXW3LsmzSjl
         Rspn11WonMsEn1EwqnWace/pdI4svndFMt0HuBj7arK2hWUGHIbrnIFgDBu3K1isRy5W
         Qaig==
X-Gm-Message-State: AOAM531K0IUDx6NwdJkXL/b9CK1LgoWZgawRDyF3dQCbrEGmQ1slG/6K
        I/cDFsg7OmnqKz0yZAqvIJnpug==
X-Google-Smtp-Source: ABdhPJwsuvXD5qgp029828wqLpR1cX2SOM/CqGlwkz97B2cHjqrKqUR1XAm+Epc/0bMXU0qByl31WQ==
X-Received: by 2002:a17:902:a412:b029:db:cf5a:8427 with SMTP id p18-20020a170902a412b02900dbcf5a8427mr11747670plq.48.1610696499826;
        Thu, 14 Jan 2021 23:41:39 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id 4sm7656692pjn.14.2021.01.14.23.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 23:41:39 -0800 (PST)
Subject: [PATCH] drm/rockchip: cdn-dp-core: Fix cdn_dp_resume unused warning
Date:   Thu, 14 Jan 2021 23:40:43 -0800
Message-Id: <20210115074043.2944-1-palmer@dabbelt.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     hjc@rock-chips.com, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Palmer Dabbelt <palmerdabbelt@google.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     heiko@sntech.de
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmerdabbelt@google.com>

cdn_dp_resume is only used under PM_SLEEP, and now that it's static an
unused function warning is triggered undner !PM_SLEEP.  This
conditionally enables the function to avoid the warning.

Fixes: 7c49abb4c2f8 ("drm/rockchip: cdn-dp-core: Make cdn_dp_core_suspend/resume static")
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 drivers/gpu/drm/rockchip/cdn-dp-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
index a4a45daf93f2..063a60d213ba 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
@@ -1121,6 +1121,7 @@ static int cdn_dp_suspend(struct device *dev)
 	return ret;
 }
 
+#ifdef CONFIG_PM_SLEEP
 static int cdn_dp_resume(struct device *dev)
 {
 	struct cdn_dp_device *dp = dev_get_drvdata(dev);
@@ -1133,6 +1134,7 @@ static int cdn_dp_resume(struct device *dev)
 
 	return 0;
 }
+#endif
 
 static int cdn_dp_probe(struct platform_device *pdev)
 {
-- 
2.20.1

