Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 149821EE4D9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jun 2020 14:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbgFDM4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jun 2020 08:56:23 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41833 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbgFDM4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 08:56:22 -0400
Received: by mail-lj1-f196.google.com with SMTP id 9so7118013ljc.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 05:56:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I+T4a/K2DGHf7cf/NXgqqInb1lYvZPk1WZQNcpjFcNs=;
        b=ZqoJQLlLkxAAMbM3/doprCXi+Dn/5yRafiHz8Pg0rbGJjTBJnSNYG+PLZMIHN1YJUZ
         dvuvK5BgsyG09FR98w4asDEADpalxvebixZVr47avbVBFvhtyx3TOLZbvQkrPsU0QTEw
         o/sLJgAJm+blLL9BKwS2UJGK7eYhLRu5NEyuoAUMobhWwrlK/LGYSP2Ov88rXdCVWP5Y
         WQ7jnSczPSF8R7FCz8lVotN3golnNsJX1zwZBVdkE+vxLohWy49GGKFncTX/1P0X9JdH
         /agR/RTRdHH/1nQ24zLeiSQZH/jWkiNX5NAn4C6Qs+2wFkOxnUxrtbOpxnCOGKxMOylS
         chZA==
X-Gm-Message-State: AOAM5307uR6G4ep34NdBuss4MsLHmsAgCb2UJ4X+hO9vy6Khbdbku2LX
        yTcL40qicmWSlE09VfYpfEY=
X-Google-Smtp-Source: ABdhPJw6Q1myIejdtGw90gfYiJl034AWpTCndAx+I/QkvRC+yqb3ztgKzVOIXycKxOxU3zt3iiSX+w==
X-Received: by 2002:a2e:811:: with SMTP id 17mr2055650lji.287.1591275381730;
        Thu, 04 Jun 2020 05:56:21 -0700 (PDT)
Received: from localhost.localdomain (broadband-37-110-38-130.ip.moscow.rt.ru. [37.110.38.130])
        by smtp.googlemail.com with ESMTPSA id l8sm1176676ljc.59.2020.06.04.05.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 05:56:21 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Evgeniy Polyakov <zbr@ioremap.net>
Cc:     Denis Efremov <efremov@linux.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] w1: Use kzfree() in w1_master_release()
Date:   Thu,  4 Jun 2020 15:56:17 +0300
Message-Id: <20200604125617.100046-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kzfree() instead of memset() with 0 followed by kfree().
The pointer is allocated in w1_alloc_dev().

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/w1/w1.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index e58c7592008d..24baacf8314c 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -71,8 +71,7 @@ static void w1_master_release(struct device *dev)
 	struct w1_master *md = dev_to_w1_master(dev);
 
 	dev_dbg(dev, "%s: Releasing %s.\n", __func__, md->name);
-	memset(md, 0, sizeof(struct w1_master) + sizeof(struct w1_bus_master));
-	kfree(md);
+	kzfree(md);
 }
 
 static void w1_slave_release(struct device *dev)
-- 
2.26.2

