Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97B32288E44
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 18:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389856AbgJIQPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 12:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389778AbgJIQOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 12:14:21 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F69C0613DA
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 09:14:21 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id w64so7133222qkc.14
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 09:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=IWlwO4V8zfIKj2VoQVJSOpIzEd6XIOwNzizfhzYsm+I=;
        b=icGF2o4BoUC5H7jDfDcqIeIDmztt1DX3EBV4AR9CIZel1UdghtV62q3fzjA81E5ME4
         x9g3yQfuIaLSgx21c6ABnIjUmaI4VqxjY4B5WnUXRoUb92nAtC/XbQPpxdBRAKJqH+qH
         jcvBMX8XEpz4rNBFWhnnnRs6RxEEg7NtFbXbUMhmEcBsm9ep+5oJx3BqoMUfqRJe9eh+
         HQV2rljyVTcunwoXwynW5GLctChORkFUDmM1/j1sk+6+WxF8Dg5/LcVdGd37dGhF+GtO
         M9aoDBKTtmJg2M/huHN2yYE2hfJUvsC+WO6y4SzBmnETs4aTNvX9A0N+1ApFOCsrkyFd
         VCjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IWlwO4V8zfIKj2VoQVJSOpIzEd6XIOwNzizfhzYsm+I=;
        b=t6FSlOT4bVWt5Qe9meoDlf9WJbIsapZ+A3GTq/XH8JE30GIBFXYyzEAPHEorteySeR
         Y43SdX1c2DgTO5L8EU8rY8WEu3ENKXeyLVoMrXlReCHXSHbFlI/5pURqH/4WDJ49KJWk
         Ic1F0tz7+1/PGmEzmWzKAve/Z5P/4eYb0NwvBNuG4MKmAooUEYkB5ExT90z7uf7QY1A4
         fjM1I0JparoTt18UWYn1GCbZXg5Arwtfp6HaiYIYAvN1QJQ3XEQz1Bt3Tyn6N11tY82h
         btjmFc9oukzyJ4k0xGZH2ht7EwxPPy+4zaK7VCp2tb88wC4T9h1uKvNz0fHazt/kQCo2
         QD7g==
X-Gm-Message-State: AOAM53240d47XXlJvsezqg7NRQnNB20MiI1/CCe0D1ub7hTxu/dP1myo
        XzzMtkPvCYGN7ggReMOb4bkLgZdbZhXPXvgjQdA=
X-Google-Smtp-Source: ABdhPJxEWHAvyNkdIDlQRKJ2smQRYfbTU12bNHGd7NqYEmxH7inHJ1sIHSNvQnTIBhdfm/bIQe6W23Fz9FB7iOfrFU0=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:ad4:43e5:: with SMTP id
 f5mr13905635qvu.12.1602260060762; Fri, 09 Oct 2020 09:14:20 -0700 (PDT)
Date:   Fri,  9 Oct 2020 09:13:29 -0700
In-Reply-To: <20201009161338.657380-1-samitolvanen@google.com>
Message-Id: <20201009161338.657380-21-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201009161338.657380-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v5 20/29] efi/libstub: disable LTO
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_LTO_CLANG, we produce LLVM bitcode instead of ELF object
files. Since LTO is not really needed here and the Makefile assumes we
produce an object file, disable LTO for libstub.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 drivers/firmware/efi/libstub/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 0c911e391d75..e927876f3a05 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -36,6 +36,8 @@ KBUILD_CFLAGS			:= $(cflags-y) -Os -DDISABLE_BRANCH_PROFILING \
 
 # remove SCS flags from all objects in this directory
 KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_SCS), $(KBUILD_CFLAGS))
+# disable LTO
+KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_LTO), $(KBUILD_CFLAGS))
 
 GCOV_PROFILE			:= n
 # Sanitizer runtimes are unavailable and cannot be linked here.
-- 
2.28.0.1011.ga647a8990f-goog

