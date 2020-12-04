Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7212CEB8F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 11:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387586AbgLDKBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 05:01:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbgLDKBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 05:01:39 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15314C061A4F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 02:00:53 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id k10so5016755wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 02:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2tAzY7WCaNY6Vvb3iCn3hNcrKN7+M/W71UmthXEquj0=;
        b=y9oNpFq53B5EE/jGbIaoeXp92gfaRFlFJ+UPv2gZuhy61Dfymwa+E5xnARYD5xyYIh
         cT9LIAaOPfBxXrJTKcZvv56ZuLOB1Mm2uXIcYTiHp9+KPneeEZrwBkCyPAxp2webvr3z
         bH6+51Io/3vAUgNHFSMYnmzRV87JwCZ5MArtCS+C5XyvHxBYBsajF104FfCbAvsugSPP
         p1NHMSaY1lDwmO9zDt6LevTtkgGvRki8d69UCN0Lf6wfdV/mBwkktDqEAHVQyDU99QYT
         7iZXr8/5iVgv6kCVK4GWaAEphAsor1rkbFN7nah/El4fnHx+pn7XMI7pcFsEWoJSp4vs
         m1ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2tAzY7WCaNY6Vvb3iCn3hNcrKN7+M/W71UmthXEquj0=;
        b=n8TznaznkxuHWdPNGmqlSSURg0xrwr0VpA/0Q+OYVv5Xgr0wQdzYhkBu7jeCLmztLT
         /yhP1euuShFB0MDoEsICQNXfgpW06+2bHuEnf9yWupbrYarW4hdQW3PBWTSE8J62fc19
         vwG1oICp4LckphTpTGjenB2v/RDLFfmGeJeNnIyNYKh1hgzbUTZO9vM96Lv3JWyjJQ8/
         lx4QXJ8U8WEE8JBRmsGw32Cw4tr6Z8JrmgsDyWRBipQ05Wc8LcugX1CyORqv2Ac4NFuq
         TVJB/23V8XUWAASSqMY87LtNlqYIyWqmE5m1wIv24vTkwQRPTyXYpgTsrgT/xHHVD5nE
         kT+w==
X-Gm-Message-State: AOAM530bv0L3HVA9MoUXXbFsyhON1ou+rTf/ZlSPEAH+t/gmfop1b+sk
        KgtGHeNZyzMTrM2GLWVTdmOGtVZWgL5B/w==
X-Google-Smtp-Source: ABdhPJyMkKZd+hHYtWJXI831sKyNYCE1HAvIvXiO3HEOSL37KCU7GqIbI/ozTXfLDA63kkTH6ni+PA==
X-Received: by 2002:a1c:9695:: with SMTP id y143mr3189757wmd.70.1607076051838;
        Fri, 04 Dec 2020 02:00:51 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-190-206.w2-15.abo.wanadoo.fr. [2.15.39.206])
        by smtp.gmail.com with ESMTPSA id v4sm2907436wru.12.2020.12.04.02.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 02:00:51 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 1/4] configfs: increase the item name length
Date:   Fri,  4 Dec 2020 11:00:36 +0100
Message-Id: <20201204100039.19159-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201204100039.19159-1-brgl@bgdev.pl>
References: <20201204100039.19159-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

20 characters limit for item name is relatively small. Let's increase it
to 32 to fit '04-committable-children' - a name we'll use in the sample
code for committable items.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 include/linux/configfs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/configfs.h b/include/linux/configfs.h
index 2e8c69b43c64..4f76dcc08134 100644
--- a/include/linux/configfs.h
+++ b/include/linux/configfs.h
@@ -27,7 +27,7 @@
 #include <linux/kref.h>   /* struct kref */
 #include <linux/mutex.h>  /* struct mutex */
 
-#define CONFIGFS_ITEM_NAME_LEN	20
+#define CONFIGFS_ITEM_NAME_LEN	32
 
 struct module;
 
-- 
2.29.1

