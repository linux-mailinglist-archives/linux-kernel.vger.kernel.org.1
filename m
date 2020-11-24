Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 019FB2C2B21
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 16:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389618AbgKXPWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 10:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730771AbgKXPWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 10:22:01 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC4DC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 07:22:00 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id t6so13266623lfl.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 07:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MzDXagPugS5o+KmKXpuVg51WsdU5lLTnROP0cd+1ApQ=;
        b=rE6GLlPAJ9z/ChKNrYX53P+OJarMJAnhSG76r0IF5zJvaFsvxt81Y3J0uAnSml4uCm
         N2NJhUI/Dao3ke0nui1hJbxrvEp30iNvHZQLLZVv46SqkTJ6UrknrOEX27CmrWfzGxjq
         BAz2j9FUwy2E5GOmt5KMyJlc0L6xDpNVyyNg8dtuAv5LYZP5C/odDmQ5u9vS7kqJinKv
         qDuZte5lQYsPIF+fI+Hf/bTJ1Sx95jVqjq+2Prg8sfMMYH5YhT/kdxoLxORtQXkPgA7+
         GDYllGD/+XecM90G0e1f964iLZzLmXNns4TGpQfD+kLbZPoC0ZfRxyZ5H5WJDqIE1xZZ
         TGdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MzDXagPugS5o+KmKXpuVg51WsdU5lLTnROP0cd+1ApQ=;
        b=ld848aTQObRtSW5p9H+FYaWLsFzeU0o2J3b9tmoNFMwYyXdR6uCzvZakYpz9mrrT95
         wQW9zaZ89RnM1+KSAyFVpjwvJ7LJrQXex9CcGeDnpTAgWYjP+p3tgpyYHVv9z3Af3Sqx
         FOx5w6bESB7HBvtOGL69ZAFcDMcEsfBarDex6qR+HT502DYU4t4IkUcVwPHBjTThFBsu
         T7KLyGjfZK33jWtMMeaO684pR/s5S3ZCfTwRtgRti5ooE57BUgjLw1dlUL6T7P4DLZvM
         ZYuNLl3f43FTlcVZUhKOyu2kyyvUC2qKdRXBxoZc4w1vx2hzqupdFgmKVJRZB0t7eCmw
         sbTg==
X-Gm-Message-State: AOAM530NxycdV8DHvmCyzb7tYpeFbgZ0iNBhAmkz9bwSbLTOXmHCvZZA
        OSxa0ykugqQER6SDT7W1OMoB80j6e6KAirCFaUzs6g==
X-Google-Smtp-Source: ABdhPJw9emUWnhbBIWCETbI02Q6AAMS1NjlG9mSwYBl2+eJFmM0BDZa8fxjOq0MJCuD18PQrSzVG5Xa65kvwkNKrMrs=
X-Received: by 2002:a19:7b06:: with SMTP id w6mr2113166lfc.260.1606231319202;
 Tue, 24 Nov 2020 07:21:59 -0800 (PST)
MIME-Version: 1.0
References: <20201106150706.29089-1-TheSven73@gmail.com> <CAHp75VfP1R7bXV6nWWnovWB5BMFcNNEmwBQXheBCUVDbr=xXGA@mail.gmail.com>
 <CAGngYiVu3cXtzb5PaoDOoyqjuuohLQ+em6Keg-qgDFFn2tdp=Q@mail.gmail.com>
 <CACRpkdagAK1X6FT=sug5FGA1iipXnOT_ujtMBh9cVnep_DpWyA@mail.gmail.com>
 <20201111123327.GB4847@sirena.org.uk> <CACRpkdZW3G48Yj3yGMTKZGwVEQOSs1VeVTTGLgyoJViM3=Yedg@mail.gmail.com>
 <20201116210632.GJ4739@sirena.org.uk> <CACRpkdayWzWKHv69cg_GL2O=NWozqi_ZLnH1WdMOHzEb1bU-xA@mail.gmail.com>
 <20201118114049.GA4827@sirena.org.uk>
In-Reply-To: <20201118114049.GA4827@sirena.org.uk>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 24 Nov 2020 16:21:48 +0100
Message-ID: <CACRpkdbJsiW_U2hrsT+t5gsbj+ow2t_kEmTQyD2jZxs3LCRfLw@mail.gmail.com>
Subject: Re: [PATCH v1] spi: fix client driver breakages when using GPIO descriptors
To:     Mark Brown <broonie@kernel.org>
Cc:     Grant Likely <grant.likely@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Simon Han <z.han@kunbus.com>, Lukas Wunner <lukas@wunner.de>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 12:41 PM Mark Brown <broonie@kernel.org> wrote:

> What people think they were sold was the idea that they shouldn't have
> to write driver code or upstream things, something with more AML like
> capabilities (not realising that AML works partly because ACPI hugely
> constrains system design).

This makes a lot of sense.

I suppose what we need to think about is the bigger question of why
people/companies/managers are so worried about working upstream
that they will go to lengths to avoid it and jump at any chance of
raising a wall of abstraction between their internal development and
the in-kernel software development.

I think of this as vendor/community couples therapy or something,
there is some form of deep disconnect or mistrust going on at times
and having worked on both ends myself I would think I could
understand it but I can't.

Yours,
Linus Walleij
