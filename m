Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A01EE27DB0A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 23:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729508AbgI2VtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 17:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729197AbgI2Vrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 17:47:45 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEEFCC0613DE
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 14:47:26 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id q131so3660321qke.22
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 14:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=dEqcNX1Djl0IV1+V4O1jZ3zX0CSjG7hkO+H8f2GKot0=;
        b=VQOoXlScak0WysBr/W0lMAFEgBmf32Hfw3oXYJ6KFr0fKBu3y13ZA46qQn/qdgZK8G
         i7ux8V3oo0qTphW/9JBrWhu78R0GtF1wBcMFmXjLpLEc7GSsvPNid7x6lav1uJEis2a7
         9W/iGpPEQWtZ88Ylf6C8QNA3xu3tblmY6b/lZ2G2WdHJgfBPHmhOTR1ICCMpX+ICACEs
         gkyzgzySrJUDgSqaEtM3K6Q4WXigD1N/jiQrFgmXGoYkLUA/xKM7BuINs/wO+fWF4DHc
         JWaw9z1iMdO3i+MVSCqHWvgzTM8qRNCbnWvbhhOBb0dwF6b5pI+bPyepJLJRhfWXJMhQ
         QkeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dEqcNX1Djl0IV1+V4O1jZ3zX0CSjG7hkO+H8f2GKot0=;
        b=d3d6bMLZk6IiBcVAPkPo7pux086B5LTr9doen1VCPzLDu+JgTN2DC6pzh27yM+7Sud
         FgIUVFWymFYak5XNyP0Egk1eyMR1iQURy3/7WsqTiqtrp7zlVbHrRRlFMeoB3nw3cZDT
         K/+Az4l1iGvehjmrCpkKp+fXM4uZgiNeMhG560CbUgiJh52ngQXCaYgxOamToJ9qn8zA
         tiI88RsjHRjCIkfPso/MbPbFnlXixEH99sXV8L6+krzCxmmzm1WR3PGKUrAHrwVvgrGz
         1U0eF4UYXTLV7/jSuI56CSKnuzVYHDYjfbFZZcsfeFjw8a4tCrH00WwsUlJNMV8Hd7+W
         oIXA==
X-Gm-Message-State: AOAM533J9nwsoSwmKiOnnDptSrhwBAfSnIw/cltqIYiSf460qc6Z44DQ
        Z0M1VCq+L5O+mPgu9BvidhkOIpWdy4hyavRDRuo=
X-Google-Smtp-Source: ABdhPJx3IHLlEpEE6lKzgLbRoH8pUHS5aZ5bMzeasJnHs8u5b0ZHEbgeZKYJBmfQeDJ5khZeV7Cye7dg816GPppPI2c=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a0c:abc7:: with SMTP id
 k7mr6181365qvb.45.1601416045978; Tue, 29 Sep 2020 14:47:25 -0700 (PDT)
Date:   Tue, 29 Sep 2020 14:46:25 -0700
In-Reply-To: <20200929214631.3516445-1-samitolvanen@google.com>
Message-Id: <20200929214631.3516445-24-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200929214631.3516445-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v4 23/29] drivers/misc/lkdtm: disable LTO for rodata.o
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

Disable LTO for rodata.o to allow objcopy to be used to
manipulate sections.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Acked-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/lkdtm/Makefile b/drivers/misc/lkdtm/Makefile
index c70b3822013f..dd4c936d4d73 100644
--- a/drivers/misc/lkdtm/Makefile
+++ b/drivers/misc/lkdtm/Makefile
@@ -13,6 +13,7 @@ lkdtm-$(CONFIG_LKDTM)		+= cfi.o
 
 KASAN_SANITIZE_stackleak.o	:= n
 KCOV_INSTRUMENT_rodata.o	:= n
+CFLAGS_REMOVE_rodata.o		+= $(CC_FLAGS_LTO)
 
 OBJCOPYFLAGS :=
 OBJCOPYFLAGS_rodata_objcopy.o	:= \
-- 
2.28.0.709.gb0816b6eb0-goog

