Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A89C42CF7AF
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 00:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729490AbgLDXrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 18:47:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbgLDXrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 18:47:23 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D27C061A52
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 15:46:43 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id t3so4480279pgi.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 15:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LGD/RRlJ9qYcjJKn7WhBQr/iddBUcMbCKVBFUtvDryw=;
        b=W8nYbzW29aK5BI9b3s/HSOzJYye5fofwtRGf/n08NAYFqTAnms5MDGLkVxvQuvia7+
         8lYvKlc7hfU3yjVEqUwwHVXeutiagN4yzJLeVYiNWpjJHD0a/Nl9HfaHBtd3nxPp2lve
         mQVzqhP3egC18W9DwiyAoc7E6BOq0rAXrJ0ek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LGD/RRlJ9qYcjJKn7WhBQr/iddBUcMbCKVBFUtvDryw=;
        b=LP53w6rHs/mHZEsgN+VWYYlV11E6efOWgDctZ2X4Lt4BIDEP10i2nx2QnelNal503+
         ihc3X8CoRYr11OpclH33E43H+1FKdFqYRdCarCth9pWiRo68vueD3xApKesRaFWZPmRu
         YdgAMyZwbnQmzpyrseWsiv++3XRnbR94KhxclildGwPf8/JSa2WzFmeI3p9oJkE4Jc9U
         JEUFQhJmSMn82L1/IjyYAq1YLGV20fDRDsOiCaDiu7P4ENBtL9vFEZ0Yi8EflIZURRH1
         NEqKW/UYKq0h6wv9P8/jGrOb6+9EInNZRTqzFgqPSLAzARt7wRgrNB3x818rI4Ft3Whi
         Sn7w==
X-Gm-Message-State: AOAM530fpUbTEvoRATj1bMcAPoaRNSC6X/4YxBZCl03O0fuiZ2JMsLEr
        sKwehZ7FdCFu/z846iEEvEddMA==
X-Google-Smtp-Source: ABdhPJxst/88x4vpS1tQ3o1+yZeDoCO32pjKEs+qGoYQW6uKQW2SDAJq6pQ3PklTgGowiEbbpxN2MQ==
X-Received: by 2002:aa7:8090:0:b029:198:39d9:23e6 with SMTP id v16-20020aa780900000b029019839d923e6mr5896075pff.45.1607125602602;
        Fri, 04 Dec 2020 15:46:42 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q6sm5732915pfu.23.2020.12.04.15.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 15:46:41 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kbuild@vger.kernel.org, Emese Revfy <re.emese@gmail.com>,
        linux-hardening@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] gcc-plugins: simplify GCC plugin-dev capability test
Date:   Fri,  4 Dec 2020 15:46:29 -0800
Message-Id: <160712557572.2401125.2412248759980660312.b4-ty@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201203125700.161354-1-masahiroy@kernel.org>
References: <20201203125700.161354-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Dec 2020 21:57:00 +0900, Masahiro Yamada wrote:
> Linus pointed out a third of the time in the Kconfig parse stage comes
> from the single invocation of cc1plus in scripts/gcc-plugin.sh [1],
> and directly testing plugin-version.h for existence cuts down the
> overhead a lot. [2]
> 
> This commit takes one step further to kill the build test entirely.
> 
> [...]

Applied to for-next/gcc-plugins, thanks!

[1/1] gcc-plugins: simplify GCC plugin-dev capability test
      https://git.kernel.org/kees/c/1e860048c53e

-- 
Kees Cook

