Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2165228BC5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 00:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbgGUWAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 18:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbgGUWAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 18:00:43 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F47C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 15:00:43 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id b92so91856pjc.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 15:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DdNcuQK0NXb9O+sBfaHLVJivIhqCAN5FeOqzQif1mJk=;
        b=Wskphfs/cMN5rdywSMJMV4e4u/ThVaEMleo4waV8I+8i65tE9ErTUq89Q7RQF9CKNf
         iQGt8UiObHNjCqCKWfciSW/Eo6TiY+shrgK8EzRJeNZJ3zmEEfEYl1kjTKdD8FSj8JeP
         Wp7IpCT1WqS2zhRy6Ru28EEUPqHxdKSY567pQIz6Om7ntqpzz60JdWHZnANluR5jfwsM
         S/vOzD4FDNHuAHDwoRuKOifqTDhxw1k26DuayJqSS1/8AVOHw86LIo1J+5TDuM1DNqQy
         Z0EEi5fJhwX63P7sRoF+sqmKvIF5ZvL6AhF2tQXbJejOg2XJc5ouz4zKmMBT5QgOdQGv
         Tg2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DdNcuQK0NXb9O+sBfaHLVJivIhqCAN5FeOqzQif1mJk=;
        b=sWv54z9vt9/OlooPQZ8mwAEDTQYoOemViVMT3WmG+BPPOqvGy85I2Vv/dtBG9zN687
         mQSJdL/hsVvQ/ZYutn14co0tpKBUYRKwcr85qwkBPorknr92YJQOGyAuDD6bI39J6FDg
         1kSZ7lKR/GvgUQmK7Zee5kRZPf63RKbse4W4rFRuvJX37nXBLSDzf/T1/47i3sRdRI+K
         IF3jf/r/mJmhDYxrrJQyBI42kfKVqVEe8aEugPfrAY3dbZh6tK/lRryipwN/8uIeAojI
         NbDBVGQe/xuxzOQfneL8INBidDClCnTLj6cgp7j0DodHfLQAxRrEracj9fy5siaCmi1c
         wm7g==
X-Gm-Message-State: AOAM530ggVkjbPff+4T7V6Gwv1skCuuaC7eZsBx1hCSv9QaSA+2x0KTy
        wJQqD+MF+9TMM2d64oJmUNs=
X-Google-Smtp-Source: ABdhPJzDxZFymjNgcSR3l18ygAmdv4lsoT9yT3V3JP5Rwk0QYQI7U8yzNU7v1MmO+QQZLJQKl/R+qA==
X-Received: by 2002:a17:90a:db17:: with SMTP id g23mr7187756pjv.180.1595368842718;
        Tue, 21 Jul 2020 15:00:42 -0700 (PDT)
Received: from octofox.cadence.com ([2601:641:400:e00:19b7:f650:7bbe:a7fb])
        by smtp.gmail.com with ESMTPSA id q96sm4453920pja.0.2020.07.21.15.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 15:00:42 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH] xtensa: fix access check in csum_and_copy_from_user
Date:   Tue, 21 Jul 2020 15:00:35 -0700
Message-Id: <20200721220035.32584-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d341659f470b ("xtensa: switch to providing
csum_and_copy_from_user()") introduced access check, but incorrectly
tested dst instead of src.
Fix access_ok argument in csum_and_copy_from_user.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Fixes: d341659f470b ("xtensa: switch to providing csum_and_copy_from_user()")
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/include/asm/checksum.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/xtensa/include/asm/checksum.h b/arch/xtensa/include/asm/checksum.h
index d8292cc9ebdf..243a5fe79d3c 100644
--- a/arch/xtensa/include/asm/checksum.h
+++ b/arch/xtensa/include/asm/checksum.h
@@ -57,7 +57,7 @@ static inline
 __wsum csum_and_copy_from_user(const void __user *src, void *dst,
 				   int len, __wsum sum, int *err_ptr)
 {
-	if (access_ok(dst, len))
+	if (access_ok(src, len))
 		return csum_partial_copy_generic((__force const void *)src, dst,
 					len, sum, err_ptr, NULL);
 	if (len)
-- 
2.20.1

