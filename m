Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3789F304DA0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 01:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732909AbhAZXMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 18:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729180AbhAZEy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 23:54:59 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59651C061573
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 20:54:19 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id s15so9139058plr.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 20:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a69BMfJQ9E4oHULh93aNwSAV8hiyHTyNrIA1sCczbko=;
        b=mNfngmN/q7ViCvgKIo8bo3NBWuQB90CjvHeINbBALSaZ9eQfiKiHDbOkzIlmSFVJsr
         S1Swe0LlSEQdH19e70KOsf8TqXZl6qUlsmhl8B8BadbI4RpVDG+3PMVsTsXZljl9fTez
         nDIu2af4HTSc7/qULyahGyHx7G1jqNlinR55/bJusztTdX4F96cnWe64sDxGUjr8mP2x
         0G0mp360Y5bYDAsNb62nazgCY6L9MoSuAUCEJk/uXxsqC3EJv70Yq6f0FbtwQ6O/rE06
         aJmTWlzwFplZhScxww31Fji6SUnUGDFL3PUz1KF5NEBsKS+eF7yMd1x0TjLd/fyG1J1s
         eQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a69BMfJQ9E4oHULh93aNwSAV8hiyHTyNrIA1sCczbko=;
        b=sVRa+4KKIyLTzTnL0Y1BAxCiCuogpuht3b4j3fxi0oIsW43zK8C2lazASYYP/Tob9Q
         KPj4+6cdMnXmJbMqt+p6d0+tKidhbnni6MDs2fcIQXLcdO8p8zvJyIGHdz9Urqk6euGJ
         Ss04hAj2KewGnXXNEzGdQ3B6kVOoBUm2lmJ9sJLWSBazueRM//yddkfXtQX6FRxJdJLf
         DiUL4pU1k7haiCWkqYtGqX/yo3d0ayieI/f0a6+mdhh9dPcpc6u9THi80B2BhEc4l+UQ
         LUGaKjy1wEdifNuEO4WbYWsS8yya8VdtItHOtnBHqJ7PhkSv6Ss2QAznRWUdq8uEkv0n
         UCQw==
X-Gm-Message-State: AOAM530nEQnWnA6NLhMPSok0nAQcgblkYx9koc7oFFPNaqQX1TyLXRVG
        VQtsnbua0Vb1WM31PraZKIE=
X-Google-Smtp-Source: ABdhPJwSa2nXR/aKoIRxXCZWsKkoMqrHw7m/qOUyKn2wDN2zSos1dL5DiF7wqcAQ5jV1WhPBUCJ4ow==
X-Received: by 2002:a17:902:7c10:b029:e0:7a2:38c7 with SMTP id x16-20020a1709027c10b02900e007a238c7mr4251545pll.79.1611636858988;
        Mon, 25 Jan 2021 20:54:18 -0800 (PST)
Received: from bobo.ozlabs.ibm.com (192.156.221.203.dial.dynamic.acc50-nort-cbr.comindico.com.au. [203.221.156.192])
        by smtp.gmail.com with ESMTPSA id w184sm18803382pgb.71.2021.01.25.20.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 20:54:18 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org
Subject: [PATCH 2/5] kernel/dma: remove unnecessary unmap_kernel_range
Date:   Tue, 26 Jan 2021 14:54:01 +1000
Message-Id: <20210126045404.2492588-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210126045404.2492588-1-npiggin@gmail.com>
References: <20210126045404.2492588-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vunmap will remove ptes.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux-foundation.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 kernel/dma/remap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
index 905c3fa005f1..b4526668072e 100644
--- a/kernel/dma/remap.c
+++ b/kernel/dma/remap.c
@@ -66,6 +66,5 @@ void dma_common_free_remap(void *cpu_addr, size_t size)
 		return;
 	}
 
-	unmap_kernel_range((unsigned long)cpu_addr, PAGE_ALIGN(size));
 	vunmap(cpu_addr);
 }
-- 
2.23.0

