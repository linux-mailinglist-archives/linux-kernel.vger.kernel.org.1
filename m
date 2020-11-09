Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D25C32AC3E6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 19:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729814AbgKISfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 13:35:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729320AbgKISff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 13:35:35 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3863BC0613D6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 10:35:35 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id t64so6635811qkd.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 10:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=UPtFfO/KAGWjAZ8J0b/rcbbvthH9v1BWCmAggArm5i8=;
        b=vKs5LajVBuLwgcTXsa04azyliKJQi5uGBHpoBZQTKHdiPBPI8ds9ivlapOW8u5uGCT
         Y+le2kl8KzoOf5zjXrcY/r12LsBEZuMYGzMzUyvBWX5zTR8q1h8C1BRdkkS2h7faC3gd
         dWcwQniJuCPtPlYBrHtcUSe3o+fqWUUioN7sgNpk04r9BseaXw//Kr2z2g/uqNRCuGyH
         IcruuoMx9dT/Sl65YKMJanasPemkm1w//WpuFOiOHGZDBt/jI/Znff/6OsNiEOqKlhYr
         zuyrjsFW5Psr/ecmVk8p5sRfgeDAjyCWiJ1Z3tDoNHlUTG0n1vPonPh6ZqWIm6Da2lxv
         sRNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UPtFfO/KAGWjAZ8J0b/rcbbvthH9v1BWCmAggArm5i8=;
        b=SKwAsLMBWFR4KqNXpbJoziyCSKymnC4m+c3gw6B9Jr6RnpVMmIhChCFKcb3risrKZI
         hhLcE+TIEBB7bUYxJCo6wzf9b/8SKDkIdT+cpSI+0ZvIhowp6dQl9Ch3VAbqYJLvzaQh
         JNKukGB54unVHoR3yWfX/nB0cGUSlpC+pXJ3BDeH1Ti5L+0gt6ez6Kw5ccTOnyZoZASD
         aapgmxDHNMqEpqFVjYHx4nCqTnNUMz3OHmyaBy3oay1AwqzowUo1YbSdcxia2RTvyvCg
         SXK/o7LskFmY2AP1zxxYDMb4yIJXqYLtQHUV3aaRcD+2FiBtABcb5TP8cRtNKZOa7Y2s
         wwXw==
X-Gm-Message-State: AOAM533HTnOCqp9I2oUWwrP2epEjv4TgbRLeQ6hrUCKftPRkD97S/D4d
        DYxrd0tCrFmxhyv6mM145rzaaTZ6wXhF4q+cpUk=
X-Google-Smtp-Source: ABdhPJwgPIHlj9NT7rS2i7sB9ZpOasgaq9iZtu2LQMEd+sLO0IZwnKE+DnnlR5Y1adiIDuPR7yiHasMmtC6f9JFfLw4=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a05:6214:174f:: with SMTP id
 dc15mr15123606qvb.26.1604946934162; Mon, 09 Nov 2020 10:35:34 -0800 (PST)
Date:   Mon,  9 Nov 2020 10:35:28 -0800
In-Reply-To: <CAKwvOd=9iqLgdtAWe2h-9n=KUWm_rjCCJJYeop8PS6F+AA0VtA@mail.gmail.com>
Message-Id: <20201109183528.1391885-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <CAKwvOd=9iqLgdtAWe2h-9n=KUWm_rjCCJJYeop8PS6F+AA0VtA@mail.gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH v3] Kbuild: do not emit debug info for assembly with LLVM_IAS=1
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-toolchains@vger.kernel.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Fangrui Song <maskray@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Dmitry Golovin <dima@golovin.in>,
        Alistair Delva <adelva@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang's integrated assembler produces the warning for assembly files:

warning: DWARF2 only supports one section per compilation unit

If -Wa,-gdwarf-* is unspecified, then debug info is not emitted for
assembly sources (it is still emitted for C sources).  This will be
re-enabled for newer DWARF versions in a follow up patch.

Enables defconfig+CONFIG_DEBUG_INFO to build cleanly with
LLVM=1 LLVM_IAS=1 for x86_64 and arm64.

Cc: <stable@vger.kernel.org>
Link: https://github.com/ClangBuiltLinux/linux/issues/716
Reported-by: Dmitry Golovin <dima@golovin.in>
Reported-by: Nathan Chancellor <natechancellor@gmail.com>
Suggested-by: Dmitry Golovin <dima@golovin.in>
Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
Suggested-by: Sedat Dilek <sedat.dilek@gmail.com>
Reviewed-by: Fangrui Song <maskray@google.com>
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Makefile b/Makefile
index f353886dbf44..7e899d356902 100644
--- a/Makefile
+++ b/Makefile
@@ -826,7 +826,9 @@ else
 DEBUG_CFLAGS	+= -g
 endif
 
+ifneq ($(LLVM_IAS),1)
 KBUILD_AFLAGS	+= -Wa,-gdwarf-2
+endif
 
 ifdef CONFIG_DEBUG_INFO_DWARF4
 DEBUG_CFLAGS	+= -gdwarf-4
-- 
2.29.2.222.g5d2a92d10f8-goog

