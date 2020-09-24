Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E15A1277157
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 14:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgIXMpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 08:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727937AbgIXMpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 08:45:46 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CF2C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 05:45:46 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k15so3638026wrn.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 05:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sTmTg/1RYkDS49c/XN57kUEgCHYn2RNoEJqK8zaSw3Y=;
        b=YQTL/DbH9ENhyE8aHjMrcdCRT4rkxXtuEOj1Izdbmx1RedKDcaxrilxqtUbc8cDrsn
         XlEQXMVnl5GfUootO4ZK0JAdUoJ+UZAHroup0GweyKfDhW3R+aCjETntW1iE/QCOgoAU
         riBCQCV8DrwyKX0QsSbY6pDJM5ZrJGYjw403EujLHU1h/VZH+xzHEOcCMGW9PkeiTk4H
         +QoIhXXGWcJDB6pGfnvKlTautV/PwP74Saqdd7bc2d97vi7+y4OdqvTpie/ia86HWoTJ
         nCY4UufJw4pwJu7V565g/li39KzmqKrfbzEtc8U4bq8DIzKgazAoukuxax5m6JVm4X1+
         j5dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sTmTg/1RYkDS49c/XN57kUEgCHYn2RNoEJqK8zaSw3Y=;
        b=tqhLWyMwzpo2tjpZQm7/tjEvU47t8YsCBOUdZK08ItsYtdVZ4Tbc4zybIFNMw9Igdr
         UGNlybXVGtry8KkO46seXdics3NoWEIGF/nYumO8YhiUSwN0312T4wQ5aw2z4ZwywsJe
         c4kIwUIVEmWtE9tBc/XnII+J+QvDwevBqmI5hSWVRvT/jXLQ6thuM7TUAesx6CPNTrrY
         0+80mtg9HNjDHLE8/ulzsvRs7G+5Ei0Ri6EXrEIwaKNpQN8od5aCwAINW/YHoslto1HG
         mMewfDmZm69KNjHzO49lkplwiqyLRPsE+5KUXfkBP1uF/ei9RyN8RCO/ZHNsJWp8ofWn
         ST1w==
X-Gm-Message-State: AOAM532q5SwRCeykCbvi9/0C0sMRdTSWyc37Y1+2vr4uslKqW1kPpcNq
        CNM8Aswvhv2Pc6hhBkt8aPl69w==
X-Google-Smtp-Source: ABdhPJxrH7qba8OemWrt6QWD5d/EEi3jwOhSvplfMRBppbjrpMx8JthKNLQH2HuSPezeyCVa+SB5jQ==
X-Received: by 2002:adf:ec4f:: with SMTP id w15mr4704262wrn.333.1600951545045;
        Thu, 24 Sep 2020 05:45:45 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id 9sm3316834wmf.7.2020.09.24.05.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 05:45:44 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 09/12] samples: configfs: prefer sizeof(*var) to sizeof(struct var_type)
Date:   Thu, 24 Sep 2020 14:45:23 +0200
Message-Id: <20200924124526.17365-10-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200924124526.17365-1-brgl@bgdev.pl>
References: <20200924124526.17365-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

It's better to use the size of the actual variable than its type when
allocating memory. This also has the benefit of avoiding a line break
here.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 samples/configfs/configfs_sample.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/samples/configfs/configfs_sample.c b/samples/configfs/configfs_sample.c
index 20bf3b3e0f0f..220aee7075b6 100644
--- a/samples/configfs/configfs_sample.c
+++ b/samples/configfs/configfs_sample.c
@@ -185,7 +185,7 @@ static struct config_item *simple_children_make_item(struct config_group *group,
 {
 	struct simple_child *simple_child;
 
-	simple_child = kzalloc(sizeof(struct simple_child), GFP_KERNEL);
+	simple_child = kzalloc(sizeof(*simple_child), GFP_KERNEL);
 	if (!simple_child)
 		return ERR_PTR(-ENOMEM);
 
@@ -262,8 +262,7 @@ group_children_make_group(struct config_group *group, const char *name)
 {
 	struct simple_children *simple_children;
 
-	simple_children = kzalloc(sizeof(struct simple_children),
-				  GFP_KERNEL);
+	simple_children = kzalloc(sizeof(*simple_children), GFP_KERNEL);
 	if (!simple_children)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.17.1

