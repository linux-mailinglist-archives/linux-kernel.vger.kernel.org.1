Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33FFD2F6763
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbhANRSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbhANRSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:18:32 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7F6C0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:17:51 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id p5so2631360qvs.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rLcBppnM0ZASYq/J9hvFFWbJph0iUmsiQatVdfz+NG0=;
        b=sH1F492Gl7C7mkwf5mK59MkOzrkkZMvh4XpeaQmgf+7oHtbdOROrLylyuzPwfyzkfz
         ourkv03TFHTQ/xfDWsLokD5Rhq7GxzPSkCeZ2KYmlL3IM5XR8KpINBayQzfsIm/339Gt
         e772wN2JBLVx5hwu556Rf0/8v5tM1yKzAB+mrWiDl9qDSM9OvvvQ5FnScKqkHMEXSdoO
         STCFXKULGr2rTfqhFAhyaFraHunTmX9/CYmM6n+Khd47HzGBKuH4YCjuTSlSsoArL5w6
         8gtgsEl0scW3DTCdEbPGalmIMT8yHp22yLUFHamK+OHKz9D7ulhlNUAu02dA/NlJk/M4
         Vd3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rLcBppnM0ZASYq/J9hvFFWbJph0iUmsiQatVdfz+NG0=;
        b=kjk6FOknUMxRDSnwRlNZ/WxWYUc6OPS3M/yNeOQq9A7lUeX6qYa+ZllP4NP1LHzC02
         TX64li935UV7XVufHMLYcU6o/CHL08rSC9FSUAK/udErOMVkySVGIQJheBOM/m3Du6jS
         YayEa6n+Pbt921eLEX2HOhQlHD42WDJXp//bHrgOmlJq30Jrm+PZmFCbeonWfNANhpEC
         cbgmANl0DNxe2o1rYyvng79P6CK6QC1I0zxIzuC7E4mi5EzKy3krDLrxFFlv5tuol4h9
         HhIUCR8esLytfWiqsT8BWQV8MNnERxJu8SjqDuPO3Hhnn12OqGzizDH0yz5Fktc6fTe/
         4bLg==
X-Gm-Message-State: AOAM530e7u9GTOMr55Og+UctxHfPDiwJx3olBWPReamiIu4x+PrPXt1K
        FsYyvOW8CjWZWlP+ogeZ3M7gGH4fkUZjhA==
X-Google-Smtp-Source: ABdhPJyhAMXyvVszgK40uevz8/yNrQuQ6IDCEH7tuglo5h5RYFRZcUFwkeFCdv93JzAMxGlMcVQz8A==
X-Received: by 2002:a0c:9e5a:: with SMTP id z26mr8232837qve.2.1610644671008;
        Thu, 14 Jan 2021 09:17:51 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id r15sm3332289qke.55.2021.01.14.09.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 09:17:50 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH v2] MAINTAINERS: Add compiler-clang.h to the Clang/LLVM section
Date:   Thu, 14 Jan 2021 10:16:30 -0700
Message-Id: <20210114171629.592007-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210114004059.2129921-1-natechancellor@gmail.com>
References: <20210114004059.2129921-1-natechancellor@gmail.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The K: entry should ensure that Nick and I always get CC'd on patches
that touch thid file but it is better to be explicit rather than
implicit.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

v1 -> v2:

* Omit scripts/clang-version.sh as Masahiro has proposed unifying
  {clang,gcc}-version.sh into one cc-version.sh:

  https://lore.kernel.org/r/20210114042420.229524-1-masahiroy@kernel.org/

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cc1e6a5ee6e6..8036a7860836 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4313,6 +4313,7 @@ W:	https://clangbuiltlinux.github.io/
 B:	https://github.com/ClangBuiltLinux/linux/issues
 C:	irc://chat.freenode.net/clangbuiltlinux
 F:	Documentation/kbuild/llvm.rst
+F:	include/linux/compiler-clang.h
 F:	scripts/clang-tools/
 F:	scripts/lld-version.sh
 K:	\b(?i:clang|llvm)\b

base-commit: 7c53f6b671f4aba70ff15e1b05148b10d58c2837
-- 
2.30.0

