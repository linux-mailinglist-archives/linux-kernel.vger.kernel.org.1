Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A3E250865
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 20:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgHXSqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Aug 2020 14:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgHXSqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 14:46:44 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAB1C061573
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 11:46:43 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id i10so10871180ljn.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 11:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1LTtMW98wE2oKWRMDyHej2caYOCUtUuu7JAT8yzsI6k=;
        b=Q1vguMaRfNz4+cIAUqC3NftDvY/Uv8p4ZUNkVNVYVOPHeXyFTOdlJf+0PoURhamMa/
         jfwHyfOlTj5jRFmLtBlhZQNwOkVYjz34Y3JIylrRDEYazF2eOgVzwqGkT2yUPf0m5Jfi
         kH4JAZQfjmWEsv2Mg7AAwhZIuDlC7PdSjzlbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1LTtMW98wE2oKWRMDyHej2caYOCUtUuu7JAT8yzsI6k=;
        b=hwPjmlgGrgyxuy5oN5zGpyHlQdbZfRjqq/IjEMi/XktqijdHLGxdSyqlkqzEcOM2wd
         H/Z418jeGq1TNGedHHCLtLSlwVl7KRrmZPlEjEPMHWUuEEVLBRhbOJEpDjADC6+ygTno
         Qsf5g1LJttjH6McA+XX7/SIXW58OvAwmzzGgetL3Efp19fgzL8yfDv2Fbxo+l4ns1WUx
         tWZHYVfSGj/uJ+Je3vHPCuwCbNKeDedTrRPLqid+ZPQc4qWgHI9Xu24kofaZWRfOYU1+
         sKJpAvWSzq91PFokSgYJGDw8ZJFKpbW3P/HkozC3f7g9k+00RQJG08QV3C8FrJ7SjqPg
         x0gQ==
X-Gm-Message-State: AOAM531hIP/Smwjk6c9/rikRvRr2+Zt3S3HWHN8kgIE8uHFx3DzZEjjD
        LKnLJ1cqiZo1X2b0ZpyPXoNI1ttXyCjGEA==
X-Google-Smtp-Source: ABdhPJx6aB01X7AhmCDh1S2CLiZoyiTGA23c8KUvRDKy46ncQCCAzyW2qYoP/pdlIv4fjp2RGd59xQ==
X-Received: by 2002:a2e:9913:: with SMTP id v19mr3043738lji.292.1598294796974;
        Mon, 24 Aug 2020 11:46:36 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id v201sm2447555lfa.34.2020.08.24.11.46.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 11:46:36 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id v4so10890815ljd.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 11:46:36 -0700 (PDT)
X-Received: by 2002:a2e:545:: with SMTP id 66mr3365788ljf.285.1598294795762;
 Mon, 24 Aug 2020 11:46:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200824034841.GA29995@embeddedor>
In-Reply-To: <20200824034841.GA29995@embeddedor>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Aug 2020 11:46:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh8a8crLw5Lbs7C2Mz34fAUQn1tTHWqqOXCxbXF1bc_WA@mail.gmail.com>
Message-ID: <CAHk-=wh8a8crLw5Lbs7C2Mz34fAUQn1tTHWqqOXCxbXF1bc_WA@mail.gmail.com>
Subject: Re: [GIT PULL] fallthrough pseudo-keyword macro conversions for 5.9-rc3
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 23, 2020 at 8:42 PM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> Not sure what the problem was with my pull-request for -rc2. So, I'm giving
> this a second try because I think it is worth it.

Just "a ton of lines changed across subsystems, I feel like I need to check it".

For example, you say that you remove unnecessary fall-through
markings, but I'm not sure what your pattern for that was.

You left the one in arch/arm64/kernel/cpuinfo.c:
cpuinfo_detect_icache_policy(), for example.

And you've fixed up indentation clearly by hand in places, but then
it's incorrectly done in other places (dib8096_set_param_override())

I've pulled it, but these kinds of "trivial" conversions do make me
nervous. We've had a lot of cases of them breaking things, and it's a
pain to find when it happens.

I think I'd have preferred to get this as a couple of scripts that do
the obvious 1:1 direct conversion of the simple cases that cover 90%
of it all, so then the manual fixups separately.

Oh well. I've pulled it.

                  Linus
