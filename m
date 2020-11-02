Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 071212A2A18
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbgKBLzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728828AbgKBLyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:54:32 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25931C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 03:54:31 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id b8so14282816wrn.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 03:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f8gLjdITMnVrqmugPHujVfTcLhAJYypSuHoOUIZ3ZBo=;
        b=mWH+ZQQAgp14+cj/4aWcz5wyp1y5NMCANvsq3s8s9N3Sq8eVsQU3M8Ps1MPkf8tRrF
         xHhYTWPJrEN0SQHqbii0X8vSGK7nm0ogfkrVvbgV1BszDKgOfMxPIJ4Es/iD0IBoxETZ
         g45CLKAquuwCebqciBSJBy1y1QKpZ+bLH3E/CZQshiOcg9ZeAqjt5Wa+lTEjQT0Vsc68
         LYGigy22aQifKtnFsgHyaWkj5drOQHXvkCYSS0F1xMre8ETMGdKznro0FtZFLKKYMRiD
         DSr7lJAomoISqF27930TRkEFteXoTwbm2+kqssGUgq4oPxoXQLw9AuSuI3eoaG0xBJ7O
         57Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f8gLjdITMnVrqmugPHujVfTcLhAJYypSuHoOUIZ3ZBo=;
        b=TEi/v9lzdGVnWLikpoJTXajJiVecfwYoxBaTAefBrTYxlTheXZLh4XV6Y9nVA1unT6
         hhCXI3KvFGJiIEGEmbWnrnHEIHmYOy42qEaRWP9nbyAMYJ6cUYB8FWi+XAxcoNqTHjGH
         25C3qL0VCJGLPtacpudQ+2elGa1P1iVr0vxRB0WP+LavNcnEpc3cvJC5LdxsamefFOGQ
         iXPrpbUGsK9C3iLb3pIuz816ei3+qy6C7wsvarvLgPkncOWhdkfzlqIwVbvhfVifsXU9
         4Ih9PTiOtqScIiD+5wkDP9463cYld/26Y/46qyYh3Iz/OAtuu8Rb4yTukLfUeodneEZr
         dLMQ==
X-Gm-Message-State: AOAM532yd96zmwAps15Cbwydi2A7CMHjSbQ8p+rpVvWyHQ344Cun9Z7b
        y33fnm8KBsYLQO3w1NDTtV4Kug==
X-Google-Smtp-Source: ABdhPJxYm1vBMc1aI9uxDeBprh/0v05ue74raBt0z9kuRgY4KkUn71bNqBpLQ7uWKiLP9Ns3g7g/og==
X-Received: by 2002:a05:6000:142:: with SMTP id r2mr13623709wrx.155.1604318069806;
        Mon, 02 Nov 2020 03:54:29 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id t23sm14284010wmn.13.2020.11.02.03.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:54:29 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     vigneshr@ti.com
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH 13/23] mtd: nand: raw: brcmnand: brcmnand: Demote non-conformant kernel-doc headers
Date:   Mon,  2 Nov 2020 11:53:56 +0000
Message-Id: <20201102115406.1074327-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102115406.1074327-1-lee.jones@linaro.org>
References: <20201102115406.1074327-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/mtd/nand/raw/brcmnand/brcmnand.c:1854: warning: Function parameter or member 'host' not described in 'brcmnand_edu_trans'
 drivers/mtd/nand/raw/brcmnand/brcmnand.c:1854: warning: Function parameter or member 'addr' not described in 'brcmnand_edu_trans'
 drivers/mtd/nand/raw/brcmnand/brcmnand.c:1854: warning: Function parameter or member 'buf' not described in 'brcmnand_edu_trans'
 drivers/mtd/nand/raw/brcmnand/brcmnand.c:1854: warning: Function parameter or member 'len' not described in 'brcmnand_edu_trans'
 drivers/mtd/nand/raw/brcmnand/brcmnand.c:1854: warning: Function parameter or member 'cmd' not described in 'brcmnand_edu_trans'
 drivers/mtd/nand/raw/brcmnand/brcmnand.c:1951: warning: Function parameter or member 'host' not described in 'brcmnand_fill_dma_desc'
 drivers/mtd/nand/raw/brcmnand/brcmnand.c:1951: warning: Function parameter or member 'desc' not described in 'brcmnand_fill_dma_desc'
 drivers/mtd/nand/raw/brcmnand/brcmnand.c:1951: warning: Function parameter or member 'addr' not described in 'brcmnand_fill_dma_desc'
 drivers/mtd/nand/raw/brcmnand/brcmnand.c:1951: warning: Function parameter or member 'buf' not described in 'brcmnand_fill_dma_desc'
 drivers/mtd/nand/raw/brcmnand/brcmnand.c:1951: warning: Function parameter or member 'len' not described in 'brcmnand_fill_dma_desc'
 drivers/mtd/nand/raw/brcmnand/brcmnand.c:1951: warning: Function parameter or member 'dma_cmd' not described in 'brcmnand_fill_dma_desc'
 drivers/mtd/nand/raw/brcmnand/brcmnand.c:1951: warning: Function parameter or member 'begin' not described in 'brcmnand_fill_dma_desc'
 drivers/mtd/nand/raw/brcmnand/brcmnand.c:1951: warning: Function parameter or member 'end' not described in 'brcmnand_fill_dma_desc'
 drivers/mtd/nand/raw/brcmnand/brcmnand.c:1951: warning: Function parameter or member 'next_desc' not described in 'brcmnand_fill_dma_desc'
 drivers/mtd/nand/raw/brcmnand/brcmnand.c:1977: warning: Function parameter or member 'host' not described in 'brcmnand_dma_run'
 drivers/mtd/nand/raw/brcmnand/brcmnand.c:1977: warning: Function parameter or member 'desc' not described in 'brcmnand_dma_run'

Cc: Brian Norris <computersforpeace@gmail.com>
Cc: Kamal Dasu <kdasu.kdev@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org
Cc: bcm-kernel-feedback-list@broadcom.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 2da39ab892869..659eaa6f0980c 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -1846,7 +1846,7 @@ static void brcmnand_write_buf(struct nand_chip *chip, const uint8_t *buf,
 	}
 }
 
-/**
+/*
  *  Kick EDU engine
  */
 static int brcmnand_edu_trans(struct brcmnand_host *host, u64 addr, u32 *buf,
@@ -1937,7 +1937,7 @@ static int brcmnand_edu_trans(struct brcmnand_host *host, u64 addr, u32 *buf,
 	return ret;
 }
 
-/**
+/*
  * Construct a FLASH_DMA descriptor as part of a linked list. You must know the
  * following ahead of time:
  *  - Is this descriptor the beginning or end of a linked list?
@@ -1970,7 +1970,7 @@ static int brcmnand_fill_dma_desc(struct brcmnand_host *host,
 	return 0;
 }
 
-/**
+/*
  * Kick the FLASH_DMA engine, with a given DMA descriptor
  */
 static void brcmnand_dma_run(struct brcmnand_host *host, dma_addr_t desc)
-- 
2.25.1

