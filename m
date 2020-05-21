Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF68D1DD840
	for <lists+linux-kernel@lfdr.de>; Thu, 21 May 2020 22:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729322AbgEUU1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 May 2020 16:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728365AbgEUU1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 16:27:23 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60966C05BD43
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 13:27:22 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 186so6730590ybq.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 13:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=GkG9xsAhJ+pShDH+d4d2X98f90rTaKTAoKNDQBhcics=;
        b=jix5+TViqcLHXWKoscSQIz+Kfk6XZkvQnlTigyaTIz0LFWBlXc6l1grS/3wsXGQDUr
         /mwfHPpmS8FZP2XpaJ5kdedErbZulbkz4ZAKG74YJXz/y255g8aJHC2EoAZIA4Yxzmhi
         kY54wIhor5QSc1JnETCzmRj7pxJcko3mumUxLKHd03E/lFENaQ13+PV/A9pEs+AB+LMb
         35YFv37+TilxzLSyIGexDtjWfxb04cA3ydx02wBZ7WAa7t3J3Hg9FIwQ0lbz6RxJHy/U
         FIC8MBI3RB4eHrwFDVUSyx/TeQXkD9Pn+Zwn7hmv6oA1h8ZBL7NmYtOdca+gmYfMP9dz
         hCGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=GkG9xsAhJ+pShDH+d4d2X98f90rTaKTAoKNDQBhcics=;
        b=K7WD4+DIdfCUac0S6fwoEEvuY6cxftSLgrpdOgYU1QAM+qix+c9lrkji9a82Y6ceDY
         6M8U/CwoOhG+yjP3NtkA2AfRZ+Zz4PPnyBlA8mI86OuHdwcg3F+HzQWO38w35s72q0Km
         ZaGg5Yt7G2fqYQz7eTApNsRt2Rxle2dXV2XESYpHdsbVe5ZsovKuHBh/TD8gXMpqmy8w
         9/OW+rMGLJamzCZJRWw2KwPq4+BvQTNP4cZFuflNDUp2QEviWrt4QdzrIWMzoYdEWap6
         NcZCbP5IHQTCCz1VxcWy5cJxRlgVJzwM9jRgawGAnhAsuNVPnMKXklpW6vcRgwPcwxID
         B2nA==
X-Gm-Message-State: AOAM5336cwDLY47CbJbE/qeMmAEqPEn+0BYyUQEvdTfmVuYLNQxhPMLS
        vTPDfsphdn8HpNOLxuJ7EhcsS6L5WrNSoDowA24=
X-Google-Smtp-Source: ABdhPJxkkMI44JP0E64EaF0MUV3zDrFTM8DJ9779Ya6G5m7K+7uFGA+yP08mMIGVPF67M3n6qjbT8kn/xVt2FmyfeLw=
X-Received: by 2002:a25:c010:: with SMTP id c16mr3140273ybf.506.1590092841442;
 Thu, 21 May 2020 13:27:21 -0700 (PDT)
Date:   Thu, 21 May 2020 13:27:16 -0700
Message-Id: <20200521202716.193316-1-samitolvanen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
Subject: [PATCH] kbuild: reuse vmlinux.o in vmlinux_link
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     Kees Cook <keescook@chromium.org>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of linking all compilation units again each time vmlinux_link is
called, reuse vmlinux.o from modpost_link.

With x86_64 allyesconfig, vmlinux_link is called three times and reusing
vmlinux.o reduces the build time ~38 seconds on my system (59% reduction
in the time spent in vmlinux_link).

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 scripts/link-vmlinux.sh | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index d09ab4afbda4..c6cc4305950c 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -77,11 +77,8 @@ vmlinux_link()
 
 	if [ "${SRCARCH}" != "um" ]; then
 		objects="--whole-archive			\
-			${KBUILD_VMLINUX_OBJS}			\
+			vmlinux.o				\
 			--no-whole-archive			\
-			--start-group				\
-			${KBUILD_VMLINUX_LIBS}			\
-			--end-group				\
 			${@}"
 
 		${LD} ${KBUILD_LDFLAGS} ${LDFLAGS_vmlinux}	\

base-commit: b85051e755b0e9d6dd8f17ef1da083851b83287d
-- 
2.27.0.rc0.183.gde8f92d652-goog

