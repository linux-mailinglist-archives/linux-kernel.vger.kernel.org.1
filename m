Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E54452D7242
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 09:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405503AbgLKIvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 03:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403782AbgLKIv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 03:51:27 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCF6C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 00:50:47 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id t8so6588962pfg.8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 00:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=u7JMQZvgEid85bk0GRu+K67PTTlqfUvEzJX5XdyMvGY=;
        b=Z9f6tLQdp5fCaD6n/7Ur4nGvTRVEFx2v/Toe16VwLUVIWZ+5kvYWvHCoFj0gOTK4Sy
         eroHC2dDh2sAeJhFHNdLUZuf21OvuhqgQGLgAywB9cHnHEzyzASqUzbZhbUCl1a6OwIB
         Lz70OpRDOGZ90/V/f0ysDRV3XlB2S+rN+vNaN/F9uYcDuQ/5Hbk7jg+CUMtm1mkh06s/
         ACMDMJtdHAA0qNBJFeBLSaUcTlxUEuSFXjdEESWr6ss9sxdoY4SPSuKK/hJq/oy39gFc
         iy9MX8U3MHdxq20mvr48Vo0r6HnoPr7BajjqHb0FThJvTZTvkeTQpxZgFxRrMwZ7aC8B
         YmaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=u7JMQZvgEid85bk0GRu+K67PTTlqfUvEzJX5XdyMvGY=;
        b=qoTpazY85MTHa/9fatOtQpUulPzHsvzk/Epo5hDM6B0aiqR5V1dKdV8qDuA7gXL7t6
         brXSN3YrjC1W92k8TjFLa+Bx0SDO81syzSDia01LD1h19NdCBx2fC649Z32Mtk5bCR+/
         qaeJDYD8vJhOtB1+xUTqCoNWX6Uwnmkq7cytfJbjpSA4eyDV2k1AVhZrTALSFd3tKmkH
         CW4YQ/DSlG6a9+8AjsTCdwV3F3Q7CGev4IkY/zV2Y7A1Ew3kZ0AlmedqLiXABCzj8j1D
         I1jf0e4mDtS59puBZqMmW81vqygANyqEAO6e6026eVVOPdfVqdcd64Szi7mbISikGjav
         4r4A==
X-Gm-Message-State: AOAM530OhduQmugJxMK9wlxFkD2Atl+/bbGRcVcnbdSyi1aLCmOJ52dN
        oC1kCPVcaxFtw6U0UJfyTR4=
X-Google-Smtp-Source: ABdhPJxZGCPgoXMVSDU7P4uxq956WQzvkQ//3O/oyEGZjNcQA086pt1QTGOfPUVyxxJKZiPJtD3YlA==
X-Received: by 2002:a62:1b16:0:b029:19e:238:8627 with SMTP id b22-20020a621b160000b029019e02388627mr3884431pfb.52.1607676646528;
        Fri, 11 Dec 2020 00:50:46 -0800 (PST)
Received: from ubuntu ([125.132.45.8])
        by smtp.gmail.com with ESMTPSA id e3sm8754901pfe.154.2020.12.11.00.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 00:50:45 -0800 (PST)
Date:   Fri, 11 Dec 2020 17:50:39 +0900
From:   Levi Yun <ppbuk5246@gmail.com>
To:     dushistov@mail.ru, arnd@arndb.de, akpm@linux-foundation.org,
        gustavo@embeddedor.com, vilhelm.gray@gmail.com,
        richard.weiyang@linux.alibaba.com,
        andriy.shevchenko@linux.intel.com, joseph.qi@linux.alibaba.com,
        skalluru@marvell.com, yury.norov@gmail.com, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] lib/find_bit_bench: fix the unmatched iterations cnt
Message-ID: <20201211085039.GA7619@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should have same iteration count when we walk the same bitmap
regardless of using find_next_bit or find_last_bit.

When we run the find_bit_benchmark.ko, we sometime get
unmatched iterations count below:

             Start testing find_bit() with random-filled bitmap
[+...] find_next_bit:                  875085 ns, 163755 iterations <
[+...] find_next_zero_bit:             865319 ns, 163926 iterations
[+...] find_last_bit:                  611807 ns, 163756 iterations <
[+...] find_first_bit:                1601016 ns,  16335 iterations
[+...] find_next_and_bit:              400645 ns,  74040 iterations
[+...]
              Start testing find_bit() with sparse bitmap
