Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4CE2A6DA8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 20:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731485AbgKDTNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 14:13:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731466AbgKDTNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 14:13:44 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892B0C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 11:13:44 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id b25so22866272ybj.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 11:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=uYTChtPoUZn68QnU98ObMvhC9uF9K4phW3blmsNr5ng=;
        b=J8L1VcQLpWaYwk5TXhwHuyzXC+bLLjOKKMgHPgUvOyu35w92we2LCRqFGPPyVyX9PU
         FCVxZNMziDFxQmvNgFBRlicuSlPzT4tEWNJ/J4tnerbExp4m0PWrvq2CTs4qZUk+UttU
         mpPj4A2geJz4ZYwgDWu1Z6/aZFhe6lR7afuvqklzz9J6HLI7DJP/fj+8gAeiFsQgijxp
         bZDDXN1saKwe95UzdpPNW/LmsSerkBT0/SAXjUFPPG4LgMmefObLNbCI3/jX8UeZ3fwm
         f2j8mrNFst2tMjjgI3zyF10zSf7lWAPle0fEL/xQdawH+yR2tzGJwKxoEhAQ41vr7na6
         LBHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=uYTChtPoUZn68QnU98ObMvhC9uF9K4phW3blmsNr5ng=;
        b=Kt0z6qvrug8/cnDYXdNTCYyM+RX2mJqcRDojjI66rPnayjS9GHRoIK/0KLxkR5APo1
         aSiYdjvDdj7/V/MRWDy2vhqGXl6NpWPNQB7raUsARjAjzj7KqydjtAPtdnKDzr7HxDYY
         bvpjl6A6u/N6QOxKaeZgwrLllNRhbtF5RH9UxjSV+74qTl3BecfFr719WSkqF4PH8yns
         e2GyySxOh95X1NndDCeus3ExUOPWmTdeNFySbgsQrhBXUUFfinJclCHCMygWx6CGkVHm
         XODvT0kGRPQ10XgpRy8VP4nBjzadX6/XOPM+qPp8kBJQsCJTIvveAam5ajnU8qZK7NH5
         e13Q==
X-Gm-Message-State: AOAM533vbPm5i/cWbHx9DvU5ICRZLkoSUkVyQD3r3sPalRHZg8pXK6ZB
        nLskvQZhrRdd6gw/LDWVrbNs7T+0PrEGuhKlXMA=
X-Google-Smtp-Source: ABdhPJxg0ez4h+LV3GpK48TsldixSvXLdah99f65jwhJpLLoMmn1AYu4aN0v5n7HEk8jMeDcNiDCpDhLzVYfAEEVrVE=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a25:ba4c:: with SMTP id
 z12mr36344394ybj.366.1604517223782; Wed, 04 Nov 2020 11:13:43 -0800 (PST)
Date:   Wed,  4 Nov 2020 11:13:34 -0800
Message-Id: <20201104191334.393972-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH] MAINTAINERS: mark LLVM as maintained rather than supported
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Funding secured.

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 721fa3aa62d0..165f580586aa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4274,7 +4274,7 @@ CLANG/LLVM BUILD SUPPORT
 M:	Nathan Chancellor <natechancellor@gmail.com>
 M:	Nick Desaulniers <ndesaulniers@google.com>
 L:	clang-built-linux@googlegroups.com
-S:	Supported
+S:	Maintained
 W:	https://clangbuiltlinux.github.io/
 B:	https://github.com/ClangBuiltLinux/linux/issues
 C:	irc://chat.freenode.net/clangbuiltlinux
-- 
2.29.1.341.ge80a0c044ae-goog

