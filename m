Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 551E82BC1B0
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 20:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbgKUTLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 14:11:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42088 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728190AbgKUTLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 14:11:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605985891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=Y+ODGJoKAQB4fqN11EBA++p3TYNoPdfULESrqAv4joY=;
        b=PqTZNmdZhvPA8jZBNO6bfjI20CxkiK1uRBTWVU0S03K640+dGVcXotnHuv3oVC3GivklOk
        gEiVw1P7/SgFJCV2wcAp6RHQrYqvCUMNcIoaBA1mznatlCWmp5iVM6iT4VYkqIlF9PCesJ
        HpTlJShiD84XwImogilTayAoVz0TqZU=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-dmOB1s57O5eMvid9tLkGhg-1; Sat, 21 Nov 2020 14:11:28 -0500
X-MC-Unique: dmOB1s57O5eMvid9tLkGhg-1
Received: by mail-pf1-f199.google.com with SMTP id a24so9673929pfo.3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 11:11:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Y+ODGJoKAQB4fqN11EBA++p3TYNoPdfULESrqAv4joY=;
        b=UATUXWezC4/0SRyLJKp43QEY4OYtDBgaT/Ekpnq43+dhuc0VBAkEEeA8MF+oZuXNdW
         HFJ6oRyezuAgdqwiH48DMp7hUOlQETJjihO3MHF0UV48AwhFT6HJ5NN9t43dks4tsZtz
         vnSgTjX73ocURLE+9n8Udr2Hyl+OcvGJ8zJnaEWJjH5CUQsm8zdD3ogtOxf8xu0he/V4
         XBBM80yCIq/XTuubIOl/IgELTUJOXbU7kg1Z9oEPdOYzrkE889B3vMFD5cZdie1sS0Uc
         ZhYJnRXGBq6So2fsUB3nynEWACaeWGE51VNt6ELwwYuYEjZpuBYlZoMprd82tJd3ojVW
         ixMg==
X-Gm-Message-State: AOAM533qehWoN+7Oyc5OoZ0ZJtpjaCHU42lnxktS04TeJnZe3SUQuGpJ
        HWnRIfe534fv1XiqGhM05/vzAI5mCc6Bg7PUkKh4n4L2fgUPBiGGHdWveyaFSModVWigpqIjy6Q
        fsZEYbUr8i3dQj5l/6G9qHCvz
X-Received: by 2002:aa7:96ba:0:b029:197:e733:ae3c with SMTP id g26-20020aa796ba0000b0290197e733ae3cmr3715430pfk.46.1605985886911;
        Sat, 21 Nov 2020 11:11:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwo3SCUDysueXZ4MblxGao2p3clXqAuVx7Nt4q0WMp76p0Ga9m1dvQu8yA5wEYFXOkl3de4eg==
X-Received: by 2002:aa7:96ba:0:b029:197:e733:ae3c with SMTP id g26-20020aa796ba0000b0290197e733ae3cmr3715420pfk.46.1605985886711;
        Sat, 21 Nov 2020 11:11:26 -0800 (PST)
Received: from xiangao.remote.csb ([119.254.120.70])
        by smtp.gmail.com with ESMTPSA id m8sm6576375pgg.1.2020.11.21.11.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2020 11:11:26 -0800 (PST)
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Gao Xiang <hsiangkao@redhat.com>,
        Yann Collet <yann.collet.73@gmail.com>,
        Miao Xie <miaoxie@huawei.com>, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] lib/lz4: explicitly support in-place decompression
Date:   Sun, 22 Nov 2020 03:10:24 +0800
Message-Id: <20201121191024.2631523-1-hsiangkao@redhat.com>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LZ4 final literal copy could be overlapped when doing
in-place decompression, so it's unsafe to just use memcpy()
on an optimized memcpy approach but memmove() instead.

Upstream LZ4 has updated this years ago [1] (and the impact
is non-sensible [2]), this commit just synchronizes LZ4
upstream code to the kernel side as well.

It can be observed as EROFS in-place decompression failure
on specific files when X86_FEATURE_ERMS is unsupported,
memcpy() optimization of commit 59daa706fbec ("x86, mem:
Optimize memcpy by avoiding memory false dependece") will
be enabled then.

Currently most modern x86-CPUs support ERMS, these CPUs
just use "rep movsb" approach so no problem at all. However,
it can still be verified with forcely disabling ERMS feature...

arch/x86/lib/memcpy_64.S:
        ALTERNATIVE_2 "jmp memcpy_orig", "", X86_FEATURE_REP_GOOD, \
-                     "jmp memcpy_erms", X86_FEATURE_ERMS
+                     "jmp memcpy_orig", X86_FEATURE_ERMS

We didn't observed any strange on arm64/arm platform before,
but it really needs an update for sure considering this
unsafe overlapping memcpy() behavior for LZ4 in-place
decompression.

[1] https://github.com/lz4/lz4/commit/33cb8518ac385835cc17be9a770b27b40cd0e15b
[2] https://github.com/lz4/lz4/pull/717#issuecomment-497818921
Cc: Yann Collet <yann.collet.73@gmail.com>
Cc: Miao Xie <miaoxie@huawei.com>
Cc: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
Hi Andrew,

Could you kindly consider picking this patch up, although
the impact is EROFS but it touchs in-kernel lz4 library
anyway...

Thanks,
Gao Xiang

 lib/lz4/lz4_decompress.c | 2 +-
 lib/lz4/lz4defs.h        | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/lz4/lz4_decompress.c b/lib/lz4/lz4_decompress.c
index 00cb0d0b73e1..fa88e13ef00b 100644
--- a/lib/lz4/lz4_decompress.c
+++ b/lib/lz4/lz4_decompress.c
@@ -263,7 +263,7 @@ static FORCE_INLINE int LZ4_decompress_generic(
 				}
 			}
 
-			LZ4_memcpy(op, ip, length);
+			LZ4_memmove(op, ip, length);
 			ip += length;
 			op += length;
 
diff --git a/lib/lz4/lz4defs.h b/lib/lz4/lz4defs.h
index c91dd96ef629..673bd206aa98 100644
--- a/lib/lz4/lz4defs.h
+++ b/lib/lz4/lz4defs.h
@@ -146,6 +146,7 @@ static FORCE_INLINE void LZ4_writeLE16(void *memPtr, U16 value)
  * environments. This is needed when decompressing the Linux Kernel, for example.
  */
 #define LZ4_memcpy(dst, src, size) __builtin_memcpy(dst, src, size)
+#define LZ4_memmove(dst, src, size) __builtin_memmove(dst, src, size)
 
 static FORCE_INLINE void LZ4_copy8(void *dst, const void *src)
 {
-- 
2.18.4

