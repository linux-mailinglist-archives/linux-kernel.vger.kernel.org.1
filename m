Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD1A1F010D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jun 2020 22:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgFEUir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Jun 2020 16:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728275AbgFEUir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 16:38:47 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C414DC08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 13:38:46 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id h188so6570699lfd.7
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 13:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FH95ibhtHjzCQf5JaVO7CI8yDEGZvTMnjh0aZYzquSU=;
        b=HwsGLu2Axjp4iMbTJca781tfoN6FfcigKyNrRDuFlE9Bc8sSLIpaeWs+c4hftPgT4n
         U9r0pW+BGh8JplPa3RBas2mRbG7oj5Qq3EPgEfpa0SXXfnPoXmCL4jO+7NXunnInMTFL
         kGXsbt8bTVVQiirsEBNXnjiA2JieM0l2rZ3TA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FH95ibhtHjzCQf5JaVO7CI8yDEGZvTMnjh0aZYzquSU=;
        b=bkvgJnFxEIWjl4sPr2wymooichxvFQwbwzxPsfH7//ZUqWGPzGbcCVITUB80oKX1+3
         AcaFKrBwLUC9b2l/qxxEY90Zx0PonRSt/NatJepN+i2ELaI9aOKNT7ZQWdWqwl5mUTo0
         mQ8TJiR6EE+8vUIl96UlXrHvxu5Oqp1/ZYVdCoSXf1LiYee7LuscQhHaSlo+HF/IUshn
         DYTx9EzQVeSezDOtN3c1gdu9qlRrsSbL3KJh52NHzYw8yy9YL+3ByEEkpidsVz36D4+y
         eqTfGAqJZbQgFPJLtIzvGK/mOV+0rts++/53myaKrLIIl13x4KhIFPzzh21HXsUSPpjp
         QQiQ==
X-Gm-Message-State: AOAM5301o4jtvZhJNvMzcaSbSnrESom3ADHslci00eP7YYDeIEG7sbR6
        Wbhm4iq4U9YmxDXHn6dQ5UiEfhHNsGE=
X-Google-Smtp-Source: ABdhPJw4ft02zoG5JgxeZZe50WFiypy8UrtNhe83rXlrJu8VCtdDDtt3IW8yZTTE2JT8xDx9gs9LNQ==
X-Received: by 2002:ac2:59c3:: with SMTP id x3mr6323188lfn.117.1591389524650;
        Fri, 05 Jun 2020 13:38:44 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id p1sm1348989lfo.66.2020.06.05.13.38.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2020 13:38:43 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id y11so11678366ljm.9
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 13:38:43 -0700 (PDT)
X-Received: by 2002:a2e:7e0a:: with SMTP id z10mr5488926ljc.314.1591389523194;
 Fri, 05 Jun 2020 13:38:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200605093354.GA23721@linux-8ccs.fritz.box>
In-Reply-To: <20200605093354.GA23721@linux-8ccs.fritz.box>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 5 Jun 2020 13:38:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgNqzQ0CUJ9LP+cLR8FMKwHTqOuSzqvFFKn7Duqquxo1g@mail.gmail.com>
Message-ID: <CAHk-=wgNqzQ0CUJ9LP+cLR8FMKwHTqOuSzqvFFKn7Duqquxo1g@mail.gmail.com>
Subject: Re: [GIT PULL] Modules updates for v5.8
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 5, 2020 at 2:34 AM Jessica Yu <jeyu@kernel.org> wrote:
>
> Please pull below to receive modules updates for the v5.8 merge window.

Done. Considering the confusion this merge window with the
dependencies of trees with each other, can you verify that what I got
matches what you expect?

                  Linus
