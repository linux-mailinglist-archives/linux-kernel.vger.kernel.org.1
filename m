Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80A302CDC87
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 18:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgLCRiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 12:38:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbgLCRiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 12:38:02 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A657EC061A4F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 09:37:21 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id q8so3417088ljc.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 09:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IAYzt5aWmV7k8rYu1oRqo0Iimqerq25dwLnLWK087IQ=;
        b=g0RuxTC/9WXibSwY5+tIOu4MFx49cSGSc9R6BBeB0r2N/EwzO3l5hiz5zRhoRxTjkr
         /6iZvATcu++ZOkyFOL9z5bNa8MptTxwO92Sq8SlrhC4i9hnYgcuER2QESiIS5hyddN64
         7B+S6BMI/TOidGb4AUDbKQSxvIkDJJJ/NGFPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IAYzt5aWmV7k8rYu1oRqo0Iimqerq25dwLnLWK087IQ=;
        b=ALWQOdKunBdMa0Qh+HMMR2P0OXMES2CAaogMy86VBh0D5OfBl/BROY/UThk6wdCTer
         YM6jxdk74TqAfRdf8vxxgScijeqSwUpODUacP8s7CkW31zZybC57SJSUJwFgz6+ctQNz
         rFz+ZJtawHIfVN0s03Zd/21cB3bqEDC+TOVsqLIQH7d5VN7d4yqTH3kh8za0gJkOy+yU
         aeIxTHPPPpTM017k+9cRx8xm48VjvuZng+T8vwU/7Et2OYD2bsIuBVPvNre3xcfIxcXD
         DL5h+W7Dft22B+rozIg1lm/ozJKIaYiMRVkA4TAA6J/NnrrsrHhB69fDBPUtyoQAeHlW
         tpKw==
X-Gm-Message-State: AOAM533KdvOL/D0yWK18XqlppqhJ1FnFC3gTZJm4nIOJwAtCCidJLe/D
        vTXxBBwG1pzEzd80h+pNM9pTxUU+NQ0+hA==
X-Google-Smtp-Source: ABdhPJzGnt8jC0yIn3AnQAi2/B87EEfKhFnq24TTLs5nN9K9gE8JmLkpd9A7bP/9MVHSRoUiaogiwQ==
X-Received: by 2002:a05:651c:1051:: with SMTP id x17mr1770335ljm.56.1607017039602;
        Thu, 03 Dec 2020 09:37:19 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id c2sm728225lfh.218.2020.12.03.09.37.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Dec 2020 09:37:18 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id f18so3429143ljg.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 09:37:18 -0800 (PST)
X-Received: by 2002:a2e:a543:: with SMTP id e3mr1691756ljn.421.1607017037787;
 Thu, 03 Dec 2020 09:37:17 -0800 (PST)
MIME-Version: 1.0
References: <20201203125700.161354-1-masahiroy@kernel.org>
In-Reply-To: <20201203125700.161354-1-masahiroy@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 3 Dec 2020 09:37:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgRV9VHO2RVwn+iMfH_WFjQV1dsZtEQhgrUBQfM9QBPmQ@mail.gmail.com>
Message-ID: <CAHk-=wgRV9VHO2RVwn+iMfH_WFjQV1dsZtEQhgrUBQfM9QBPmQ@mail.gmail.com>
Subject: Re: [PATCH] gcc-plugins: simplify GCC plugin-dev capability test
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Emese Revfy <re.emese@gmail.com>,
        linux-hardening@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 3, 2020 at 5:03 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Checking the existence of plugin-version.h is still needed to ensure
> the plugin-dev package is installed. The test code is now small enough
> to be embedded in scripts/gcc-plugins/Kconfig.

Ack. I think the "plugin" directory name should be quoted, but that's
a pre-existing bug.

          Linus
