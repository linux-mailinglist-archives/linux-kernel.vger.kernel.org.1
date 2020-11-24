Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 719562C231C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 11:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732072AbgKXKku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 05:40:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731175AbgKXKks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 05:40:48 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64274C0613D6;
        Tue, 24 Nov 2020 02:40:48 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id x22so1958934wmc.5;
        Tue, 24 Nov 2020 02:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=npqzxLRCrGkHUhaQyNRoZgZ1pTCF4pQdXZS5ZUJCVmk=;
        b=hbkiGZR9tHc/NOEtjYDZIgDgro/CH0D+yAAjMYULMLK0xoOXAXmf8ZqyqiP4ygGerb
         /E70Y2ZhprBxsS+hXEbk4XBYnika9CsVYgvvUOXMYM5y3g1vPCxiKmNcQdF3nTBkaW8M
         h/ezO0yjtPNPU1Z3Qb0SdbwoNN6Nwpip2xwaLjMGKXAahZT6kfkKzNyGea7QwBXmF6gQ
         vc6l07KTOSwMvFtKGNaIJA5xvBXn6nZLp/PwcMOujrkSMURQkE7i5Xdswq//vhbt+yrF
         2sDEnW/bc9sps9zPHNSlJk5YqEf5cenlWBT9TohxLySGTVT87GmpQ8ZTnkAd94RqQMlF
         XyQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=npqzxLRCrGkHUhaQyNRoZgZ1pTCF4pQdXZS5ZUJCVmk=;
        b=h4wm5Vik1JkqKuY4owS082VG2bSBEQGVvXSNMRWtXGgDuxbP0/7na4Mh5rQ+pcMJ4N
         TMTztsNJOkCtUgy8NmU9PenUwxAjxgYdgHaCimhYMxbtBUDSc14Kaxj2kq4nqG5gUx1p
         urltrgCNGxtPPTgni+ErPMPj5tQvs/R4BkvSXGoGrqAHoxY+u5HCMrPuSX9aVWMEttWo
         441+IAufbR+w/whZFv9KGg5xoZE22TuRgMh1lwxu4JtYRxinJ54Sms4etOzKRv6N1TXK
         /Y3dL3WSdtVNwxBUPXrdY+oCxTOIFMK2rYy5WIakIFfUWsl/8eOcpApo9KKnpM2dvdWN
         Zh9g==
X-Gm-Message-State: AOAM531Bjseyf9tZTkwTUjtVKjnQQh/+3fjhmYX1689JzR2aHyCK88vC
        RJA1l5CSPmiYAZ2fR8CywvI=
X-Google-Smtp-Source: ABdhPJxlWmF7zD7wkDry1SqBHa3a/Q4NfQ+05UKdisSGVB2aCD3aGIlT3WwPBRIvqadg+FjgJRSn0A==
X-Received: by 2002:a7b:ca4c:: with SMTP id m12mr2759253wml.11.1606214447117;
        Tue, 24 Nov 2020 02:40:47 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2daf:7e00:40d0:5d6f:88a2:6c4f])
        by smtp.gmail.com with ESMTPSA id w1sm4359378wmi.24.2020.11.24.02.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 02:40:46 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Tom Rix <trix@redhat.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] zlib: define get_unaligned16() only when used
Date:   Tue, 24 Nov 2020 11:40:30 +0100
Message-Id: <20201124104030.903-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit acaab7335bd6 ("lib/zlib: remove outdated and incorrect
pre-increment optimization"), get_unaligned16() is only used when
!CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS.

Hence, make CC=clang W=1 warns:

  lib/zlib_inflate/inffast.c:20:1:
    warning: unused function 'get_unaligned16' [-Wunused-function]

Define get_unaligned16() only when it is actually used.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on current master and next-20201124

Jann, please ack.
Andrew, please pick this minor non-urgent clean-up patch.

 lib/zlib_inflate/inffast.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/zlib_inflate/inffast.c b/lib/zlib_inflate/inffast.c
index ed1f3df27260..ca66d9008228 100644
--- a/lib/zlib_inflate/inffast.c
+++ b/lib/zlib_inflate/inffast.c
@@ -15,7 +15,8 @@ union uu {
 	unsigned char b[2];
 };
 
-/* Endian independed version */
+#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
+/* Endian independent version */
 static inline unsigned short
 get_unaligned16(const unsigned short *p)
 {
@@ -26,6 +27,7 @@ get_unaligned16(const unsigned short *p)
 	mm.b[1] = b[1];
 	return mm.us;
 }
+#endif
 
 /*
    Decode literal, length, and distance codes and write out the resulting
-- 
2.17.1

