Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3224424D7AF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 16:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgHUOvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 10:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgHUOvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 10:51:11 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1EE7C061573
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 07:51:10 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id p4so1595942qkf.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 07:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=C+aPe0VJdh+B0pBTgocZDloTWYDQSyjP+p964+SHgq8=;
        b=q5rm0nyNbbtlCNknMxxNQZd0Clz0zJirQmi6x+gTkmTUYKunlVcTNESBPGsUw06kat
         fyakI8HW1G/z4rGQXCl0T6dDoZ1TlqN5GMszlbNuvmT9W1XxCOdyVWwgGV/Xhj2GlHBz
         p0qOVFDsvraUxKpqMF0IxyUe0EsHsoPV3QzCgsIJe0f7sPeE0w3OOsLqTXPzNb2vQPoq
         +HasXzyNZ1n5nn//kgiGtpnnnYRIoWYy7GJi6e4Evj+YKyx955I0vL35MTgzSxxM+gW9
         CLf5gu32gP4ZTW3xPfiT+Ij03K2uGuIgKiLMqQv9rIUKGHeyxOiwSz1TnAXZ6R9MJke0
         HtJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=C+aPe0VJdh+B0pBTgocZDloTWYDQSyjP+p964+SHgq8=;
        b=Mm2SSZM2EOao778FJTLi0ZfZCYk/LoPwA/dLARi/NH/6sh1qDrOEke4CuZu7/RHrlh
         ISc2bCAdx0nXkZ09WBIOvtWn4ryLP4jlAxIAvDv2jA9577pBldyV1R99etKkRq6tvaiX
         2D6P6ybeyDM378gAXVfE3943Zn9lqyKprrQDVJtmO+Q7JalKfcoFjYbpRHeFdDf/Z8/1
         BV5AFrJxaLvO8YnDfNi7hjy0Q/PDVnEWBYTU/r9GsA6j0UV3EeJ1eCXSzsz4tjHCUWU3
         BOoQvG9Uax/dxxu5VecMP92RnZ5mvoFHWj7nGzaoEp0Cuf5As3gpyqClvVTCtkKbv5+L
         gdRw==
X-Gm-Message-State: AOAM530ciExvtbIRLohkyzq3JxO9AGTJaesRLBi12ovxgHAy4pdDUrvw
        lV8+iYPh4U4KarOBFWQ9kaE=
X-Google-Smtp-Source: ABdhPJyn2/MGokHnLBe4frIEbP/BV2XoRdjz7y6opoonj0Dp5qXpXCaGCnSAMFLYT9vhSsC/RDuukA==
X-Received: by 2002:a37:9987:: with SMTP id b129mr3110654qke.315.1598021470040;
        Fri, 21 Aug 2020 07:51:10 -0700 (PDT)
Received: from localhost.localdomain ([177.194.72.74])
        by smtp.gmail.com with ESMTPSA id w58sm2302302qth.95.2020.08.21.07.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 07:51:08 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     broonie@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2] regulator: dbx500: Remove unused debugfs goto label
Date:   Fri, 21 Aug 2020 11:48:23 -0300
Message-Id: <20200821144823.13404-1-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following build warning is seen after commit 8bdaa43808b7 ("regulator:
dbx500: no need to check return value of debugfs_create functions"):

drivers/regulator/dbx500-prcmu.c:144:1: warning: label 'exit_no_debugfs' defined but not used [-Wunused-label]

Remove the unused label and its associated error message.

Fixes: 8bdaa43808b7 ("regulator: dbx500: no need to check return value of debugfs_create functions")
Reported-by: Olof's autobuilder <build@lixom.net>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
Changes since v1:
- Add a Fixes tag
- Put the Reported-by tag in the correct position

 drivers/regulator/dbx500-prcmu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/regulator/dbx500-prcmu.c b/drivers/regulator/dbx500-prcmu.c
index 7395ad2105ab..8b70bfe88019 100644
--- a/drivers/regulator/dbx500-prcmu.c
+++ b/drivers/regulator/dbx500-prcmu.c
@@ -141,8 +141,6 @@ ux500_regulator_debug_init(struct platform_device *pdev,
 	kfree(rdebug.state_before_suspend);
 exit_destroy_power_state:
 	debugfs_remove_recursive(rdebug.dir);
-exit_no_debugfs:
-	dev_err(&pdev->dev, "failed to create debugfs entries.\n");
 	return -ENOMEM;
 }
 
-- 
2.17.1

