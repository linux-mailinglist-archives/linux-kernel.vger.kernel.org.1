Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B35259F92
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 22:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732755AbgIAUBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 16:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732069AbgIAUB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 16:01:28 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CE8C061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 13:01:28 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id a8so1092557plm.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 13:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UjrXFlrwlFcaBJes26UhoSpBJyw05OEZbNN97Pv9QCA=;
        b=HEYouRK6zRQC2b74dfauX3z0nMq6GedE0xNxNRJd9FdWfO2xKQm71Lr7yzoxFH25+H
         cSQPa89f7aPEGUPeZR8QKP08J1SD0XT7Wm3kH4AUckMR2V2EWqnG03pzn7c6l3AH2c7m
         A75UNyOguy9wwLbw4piT3uMGHfIkEdFaJQqSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UjrXFlrwlFcaBJes26UhoSpBJyw05OEZbNN97Pv9QCA=;
        b=tEAJC2Imu4h19VgDbKLyprcmO9jfX4uRWu9fXPHu1Omq4kalICjElC+7w8nRxaEYTV
         XaQJdCaJIlYrmtVqod5l9E4xH7r4HRZf3uWF0QEcr7+04aBqfg0ahudvAScIr9K05GvD
         MgIifcR5JzBNCgbGGM1+V2mSELQZFFYBXzsvtFierRfunAEVZTF5E87VLAxkXqxlszzw
         bhE4mPGuc0AsZ9ZQUYvR1DkYahKgtCbopZvYJhBcGywjIfX+hStH6c5faWOsHX/SZ4i9
         nExcWuiK/E1ja0S7E2+tbYwPmqTpLMVCZD1EuHzMC/vLp92sn3SroDeFpPXKeGN7SmJ9
         pBog==
X-Gm-Message-State: AOAM533aiZvBhMPXsbyKDpmJuVmCm+Z+B4/SSI6+IVWTEyoWVvFn2SW7
        Tr4HCTYBtr17SYVwfa0CaHRrwA==
X-Google-Smtp-Source: ABdhPJxQA6wgzqXd9IgaRux7H5G7DlMcStnSUdfcK/yepsungBU/BlogKjVZvzxw5ShAkAPllbZkuw==
X-Received: by 2002:a17:902:d345:: with SMTP id l5mr2720112plk.265.1598990487868;
        Tue, 01 Sep 2020 13:01:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t11sm2829990pfe.165.2020.09.01.13.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 13:01:26 -0700 (PDT)
Date:   Tue, 1 Sep 2020 13:01:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        clang-built-linux@googlegroups.com,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] set clang minimum version to 10.0.1
Message-ID: <202009011255.5BBF4F31F1@keescook>
References: <20200901002326.1137289-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901002326.1137289-1-ndesaulniers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 05:23:19PM -0700, Nick Desaulniers wrote:
> Adds a compile time #error to compiler-clang.h setting the effective
> minimum supported version to clang 10.0.1. A separate patch has already
> been picked up into the Documentation/ tree also confirming the version.
> 
> Next are a series of reverts. One for 32b arm is a partial revert.
> 
> Then Marco suggested fixes to KASAN docs.
> 
> Finally, improve the warning for GCC too as per Kees.
> [...]
>  8 files changed, 16 insertions(+), 27 deletions(-)

A nice simplification!

Reviewed-by: Kees Cook <keescook@chromium.org>

(I do note that for Ubuntu 20.04, they're going to need to do an LLVM
10.0.0 -> 10.0.1 bump to do kernel builds for their latest LTS...)

-- 
Kees Cook
