Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5F425CACD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Sep 2020 22:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729702AbgICUfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Sep 2020 16:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729561AbgICUcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 16:32:48 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72358C0619EE
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 13:31:35 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 8so2499781pgm.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 13:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=1wwsKOGiECV1D1KgEHVbv0B/BweA4F/I9dw72JmCR3Y=;
        b=jsA0R90VNx0CoNdYrwoyOulsyiH5eOY2B2rBuxLOroD3N8gF6y68Uc74RwL8AKswR5
         n5/cBj7T/lyKXDy+P6JEI3be0GGmxiSkgHJmFktuKctZm2r28JRNmXt3g4bRrATpRRJj
         AKOpxNPAVu2AFG1rMtyHbfAjRlhyxI5DXqho5Y5dgitaesdKWb1R2Xlfv4eCDShyWxYd
         M2olQjWDVjBt6grqHSaDbsq6b9joIjXKtUCXnqfaiFE3kVTOyDzHYaowglyC6rRbuC8n
         ZMsNaxWGpDQCuE51B+THxTbQeMBeUvq6W0Zdbe2AYAQZkL71Lk4+kzlFUo83wtb7N8s5
         fiJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1wwsKOGiECV1D1KgEHVbv0B/BweA4F/I9dw72JmCR3Y=;
        b=tt7N40sYMeB4Bc/slZS6CFIQzMYfOl+2PtfQyTOXJYDGO0EjtYe7UZfHLZw58xcocV
         Z29sz6iXjOV8ZKkBCUDi3KqT1hyVpY4kHOcvsAS2heAcWxxxpoXO5TD6LylsKbAnQcBD
         bAOL299za1gPw4vrjtmAtKGmZdCJSJ1gWZWbLCXWolBRg0c4qhB6WjfGipp4w0h9Hz8L
         903KktsEMehhWJIjQOo8FUJ6SHbPFhH8flBG0cA0SAQc34RKgJ6Hb2giqsQuJ919anVr
         rVJmbxFM6VCBdb1r4NRIybNQ1lFetyUSk73tYHP2Pk6EB/CravWaAoYQ3WNlezYfjN/3
         DfmA==
X-Gm-Message-State: AOAM53280WrLyqoEh8URhZd9sn5aQnRU0Dr9Eu/l6S/9LfUPZFXI3BuX
        P/ghzX7FLix/cwNCX0bTUIg+nlkSaU76nTh8Ti4=
X-Google-Smtp-Source: ABdhPJwEKrxzd5NrBrajDh1vcsnhdiTwGRM7+BFQV4hZChNnFjkX2yaVuQmX8BQu56ntgdFiR9mN2xnv8SJVdSGGSeE=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a17:90b:384c:: with SMTP id
 nl12mr4502047pjb.205.1599165094662; Thu, 03 Sep 2020 13:31:34 -0700 (PDT)
Date:   Thu,  3 Sep 2020 13:30:44 -0700
In-Reply-To: <20200903203053.3411268-1-samitolvanen@google.com>
Message-Id: <20200903203053.3411268-20-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com> <20200903203053.3411268-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH v2 19/28] scripts/mod: disable LTO for empty.c
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_LTO_CLANG, clang generates LLVM IR instead of ELF object
files. As empty.o is used for probing target properties, disable LTO
for it to produce an object file instead.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 scripts/mod/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/mod/Makefile b/scripts/mod/Makefile
index 78071681d924..c9e38ad937fd 100644
--- a/scripts/mod/Makefile
+++ b/scripts/mod/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 OBJECT_FILES_NON_STANDARD := y
+CFLAGS_REMOVE_empty.o += $(CC_FLAGS_LTO)
 
 hostprogs-always-y	+= modpost mk_elfconfig
 always-y		+= empty.o
-- 
2.28.0.402.g5ffc5be6b7-goog

