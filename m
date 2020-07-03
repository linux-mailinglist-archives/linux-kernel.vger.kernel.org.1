Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE1A213B56
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 15:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbgGCNtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 09:49:45 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:57467 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726035AbgGCNtp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 09:49:45 -0400
Received: from hopp.molgen.mpg.de (hopp.molgen.mpg.de [141.14.25.186])
        by mx.molgen.mpg.de (Postfix) with ESMTP id 9D27E20646DD8;
        Fri,  3 Jul 2020 15:49:42 +0200 (CEST)
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 1/2] moduleparams: Add hexint type parameter
Date:   Fri,  3 Jul 2020 15:49:39 +0200
Message-Id: <20200703134940.27054-1-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For bitmasks printing values in hex is more convenient.

Prefix with `0x` to make it clear, that it’s a hex value, and pad it
out.

Using the helper for `amdgpu.ppfeaturemask`, it will look like below.

Before:

    $ more /sys/module/amdgpu/parameters/ppfeaturemask
    4294950911

After:

    $ more /sys/module/amdgpu/parameters/ppfeaturemask
    0xffffbfff

Cc: linux-kernel@vger.kernel.org
Cc: amd-gfx@lists.freedesktop.org
Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
v2: Address review comments: Rename hex to hexint, and pad sizes

 include/linux/moduleparam.h |  7 ++++++-
 kernel/params.c             | 17 +++++++++--------
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
index 3ef917ff0964..cff7261e98bb 100644
--- a/include/linux/moduleparam.h
+++ b/include/linux/moduleparam.h
@@ -118,7 +118,7 @@ struct kparam_array
  * you can create your own by defining those variables.
  *
  * Standard types are:
- *	byte, short, ushort, int, uint, long, ulong
+ *	byte, hexint, short, ushort, int, uint, long, ulong
  *	charp: a character pointer
  *	bool: a bool, values 0/1, y/n, Y/N.
  *	invbool: the above, only sense-reversed (N = true).
@@ -448,6 +448,11 @@ extern int param_set_ullong(const char *val, const struct kernel_param *kp);
 extern int param_get_ullong(char *buffer, const struct kernel_param *kp);
 #define param_check_ullong(name, p) __param_check(name, p, unsigned long long)
 
+extern const struct kernel_param_ops param_ops_hexint;
+extern int param_set_hexint(const char *val, const struct kernel_param *kp);
+extern int param_get_hexint(char *buffer, const struct kernel_param *kp);
+#define param_check_hexint(name, p) param_check_uint(name, p)
+
 extern const struct kernel_param_ops param_ops_charp;
 extern int param_set_charp(const char *val, const struct kernel_param *kp);
 extern int param_get_charp(char *buffer, const struct kernel_param *kp);
diff --git a/kernel/params.c b/kernel/params.c
index 8e56f8b12d8f..487261eb836f 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -233,14 +233,15 @@ char *parse_args(const char *doing,
 	EXPORT_SYMBOL(param_ops_##name)
 
 
-STANDARD_PARAM_DEF(byte,	unsigned char,		"%hhu", kstrtou8);
-STANDARD_PARAM_DEF(short,	short,			"%hi",  kstrtos16);
-STANDARD_PARAM_DEF(ushort,	unsigned short,		"%hu",  kstrtou16);
-STANDARD_PARAM_DEF(int,		int,			"%i",   kstrtoint);
-STANDARD_PARAM_DEF(uint,	unsigned int,		"%u",   kstrtouint);
-STANDARD_PARAM_DEF(long,	long,			"%li",  kstrtol);
-STANDARD_PARAM_DEF(ulong,	unsigned long,		"%lu",  kstrtoul);
-STANDARD_PARAM_DEF(ullong,	unsigned long long,	"%llu", kstrtoull);
+STANDARD_PARAM_DEF(byte,	unsigned char,		"%hhu",  kstrtou8);
+STANDARD_PARAM_DEF(short,	short,			"%hi",   kstrtos16);
+STANDARD_PARAM_DEF(ushort,	unsigned short,		"%hu",   kstrtou16);
+STANDARD_PARAM_DEF(int,		int,			"%i",    kstrtoint);
+STANDARD_PARAM_DEF(uint,	unsigned int,		"%u",    kstrtouint);
+STANDARD_PARAM_DEF(long,	long,			"%li",   kstrtol);
+STANDARD_PARAM_DEF(ulong,	unsigned long,		"%lu",   kstrtoul);
+STANDARD_PARAM_DEF(ullong,	unsigned long long,	"%llu",  kstrtoull);
+STANDARD_PARAM_DEF(hexint,	unsigned int,		"%#08x", kstrtouint);
 
 int param_set_charp(const char *val, const struct kernel_param *kp)
 {
-- 
2.26.2

