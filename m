Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 995F72538FA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 22:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgHZUOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 16:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbgHZUOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 16:14:34 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D80EC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 13:14:33 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 187so2129749pgb.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 13:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=IinaA3OlAbDYM7J0tIy8taCdI4ZoZL5ZpgInF7cAa5Q=;
        b=Cu4SyoKWv5V4c9UF3RMRdqzlt5KwAeU44bRELcJ5z8YufoSCSsOxiPK6DVHdAvr8y9
         QfzmDUC/4JSakVod3Psg4D4Hx8EWpKy7B7HvlTiqUG8UWA2zGu7brfpmC2atxFWNF0x3
         bLAkUHXB6ar17vETQMPxqbk3rf8dG/MUdpg6byUJotxQFITvZMuNwYmTi+FhORlGGqIP
         /9kKfq4HWrRDarhj/CZrAKukjN4ndm+TAVotyTWrlm5qC6r+QqsDiuP1G7dpmN46qTcN
         VFFq1pfnebaupXTBt+9ai/ftGLm45e/qyMe7zgri2tktodye7R3oDXPdHFhdHPgQ05yy
         HtzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=IinaA3OlAbDYM7J0tIy8taCdI4ZoZL5ZpgInF7cAa5Q=;
        b=qm3vBCp6tDRJXl+KbWUCXb6U69LbFiYPAF1D1/f2bPcUgQ7+522CE0kr5LfSlb4aW6
         apN/Nb65C82rV/ykgZOff+If4AEEYi1TiCc3vA39fb4DY32zA23zTdtIQl019LrvYao0
         dovdaX+SnEX3/UAg6yD+bFwU8xFRccBFzVqxbqzPQ0s1M5GCXvgRsy/Bqoh3G0QUoeWB
         X9uNc8lrhULh8uopxd49D0EkTTmYzZ3g6J0L/sc8NC8yY3U6VrXYOdtfl1dj0pv1Z95t
         /fW1zojxnukN3AokybgHyvOxhHThKZrf9ibH2feek1ij8w79N4+6awodDhh/4u2PQV0g
         Tqiw==
X-Gm-Message-State: AOAM533uBkizjtEgzKjRRByMETQFJ7kKh+LOPaoEj3mNl7c1kh+kgmhM
        SmGN5YFVSzxhxb4X7vls+5HqWeuN4VbcvQnX8mw=
X-Google-Smtp-Source: ABdhPJxq77ulKQSpn7P9+SOIkZQ+nw2m984QaKvuDVUuYrfVwT8NIcZ4Zg/Vk2JvUspHbwU8muAWztCN39FFZze3Nws=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a62:7d4c:: with SMTP id
 y73mr10660609pfc.137.1598472872538; Wed, 26 Aug 2020 13:14:32 -0700 (PDT)
Date:   Wed, 26 Aug 2020 13:14:19 -0700
Message-Id: <20200826201420.3414123-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH] compiler-clang: add build check for clang 10.0.1
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During Plumbers 2020, we voted to just support the latest release of
Clang for now.  Add a compile time check for this.

Older clang's may work, but we will likely drop workarounds for older
versions.

Link: https://github.com/ClangBuiltLinux/linux/issues/9
Link: https://github.com/ClangBuiltLinux/linux/issues/941
Suggested-by: Sedat Dilek <sedat.dilek@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 include/linux/compiler-clang.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index cee0c728d39a..7338d3ffd240 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -3,6 +3,14 @@
 #error "Please don't include <linux/compiler-clang.h> directly, include <linux/compiler.h> instead."
 #endif
 
+#define CLANG_VERSION (__clang_major__ * 10000	\
+		     + __clang_minor__ * 100	\
+		     + __clang_patchlevel__)
+
+#if CLANG_VERSION < 100001
+# error Sorry, your compiler is too old - please upgrade it.
+#endif
+
 /* Compiler specific definitions for Clang compiler */
 
 /* same as gcc, this was present in clang-2.6 so we can assume it works
-- 
2.28.0.297.g1956fa8f8d-goog

