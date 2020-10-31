Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0C402A1AB3
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 22:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbgJaVbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 17:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgJaVbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 17:31:20 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980C0C0617A6
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 14:31:19 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 126so12402597lfi.8
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 14:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6iIHUQjb9HBtgLABjU5zVfn2KSQWsdSCf2JgjHO1UEk=;
        b=GUTOizXVfvsAWV1T7QtH1JT/touIV4Y2V6eqEd6URm5cZ0kSloLlOxFI31Glcb6H/c
         JWnyES4x8kOvHOw3jYsIlChcBf2TTTFG75MEgbdb+z7FocaScfxACaQxmMMueL3T6yY7
         lEWlgqCcKZvs8n6LKZ4YxUUi+L/tXZUuyxEMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6iIHUQjb9HBtgLABjU5zVfn2KSQWsdSCf2JgjHO1UEk=;
        b=eURt7zTXdjVHuDxI4CkUndvY5n6LsotInMyVfe2OPwtFxSMY55hkZ+D8xI+1cPKVbX
         I0tl9sf8Sx2YxOpOhQ6/HtwFmE2Yv97T27+ZS/g3te0hT06GalBYYoGweS0SFld0suqj
         RJ88XsJ1jhz1RyWur9N3xJw9tLjXT30PGA4qb5aX0RXcFzBuCkhKcZCKw9raElx9nVH/
         dJug80v/HpDz7hGKtBd63/VFvYG2l/lGjTEUzO5SNCz7b28eFatFnLEobFjbYDcM5rbq
         Af+JqSSQEX7VI3VzOIVeJiYVAjZg6tyi8oi60frnpWYcpv0mdp0zsqQKt7H4QWx4WVX4
         8BHA==
X-Gm-Message-State: AOAM530tNNgX33lS6qrnxu18jZHv+18Ocim8sUpgWpORHSGm90qu63YA
        kxNUtRGKSb0OXamRwsawHVhCJr6TLxEUsw==
X-Google-Smtp-Source: ABdhPJwNko1/qVhnk1zlKtqegZ+7/bGCZuYGY0GifFidzavXxfXNLUU6yOoj/r1kLFHVVdvEj+46tw==
X-Received: by 2002:a19:740c:: with SMTP id v12mr2909635lfe.221.1604179876589;
        Sat, 31 Oct 2020 14:31:16 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id m14sm1236069ljo.76.2020.10.31.14.31.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Oct 2020 14:31:16 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id a9so12422205lfc.7
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 14:31:15 -0700 (PDT)
X-Received: by 2002:ac2:5f48:: with SMTP id 8mr3418700lfz.344.1604179875397;
 Sat, 31 Oct 2020 14:31:15 -0700 (PDT)
MIME-Version: 1.0
References: <20201030185908.20611-1-acme@kernel.org>
In-Reply-To: <20201030185908.20611-1-acme@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 31 Oct 2020 14:30:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj4Xujkp8NraScb=YTf4+U1PfkG-rY1D2HQpemoDgY68w@mail.gmail.com>
Message-ID: <CAHk-=wj4Xujkp8NraScb=YTf4+U1PfkG-rY1D2HQpemoDgY68w@mail.gmail.com>
Subject: Re: [GIT PULL] perf tools changes for v5.10: 2nd batch
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dengcheng Zhu <dzhu@wavecomp.com>,
        Ian Rogers <irogers@google.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        "Justin M . Forbes" <jforbes@fedoraproject.org>,
        Leo Yan <leo.yan@linaro.org>, Peng Fan <fanpeng@loongson.cn>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Stanislav Ivanichkin <sivanichkin@yandex-team.ru>,
        Tommi Rantala <tommi.t.rantala@nokia.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 11:59 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
>         Please consider pulling,

Malformed pull request, and this doesn't even seem to be fixes.

           Linus
