Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6842BB3B7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 19:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731159AbgKTShp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 13:37:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:56200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730579AbgKTShn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 13:37:43 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5084D24124;
        Fri, 20 Nov 2020 18:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605897463;
        bh=tBaPpJPmxXUf73eAJA+QVsu+zTVoZtKsBdcV4QFuZxc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lIfDMP4gnKR37+GQEfhGQBBWIAbbesWesMWbQeIwLDAsnJhWQRadcR3FDcieCwm4Y
         nuPx/bGuKrXkgUoVFxrgPG39qUeTzkhNKP/kW8ANdGh3ry2A4ZZ42AVT0LxsUre1X2
         i4iCxCGntBFwV7Z4RoqlGP8oC/8mswe1Ykxuming=
Date:   Fri, 20 Nov 2020 12:37:48 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Cc:     linux-mtd@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 104/141] mtd: rawnand: stm32_fmc2: Fix fall-through warnings
 for Clang
Message-ID: <299d044a69b59eff2c733543b927aa608282a9a8.1605896060.git.gustavoars@kernel.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1605896059.git.gustavoars@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix a couple
of warnings by explicitly adding a couple of fallthrough pseudo-keywords
instead of letting the code fall through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/mtd/nand/raw/stm32_fmc2_nand.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
index 550bda4d1415..002fa521036f 100644
--- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
+++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
@@ -531,6 +531,7 @@ static int stm32_fmc2_nfc_ham_correct(struct nand_chip *chip, u8 *dat,
 		switch (b % 4) {
 		case 2:
 			bit_position += shifting;
+			fallthrough;
 		case 1:
 			break;
 		default:
@@ -546,6 +547,7 @@ static int stm32_fmc2_nfc_ham_correct(struct nand_chip *chip, u8 *dat,
 		switch (b % 4) {
 		case 2:
 			byte_addr += shifting;
+			fallthrough;
 		case 1:
 			break;
 		default:
-- 
2.27.0

