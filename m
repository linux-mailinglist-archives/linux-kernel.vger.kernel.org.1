Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C776C2BC344
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 04:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgKVDIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 22:08:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37585 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726662AbgKVDIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 22:08:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606014522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=bjOFi5FKgOSnFyxA6Adb1icB0ZzO71nzVBJEkr3Dvho=;
        b=jS5HBNvOWCeU9S1gRaQm94SuoY3MtzQOD5iXf1Q4fvPpPYCic1JrB8I69dsYR3egqlZALJ
        USVLvdD9sHKLFYF4UP5CIqN0P8BZ3mXDTDbmw/b8aq1iNbVjDr/k2Ygdx/l/Az13Kr2hQl
        36Tm3yEXLvnpVZ1G+VYjsiBQhzXI9bw=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-yJutpKahMtuQRDG6Ie4dYQ-1; Sat, 21 Nov 2020 22:08:37 -0500
X-MC-Unique: yJutpKahMtuQRDG6Ie4dYQ-1
Received: by mail-pl1-f199.google.com with SMTP id 1so7051774plb.4
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 19:08:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bjOFi5FKgOSnFyxA6Adb1icB0ZzO71nzVBJEkr3Dvho=;
        b=ucfjK1JF4iXINAbp2n15R551mIG9J9FgpMKtgZwiMq2gL/oqcDVMzsDqGVLqIOR3Vd
         m2VsmT+jtqk9859+UljNx4FHuJ+dufLrG0XilF3r4H+8AD1EYIWEjmDTpQ0wW7tutKf2
         gUcqfTBs9kRKozRfv0drADuMt+yQyd588YUOtqT85ESRXfw3eEtrm9Vvf6kAO2pvFh+q
         mLZwMpYHFa20/iQNe/3fuhmgZzQV+OqVaRF+uhsSUSOfjkQz6lbu7v8geZQgxHIfMs56
         WwE80oqOy1PC2vbOLkOoWluZLbcWCDU/UwvhgnoPswjYGV+CrZGToV7XsG2VgtK5uq7l
         NyQA==
X-Gm-Message-State: AOAM531d5KlhneaHXfcJmh0TBKsUQMvM8odpEWV9NU8UAeKlWX8L8wdl
        70Kr3+45hV3FSBwG8KhUiNWCCOxaJ/T8M6+EBbKhGHE1WpFP9k5CnvR7TnWk/285Sur1iCWEAIW
        PK6XfpuLSDxr3wbzABnOyoivW
X-Received: by 2002:a17:902:c14b:b029:d6:ab18:108d with SMTP id 11-20020a170902c14bb02900d6ab18108dmr19955543plj.20.1606014516933;
        Sat, 21 Nov 2020 19:08:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz3Z1H7APA3qDLPNRo8ZGkl70bt8bHYxJFv6CH+wSTm2Y4kup5kY8OhzGd+Z1nO4V4s6LeKpA==
X-Received: by 2002:a17:902:c14b:b029:d6:ab18:108d with SMTP id 11-20020a170902c14bb02900d6ab18108dmr19955529plj.20.1606014516688;
        Sat, 21 Nov 2020 19:08:36 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id k25sm7907627pfi.42.2020.11.21.19.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2020 19:08:36 -0800 (PST)
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
        Gao Xiang <hsiangkao@redhat.com>,
        Yann Collet <yann.collet.73@gmail.com>,
        Nick Terrell <terrelln@fb.com>, Miao Xie <miaoxie@huawei.com>,
        Chao Yu <yuchao0@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Guo Xuenan <guoxuenan@huawei.com>
Subject: [PATCH v2] lib/lz4: explicitly support in-place decompression
Date:   Sun, 22 Nov 2020 11:07:49 +0800
Message-Id: <20201122030749.2698994-1-hsiangkao@redhat.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201121191024.2631523-1-hsiangkao@redhat.com>
References: <20201121191024.2631523-1-hsiangkao@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LZ4 final literal copy could be overlapped when doing
in-place decompression, so it's unsafe to just use memcpy()
on an optimized memcpy approach but memmove() instead.

Upstream LZ4 has updated this years ago [1] (and the impact
is non-sensible [2] plus only a few bytes remain), this commit
just synchronizes LZ4 upstream code to the kernel side as well.

It can be observed as EROFS in-place decompression failure
on specific files when X86_FEATURE_ERMS is unsupported,
memcpy() optimization of commit 59daa706fbec ("x86, mem:
Optimize memcpy by avoiding memory false dependece") will
be enabled then.

Currently most modern x86-CPUs support ERMS, these CPUs just
use "rep movsb" approach so no problem at all. However, it can
still be verified with forcely disabling ERMS feature...

arch/x86/lib/memcpy_64.S:
        ALTERNATIVE_2 "jmp memcpy_orig", "", X86_FEATURE_REP_GOOD, \
-                     "jmp memcpy_erms", X86_FEATURE_ERMS
+                     "jmp memcpy_orig", X86_FEATURE_ERMS

We didn't observe any strange on arm64/arm/x86 platform before
since most memcpy() would behave in an increasing address order
("copy upwards" [3]) and it's the correct order of in-place
decompression but it really needs an update to memmove() for sure
considering it's an undefined behavior according to the standard
and some unique optimization already exists in the kernel.

[1] https://github.com/lz4/lz4/commit/33cb8518ac385835cc17be9a770b27b40cd0e15b
[2] https://github.com/lz4/lz4/pull/717#issuecomment-497818921
[3] https://sourceware.org/bugzilla/show_bug.cgi?id=12518
Cc: Yann Collet <yann.collet.73@gmail.com>
Cc: Nick Terrell <terrelln@fb.com>
Cc: Miao Xie <miaoxie@huawei.com>
Cc: Chao Yu <yuchao0@huawei.com>
Cc: Li Guifu <bluce.liguifu@huawei.com>
Cc: Guo Xuenan <guoxuenan@huawei.com>
Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
changes since v1:
 - refine commit message;
 - Cc more people.

Hi Andrew,

Could you kindly consider picking this patch up, although
the impact is EROFS but it touchs in-kernel lz4 library
anyway...

Thanks,
Gao Xiang

 lib/lz4/lz4_decompress.c | 6 +++++-
 lib/lz4/lz4defs.h        | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/lz4/lz4_decompress.c b/lib/lz4/lz4_decompress.c
index 00cb0d0b73e1..8a7724a6ce2f 100644
--- a/lib/lz4/lz4_decompress.c
+++ b/lib/lz4/lz4_decompress.c
@@ -263,7 +263,11 @@ static FORCE_INLINE int LZ4_decompress_generic(
 				}
 			}
 
-			LZ4_memcpy(op, ip, length);
+			/*
+			 * supports overlapping memory regions; only matters
+			 * for in-place decompression scenarios
+			 */
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

