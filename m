Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C79612A9F3A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 22:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbgKFViI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 16:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728330AbgKFVhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 16:37:19 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7751FC0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 13:37:18 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id a65so2633738wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 13:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ADB+AAqc36iIolfkYxxVJScxpF6foqJc0x2xHW3DbKM=;
        b=s+8pnqnqeZzO/YvzdMf3SHPtNAs0DYXQIadajMOMBygCqYgl4arX9fKT8xfh9F6FWA
         krlAql03lX1koQn7sL8jA9C0sl0pC+e17S6IIxL7nbfSrHk8Ql62MdPsXSHY0dM5O+et
         fBgi6TmKbskI7PiXbHEJg3W5bCpOwddDKnhlF/SbBX57ZKGgfcvsydtRLXQ592qShBDD
         sz2VAWxxZjlEUVZvR43ToUMC4aBtYGVf6a25J6PjEitmVoNGfcGLnoialDb8y7hlC+YC
         dpiHl9Pjk5OMw+OMprTyJC2oRxOxXoc99gaNlgBtGV17qTMOSVpGAK8wcgafgdHTpDqz
         wG/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ADB+AAqc36iIolfkYxxVJScxpF6foqJc0x2xHW3DbKM=;
        b=YzmPoDXJY5yNArFLqvURGg7WW5pEBy0lMBzitAjHvvjH9VMu0Led+utDtfrt3P3knV
         a9928BdYPPPh8w3B463yIBKuVcQwqpsat0D+McpwJcuTbDYSdGtyCpmm7I7pSaFqRIPL
         p8oLY7I6MNWHyt6H1LialOIEW4phW+3+CFjXAEbfcuNzt0+I0U2Z6ozP39Nu1AaM5Uqj
         s3KVUT3KXgdrp908wawOItyYFTez+6f+Y+kIRni4QAoyGzRmq7xF8eVa9sCpw5VD3OHY
         zHre2E5Rh+drJ1KsX3GJjtWyV99RpQI/EBysek/U5hPcUaZRzp2eCqKMxUj/fFgEKOqZ
         KloQ==
X-Gm-Message-State: AOAM5333E5i5nAQ50M2SEt5ISwAul2vwArr0yKpJ7vTbTqp3Dzxj2v5z
        obyTSPJSDqa95wtjKxwL6eqs0w==
X-Google-Smtp-Source: ABdhPJyXxy+XFbtuHwNmCXcpCg9A7LNzjcKMCK9aCbkY8YKlmWfwuKnp+W8UeDGaazEHaL9t1uplvw==
X-Received: by 2002:a1c:8087:: with SMTP id b129mr1617789wmd.10.1604698637166;
        Fri, 06 Nov 2020 13:37:17 -0800 (PST)
Received: from dell.default ([91.110.221.236])
        by smtp.gmail.com with ESMTPSA id d16sm3984942wrw.17.2020.11.06.13.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 13:37:16 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Brian Norris <computersforpeace@gmail.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH v2 13/23] mtd: nand: raw: brcmnand: brcmnand: Demote non-conformant kernel-doc headers
Date:   Fri,  6 Nov 2020 21:36:45 +0000
Message-Id: <20201106213655.1838861-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106213655.1838861-1-lee.jones@linaro.org>
References: <20201106213655.1838861-1-lee.jones@linaro.org>
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
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
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

