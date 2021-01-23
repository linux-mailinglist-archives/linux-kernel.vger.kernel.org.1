Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 507A03013A9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 08:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbhAWHHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 02:07:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbhAWHHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 02:07:15 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFA4C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 23:06:34 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id 11so5303484pfu.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 23:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=y32mYIIEVwOv7vWlZTkvjmrL+on8Qmqm9Gq8oiBE60A=;
        b=Clrp3T6WXbqiA/HQDW2+tBqgwTF06olwdV6coRSucnYCjDedAKVzgoybtvGadupVSW
         39Xp1h9GGg84eLeEE4Gh0fnesrsek68r6Gf4CW+Id3TY+KvGgssBIpZ20OODTPB+SMzx
         XbMUlA7ErxVX5j8D54WxvwYjzyoDa7ucHEM04BmQ2Ubus6dB8EAmMKKn6YLb/n5W8Sv+
         ljO1y6uvYmTcXyQLNhriA+ABY18yt2mqojJQbocvSfIks1vrFoAS3yUt2Sd8sXC3Lj4O
         YGg/IYR9PPLTwmwcq1HmDoY0ec7tCiL4IQ3nV6U7+4rgSThUmYUeSm0/wnMkrfttXAPH
         5Q5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=y32mYIIEVwOv7vWlZTkvjmrL+on8Qmqm9Gq8oiBE60A=;
        b=pWwI2oD1vJOwgKEtNg7YUVJ4VakVzcl8Ex51KcezdVoi7qOOzdQ6SYCBKwHPaZbw9q
         sxz/rXqJ2Mn6/Pliu7RyR+4jqx0yaCR0vpArh7+0ymbDpopyQudfQT+nhula1IcDh5Zh
         1aXGoK1LBjWh4Zn32os+zBJNOToJ2s8AMXcZaU0buUoqlnynaIuMlduWxreBMRU2sieN
         vI2zXHNI5vgeiIdtyZ3fS/F7ZJfui9Q+Z81tphDsO1CTGVIvXK1U+iTbQWIIvgcfIw6T
         +dyKkmL0689pw+4ylKWZDjsNuRZihDvbs4A1ZXZg93NBSWdP/fGZsyvFhWJnI1RrzwoM
         9ALw==
X-Gm-Message-State: AOAM532NjaSghpGNnIZRi7rJryANr3p7z0qQ/QiX+Y7J2GCcmob9ogGn
        cWqpooMGFbitydHn9h150/+ODzCz3C8=
X-Google-Smtp-Source: ABdhPJyccqNpO3KUrvO0Ku7AIG5/eEe0KkEicd6jjV9SLeLAOstriEMqOUGaFGhDQb/JLHeDnLg74w==
X-Received: by 2002:a63:e5e:: with SMTP id 30mr3250907pgo.181.1611385594280;
        Fri, 22 Jan 2021 23:06:34 -0800 (PST)
Received: from localhost.localdomain ([125.227.22.95])
        by smtp.gmail.com with ESMTPSA id mm4sm11465132pjb.1.2021.01.22.23.06.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jan 2021 23:06:33 -0800 (PST)
From:   Stephen Zhang <stephenzhangzsd@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Stephen Zhang <stephenzhangzsd@gmail.com>
Subject: [PATCH] mm/early_ioremap.c: Use __func__ instead of function name
Date:   Sat, 23 Jan 2021 15:06:27 +0800
Message-Id: <1611385587-4209-1-git-send-email-stephenzhangzsd@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is better to use __func__ instead of function name.

Signed-off-by: Stephen Zhang <stephenzhangzsd@gmail.com>
---
 mm/early_ioremap.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/early_ioremap.c b/mm/early_ioremap.c
index a0018ad..164607c 100644
--- a/mm/early_ioremap.c
+++ b/mm/early_ioremap.c
@@ -181,17 +181,17 @@ void __init early_iounmap(void __iomem *addr, unsigned long size)
 		}
 	}
 
-	if (WARN(slot < 0, "early_iounmap(%p, %08lx) not found slot\n",
-		 addr, size))
+	if (WARN(slot < 0, "%s(%p, %08lx) not found slot\n",
+		  __func__, addr, size))
 		return;
 
 	if (WARN(prev_size[slot] != size,
-		 "early_iounmap(%p, %08lx) [%d] size not consistent %08lx\n",
-		 addr, size, slot, prev_size[slot]))
+		 "%s(%p, %08lx) [%d] size not consistent %08lx\n",
+		  __func__, addr, size, slot, prev_size[slot]))
 		return;
 
-	WARN(early_ioremap_debug, "early_iounmap(%p, %08lx) [%d]\n",
-	     addr, size, slot);
+	WARN(early_ioremap_debug, "%s(%p, %08lx) [%d]\n",
+	      __func__, addr, size, slot);
 
 	virt_addr = (unsigned long)addr;
 	if (WARN_ON(virt_addr < fix_to_virt(FIX_BTMAP_BEGIN)))
-- 
1.8.3.1

