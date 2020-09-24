Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0ACF277155
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 14:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgIXMpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 08:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727940AbgIXMpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 08:45:49 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A41C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 05:45:48 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id d4so3384440wmd.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 05:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2V5M+FDSZDWDy1Ha1cb7iiLxGSjLMdxiz3Jy9cWQLbQ=;
        b=ne3gitgO2+2i74emuGk61aVvjRPoFBsnblAOwIivO7TEqUfOBqoO+flY957SF1x9A5
         ddgYL/ycc5ZCuFLPEmBtE29rd7sONgPPv3VPexw6pevX+O0tBc7tHdcmprVWlc/CtpIy
         DgDM59uni9bMLRBPufjK5H/AHWgJt/3LYcIOLZSTY8HPBIDPc+Kf0R3qsQdvQHr9bHoJ
         8Et0z7udaSiDzb/x6RaIVUAE4mNjnXW41CpyZxRl+CdiODiIAIyBm/8AEpSFjPUkONp9
         GdHSSvhZdPLAbRB+b7DjscQxAXPhuPYYXcB8DOFv8sR44Yy1bDaHqBcXcGlMg1w6OcIb
         R7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2V5M+FDSZDWDy1Ha1cb7iiLxGSjLMdxiz3Jy9cWQLbQ=;
        b=WVhnlz6W9rlMFZFeTB4ZQVntxOOYVXyiQ6jbkDkQpAQHnPDWzQ9gA/6Y73E55D1yMy
         HDRkrG51u1MC5Y679pJXEJ4rB9lKXX6m8ZJYq5WOr8ThYxQtalVOzurvRdWKv2Au9SpO
         wl/HiGXv84GOwEuhn6ArjTfZHc1qx9TAP87Jq0WKfEfd7ljjwbeLWF1GSIUrmy5/1EGl
         Fxwic7JLyt89evKHClzocn0zF6LhN0VoC9zZIAtd4J1q/03GnUyzXE1JYKEBG9LTEcig
         AYz9Ptcr2KqzOGNgopxoEDWHvs4zgoS5XKZgEU8MmSX+H9dklI2J50tQZ4f6XCFLvcHU
         u1IQ==
X-Gm-Message-State: AOAM531kH1Gxdo60olRY4a6kL95mgV8/lqfP7afFfpo6QAb6lIYEGgKA
        iIHKKMK4nFjTc7k/QyspLaXYmI5smUhNmg==
X-Google-Smtp-Source: ABdhPJx3ngzVAfyfUFKOqIisUThFLdcKRKFT2tThS8cCgccRZtw0UZd5in7Sie4Of/IM7mCuIFFJ9Q==
X-Received: by 2002:a7b:cd88:: with SMTP id y8mr4524508wmj.24.1600951547427;
        Thu, 24 Sep 2020 05:45:47 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id 9sm3316834wmf.7.2020.09.24.05.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 05:45:46 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 11/12] samples: configfs: don't use spaces before tabs
Date:   Thu, 24 Sep 2020 14:45:25 +0200
Message-Id: <20200924124526.17365-12-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200924124526.17365-1-brgl@bgdev.pl>
References: <20200924124526.17365-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The copyright notice alarms checkpatch.pl of usin spaces before tabs.
Fix this.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 samples/configfs/configfs_sample.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/configfs/configfs_sample.c b/samples/configfs/configfs_sample.c
index 49c87ca58116..da4e0f4ec20a 100644
--- a/samples/configfs/configfs_sample.c
+++ b/samples/configfs/configfs_sample.c
@@ -7,7 +7,7 @@
  *      macros defined by configfs.h
  *
  * Based on sysfs:
- * 	sysfs is Copyright (C) 2001, 2002, 2003 Patrick Mochel
+ *      sysfs is Copyright (C) 2001, 2002, 2003 Patrick Mochel
  *
  * configfs Copyright (C) 2005 Oracle.  All rights reserved.
  */
-- 
2.17.1

