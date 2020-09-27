Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C967A27A288
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 21:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgI0TRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 15:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbgI0TRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 15:17:21 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247BCC0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 12:17:21 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id n25so6574949ljj.4
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 12:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mjHuHBOMuKs2k/aQNO/HK+2YW0KO567Qs4BlARgJ/HE=;
        b=dJ5qf1i5rgjXxhg7VYooXql7hvSeRUvl3B7+i2Etx/1J64fSf4wb8/Xz0cknpuu7Mp
         gNi9Faz3R7QGscrf4zzQCJ6sFc9uy4E3clZYin7FhVhTu9n3bwJwexk/GirwPOVYYWLV
         QwVkPmrrZv/N6++PyaKCnUKaV2GlNKYuwGprk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mjHuHBOMuKs2k/aQNO/HK+2YW0KO567Qs4BlARgJ/HE=;
        b=ffZg2vuXFg3ulnBwM13xPrPPssfA4ncn5a/31ao8gkCh0ThfV6JGV4nL2RVSdP8XAa
         6qhlfIXjnk0B5W5zy1NmXKyTsdhA2pJp7FQ8dBVOfExJaeNC3DLx5/Qoj1sgGfI2+JOS
         zbmlo8XtnaIhqE+BwsOs0WZayWa6fScjSaK95BtiWRdRv7RGApAptHbk5COYYA+oDJW5
         L5vSwESN0UxBIEJeoWMRAbS/A3sAEtoJgPps6dkQdR/KR0X6CqK0vlr7f9oHq68jr0Fi
         /kTdq8H+pdy4n2/lqMcoH5lS+RvQH6dJVsMICQSln72Ukk52RW11wx5Y6/sUUPTYqs9w
         wEYA==
X-Gm-Message-State: AOAM530YvW6S0WQffkTudb5gOL5xjr0b40JGYcpL7dNFm9cn822wJ0JG
        /nOdJKZgsJPe0TOX+MrNw2YG4uGPivpgSw==
X-Google-Smtp-Source: ABdhPJykuALo5fEf19VFC6OrLXXTwj1fL+4t02J8kNKIYnGXEJvDQDyJZ7EYrw/qVdE5umywKB1w/Q==
X-Received: by 2002:a05:651c:1248:: with SMTP id h8mr4302246ljh.225.1601234239083;
        Sun, 27 Sep 2020 12:17:19 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id m203sm2575184lfd.195.2020.09.27.12.17.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Sep 2020 12:17:17 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id u8so8617806lff.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 12:17:17 -0700 (PDT)
X-Received: by 2002:a19:e00a:: with SMTP id x10mr3093560lfg.603.1601234237338;
 Sun, 27 Sep 2020 12:17:17 -0700 (PDT)
MIME-Version: 1.0
References: <160121922194.23623.5568205948074131939.tglx@nanos>
In-Reply-To: <160121922194.23623.5568205948074131939.tglx@nanos>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 27 Sep 2020 12:17:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgdcYgqGvS76ohR4SsgooahOWVc0Z9LRPP61wcGoHx4Pw@mail.gmail.com>
Message-ID: <CAHk-=wgdcYgqGvS76ohR4SsgooahOWVc0Z9LRPP61wcGoHx4Pw@mail.gmail.com>
Subject: Re: [GIT pull] timers/urgent for 5.9-rc7
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 27, 2020 at 8:08 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> please pull the latest timers/urgent branch from:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2020-09-27

Hmm. I got this (and the x86) pull request twice.

Is it just because the subject line was messed up the first time, or
did you perhaps mean to send something else?

                       Linus
