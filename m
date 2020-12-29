Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E71032E6E63
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 06:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgL2FwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 00:52:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgL2FwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 00:52:06 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F89C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 21:51:26 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id j1so6733482pld.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 21:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ws6av0vO/n+wtrNUa74n3tClewh7290nN7ExGkq43UI=;
        b=YY41nMVeSFbTCpTx+MYE+RLVcV7VcqULCF0sXiC5fu3HDw4t/KZWH7ZUF1rr8VHw8u
         4i0NUe0+vqLBoKxuvW761+OekAaEKXolvcFlzmK76eVnaWnhEQjf+VhNQLvvhO3NrTq3
         qCIgzBCCmuUYOTIku0kq01wRcRZd7K+1ybJtI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ws6av0vO/n+wtrNUa74n3tClewh7290nN7ExGkq43UI=;
        b=Yz86ZSZKMkvfoitM4J13n5UPh5YnsPqnsWyrb719Anpjec5IULPtd6k7CtQyXQQ8kS
         F09KXiPkebgKQHPdZVlpUYIapyHvkdqkwbbWazGYJsEfofRdsjGRjgXHZlYp8meps0mn
         BTJ5Ihr8rEBwxCB6UO8rpxj/M7Z5BOLSGMqnRkylMeIs7BGuGqdDWYQwKr0VsHAw3RqS
         MBSYhnLZt7duGQLoOPHZlsL/CZlkDBKuWmrnyMbY4PStylaojZ0HRYHjGCxhhlBE/fGk
         FffYNsJ6OVRAWYd6t6/WzEcmTTRAhnfkDdPopI9us6H1QxDyGKKbkArtwIB/LvunIda/
         kiyw==
X-Gm-Message-State: AOAM533UC1970UmYckDk+f2MKVYaSUH5TWG9V8eH0EB47mlVqaCj+iJR
        waVpeOUFnnUYTxxFXyViPGKjQA==
X-Google-Smtp-Source: ABdhPJyho6BEPlXg0tseu2Gzc0+n/F44qHf9yOCIxgGR0kpQZq/Rh9SpXsyWd3kxTKjiFY3PI0SXaA==
X-Received: by 2002:a17:90b:90f:: with SMTP id bo15mr2474480pjb.148.1609221085820;
        Mon, 28 Dec 2020 21:51:25 -0800 (PST)
Received: from shiro.work (p1268123-ipngn200803sizuokaden.shizuoka.ocn.ne.jp. [118.13.124.123])
        by smtp.googlemail.com with ESMTPSA id x23sm45041113pge.47.2020.12.28.21.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 21:51:25 -0800 (PST)
From:   Daniel Palmer <daniel@0x0f.com>
To:     linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 0/1] Add basic support for Foresee SPI NAND
Date:   Tue, 29 Dec 2020 14:50:58 +0900
Message-Id: <20201229055059.2255021-1-daniel@0x0f.com>
X-Mailer: git-send-email 2.30.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is my very crude attempt at adding support for Longsys'
Foresee branded SPI NAND parts that are showing up on some
boards.

I fully admit I have no idea what I'm doing here and I basically
took one of the existing files, ripped out what I didn't
understand and tried to fill in the numbers from the datasheet
without really knowing what they mean.

This worked well enough for me to get something that looks like
a correct dump of the SPI NAND from a board I'm working with.
I need the vendor firmware on the board for reverse engineering
so I haven't actually tried to write anything yet.

The datasheet for this chip is linked. If someone that actually
knows what they're doing could take a look and point out my
mistakes that would be great.

Link: https://datasheet.lcsc.com/szlcsc/2008121142_FORESEE-FS35ND01G-S1Y2QWFI000_C719495.pdf

Daniel Palmer (1):
  mtd: spinand: add support for Foresee FS35ND01G

 drivers/mtd/nand/spi/Makefile  |  2 +-
 drivers/mtd/nand/spi/core.c    |  1 +
 drivers/mtd/nand/spi/longsys.c | 45 ++++++++++++++++++++++++++++++++++
 include/linux/mtd/spinand.h    |  1 +
 4 files changed, 48 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mtd/nand/spi/longsys.c

-- 
2.30.0.rc2

