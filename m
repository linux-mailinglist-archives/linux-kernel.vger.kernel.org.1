Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6358E302363
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 10:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbhAYJuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 04:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbhAYJfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 04:35:52 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1260BC061224
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 00:56:38 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id r4so7156944pls.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 00:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0Tg3AO11+laABwQxj64s25+YkKlIw2DDqPTzk+9m3NA=;
        b=WoCye80M8x4ZKxCAmP00jU6mS+f/VayYVmmikRShox5xNBLkJ/hSaVzDTzCbGdp9s4
         pVbQEeNUb0I2B+CYEnmt/Yt6BRIOnzgz2CEgGocb79uG+XmUiZ2Zzf9hZ54fNCZeRBOS
         pwCKPuf36lXbZ+2jg4FaOOAQJbTESr5CKLSIjtm2dNM0qsMH+n5jx5w/knWfmo0Nftdv
         OAMM6tvUM+TIytMcE74rnk6fbE5smQJniMc6AwCWPD2sXpbZBsFtKEDcU+ifRchZJg26
         E/oybp+PF/LNzIe1iHTz1flFkDCIrzm6/ltdFGbrsSHh2RYWqy8mO22yArN9KGqlitH1
         7E+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0Tg3AO11+laABwQxj64s25+YkKlIw2DDqPTzk+9m3NA=;
        b=MyAg2Scj3hLfaQu8t4nsdzaXjt4n+luLM2VOxGrWSQHYuAff23J4274xqSIFqTlVVr
         kwcL5Q5b/ti3sYUwFmAbl3oMykWaKwkLXYApOrZiwSlIJvZnFBRBny9CM/3ORYjhxpuV
         AmMxiMKptLmeUXA13jfQ8iYQcKnuMsv44gvn1zNJqwsWNh9rZ87FlNHt9oz1c7lSNDcM
         Hhy+3HCmZBzB2JnHrbbxzNuo9kb/4kttoGIX2CjKtkCNFtohHPW9zze6eTAchAvMc0Hc
         WCduw4dsicbQxU1n+oFynulgpOVauJ0WfjmzL7iyH4OqJi/L+rnVMW8p5QBuTidr4mKg
         P2RQ==
X-Gm-Message-State: AOAM530NjcavAuvrdzIav3mkWr8cfs7n1GD/3NxmspMYoNNIo41EToWs
        KteaP8vSC+sqKAgaP7uQMRg=
X-Google-Smtp-Source: ABdhPJyK64XWDJ4pEFtiZoiBJZthYUHFUTOaLkdd9WQt0tQ2FDjvYPOByicZMyWxv2jgwF+BqOR3pQ==
X-Received: by 2002:a17:902:bd01:b029:da:3d4f:abe1 with SMTP id p1-20020a170902bd01b02900da3d4fabe1mr18912704pls.16.1611564997676;
        Mon, 25 Jan 2021 00:56:37 -0800 (PST)
Received: from bj04616pcu01.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id m18sm12918724pfd.206.2021.01.25.00.56.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jan 2021 00:56:37 -0800 (PST)
From:   Candle Sun <candlesea@gmail.com>
To:     keescook@chromium.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        natechancellor@gmail.com, ndesaulniers@google.com,
        candle.sun@unisoc.com, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH] lkdtm: fix memory copy size for WRITE_KERN
Date:   Mon, 25 Jan 2021 16:56:22 +0800
Message-Id: <20210125085622.2322-1-candlesea@gmail.com>
X-Mailer: git-send-email 2.17.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Candle Sun <candle.sun@unisoc.com>

Though do_overwritten() follows do_nothing() in source code, the final
memory address order is determined by compiler. We can't always assume
address of do_overwritten() is bigger than do_nothing(). At least the
Clang we are using places do_overwritten() before do_nothing() in the
object. This causes the copy size in lkdtm_WRITE_KERN() is *really*
big and WRITE_KERN test on ARM32 arch will fail.

Compare the address order before doing the subtraction.

Signed-off-by: Candle Sun <candle.sun@unisoc.com>
---
 drivers/misc/lkdtm/perms.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
index 2dede2ef658f..fbfbdf89d668 100644
--- a/drivers/misc/lkdtm/perms.c
+++ b/drivers/misc/lkdtm/perms.c
@@ -31,13 +31,13 @@ static unsigned long ro_after_init __ro_after_init = 0x55AA5500;
  * This just returns to the caller. It is designed to be copied into
  * non-executable memory regions.
  */
-static void do_nothing(void)
+static noinline void do_nothing(void)
 {
 	return;
 }
 
 /* Must immediately follow do_nothing for size calculuations to work out. */
-static void do_overwritten(void)
+static noinline void do_overwritten(void)
 {
 	pr_info("do_overwritten wasn't overwritten!\n");
 	return;
@@ -110,15 +110,14 @@ void lkdtm_WRITE_RO_AFTER_INIT(void)
 
 void lkdtm_WRITE_KERN(void)
 {
-	size_t size;
-	volatile unsigned char *ptr;
+	unsigned long value_dow = (unsigned long)do_overwritten;
+	unsigned long value_do =  (unsigned long)do_nothing;
+	size_t size = (size_t)(value_dow > value_do ?
+			value_dow - value_do : value_do - value_dow);
 
-	size = (unsigned long)do_overwritten - (unsigned long)do_nothing;
-	ptr = (unsigned char *)do_overwritten;
-
-	pr_info("attempting bad %zu byte write at %px\n", size, ptr);
-	memcpy((void *)ptr, (unsigned char *)do_nothing, size);
-	flush_icache_range((unsigned long)ptr, (unsigned long)(ptr + size));
+	pr_info("attempting bad %zu byte write at %px\n", size, do_overwritten);
+	memcpy((void *)value_dow, (void *)value_do, size);
+	flush_icache_range(value_dow, value_dow + (unsigned long)size);
 	pr_err("FAIL: survived bad write\n");
 
 	do_overwritten();
-- 
2.17.0