[+...] find_next_bit:                    9942 ns,    654 iterations
[+...] find_next_zero_bit:            1678445 ns, 327027 iterations
[+...] find_last_bit:                    7131 ns,    654 iterations
[+...] find_first_bit:                 551383 ns,    654 iterations
[+...] find_next_and_bit:                3027 ns,      1 iterations

Normally, this is happen when the last bit of bitmap was set.

This patch fix the unmatched iterations count between
test_find_next_bit and test_find_last_bit.

Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
---
 lib/find_bit_benchmark.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/lib/find_bit_benchmark.c b/lib/find_bit_benchmark.c
index 5637c5711db9..766e0487852b 100644
--- a/lib/find_bit_benchmark.c
+++ b/lib/find_bit_benchmark.c
@@ -35,14 +35,14 @@ static DECLARE_BITMAP(bitmap2, BITMAP_LEN) __initdata;
  */
 static int __init test_find_first_bit(void *bitmap, unsigned long len)
 {
-	unsigned long i, cnt;
+	unsigned long i = 0, cnt = 0;
 	ktime_t time;
 
 	time = ktime_get();
-	for (cnt = i = 0; i < len; cnt++) {
+	do {
 		i = find_first_bit(bitmap, len);
 		__clear_bit(i, bitmap);
-	}
+	} while (i++ < len && ++cnt);
 	time = ktime_get() - time;
 	pr_err("find_first_bit:     %18llu ns, %6ld iterations\n", time, cnt);
 
@@ -51,12 +51,13 @@ static int __init test_find_first_bit(void *bitmap, unsigned long len)
 
 static int __init test_find_next_bit(const void *bitmap, unsigned long len)
 {
-	unsigned long i, cnt;
+	unsigned long i = 0, cnt = 0;
 	ktime_t time;
 
 	time = ktime_get();
-	for (cnt = i = 0; i < BITMAP_LEN; cnt++)
-		i = find_next_bit(bitmap, BITMAP_LEN, i) + 1;
+	do {
+		i = find_next_bit(bitmap, BITMAP_LEN, i);
+	} while (i++ < BITMAP_LEN && ++cnt);
 	time = ktime_get() - time;
 	pr_err("find_next_bit:      %18llu ns, %6ld iterations\n", time, cnt);
 
@@ -65,12 +66,13 @@ static int __init test_find_next_bit(const void *bitmap, unsigned long len)
 
 static int __init test_find_next_zero_bit(const void *bitmap, unsigned long len)
 {
-	unsigned long i, cnt;
+	unsigned long i = 0, cnt = 0;
 	ktime_t time;
 
 	time = ktime_get();
-	for (cnt = i = 0; i < BITMAP_LEN; cnt++)
-		i = find_next_zero_bit(bitmap, len, i) + 1;
+	do {
+		i = find_next_zero_bit(bitmap, len, i);
+	} while (i++ < BITMAP_LEN && ++cnt);
 	time = ktime_get() - time;
 	pr_err("find_next_zero_bit: %18llu ns, %6ld iterations\n", time, cnt);
 
@@ -84,12 +86,11 @@ static int __init test_find_last_bit(const void *bitmap, unsigned long len)
 
 	time = ktime_get();
 	do {
-		cnt++;
 		l = find_last_bit(bitmap, len);
 		if (l >= len)
 			break;
 		len = l;
-	} while (len);
+	} while (len >= 0 && ++cnt);
 	time = ktime_get() - time;
 	pr_err("find_last_bit:      %18llu ns, %6ld iterations\n", time, cnt);
 
@@ -99,12 +100,13 @@ static int __init test_find_last_bit(const void *bitmap, unsigned long len)
 static int __init test_find_next_and_bit(const void *bitmap,
 		const void *bitmap2, unsigned long len)
 {
-	unsigned long i, cnt;
+	unsigned long i = 0, cnt = 0;
 	ktime_t time;
 
 	time = ktime_get();
-	for (cnt = i = 0; i < BITMAP_LEN; cnt++)
-		i = find_next_and_bit(bitmap, bitmap2, BITMAP_LEN, i + 1);
+	do {
+		i = find_next_and_bit(bitmap, bitmap2, BITMAP_LEN, i);
+	} while (i++ < BITMAP_LEN && ++cnt);
 	time = ktime_get() - time;
 	pr_err("find_next_and_bit:  %18llu ns, %6ld iterations\n", time, cnt);
 
-- 
2.27.0
