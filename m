Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB3E27715F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 14:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgIXMqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 08:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727932AbgIXMph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 08:45:37 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4684AC0613D5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 05:45:37 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id a9so3469653wmm.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 05:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W6VETlQMhinsAFnrxhicyZwDvz0AKVapVLUfWYhRvtk=;
        b=Wp+IvUvDyl3rqovUnETmm0ji0J8pQpAGA1dqkIDftOigWWAulWVGXKNw+qvsaVEVhT
         wFDOjo9K7Q2CG30TeWap3E0Y9Zpzp0GICh6TEJHmPtZG3mQyvy8k+aGR/86xiBro6xNL
         Gsp7GP3FmkNX1wyqaxsZZHTpyyHkjSKKwW7rRzPGL1pn0Jfljo+ct7HhudPY5DUjEgYr
         tiLiWK9TmK3aHfII6GVpc213DSBIJp33rwNYsVWa3TJIAlCmb/Pfmd0/MpBqSqv/Y4O5
         bwZBPgCWFP+vinjeudF5uMKytRGGbMdXSBrDEjJoc8uqqaHxP8Kt3ZUyl5S2iTAunC7U
         ZX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W6VETlQMhinsAFnrxhicyZwDvz0AKVapVLUfWYhRvtk=;
        b=YxiJfKRgMlabSbDnZKp8f8h6UNPgUaV53mQ4zD1keZ01PlEGCUvI18ZqXH52MTJlma
         UN98lsSChi4PtPZXWonKdGnc5Uqn/GXCOL6e+Uq/jikhtyE2uY3pMYxZQmf4eOX7YeqF
         kABh/OzXzUsIx6U4nDW7qJL5nnPwV1Ne0637aP8CBCrrqLnyeyZoK3xqPBo9+HKuFRWl
         Zl0qxdLJIKmtVh3o8JXGSLSnJRQ1UuJTb5IchTvPmbERa2KnYNDxvOJJw/DmX3pFpMrf
         +El7KhazHuqmNnZhbYYnQLwi9pTiWpetoOJcMnhtD4mrDrw/2oQNW/fDPO4a77cQcrwE
         ti5w==
X-Gm-Message-State: AOAM533Wmcus/eRJv339xLks45gy0VGq8rSLFVanDox+NBoBYN/AIYsb
        O910adbwuXGOW8iyDy/SDD4UBg==
X-Google-Smtp-Source: ABdhPJx5wqOD6hLUt0Qyl+/kNifG9KTG4Nvy3Qsj3YTYetDNSzlU+Vyq0GOQIl6un0NqcXDgFV28EQ==
X-Received: by 2002:a1c:488:: with SMTP id 130mr4412875wme.164.1600951535992;
        Thu, 24 Sep 2020 05:45:35 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id 9sm3316834wmf.7.2020.09.24.05.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 05:45:35 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 02/12] samples: configfs: order includes alphabetically
Date:   Thu, 24 Sep 2020 14:45:16 +0200
Message-Id: <20200924124526.17365-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200924124526.17365-1-brgl@bgdev.pl>
References: <20200924124526.17365-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The preferred coding style is to order all includes alphabetically for
improved readability. There's no need for the configfs header to come
last.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 samples/configfs/configfs_sample.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/configfs/configfs_sample.c b/samples/configfs/configfs_sample.c
index e2398d94e8da..aca994e6ab87 100644
--- a/samples/configfs/configfs_sample.c
+++ b/samples/configfs/configfs_sample.c
@@ -12,11 +12,11 @@
  * configfs Copyright (C) 2005 Oracle.  All rights reserved.
  */
 
+#include <linux/configfs.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 
-#include <linux/configfs.h>
 
 
 
-- 
2.17.1

