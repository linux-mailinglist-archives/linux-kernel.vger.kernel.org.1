Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 211CD1A5EFB
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Apr 2020 16:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgDLOZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Apr 2020 10:25:31 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33915 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgDLOZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 10:25:31 -0400
Received: by mail-wm1-f67.google.com with SMTP id c195so8393929wme.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 07:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S3d8GL8Hziepj2Ir5FLPVA9Tz/TkbgUVI34I8xIlOvI=;
        b=QDRUidQh2JuD2piovteluotX6uaVsXNBTwPV8W2GC+WHbbmp+tL7GzgEhhHjdcd+FI
         sWjrFKoWj0lX/UJ2FUNPXVB2iV1J/wmtFRNK0F/N30OGB/mUvoKKC4o3k72lyKk0L5wl
         18Z9MMgudylzbWF5P/Mss1keJAKPQ8NfRXpOoKFrJ7uPFr8FLdi3ZjEIPHIWZB1RV0jE
         T/ECcOV1Jg3eyiyk9mpQcjofWyYfp4AM9J1iLQ0+qqfcg3rdtlTM/80kpiJlmRcDM88D
         FpwvaF+mtHMo8uazyAlktuBqkbwenYU1jdSSoARMqEXmsNfr+3rWdAmAB+BJnjVJrG7t
         8piQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S3d8GL8Hziepj2Ir5FLPVA9Tz/TkbgUVI34I8xIlOvI=;
        b=kYOOTjC5WdI9majgR3PzXQfBVWEb0NfMh70UazdZ7s7l1ew55msCEDie32H5QLs22G
         9cfRt5WYwSn/YQ2ydAChf8hGirkiZrKHEtfvuwqXxkAkwmnH/30zcJI9bkvQoarnujeC
         6mS1+OkcsQ5ru2RezsAqocLsxXYbMC9Mi63g0BjUVO898l9+yLtTWLFGJwhSNoWZQ34B
         grw206NPDxgX+UB/Yz5Gc2ZV3ANID17qwfJ9Ccq493bI4YR/WlWErwt3O4jSpCWIBod5
         RgF/f9qWVHmXYySY33ATgweX/CDEbigZrHWSk2lQg6mhWkJFWnhtTSZ8/vF3O8+jeQpK
         Ucnw==
X-Gm-Message-State: AGi0PuacNggrlUPkWWNpde6ueOPdBnUmpjk9hM2AUe/xBcvGTt7v33cF
        3xB6d0+IE+E23BaxPjGBKdg=
X-Google-Smtp-Source: APiQypKCF740WjrxWdNr5PZO/1+70c6CpLSrLwxtyUyD3M5HUYON3NEAYfJ0zjvk1HYeO+9IjrKCEA==
X-Received: by 2002:a7b:cdf7:: with SMTP id p23mr14764855wmj.33.1586701509335;
        Sun, 12 Apr 2020 07:25:09 -0700 (PDT)
Received: from localhost.localdomain ([31.4.236.231])
        by smtp.gmail.com with ESMTPSA id y10sm6771334wma.5.2020.04.12.07.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2020 07:25:08 -0700 (PDT)
From:   carlosteniswarrior@gmail.com
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Carlos Guerrero Alvarez <carlosteniswarrior@gmail.com>
Subject: [PATCH] Staging: comedi: drivers: jr3_pci: fixed two warnings
Date:   Sun, 12 Apr 2020 16:25:08 +0200
Message-Id: <20200412142508.327-1-carlosteniswarrior@gmail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed two checkpatch warnings.

Signed-off-by: Carlos Guerrero Alvarez <carlosteniswarrior@gmail.com>
---
 drivers/staging/comedi/drivers/jr3_pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/comedi/drivers/jr3_pci.c b/drivers/staging/comedi/drivers/jr3_pci.c
index c3c88e6d298f..6bc87d3c6c3b 100644
--- a/drivers/staging/comedi/drivers/jr3_pci.c
+++ b/drivers/staging/comedi/drivers/jr3_pci.c
@@ -91,8 +91,8 @@ struct jr3_pci_dev_private {
 };
 
 union jr3_pci_single_range {
-	struct comedi_lrange l;
-	char _reserved[offsetof(struct comedi_lrange, range[1])];
+	const comedi_lrange l;
+	char _reserved[offsetof(const comedi_lrange, range[1])];
 };
 
 enum jr3_pci_poll_state {
-- 
2.26.0

