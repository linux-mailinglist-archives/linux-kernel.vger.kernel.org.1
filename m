Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E87E22BA162
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 05:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgKTELS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 23:11:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgKTELR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 23:11:17 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697FBC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 20:11:17 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id c18so6866605qkl.15
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 20:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=wS4+OI8HNHwDuKkngxBVI7/2DshG/84AV6P4cTtvTKw=;
        b=Gz3lBUm6kl9E7kLiYUwsrZt2L51sSM0VphseSnAqWPlRE17c2N47QW15ZwM8HOXCHq
         4IWxJKFO6zZfDhbtcpu//a9HsDblvSPa91UCgxBS6qY9mEUp5HOArg6DscyN0pA+GdM0
         0B1QxXvkh6sGiaUWo0CeXQHLTjuOOzdtmh+M9FhF2jOVH5RSTmow/w7kTuywd+iKsGRy
         g6PVLgqBLdXOtYAsS63RJVqjsvapsxvWcYFHcrOslfVr8un4ZN+Z0+dQuomK+ll+xB/e
         yhuEO/z4Qs81RR7FtdW1YJabD1jXF3jrhvho+7lDWpJfLmfeei/kq8m2HEquvOQPQugO
         pdhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=wS4+OI8HNHwDuKkngxBVI7/2DshG/84AV6P4cTtvTKw=;
        b=QW/2N9Zd/ycpTP44BUffd+NQH5+J/xPfNdstzS+1VbTOILp+NfXD4CGHtp5LuRcbw4
         vbV6073/Kx5S0bcEHK43jFa2BlBlJpr3yLGAYP3Imkk1aEg7LOcSxvdJvfon0beY7kNl
         ysr+oPYVtDB+mg9kiwhp6XS07NjYCaKM3FDHDAuXuZaeXN2rz0z0oPgAousbGrZN41Yd
         N/WzEIIcIWtMQmweCJDc9rWGQOIDig08hg9Nx9GkFCeq8wWJNI4SiH3VfSYRd3xd3u+4
         s+cl1TohdK++INkxsID8ObT6/WFa3Y3mUc6f86RA6eRq1ASLfmST/1MCjWE/6cWKtxXo
         zCCQ==
X-Gm-Message-State: AOAM533Ol9W7buEcrekKUy4HDsi2wMqEOpzasUMtn/qDKUSuoZawX8gP
        A+jhDpVCELHc81ehh/nugHVRwoRa8o8NWHBXOEQ=
X-Google-Smtp-Source: ABdhPJzV9gL2MJKvuoim0O+WNmPgr3SRoQGy1sRCc8aAX2f3sBzci+4BTjLte8qkQtVm8v2miM/YuwiCfATHHDaE594=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a05:6214:1150:: with SMTP id
 b16mr13409786qvt.46.1605845476232; Thu, 19 Nov 2020 20:11:16 -0800 (PST)
Date:   Thu, 19 Nov 2020 20:11:12 -0800
Message-Id: <20201120041113.89382-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH] lib/string: remove unnecessary #undefs
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yury Norov <yury.norov@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few architecture specific string.h functions used to be implemented in
terms of preprocessor defines to the corresponding compiler builtins.
Since this is no longer the case, remove unused #undefs.

Only memcmp is still defined in terms of builtins for a few arches.

Link: https://github.com/ClangBuiltLinux/linux/issues/428
Fixes: 5f074f3e192f ("lib/string.c: implement a basic bcmp")
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 lib/string.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/lib/string.c b/lib/string.c
index 4288e0158d47..7548eb715ddb 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -85,7 +85,6 @@ EXPORT_SYMBOL(strcasecmp);
  * @dest: Where to copy the string to
  * @src: Where to copy the string from
  */
-#undef strcpy
 char *strcpy(char *dest, const char *src)
 {
 	char *tmp = dest;
@@ -302,7 +301,6 @@ EXPORT_SYMBOL(stpcpy);
  * @dest: The string to be appended to
  * @src: The string to append to it
  */
-#undef strcat
 char *strcat(char *dest, const char *src)
 {
 	char *tmp = dest;
@@ -378,7 +376,6 @@ EXPORT_SYMBOL(strlcat);
  * @cs: One string
  * @ct: Another string
  */
-#undef strcmp
 int strcmp(const char *cs, const char *ct)
 {
 	unsigned char c1, c2;
@@ -958,7 +955,6 @@ EXPORT_SYMBOL(memcmp);
  * while this particular implementation is a simple (tail) call to memcmp, do
  * not rely on anything but whether the return value is zero or non-zero.
  */
-#undef bcmp
 int bcmp(const void *a, const void *b, size_t len)
 {
 	return memcmp(a, b, len);
-- 
2.29.2.454.gaff20da3a2-goog

