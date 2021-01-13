Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3BD32F4106
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 02:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbhAMBUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 20:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbhAMBUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 20:20:00 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C89C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 17:19:20 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id az16so128740qvb.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 17:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:mime-version:date:message-id;
        bh=sQ8DknuOX6cEszUMAK4TjW4DpTvZqznr0/2Yp0CDLHo=;
        b=DBrGyaONyFBpVhbn1+CjZUD9gjG1UBk1O+llwONE8MBcZpPZX79Ejm+xpqSHicbwA9
         sui/fYOAdOE0PXdmv4jJ47N/lC3kBxlCwzk7WDiKLVSKKZr1VH/7rajjTiGhA5uLNhG2
         h3hVjPD14cR+/7iekBEJ9ZIxSxHjIIxNyOIbVUndp77h6/gieNhnLjv7d2dqUE7w+W42
         6JtCo1Pd6Lj5fhAWYGR05RM3l3TlOCp8ANLE3aJ1gtGJ8tWq/R/6LTI6uaqLC+qMWQ7t
         2OixnyEvFaaCDicHNlj0ExxBgGkja3+lF7AviEZrvoJOx+pP122LtHRxA5JlAUoSzbUH
         dFpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=sQ8DknuOX6cEszUMAK4TjW4DpTvZqznr0/2Yp0CDLHo=;
        b=N75AYUgiqS+f12UqEQ2Ng09f/ZOU71O/WAOF0/dNxLDzyIT+6ualpkwJd+lan4JXKZ
         ut+IQpO+r/ntdNGGYMrE0fCdKNA5TZMxNDqEvukHS+ldHqtc8Ux9QA7Bgh7ohxqFbc0t
         ECr2IeoIStqWEWnv0TaYwMW/w/xAD0iWTF/Nrh5LpiOR/SL0IIVYbjhagiEE3TQKlKHp
         gobMvazIK5PJ049Q4tV7NlBiC0RCA029YtPGWvSuLrEVjhxzKqUtq6C1G+X8EKWccWwp
         VA4ZLBpm4y9O+U5uwHHbCVN1pJ4rMDLfhYF0TXzyx3zFmA+qVRBds/PnjJriTerKS6YW
         at0Q==
X-Gm-Message-State: AOAM533T6HdvB1LPmL2P1QQvlNnoA+3/8EhQXCNGMj1ZoRygXHfORt7t
        n1+u9yjzoksYQ8JPED2fCNL/o3NE0UZP0w==
X-Google-Smtp-Source: ABdhPJwRIYH8P0h+SOVfitntwxUwGY0psd45AWp5DOsEb7nsf/+7e1WVcQ2fn9Jq3w0g0ZsykFiNOg==
X-Received: by 2002:ad4:568a:: with SMTP id bc10mr2585570qvb.29.1610500759367;
        Tue, 12 Jan 2021 17:19:19 -0800 (PST)
Received: from turing-police ([2601:5c0:c380:d61::359])
        by smtp.gmail.com with ESMTPSA id 9sm225861qtr.64.2021.01.12.17.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 17:19:17 -0800 (PST)
Sender: Valdis Kletnieks <valdis@vt.edu>
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
cc:     linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] gcc-plugins: fix gcc 11 indigestion with plugins...
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Tue, 12 Jan 2021 20:19:16 -0500
Message-ID: <38485.1610500756@turing-police>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fedora Rawhide has started including gcc 11,and the g++ compiler
throws a wobbly when it hits scripts/gcc-plugins:

  HOSTCXX scripts/gcc-plugins/latent_entropy_plugin.so
In file included from /usr/include/c++/11/type_traits:35,
                 from /usr/lib/gcc/x86_64-redhat-linux/11/plugin/include/system.h:244,
                 from /usr/lib/gcc/x86_64-redhat-linux/11/plugin/include/gcc-plugin.h:28,
                 from scripts/gcc-plugins/gcc-common.h:7,
                 from scripts/gcc-plugins/latent_entropy_plugin.c:78:
/usr/include/c++/11/bits/c++0x_warning.h:32:2: error: #error This file requires compiler and library support for the ISO
 C++ 2011 standard. This support must be enabled with the -std=c++11 or -std=gnu++11 compiler options.
   32 | #error This file requires compiler and library support \

Patch is more complicated than would otherwise be needed, because
older gcc (4.9, 5.4) have gnu++11 but throw an error due to a gcc bug
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=69959

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
---
diff --git a/scripts/gcc-plugins/Makefile b/scripts/gcc-plugins/Makefile
index d66949bfeba4..cc779973724a 100644
--- a/scripts/gcc-plugins/Makefile
+++ b/scripts/gcc-plugins/Makefile
@@ -21,10 +21,13 @@ always-y += $(GCC_PLUGIN)
 
 GCC_PLUGINS_DIR = $(shell $(CC) -print-file-name=plugin)
 
+# need gnu++11 for gcc 11, but 4.9 and 5.4 need gnu++98
+GCC_FLAVOR = $(call cc-ifversion, -ge, 1100, 11, 98)
+
 plugin_cxxflags	= -Wp,-MMD,$(depfile) $(KBUILD_HOSTCXXFLAGS) -fPIC \
-		   -I $(GCC_PLUGINS_DIR)/include -I $(obj) -std=gnu++98 \
+		   -I $(GCC_PLUGINS_DIR)/include -I $(obj) -std=gnu++$(GCC_FLAVOR) \
 		   -fno-rtti -fno-exceptions -fasynchronous-unwind-tables \
-		   -ggdb -Wno-narrowing -Wno-unused-variable -Wno-c++11-compat \
+		   -ggdb -Wno-narrowing -Wno-unused-variable \
 		   -Wno-format-diag
 
 plugin_ldflags	= -shared

