Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6029727715C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 14:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgIXMqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 08:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727933AbgIXMpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 08:45:39 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0B6C0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 05:45:38 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id a9so3469735wmm.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 05:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KJfKXerNSEKSo/tEkzO5JgGVWrIgQodtAY9lROc1SIk=;
        b=s/uUUc9vZcPyDaIwzFU7hC+KpqYfQW2a3z7hfizdiiWCKoFPSIdp3w47+KYqfzanji
         i5sqd/FKVZNdr/yr1horCEd5OWKkSquVNSfIn72RwzSg5Zu2Ytj7JEzGEnhO4T9684s8
         7twMnVVI7k20QZfbQIgVqKP/GHn4lP2eCQJLJvZVphZusBA//NJV52Q8HUUNvn48JWxw
         HcsxzGL1/EmR2+cJF4uxuKYwt+DOEOGSjdtNm4nl0F1Ey1qnhyhUYvoZFBjHv9s091ta
         cd+FRaPTHM5P81/s+JwofUPVhm4SpV73q22JeeQhvJswbg5H90lD6PK5W7kVu0/OMr1t
         SQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KJfKXerNSEKSo/tEkzO5JgGVWrIgQodtAY9lROc1SIk=;
        b=S5dSRuA2rmfSvu1M3DUs514mI8Q2FYwWvnxbuWcISYNE/Tb0I0AfKcjDaT+zoOYsYv
         QFJfq5Qilv7ERPZofDjSbQ9vSQtZgOlPMt6tjFGoS2WzGdRarSmAsMqKAGsObWMkT07e
         DMAYeOkkrescGYa7tJqurz4LidlrRBXAOc+f0i7A/TU7nrje07aK22qelsc0/7jlVGVK
         DXxABz8tuaG3GRGJwVhC8jehRjlGo+qFMuKx/o52pExue+xRD6taD/SMuOTTGNqohIcp
         yBkfNDYolVqHNISFOToS9Yz4yPfMaUE8pekE4u1Azvh1R/EFubR+wzBrqM02TArrWXyx
         64EA==
X-Gm-Message-State: AOAM531iapaTzCSAasqTotiqCDZQTr/tTiJcuVM44vQ6ZX9UQGE0M3rC
        XfVasls8eh0tPW14ESjvMBNSRg==
X-Google-Smtp-Source: ABdhPJwgFXzP9fRSZgrd+6mRLupWSGMrScfsCLvTjPyT26BElZCELDelp2gTgVUG5NkE25JlMPpSWw==
X-Received: by 2002:a7b:cb97:: with SMTP id m23mr4429341wmi.173.1600951537270;
        Thu, 24 Sep 2020 05:45:37 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id 9sm3316834wmf.7.2020.09.24.05.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 05:45:36 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 03/12] samples: configfs: remove redundant newlines
Date:   Thu, 24 Sep 2020 14:45:17 +0200
Message-Id: <20200924124526.17365-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200924124526.17365-1-brgl@bgdev.pl>
References: <20200924124526.17365-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

There's no need for suplemental newlines in the source file - especially
since the examples are well divided with comments already.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 samples/configfs/configfs_sample.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/samples/configfs/configfs_sample.c b/samples/configfs/configfs_sample.c
index aca994e6ab87..d3370180bcce 100644
--- a/samples/configfs/configfs_sample.c
+++ b/samples/configfs/configfs_sample.c
@@ -17,9 +17,6 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 
-
-
-
 /*
  * 01-childless
  *
@@ -117,7 +114,6 @@ static struct childless childless_subsys = {
 	},
 };
 
-
 /* ----------------------------------------------------------------- */
 
 /*
@@ -185,7 +181,6 @@ static const struct config_item_type simple_child_type = {
 	.ct_owner	= THIS_MODULE,
 };
 
-
 struct simple_children {
 	struct config_group group;
 };
@@ -263,7 +258,6 @@ static struct configfs_subsystem simple_children_subsys = {
 	},
 };
 
-
 /* ----------------------------------------------------------------- */
 
 /*
-- 
2.17.1

