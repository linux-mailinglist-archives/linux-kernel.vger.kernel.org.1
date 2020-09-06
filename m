Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C36825ED8D
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Sep 2020 12:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgIFKGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Sep 2020 06:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbgIFKGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 06:06:33 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5DDC061573
        for <linux-kernel@vger.kernel.org>; Sun,  6 Sep 2020 03:06:31 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id g29so6608910pgl.2
        for <linux-kernel@vger.kernel.org>; Sun, 06 Sep 2020 03:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=KL+wmvrTuOe0huqscDIyhrzn6EBumFuZhyWqH5h7LEk=;
        b=c8zUgi6JkXaNiny0EIoj552BzqRnjjltlo8I08RQMWCvV/Z11yb8On9JVVQVoQzObr
         3CM4uU0vNU2Zj5aGS+sBakgrvprdY0vuoo2Q7Y5M0OywcuQGLLhGlYwdk+gp7NMau581
         iK5NqjE8nTy36uAhqikkekD99FgzN58pPy7bQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=KL+wmvrTuOe0huqscDIyhrzn6EBumFuZhyWqH5h7LEk=;
        b=Qkm6GGLoTRLSBXoZDtUZbhdWS7367HpwiSfSKCu4A3+Z4gK9U7HkF39bVPqh4Gmy3G
         rNtA1e/tefXfJUuRgs/ztYpSFxWWQ/uf9FFxdtDJnMQdNCED50VwaNtYyozDbrT4ccDP
         o8ZV60ESOjhKQAoyrLI4G/mXJIdKREx63ZiwwvuFtGYQAIsovRfYXXz7aMFtPSDu5/Rj
         HCkNMKamSk9b2KNGj1NDA4wJEg0F7T/1GEmlYYwoNQQUp8i1n9G9WVJTa5zMWIuYPiew
         EefGNnHonHAKhC9Y/3ZGeUuJnAk15DeSFyownDFGUwyET9Ur2KmuMyekFm1ThEx3Z4Dg
         EOGg==
X-Gm-Message-State: AOAM532XrFGMS7SB3A0VmD8fkGvMrZUcBe04A34BMeRUYMfQQV1Z1o+s
        ljg1goJ1ru6UD044EvaF0A9bzWRYvPrDeQ==
X-Google-Smtp-Source: ABdhPJwKj3IgZ7OC6OMvIkmlTiTII54sdP29IfEWSFKBQ5QyJdqprdyCDzIAUsoAtXX0Mk/8wYJdTA==
X-Received: by 2002:a63:593:: with SMTP id 141mr12334377pgf.302.1599386790770;
        Sun, 06 Sep 2020 03:06:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s129sm11795423pfb.39.2020.09.06.03.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 03:06:30 -0700 (PDT)
Date:   Sun, 6 Sep 2020 03:06:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Joe Perches <joe@perches.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Yury Norov <yury.norov@gmail.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] lib/string.c: Clarify kerndoc for stpcpy()
Message-ID: <202009060302.4574D8D0E0@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the language around return values to indicate destination instead of
source.

Reported-by: Masahiro Yamada <masahiroy@kernel.org>
Link: https://lore.kernel.org/lkml/CAK7LNAQvQBhjYgSkvm-dVyNz2Jd2C2qAtfyRk-rngEDfjkc38g
Cc: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
This is a fix for lib-stringc-implement-stpcpy.patch in -mm.

Andrew, please note that it would be nice to get this into -rc6
to unbreak the clang builds.

Thanks!
---
 lib/string.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/string.c b/lib/string.c
index 6bd0cf0fb009..32a56436c7eb 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -280,12 +280,12 @@ EXPORT_SYMBOL(strscpy_pad);
  * @src: pointer to the beginning of string being copied from. Must not overlap
  *       dest.
  *
- * stpcpy differs from strcpy in a key way: the return value is the new
- * %NUL-terminated character. (for strcpy, the return value is a pointer to
- * src. This interface is considered unsafe as it doesn't perform bounds
- * checking of the inputs. As such it's not recommended for usage. Instead,
- * its definition is provided in case the compiler lowers other libcalls to
- * stpcpy.
+ * stpcpy differs from strcpy in a key way: the return value is a pointer
+ * to the new %NUL-terminated character in @dest. (For strcpy, the return
+ * value is a pointer to the start of @dest. This interface is considered
+ * unsafe as it doesn't perform bounds checking of the inputs. As such it's
+ * not recommended for usage. Instead, its definition is provided in case
+ * the compiler lowers other libcalls to stpcpy.
  */
 char *stpcpy(char *__restrict__ dest, const char *__restrict__ src);
 char *stpcpy(char *__restrict__ dest, const char *__restrict__ src)
-- 
2.25.1


-- 
Kees Cook
