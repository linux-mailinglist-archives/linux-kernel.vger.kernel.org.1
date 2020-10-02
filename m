Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C263B281E1A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 00:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725710AbgJBWPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 18:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgJBWPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 18:15:31 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB230C0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 15:15:31 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id y14so1722163pgf.12
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 15:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W38dVAPuerCLRPng7jlZI5vlQvHBD4rfwSORzTtYXKQ=;
        b=P86qJ26zBTlGzUNxp4OC0MsOBNi/tpsFSeK6wcegzOcCeUa3XqFl/Ab45EktTGWVmT
         WDJU25a6cT72PvQXY3i14T9zxSdj3mDUKOZQXJVKxVLk8THyKRo9cDtmvJ0w60PzSF8D
         qjFvoco0nsdU5F3wyT0KnCJwALvIBvnmJCpY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W38dVAPuerCLRPng7jlZI5vlQvHBD4rfwSORzTtYXKQ=;
        b=bHiDLyy2fwp/nmA7LyRgjx8TQz6vOUijlqC+184KsN8iTq4+xaCl/8rA65TAHltx4B
         7O2QyNI72iLfjOOeXQTgouZluy3lZEK4DDN27G8pPdIes3SGXeKLcj1p1FoYyCaR6KDw
         DbLEJDf7/BQDHhUc91xLMTy7p3w1gAXQ4VdNmc+l6dmCJpg++WvrSRJ3ukoJKhHkt/UY
         Nmzza58aRtkKal/mH2ik1Z+gKB0DUWem7urXsv/MVqyv9ehpA9qzn3GC3bC70zEZX36i
         MWlReqs7gQ6+cN1yfCAp1jwFAjatDRPvJoHvdRylcUqZgA/PHNq5JX0CCD6dLWgU3dTD
         5pOQ==
X-Gm-Message-State: AOAM5304AuqWcgaUSXUc3zGOJiVZULOmv/TGGzJ2fw8bg4M3Z50yjCdL
        TfYznBGrPjW9T94bo06aWKqsrw==
X-Google-Smtp-Source: ABdhPJwkAsUpzwleQKAEzT+p6nflOsz5Rf8YkJbRfNibKIrcjJp5Zw/DCWLxEksgkxLbLFyq+v6hqA==
X-Received: by 2002:a63:511d:: with SMTP id f29mr4133234pgb.11.1601676930990;
        Fri, 02 Oct 2020 15:15:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q16sm3210133pfj.117.2020.10.02.15.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 15:15:29 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marco Elver <elver@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        George Popescu <georgepope@android.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        clang-built-linux@googlegroups.com, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Clean up UBSAN Makefile
Date:   Fri,  2 Oct 2020 15:15:23 -0700
Message-Id: <20201002221527.177500-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series attempts to address the issues seen with UBSAN's object-size
sanitizer causing problems under GCC. In the process, the Kconfig and
Makefile are refactored to do all the cc-option calls in the Kconfig.
Additionally start to detangle -Wno-maybe-uninitialized, and disable
UBSAN_TRAP under COMPILE_TEST for wider build coverage.

Thanks!

-Kees

Kees Cook (4):
  ubsan: Move cc-option tests into Kconfig
  ubsan: Disable object-size sanitizer under GCC
  ubsan: Force -Wno-maybe-uninitialized only for GCC
  ubsan: Disable UBSAN_TRAP for all*config

 lib/Kconfig.ubsan      | 58 +++++++++++++++++++++++++++++++++++++++++-
 scripts/Makefile.ubsan | 50 +++++++++++++-----------------------
 2 files changed, 74 insertions(+), 34 deletions(-)

-- 
2.25.1

