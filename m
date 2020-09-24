Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE7B277158
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 14:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbgIXMpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 08:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbgIXMpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 08:45:45 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299CFC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 05:45:45 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x14so3618822wrl.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 05:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1D7GqTQJFxXsyn7DWTc01QqE2JOl0Hr41fIV44hnm7c=;
        b=Gn95ZRj+9yHwuZREt2MON7SKioxYFDfGDRzKGDrmwcllTAS/47WqPZ57Q+9T4tL201
         /RCvsmOr9NC9C62YFIf1qZnjp11zruaXWApbHAPsVVPIHdkShFVMmY6VdNGBLAUkoiYd
         wK0GsRgZs+fT2bxZJg6sUCX0mlu71WP8p5KUMP21IRVbZsExiC3IPQuFRUtBUzEUKQh+
         bTbBzQ+vmRsxDE+ZM1XQ+O7vOLM+R7xYJ3pW+H28Ne9A9N9IYrTH01zIrdpkKLz/b/LJ
         ucIPc74fBHRfF5mNN43PCaT1wHEhvK5KzdcfD1oV3t9Bc5Xh8h9IxwoAf9L19RPDLJpb
         PNcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1D7GqTQJFxXsyn7DWTc01QqE2JOl0Hr41fIV44hnm7c=;
        b=X2yknyNML4UBeBTGpQLSDCiA+VIai2FJEhK5Dbq/tQPqjiEUmgDnJGonqAxmNiHyd3
         TNKdEKrQNZANLbCwGG/2JEq4+LEwF0jYkRk2kFfTBUAOiQJXLHCxauzlarHHUmH5Jd6f
         X7s6c01jQ8sOMgOna9nVqjwft5Jxvax1ECGSIEJ5QcJvTqD6xjqU7nBJxWZo0iYFiBS4
         w37iY++o7h2UU8vAcKDmT/WXDRmBMeEQqPd6nVtDIDGs+Z3VatBXpktLb/TDhsWbVI32
         XRHntuS2xIRWg4s3brW3cAtpcPQSk/NJwpZmCpGx8/m+igJMSFKQE3dMDkRW1zabJH8M
         R8iA==
X-Gm-Message-State: AOAM531lty0gaWKd+5V1pGpNWZu8INS0AhYPnIPR2i0Yk/kbBIucGnKn
        +81q49ZFyEoxNvIx12R4JrXV/pPzQoLIuA==
X-Google-Smtp-Source: ABdhPJwU3lGeE3skN0ek3Qn9WgEt6y0X0iOJ8R+bqKyHDAs1YlUYyAr0Oy01WwVa5g9U0VJ8Rz4hRA==
X-Received: by 2002:adf:e304:: with SMTP id b4mr4735036wrj.141.1600951543864;
        Thu, 24 Sep 2020 05:45:43 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id 9sm3316834wmf.7.2020.09.24.05.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 05:45:43 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 08/12] samples: configfs: don't reinitialize variables which are already zeroed
Date:   Thu, 24 Sep 2020 14:45:22 +0200
Message-Id: <20200924124526.17365-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200924124526.17365-1-brgl@bgdev.pl>
References: <20200924124526.17365-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The structure containing the storeme field is allocated using kzalloc().
There's no need to set it to 0 again.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 samples/configfs/configfs_sample.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/samples/configfs/configfs_sample.c b/samples/configfs/configfs_sample.c
index d89a1ffea620..20bf3b3e0f0f 100644
--- a/samples/configfs/configfs_sample.c
+++ b/samples/configfs/configfs_sample.c
@@ -192,8 +192,6 @@ static struct config_item *simple_children_make_item(struct config_group *group,
 	config_item_init_type_name(&simple_child->item, name,
 				   &simple_child_type);
 
-	simple_child->storeme = 0;
-
 	return &simple_child->item;
 }
 
-- 
2.17.1

