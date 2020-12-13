Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41F6C2D8EC9
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Dec 2020 17:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437453AbgLMQdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 11:33:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730046AbgLMQdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 11:33:32 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54190C0613D6
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 08:32:51 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id i24so14584409edj.8
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 08:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=CaMA9RW5UtaplKUmsQNUohW2cKU7SkQPGntX3Q5iuX4=;
        b=TJFilUYHE2iJDtdrpTCgCza67kS9Ayk6PYibDjmLcoN8r7Yg6bRfzL7pON5le7jkRj
         6H+uG5ZYrPd8w55+aJvTghf18n2LJkCmzB+z6qpC+T7gV7BFPtI9rDQCMVH2C8/KQvry
         kMG2vyLyOTrDOLJBL/AzrpImh2cosKfoWLKDMUHGmq9Jr0BZWSz07uUjV/TcLgYjQ0Gl
         piPrx/RxKKVw46XyxPaAZRMMQ7SX3OgGUElxLFe9HLC0WnjBhsMmQmXJRM1VpCxnIsWm
         tNQedvIXhq8TQLNLmO1zQTsnwn1sTEJIo599xml57IPj1chXox7Mg3/nAvarymI+gMXA
         Etow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=CaMA9RW5UtaplKUmsQNUohW2cKU7SkQPGntX3Q5iuX4=;
        b=M8vekQxrd97dUTcUxxcxhiuLCudjPGJuKpvWQJkzCUS7b50MrzWWHnNX9TdYFOPBLJ
         GBRr+AfrUkGoSemWSwdbohjvs5aJ0xhkLxQxbsJ0pxI/fgTPft/HPSElkXOoF7MWk3pn
         P35X2/LXwZ9PjubdCJ+B8y5kiz7JiYDNxSOJaIy8W9ONxbx4c25nx+/1q3EdPkAG1IVm
         ShFIzhJCJmMCZv5Eznt6HAb0UpEiImXQ2ZaMpGT8plRLCRVNZJnEcntmMXpmygQCpH6b
         OPMOb0BbNtOdIeVNEr/MJoWl91RDkOk/9Zy5oAYrGYdO+7smlFTj/f/An0bD14SEleTS
         bgQA==
X-Gm-Message-State: AOAM5318RJ0xDDf4z0izrv15Oagy0PHoXjjHkfH9J/GPfevprTlx7PS1
        dmHBk4WoHBdIirjLnH1wCX3EkmpV5rU=
X-Google-Smtp-Source: ABdhPJw6ZtNa4IRYK7c5+vO+ev1wTHdXB6evuKIfRG7TTlUcQOVhLar8KvOMzRrkjsejNTlYpdYXQg==
X-Received: by 2002:a05:6402:1041:: with SMTP id e1mr1736396edu.54.1607877169581;
        Sun, 13 Dec 2020 08:32:49 -0800 (PST)
Received: from ?IPv6:2003:ea:8f06:5500:39f9:b9d0:a27c:7a5d? (p200300ea8f06550039f9b9d0a27c7a5d.dip0.t-ipconnect.de. [2003:ea:8f06:5500:39f9:b9d0:a27c:7a5d])
        by smtp.googlemail.com with ESMTPSA id j27sm11871297ejo.61.2020.12.13.08.32.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Dec 2020 08:32:49 -0800 (PST)
To:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Barry Song <song.bao.hua@hisilicon.com>
Cc:     "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2] dma-mapping: add unlikely hint for error path in
 dma_mapping_error
Message-ID: <39581f9a-0066-ad98-094d-d41082145e23@gmail.com>
Date:   Sun, 13 Dec 2020 17:32:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zillions of drivers use the unlikely() hint when checking the result of
dma_mapping_error(). This is an inline function anyway, so we can move
the hint into this function and remove it from drivers.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
Split the big patch into the change for dma-mapping.h and follow-up
patches per subsystem that will go through the trees of the respective
maintainers.
---
 include/linux/dma-mapping.h | 2 +-
 kernel/dma/map_benchmark.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 2e49996a8..6177e20b5 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -95,7 +95,7 @@ static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
 {
 	debug_dma_mapping_error(dev, dma_addr);
 
-	if (dma_addr == DMA_MAPPING_ERROR)
+	if (unlikely(dma_addr == DMA_MAPPING_ERROR))
 		return -ENOMEM;
 	return 0;
 }
diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
index b1496e744..901420a5d 100644
--- a/kernel/dma/map_benchmark.c
+++ b/kernel/dma/map_benchmark.c
@@ -78,7 +78,7 @@ static int map_benchmark_thread(void *data)
 
 		map_stime = ktime_get();
 		dma_addr = dma_map_single(map->dev, buf, PAGE_SIZE, map->dir);
-		if (unlikely(dma_mapping_error(map->dev, dma_addr))) {
+		if (dma_mapping_error(map->dev, dma_addr)) {
 			pr_err("dma_map_single failed on %s\n",
 				dev_name(map->dev));
 			ret = -ENOMEM;
-- 
2.29.2

