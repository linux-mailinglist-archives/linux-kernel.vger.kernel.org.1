Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32D9E2D3EB5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 10:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729115AbgLIJ11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 04:27:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728673AbgLIJ10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 04:27:26 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E078C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 01:26:46 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id w13so2159321lfd.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 01:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xe2wCqmHwjSift/w8mcBzC9aoqgbz0iOwJ272Obz4Ig=;
        b=yOOA8yx8Z3df/9E32XvyNZOcUIYJ8EKGMnID8FSHOjfmmeiaGeFmf6AbYd3gGovEBi
         8BKbmnsjR+CfgUGnc6OejaVNz6ozhjNml44uYmYyueo14SLkkH/7xV7YVnKcadtoX6bq
         N2kSIcZotfIKXKl3dZWAFTxbafTySP9kABQDNy7WQeVOVF3DcmVxbFinhpXNtjlXe6gL
         OBI1zX1ckwN/IDTyhu9FyyG/tkQPA+LfnS4s6klAy/C6za7kw8vGpFuNLhaFtrc6rVYC
         nrDyq2eM2mzFJ+MoXKo2Bbqag8knS7ii4GrXylpOPMY6QslKFFz7a4fWPDG9kQJqVajG
         xYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xe2wCqmHwjSift/w8mcBzC9aoqgbz0iOwJ272Obz4Ig=;
        b=NO3St8GPMVER1pbsPvGHzO5/QcZyI0GaPwA1vF+QXkuCRXoKMp6VKVI7aQhpOdOqhw
         rIsL7wgw9tP6d+QjN3TzarJKtPEUOWyUpUDGMm229R7bOT546iIJcQA5gQgEu78SP9ev
         H8otnV8998Llw7gYXdptpAIzXwlHqKnD6m3WARbBgzUc+F8EI79MAHsp8bxg9aSVDmmn
         jNFHvHnKEbJf7ow/rt6kFxF/nV4qNscnNl73r7f8zM1+J/UPaC2j0q95ue8WpKQ1Rf/I
         j0QNC95/KvWE07l+7xislt5LEBumRPaUHtPp6fyz1GjXACycRp7hdgBLSdlJEqPKl2lb
         0B+Q==
X-Gm-Message-State: AOAM530ErtV/bBxIULC3wDm8iQO1czoPwQXjZ53Hp/1CUtxkDORyvs+7
        EeYra9wr2aPAEYlbVVr9TRrKT1yAAgXgr1/pykwb+w==
X-Google-Smtp-Source: ABdhPJwsyBUDj5awP77/Zz+uFvy2DSd7akl3rgT4gaHhFibBb8b5YMsv7eGEHOrENbczoydN2FnYKH65lWm4GrDUzmI=
X-Received: by 2002:a05:6512:74e:: with SMTP id c14mr698273lfs.529.1607506004588;
 Wed, 09 Dec 2020 01:26:44 -0800 (PST)
MIME-Version: 1.0
References: <X85UKveYKc3xLPVk@manjaro> <CAHp75Vcf-_yrUMOVLtydS+0tV4DE4gudsmqdmLLH1SSiXAK66A@mail.gmail.com>
In-Reply-To: <CAHp75Vcf-_yrUMOVLtydS+0tV4DE4gudsmqdmLLH1SSiXAK66A@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 9 Dec 2020 10:26:33 +0100
Message-ID: <CACRpkdaT7-2uFWGqj2JyE1CLHWQhG8kyjObBP=d6XOJ7nbc1Fg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: remove the blank line in pinctrl_register()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Zhaoyu Liu <zackary.liu.pro@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 7, 2020 at 7:20 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Mon, Dec 7, 2020 at 6:13 PM Zhaoyu Liu <zackary.liu.pro@gmail.com> wrote:
> >
> > Remove the blank line in pinctrl_register() to keep the code neat.
>
> Probably you want to apply the same for other drivers at once?
>
>  % git grep -n -B1 -w ^} -- drivers/pinctrl/ | grep -C1 '[0-9]-$' | less

I agree with Andy, a patch should be "one technical step" so just sweep
the entire subsystem if you wanna do this cosmetic.

Yours,
Linus Walleij
